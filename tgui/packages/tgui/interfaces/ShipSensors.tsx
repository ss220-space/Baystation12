/* eslint react/no-danger: "off" */
import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Stack, ProgressBar, Section, NoticeBox } from '../components';
import { Window } from '../layouts';

type Data = {
  on: BooleanLike;
  range: number;
  viewing: BooleanLike;
  viewing_silicon: BooleanLike;
  status: string;
  heat: number;
  critical_heat: number;
  health: number;
  max_health: number;
  temp_mes: string;
  contacts: Contact[];
  last_scan: Scan;
  sensors: BooleanLike;
};

type Contact = {
  name: string;
  color: string;
  ref: string;
  bearing: number;
};

type Scan = {
  data: string;
  location: string;
  name: string;
};

const Status = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { on, health, max_health, range, viewing, viewing_silicon, status, heat, critical_heat, temp_mes } = data;
  return (
    <Section
      title="Status"
      buttons={
        <>
          <Button icon="map" content="Map view" selected={viewing} onClick={() => act('viewing')} />
          <Button
            icon={on ? 'toggle-on' : 'toggle-off'}
            selected={on}
            disabled={status !== 'OK' || viewing_silicon}
            onClick={() => act('toggle')}
          />
        </>
      }>
      <LabeledList>
        <LabeledList.Item label="Status">{status}</LabeledList.Item>
        <LabeledList.Item label="Range">
          <NumberInput
            width="22px"
            step={1}
            stepPixelSize={1}
            minValue={0}
            maxValue={7}
            value={range}
            onDrag={(e, value) => act('range', { range: value })}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Integrity">
          <ProgressBar
            ranges={{
              good: [0.7, 1],
              average: [0.4, 0.7],
              bad: [0, 0.4],
            }}
            minValue={0}
            maxValue={1}
            value={health / max_health}>
            {health + '/' + max_health}
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Temperature">
          <ProgressBar
            ranges={{
              good: [0, 0.5],
              average: [0.5, 0.75],
              bad: [0.75, 1],
            }}
            minValue={0}
            maxValue={1}
            value={heat / critical_heat}>
            {temp_mes}
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const ContactData = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { contact, viewing_silicon } = props;
  return (
    <Button
      icon="search"
      disabled={viewing_silicon}
      content={contact.name + ', bearing: ' + contact.bearing + '°'}
      onClick={() => act('scan', { ref: contact.ref })}
    />
  );
};

const Contacts = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { contacts, viewing_silicon } = data;
  return (
    <Section title="Contacts">
      {contacts
        ? contacts?.map((contact) => <ContactData contact={contact} viewing_silicon={viewing_silicon === 1} />)
        : 'None'}
    </Section>
  );
};

const ScanData = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { last_scan, viewing_silicon } = data;
  if (last_scan) {
    return (
      <Section
        title={'Scan Data (' + last_scan.name + ' ' + last_scan.location + ')'}
        buttons={<Button disabled={viewing_silicon === 1} icon="print" content="Print" onClick={() => act('print')} />}>
        <div dangerouslySetInnerHTML={{ __html: last_scan.data }} />
      </Section>
    );
  } else {
    return <Section title={'Scan Data'}>{'N/A'}</Section>;
  }
};

export const ShipSensors = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { sensors, viewing_silicon } = data;
  return (
    <Window width={380} height={600}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>{viewing_silicon === 1 && <NoticeBox>{'AI SYSTEM DETECTED!'}</NoticeBox>}</Stack.Item>
          <Stack.Item>
            {sensors ? (
              <>
                <Status />
                <Contacts />
                <ScanData />
              </>
            ) : (
              <Section title="Status: MISSING SENSORS">
                <Button content="Link sensors" onClick={() => act('link')} />
              </Section>
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
