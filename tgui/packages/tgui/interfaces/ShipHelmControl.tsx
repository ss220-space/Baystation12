import { BooleanLike } from '../../common/react';
import { useBackend } from '../backend';
import { Section, Box, LabeledList, NumberInput, Table, Button, Stack, Flex, Divider, NoticeBox } from '../components';
import { Window } from '../layouts';

type Data = {
  linked: BooleanLike;
  viewing_silicon: BooleanLike;
  ETAnext: string;
  speed: number;
  speed_color: string;
  accel: number;
  heading: number;
  accellimit: number;
  manual_control: BooleanLike;
  canburn: BooleanLike;
  distress: BooleanLike;
  dest: BooleanLike;
  d_x: number;
  d_y: number;
  speedlimit: string;
  autopilot: BooleanLike;
  sector: string;
  s_x: number;
  s_y: number;
  sector_info: string;
  landed: string;
  locations: Location[];
};

type Location = {
  name: string;
  x: number;
  y: number;
  reference: string;
};

const FlightData = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { ETAnext, speed, accel, heading, accellimit } = data;
  return (
    <Section title="Flight Data" fill>
      <LabeledList>
        <LabeledList.Item label="ETA to next grid">{ETAnext}</LabeledList.Item>
        <LabeledList.Item label="Speed">{speed + ' Gm/h'}</LabeledList.Item>
        <LabeledList.Item label="Acceleration">{accel}</LabeledList.Item>
        <LabeledList.Item label="Heading">{heading + '°'}</LabeledList.Item>
        <LabeledList.Item label="Acceleration limiter">
          <NumberInput
            width="65px"
            unit="Gm/h"
            step={1}
            stepPixelSize={1}
            minValue={1}
            maxValue={10}
            value={accellimit}
            onDrag={(e, value) => act('accellimit', { value: value })}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const ManualControl = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { manual_control, canburn, distress, viewing_silicon } = data;
  return (
    <Section title="Manual Control" fill>
      <Flex align="stretch" justify="center">
        <Box>
          <Table mt={3.5}>
            <Table.Cell>
              <Table.Row>
                <Button
                  icon="arrow-left"
                  iconRotation={45}
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 9,
                    })
                  }
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="arrow-left"
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 8,
                    })
                  }
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="arrow-left"
                  iconRotation={-45}
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 10,
                    })
                  }
                />
              </Table.Row>
            </Table.Cell>
            <Table.Cell>
              <Table.Row>
                <Button
                  icon="arrow-up"
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 1,
                    })
                  }
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="times-circle"
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() => act('brake')}
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="arrow-down"
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 2,
                    })
                  }
                />
              </Table.Row>
            </Table.Cell>
            <Table.Cell>
              <Table.Row>
                <Button
                  icon="arrow-right"
                  disabled={!canburn || viewing_silicon === 1}
                  iconRotation={-45}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 5,
                    })
                  }
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="arrow-right"
                  disabled={!canburn || viewing_silicon === 1}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 4,
                    })
                  }
                />
              </Table.Row>
              <Table.Row>
                <Button
                  icon="arrow-right"
                  disabled={!canburn || viewing_silicon === 1}
                  iconRotation={45}
                  mb={1}
                  onClick={() =>
                    act('move', {
                      value: 6,
                    })
                  }
                />
              </Table.Row>
            </Table.Cell>
          </Table>
        </Box>
      </Flex>
      <Flex justify="space-between">
        <Flex.Item>{'Direct control'}</Flex.Item>
        <Flex.Item>
          <Button
            icon="random"
            disabled={viewing_silicon === 1}
            selected={manual_control}
            onClick={() => act('manual')}
          />
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex justify="space-between">
        <Flex.Item>{'Distress call'}</Flex.Item>
        <Flex.Item>
          <Button
            icon="exclamation-triangle"
            disabled={viewing_silicon === 1}
            selected={distress}
            onClick={() => act('distress')}
          />
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const Autopilot = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { dest, d_x, d_y, speedlimit, autopilot, viewing_silicon } = data;
  return (
    <Section
      title="Autopilot"
      buttons={
        <Button
          icon={autopilot ? 'toggle-on' : 'toggle-off'}
          disabled={!dest || viewing_silicon === 1}
          selected={autopilot}
          onClick={() => act('apilot')}
        />
      }
      fill>
      <LabeledList>
        <LabeledList.Item label="Target">
          {dest ? (
            <>
              <NumberInput
                width="22px"
                step={1}
                stepPixelSize={1}
                minValue={1}
                maxValue={200}
                value={d_x}
                onDrag={(e, value) => act('setx', { new_x: value })}
              />
              <NumberInput
                width="22px"
                step={1}
                stepPixelSize={1}
                minValue={1}
                maxValue={200}
                value={d_y}
                onDrag={(e, value) => act('sety', { new_y: value })}
              />
              <Button disabled={viewing_silicon === 1} icon="trash-alt" onClick={() => act('reset')} />
            </>
          ) : (
            <Button disabled={viewing_silicon === 1} content="None" onClick={() => act('setcords')} />
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Speed limit">
          <NumberInput
            width="65px"
            unit="Gm/h"
            step={1}
            stepPixelSize={1}
            minValue={1}
            maxValue={5}
            value={speedlimit}
            onDrag={(e, value) => act('speedlimit', { value: value })}
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const NavigationData = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { locations, sector, s_x, s_y, sector_info, landed, viewing_silicon } = data;
  return (
    <>
      <Section title="Navigation data">
        <LabeledList>
          <LabeledList.Item label="Location">{sector}</LabeledList.Item>
          <LabeledList.Item label="Coordinates">{s_x + ' : ' + s_y}</LabeledList.Item>
          <LabeledList.Item label="Scan Data">{sector_info}</LabeledList.Item>
          <LabeledList.Item label="Status">{landed}</LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Saved locations"
        buttons={
          <>
            <Button icon="save" disabled={viewing_silicon === 1} onClick={() => act('add', { loc: 'current' })} />
            <Button icon="file-medical" disabled={viewing_silicon === 1} onClick={() => act('add', { loc: 'new' })} />
          </>
        }>
        <Table>
          <Table.Row header>
            <Table.Cell>Name</Table.Cell>
            <Table.Cell>Coordinates</Table.Cell>
            <Table.Cell>Actions</Table.Cell>
          </Table.Row>
          {locations?.map((location) => (
            <Table.Row key={location.reference} className="candystripe">
              <Table.Cell>{location.name}</Table.Cell>
              <Table.Cell>{location.x + ' : ' + location.y}</Table.Cell>
              <Table.Cell>
                <Button
                  icon="plane"
                  content="Plot course"
                  disabled={viewing_silicon === 1}
                  onClick={() => {
                    act('setx', { new_x: location.x });
                    act('sety', { new_y: location.y });
                  }}
                />
                <Button
                  disabled={viewing_silicon === 1}
                  icon="trash"
                  color="red"
                  onClick={() => act('remove', { ref: location.reference })}
                />
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Section>
    </>
  );
};

export const ShipHelmControl = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { viewing_silicon } = data;
  return (
    <Window width={590} height={600}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>{viewing_silicon === 1 && <NoticeBox>{'AI SYSTEM DETECTED!'}</NoticeBox>}</Stack.Item>
          <Stack.Item height={'200px'}>
            <Stack fill>
              <Stack.Item width={'220px'}>
                <FlightData />
              </Stack.Item>
              <Stack.Item width={'160px'}>
                <ManualControl />
              </Stack.Item>
              <Stack.Item width={'190px'}>
                <Autopilot />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item grow>
            <NavigationData />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
