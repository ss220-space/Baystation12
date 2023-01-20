import { useBackend } from '../backend';
import { Box, Button, Flex } from '../components';
import { Window } from "../layouts";

const UplinkKeypad = (_props, context) => {
  const { act } = useBackend(context);
  const keypadKeys = [
    ['1', '4', '7', 'C'],
    ['2', '5', '8', '0'],
    ['3', '6', '9', 'E'],
  ];
  return (
    <Flex className="UplinkLogin__ButtonGrid">
      {keypadKeys.map(keyColumn => (
        <Flex.Item className="UplinkLogin__ButtonRow" key={keyColumn[0]}>
          {keyColumn.map(key => (
            <Button
              fluid key={key} className={'UplinkLogin__Button UplinkLogin__Button--'+key}
              onClick={() => act('keypad', { digit: key })} >
              <Box className="UplinkLogin__Button__Text">{key}</Box>
            </Button>
          ))}
        </Flex.Item>
      ))}
    </Flex>
  );
};

type UplinkLoginData = { message: string };

export const UplinkLogin = (_props, context) => {
  const { data } = useBackend<UplinkLoginData>(context);
  return (
    <Window
      width={280}
      height={428}
      theme="blank-dark">
      <Window.Content>
        <Flex direction="column" className="UplinkLogin__MainBox">
          <Flex.Item>
          <Box className="UplinkLogin__DisplayBox">
              <Box className="UplinkLogin__DisplayFancy">
                <Box className="UplinkLogin__DisplayText">{ data.message || '' }</Box>
              </Box>
            </Box>
          </Flex.Item>
          <Flex.Item grow={1} />
          <Flex.Item className="UplinkLogin__Keypad">
            <UplinkKeypad />
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
