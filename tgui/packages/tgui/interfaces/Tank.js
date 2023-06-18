import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const Tank = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    connected,
    maskConnected,
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    minReleasePressure,
    maxReleasePressure,
  } = data;

  return (
    <Window width={400} height={135}>
      <Window.Content>
        <Section title="Status">
          <LabeledList>
            <LabeledList.Item label="Pressure">
              <ProgressBar
                value={tankPressure / 1013}
                ranges={{
                  good: [0.35, Infinity],
                  average: [0.15, 0.35],
                  bad: [-Infinity, 0.15],
                }}>
                {tankPressure + ' kPa'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Pressure Regulator">
              <Button
                icon="fast-backward"
                disabled={releasePressure === minReleasePressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'min',
                  })
                }
              />
              <NumberInput
                animated
                value={parseFloat(releasePressure)}
                width="65px"
                unit="kPa"
                minValue={minReleasePressure}
                maxValue={maxReleasePressure}
                onChange={(e, value) =>
                  act('pressure', {
                    pressure: value,
                  })
                }
              />
              <Button
                icon="fast-forward"
                disabled={releasePressure === maxReleasePressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'max',
                  })
                }
              />
              <Button
                icon="undo"
                content=""
                disabled={releasePressure === defaultReleasePressure}
                onClick={() =>
                  act('pressure', {
                    pressure: 'reset',
                  })
                }
              />
              <Button
                icon={connected ? 'toggle-on' : 'toggle-off'}
                content=""
                disabled={!maskConnected}
                selected={connected ? 'selected' : null}
                onClick={() => act('toogle')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
