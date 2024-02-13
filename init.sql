CREATE SEQUENCE user_sequence
  INCREMENT 1
  START 1;
CREATE SEQUENCE quiz_sequence
  INCREMENT 1
  START 1;
CREATE SEQUENCE scenario_sequence
  INCREMENT 1
  START 1;

CREATE TABLE users
(
  sequence_id bigint PRIMARY KEY UNIQUE NOT NULL DEFAULT nextval('user_sequence'::regclass),
  first_name character varying(64) NOT NULL,
  last_name character varying(64) NOT NULL,
  id character varying(64) NOT NULL,
  active boolean DEFAULT true,
  last_modified timestamp with time zone DEFAULT now()
);

CREATE TABLE quiz
(
  sequence_id bigint PRIMARY KEY UNIQUE NOT NULL DEFAULT nextval('quiz_sequence'::regclass),
  question character varying(2048) NOT NULL,
  choice_0 character varying(1024) NOT NULL,
  choice_1 character varying(1024) NOT NULL,
  choice_2 character varying(1024) NOT NULL,
  choice_3 character varying(1024) NOT NULL,
  answer_index smallint NOT NULL,
  active boolean NOT NULL DEFAULT true,
  last_modified timestamp with time zone DEFAULT now(),
  last_modified_by_user_sequence bigint references users(sequence_id)
);

CREATE TABLE quiz_attempt
(
  sequence_id bigint PRIMARY KEY UNIQUE NOT NULL DEFAULT nextval('quiz_sequence'::regclass),
  question_sequence bigint references quiz(sequence_id),
  user_sequence bigint references users(sequence_id),
  answer_index smallint NOT NULL,
  last_modified timestamp with time zone DEFAULT now()
);

CREATE TABLE scenario
(
  sequence_id bigint PRIMARY KEY UNIQUE NOT NULL DEFAULT nextval('scenario_sequence'::regclass),
  dob date NOT NULL,
  gender character(1),
  first_name character varying(64) NOT NULL,
  last_name character varying(64) NOT NULL,
  vitals_0 json,
  vitals_1 json,
  vitals_posttreatment_0 json,
  vitals_posttreatment_1 json,
  vitals_reassess_0 json,
  vitals_reassess_1 json,
  chief_complaint character varying(128),
  chief_complaint_type character varying(128), -- ie respiratory
  lights_and_siren boolean,

  active boolean DEFAULT true,
  last_modified timestamp with time zone DEFAULT now(),
  last_modified_by_user_sequence bigint references users(sequence_id)
);
