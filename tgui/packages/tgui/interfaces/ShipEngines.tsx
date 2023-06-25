/* eslint react/no-danger: "off" */
import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Button, Box, Flex, NumberInput, Collapsible, AnimatedNumber, LabeledList, Section, Divider, Stack, NoticeBox } from '../components';
import { Window } from '../layouts';

type Data = {
  viewing_silicon: BooleanLike;
  global_state: string;
  global_limit: number;
  engines: Engine[];
  total_thrust: number;
};

type Engine = {
  eng_type: string;
  eng_on: BooleanLike;
  eng_thrust: number;
  eng_thrust_limiter: number;
  eng_status: string;
  eng_reference: string;
};

const GeneralInfo = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { global_state, global_limit, total_thrust, viewing_silicon } = data;
  return (
    <Section title="General controls">
      <LabeledList>
        <LabeledList.Item label="Global controls">
          <Button
            icon={global_state ? 'toggle-on' : 'toggle-off'}
            title={global_state ? 'Shut all down' : 'Power all up'}
            selected={global_state}
            disabled={viewing_silicon === 1}
            onClick={() => act('global_toggle')}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Thrust limit">
          <Button
            icon="angle-double-left"
            onClick={() => act('global_limit', { adjust: -0.1 })}
            disabled={global_limit < 10 || viewing_silicon === 1}
          />
          <NumberInput
            width="22px"
            step={1}
            stepPixelSize={1}
            minValue={0}
            maxValue={100}
            value={global_limit}
            onDrag={(e, value) => act('set_global_limit', { new_limit: value / 100 })}
          />
          <Button
            icon="angle-double-right"
            onClick={() => act('global_limit', { adjust: 0.1 })}
            disabled={global_limit > 90 || viewing_silicon === 1}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Total thrust">{total_thrust}</LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const ShipEngines = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { engines, viewing_silicon } = data;
  return (
    <Window width={370} height={600} resizable>
      <Window.Content scrollable>
        <Stack vertical fill>
          <Stack.Item>{viewing_silicon === 1 && <NoticeBox>{'AI SYSTEM DETECTED!'}</NoticeBox>}</Stack.Item>
          <Stack.Item>
            <GeneralInfo />
            <Divider />
            {engines.map((engine, i) => (
              <Collapsible
                title={
                  <Box inline>
                    Engine #{i + 1} | Thrust: <AnimatedNumber value={engine.eng_thrust} /> | Limit:{' '}
                    <AnimatedNumber value={engine.eng_thrust_limiter} format={(val) => val + '%'} />
                  </Box>
                }>
                <Section>
                  <LabeledList>
                    <LabeledList.Item label="Type">
                      <Flex justify="space-between" direction="row">
                        {engine.eng_type}
                        <Button
                          fluid
                          disabled={viewing_silicon === 1}
                          iconSpin={engine.eng_on === -1}
                          color={engine.eng_on === -1 ? 'purple' : null}
                          selected={engine.eng_on === 1}
                          icon="power-off"
                          onClick={() => act('toggle', { ref: engine.eng_reference })}
                        />
                      </Flex>
                    </LabeledList.Item>
                    <LabeledList.Item label="Status">
                      <p style={{ 'color': engine.eng_on ? (engine.eng_on === 1 ? 'green' : 'average') : 'red' }}>
                        {engine.eng_on ? (engine.eng_on === 1 ? 'Online' : 'Booting') : 'Offline'}
                      </p>
                      <div dangerouslySetInnerHTML={{ __html: engine.eng_status }} />
                    </LabeledList.Item>
                    <LabeledList.Item label="Current Thrust">{engine.eng_thrust}</LabeledList.Item>
                    <LabeledList.Item label="Volume Limit">
                      <Button
                        icon="angle-double-left"
                        onClick={() => act('limit', { adjust: -0.1, ref: engine.eng_reference })}
                        disabled={engine.eng_thrust_limiter < 10 || viewing_silicon === 1}
                      />
                      <NumberInput
                        width="22px"
                        step={1}
                        stepPixelSize={1}
                        minValue={0}
                        maxValue={100}
                        value={engine.eng_thrust_limiter}
                        onDrag={(e, value) => act('set_limit', { new_limit: value / 100, ref: engine.eng_reference })}
                      />
                      <Button
                        icon="angle-double-right"
                        onClick={() => act('limit', { adjust: 0.1, ref: engine.eng_reference })}
                        disabled={engine.eng_thrust_limiter > 90 || viewing_silicon === 1}
                      />
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              </Collapsible>
            ))}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
