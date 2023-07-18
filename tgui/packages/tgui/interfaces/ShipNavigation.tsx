import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  linked: BooleanLike;
  sector: string;
  s_x: number;
  s_y: number;
  sector_info: string;
  viewing: BooleanLike;
  ETAnext: string;
  speed: number;
  speed_color: string;
  accel: number;
  heading: number;
  accellimit: number;
};

export const ShipNavigation = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { linked, sector, s_x, s_y, sector_info, viewing, ETAnext, speed, speed_color, accel, heading } = data;
  return (
    <Window>
      <Window.Content>
        {linked ? (
          <>
            <Section
              title="Current Location"
              buttons={
                <Button icon="eye" selected={viewing} onClick={() => act('viewing')}>
                  Map View
                </Button>
              }>
              <LabeledList>
                <LabeledList.Item label="Current Location">{sector}</LabeledList.Item>
                <LabeledList.Item label="Coordinates">
                  {s_x} : {s_y}
                </LabeledList.Item>
                <LabeledList.Item label="Additional Information">{sector_info}</LabeledList.Item>
              </LabeledList>
            </Section>
            <Section title="Flight Data">
              <LabeledList>
                <LabeledList.Item label="ETA To Next Grid">{ETAnext}</LabeledList.Item>
                <LabeledList.Item label="Speed" color={speed_color}>
                  {speed} Gm/h
                </LabeledList.Item>
                <LabeledList.Item label="Acceleration">{accel} Gm/h</LabeledList.Item>
                <LabeledList.Item label="Heading">{heading}&deg;</LabeledList.Item>
              </LabeledList>
            </Section>
          </>
        ) : (
          <Button width="100%" content="Find Shuttle" icon="search" onCLick={() => act('sync')} />
        )}
      </Window.Content>
    </Window>
  );
};
