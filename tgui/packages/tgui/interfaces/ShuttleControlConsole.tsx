import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Section, LabeledList, Button, Stack, NoticeBox } from '../components';
import { Window } from '../layouts';

type Data = {
  viewing_silicon: BooleanLike;
  shuttle_state: string;
  timeleft: string;
  docking_status: string;
  is_docking_codes: BooleanLike;
  docking_codes: string;
  destination_name: string;
  fuel_usage: number;
  fuel_span: string;
  remaining_fuel: number;
  can_launch: BooleanLike;
  can_cancel: BooleanLike;
  can_force: BooleanLike;
  can_pick: BooleanLike;
};

const ShuttleControls = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    viewing_silicon,
    shuttle_state,
    timeleft,
    docking_status,
    can_launch,
    can_cancel,
    can_force,
    fuel_span,
    destination_name,
    fuel_usage,
    remaining_fuel,
    docking_codes,
    is_docking_codes,
  } = data;
  return (
    <Section
      title="Shuttle Controls"
      buttons={
        <>
          <Button
            disabled={!can_launch || viewing_silicon === 1}
            icon="plane-arrival"
            content="Launch"
            onClick={() => act('move')}
          />
          <Button
            disabled={!can_cancel || viewing_silicon === 1}
            icon="ban"
            content="Cancel"
            onClick={() => act('cancel')}
          />
          <Button
            disabled={!can_force || viewing_silicon === 1}
            color="red"
            icon="exclamation-triangle"
            content="Force"
            onClick={() => act('force')}
          />
        </>
      }>
      <LabeledList>
        <LabeledList.Item label="Engines">{shuttle_state}</LabeledList.Item>
        <LabeledList.Item label="ETA">{timeleft === 'NONE' ? timeleft : timeleft + 's'}</LabeledList.Item>
        <LabeledList.Item label="Docking Status">{docking_status}</LabeledList.Item>
        {remaining_fuel && (
          <LabeledList.Item color={fuel_span} label="Est. Delta-V Budget">
            {remaining_fuel + 'm/s'}
          </LabeledList.Item>
        )}
        {!!fuel_usage && <LabeledList.Item label="Avg. Delta-v per maneuver">{fuel_usage + 'm/s'}</LabeledList.Item>}
        {is_docking_codes === 1 && (
          <LabeledList.Item label="Docking Codes">
            <Button
              disabled={viewing_silicon === 1}
              content={docking_codes ? docking_codes : 'NONE'}
              onClick={() => act('set_codes')}
            />
          </LabeledList.Item>
        )}
        {destination_name && (
          <LabeledList.Item label="Destination">
            <Button
              disabled={viewing_silicon === 1}
              icon="globe"
              content={destination_name ? destination_name : 'NONE'}
              onClick={() => act('pick')}
            />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

export const ShuttleControlConsole = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { viewing_silicon } = data;
  return (
    <Window width={500} height={250}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>{viewing_silicon === 1 && <NoticeBox>{'AI SYSTEM DETECTED!'}</NoticeBox>}</Stack.Item>
          <Stack.Item>
            <ShuttleControls />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
