import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Section, LabeledList, Button } from '../components';
import { Window } from '../layouts';

type Data = {
  shuttle_state: string;
  destination_name: string;
  can_launch: BooleanLike;
  can_cancel: BooleanLike;
};

export const ShuttleControlConsoleLift = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { shuttle_state, can_launch, can_cancel, destination_name } = data;
  return (
    <Window width={500} height={200}>
      <Window.Content>
        <Section
          title="Lift Controls"
          buttons={
            <>
              <Button disabled={!can_launch} icon="plane-arrival" title="Move" onClick={() => act('move')} />
              <Button disabled={!can_cancel} icon="ban" title="Stop" onClick={() => act('cancel')} />
            </>
          }>
          <LabeledList>
            <LabeledList.Item label="Lift status">{shuttle_state}</LabeledList.Item>
            {destination_name && (
              <LabeledList.Item label="Destination">
                <Button
                  icon="globe"
                  content={destination_name ? destination_name : 'NONE'}
                  onClick={() => act('pick')}
                />
              </LabeledList.Item>
            )}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
