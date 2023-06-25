import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Input, Stack, NoticeBox, Section, Flex, Table, TextArea, Icon } from '../components';
import { Window } from '../layouts';

const Terminal = (props, context) => {
  const { errors, onClose } = props;
  return (
    <Stack.Item>
      <Section
        height="150px"
        scrollable
        title="Terminal"
        style={{ 'overflow-y': 'scroll' }}
        buttons={<Button icon="times" color="red" onClick={() => onClose()} />}>
        <p>{'Start compiling code...'}</p>
        {errors?.map((error) => (
          <p>
            <Icon color="red" name="times-circle" />
            <span style={{ 'color': 'red' }}>{' ' + error}</span>
          </p>
        ))}
        <p>{'Found ' + errors.length + ' errors!'}</p>
        <p>{'End compiling code.'}</p>
      </Section>
    </Stack.Item>
  );
};

const CodeRedactor = (props, context) => {
  const { act, data } = useBackend(context);
  const { codeText, errors } = data;
  const [text, setText] = useLocalState(context, 'codeText', codeText);
  const [launched, setLaunched] = useLocalState(context, 'launched', false);
  const [terminal, setTerminal] = useLocalState(context, 'terminal', false);
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Flex justify="space-between">
            <Flex.Item align="left">
              <Button
                icon="terminal"
                content="Compile"
                onClick={() => {
                  act('compile', { rawcode: text });
                  setLaunched(true);
                  setTerminal(true);
                }}
              />
              <Button
                icon="play"
                content="Execute"
                disabled={!(launched && errors.length === 0)}
                color="green"
                onClick={() => {
                  act('execute', { rawcode: text });
                }}
              />
              <Button
                icon="eraser"
                onClick={() => {
                  act('purge');
                }}
              />
              <Button
                icon="check"
                disabled={!(launched && errors.length === 0)}
                color="green"
                onClick={() => {
                  act('apply');
                  setLaunched(false);
                }}
              />
            </Flex.Item>
            <Flex.Item align="right">
              <Button icon="times" color="red" onClick={() => act('close')} />
            </Flex.Item>
          </Flex>
        </Section>
        <Section>
          <TextArea
            onInput={(_, value) => {
              setText(value);
              setLaunched(false);
            }}
            height={terminal ? '500px' : '670px'}
            width="100%"
            scroll
            value={text}
            style={{ 'overflow-y': 'scroll' }}
          />
        </Section>
        {terminal && <Terminal errors={errors} onClose={() => setTerminal(false)} />}
      </Stack.Item>
    </Stack>
  );
};

const ServerScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { network, serverName, signalEx } = data;
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section
          title="Server Information"
          buttons={<Button content="Main Menu" icon="home" onClick={() => act('return_home')} />}>
          <LabeledList>
            <LabeledList.Item label="Current Network">{network}</LabeledList.Item>
            <LabeledList.Item label="Selected Server">{serverName}</LabeledList.Item>
            <LabeledList.Item label="Signal Execution">
              <Button
                content={signalEx ? 'ALWAYS' : 'NEVER'}
                onClick={() => act('toggle_run')}
                color={signalEx ? 'green' : 'red'}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section fill scrollable title="Welcome to Visual NT Code">
          <Button content="Start Editing" onClick={() => act('open_editor')} />
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const MainScreen = (props, context) => {
  const { act, data } = useBackend(context);
  const { servers, network } = data;
  const [networkId, setNetworkId] = useLocalState(context, 'networkId', network);

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section>
          <Input value={networkId} onInput={(e, value) => setNetworkId(value)} placeholder="Network ID" />
          <Button content="Scan" onClick={() => act('scan_network', { network_id: networkId })} />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          fill
          scrollable
          title="Detected Telecommunication Servers"
          buttons={
            <Button
              content="Clear Buffer"
              icon="trash"
              color="red"
              disabled={servers.length === 0}
              onClick={() => act('clear_buffer')}
            />
          }>
          <Table>
            <Table.Row header>
              <Table.Cell>Address</Table.Cell>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Identification String</Table.Cell>
            </Table.Row>
            {servers?.map((s) => (
              <Table.Row key={s.ref}>
                <Table.Cell>{s.ref}</Table.Cell>
                <Table.Cell>{s.name}</Table.Cell>
                <Table.Cell>
                  <Button content={s.id} onClick={() => act('view_server', { server: s.ref })} />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const TrafficControl = (props, context) => {
  const { act, data } = useBackend(context);
  const { screen, error } = data;
  return (
    <Window width={screen === 2 ? 800 : 575} height={screen === 2 ? 800 : 450}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>{error !== '' && <NoticeBox>{error}</NoticeBox>}</Stack.Item>
          <Stack.Item grow>
            {(screen === 0 && <MainScreen />) ||
              (screen === 1 && <ServerScreen />) ||
              (screen === 2 && <CodeRedactor />)}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
