-- Case-insensitive is the default but we're playing it safe
UPDATE erro_ban SET role="Borer" WHERE role="borer";
UPDATE erro_ban SET role="Xenomorph" WHERE role="xeno";
-- UPDATE erro_ban SET role="actor" WHERE role="actor"; -- Same
UPDATE erro_ban SET role="ert" WHERE role="Emergency Response Team";
UPDATE erro_ban SET role="mercenary" WHERE role="operative";
-- UPDATE erro_ban SET role="raider" WHERE role="raider"; -- Same
-- UPDATE erro_ban SET role="wizard" WHERE role="wizard"; -- Same
-- UPDATE erro_ban SET role="changeling" WHERE role="changeling"; -- Same
-- UPDATE erro_ban SET role="cultist" WHERE role="cultist"; -- Same
-- UPDATE erro_ban SET role="loyalist" WHERE role="loyalist"; -- Same
-- UPDATE erro_ban SET role="revolutionary" WHERE role="revolutionary"; -- Same
