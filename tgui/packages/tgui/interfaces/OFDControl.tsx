import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, AnimatedNumber, Stack } from '../components';
import { Window } from '../layouts';
import { OvermapPanControls } from './common/Overmap';

type Data = {
  faillink: BooleanLike;
  calibration: Calibration[];
  overmapdir: number;
  cal_accuracy: number;
  strength: number;
  range: number;
  next_shot: number;
  nopower: BooleanLike;
  chargeload: string;
};

type Calibration = {};

export const OFDControl = (props, context) => {
  return (
    <Window width={400} height={550} resizable>
      <Window.Content>
        <OvermapDisperserContent />
      </Window.Content>
    </Window>
  );
};

const OvermapDisperserContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { faillink, calibration, overmapdir, cal_accuracy, strength, range, next_shot, nopower, chargeload } = data;

  if (faillink) {
    return <Section title="Error">Machine is incomplete, out of range, or misaligned!</Section>;
  }

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Section title="Targeting" textAlign="center">
              <OvermapPanControls actToDo="choose" selected={(val) => val === overmapdir} />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Calibration">
              <AnimatedNumber value={cal_accuracy} />%
              <Button ml={1} icon="exchange-alt" onClick={() => act('skill_calibration')}>
                Pre-Calibration
              </Button>
              <Box mt={1}>
                {calibration.map((cal, i) => (
                  <Box key={i}>
                    Cal #{i + 1}:
                    <Button ml={1} icon="random" onClick={() => act('calibration', { calibration: i })}>
                      {cal.toString() /* We do this to make the button size correctly at 0 */}
                    </Button>
                  </Box>
                ))}
              </Box>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Setup"
              buttons={<Button content="Fire!" color="red" icon="bomb" onClick={() => act('fire')} />}>
              <LabeledList>
                <LabeledList.Item label="Strength">
                  <Button fluid icon="fist-raised" onClick={() => act('strength')}>
                    {strength}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Radius">
                  <Button fluid icon="expand-arrows-alt" onClick={() => act('range')}>
                    {range}
                  </Button>
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Section title="Charge">
          <LabeledList>
            {(nopower && (
              <LabeledList.Item label="Error">At least one part of the machine is unpowered.</LabeledList.Item>
            )) ||
              null}
            <LabeledList.Item label="Charge Load Type">{chargeload}</LabeledList.Item>
            <LabeledList.Item label="Cooldown">
              {(next_shot === 0 && <Box color="good">Ready</Box>) ||
                (next_shot > 1 && (
                  <Box color="average">
                    <AnimatedNumber value={next_shot} /> Seconds
                    <Box color="bad">Warning: Do not fire during cooldown.</Box>
                  </Box>
                )) ||
                null}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
