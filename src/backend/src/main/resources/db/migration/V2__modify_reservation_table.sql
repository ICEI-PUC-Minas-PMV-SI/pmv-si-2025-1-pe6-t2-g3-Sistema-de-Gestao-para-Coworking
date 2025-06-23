ALTER TABLE reservation
ADD COLUMN reservation_date DATE;

UPDATE reservation
SET reservation_date = DATE(start_time);

ALTER TABLE reservation
DROP COLUMN start_time,
DROP COLUMN end_time;

ALTER TABLE reservation
ALTER COLUMN reservation_date SET NOT NULL;