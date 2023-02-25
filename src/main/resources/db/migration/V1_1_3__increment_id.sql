CREATE SEQUENCE users_sequence
    start 2
    increment 1;

ALTER TABLE usr ALTER COLUMN id SET DEFAULT nextval('users_sequence')