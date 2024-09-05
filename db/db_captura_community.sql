--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: mobileforms_database; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mobileforms_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE mobileforms_database OWNER TO postgres;

\connect mobileforms_database

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: applications; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA applications;


ALTER SCHEMA applications OWNER TO postgres;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA core;


ALTER SCHEMA core OWNER TO postgres;

--
-- Name: forms; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA forms;


ALTER SCHEMA forms OWNER TO postgres;

--
-- Name: i18n; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA i18n;


ALTER SCHEMA i18n OWNER TO postgres;

--
-- Name: log; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA log;


ALTER SCHEMA log OWNER TO postgres;

--
-- Name: mail; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mail;


ALTER SCHEMA mail OWNER TO postgres;

--
-- Name: mf_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mf_data;


ALTER SCHEMA mf_data OWNER TO postgres;

--
-- Name: pools; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pools;


ALTER SCHEMA pools OWNER TO postgres;

--
-- Name: projects; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA projects;


ALTER SCHEMA projects OWNER TO postgres;

--
-- Name: reports; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA reports;


ALTER SCHEMA reports OWNER TO postgres;

--
-- Name: scripting; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA scripting;


ALTER SCHEMA scripting OWNER TO postgres;

--
-- Name: sys; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sys;


ALTER SCHEMA sys OWNER TO postgres;

--
-- Name: ui; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ui;


ALTER SCHEMA ui OWNER TO postgres;

--
-- Name: workflow; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA workflow;


ALTER SCHEMA workflow OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: application_users; Type: TABLE; Schema: applications; Owner: postgres
--

CREATE TABLE applications.application_users (
    user_id bigint NOT NULL,
    application_id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE applications.application_users OWNER TO postgres;

--
-- Name: applications; Type: TABLE; Schema: applications; Owner: postgres
--

CREATE TABLE applications.applications (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    defaultlanguage character varying(255) DEFAULT 'en'::character varying NOT NULL,
    name character varying(255),
    owner_id bigint NOT NULL,
    initial_setup_ready boolean DEFAULT false NOT NULL,
    default_time_zone character varying(5) DEFAULT 'GMT'::character varying,
    has_workflow boolean DEFAULT false NOT NULL
);


ALTER TABLE applications.applications OWNER TO postgres;

--
-- Name: parameters; Type: TABLE; Schema: applications; Owner: postgres
--

CREATE TABLE applications.parameters (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    parameter_id bigint NOT NULL,
    description character varying(255),
    label character varying(255),
    type integer,
    value character varying(255),
    application_id bigint NOT NULL
);


ALTER TABLE applications.parameters OWNER TO postgres;

--
-- Name: seq_applications; Type: SEQUENCE; Schema: applications; Owner: postgres
--

CREATE SEQUENCE applications.seq_applications
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE applications.seq_applications OWNER TO postgres;

--
-- Name: seq_applications_parameters; Type: SEQUENCE; Schema: applications; Owner: postgres
--

CREATE SEQUENCE applications.seq_applications_parameters
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE applications.seq_applications_parameters OWNER TO postgres;

--
-- Name: authorizable_entities; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.authorizable_entities (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now()
);


ALTER TABLE core.authorizable_entities OWNER TO postgres;

--
-- Name: authorizable_entities_authorizations; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.authorizable_entities_authorizations (
    authorizable_entity_id bigint NOT NULL,
    role_id bigint,
    application_id bigint,
    project_id bigint,
    form_id bigint,
    id bigint NOT NULL,
    pool_id bigint,
    auth_level integer NOT NULL
);


ALTER TABLE core.authorizable_entities_authorizations OWNER TO postgres;

--
-- Name: authorization_dependencies; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.authorization_dependencies (
    base_auth character varying(255) NOT NULL,
    granted_auth character varying(255) NOT NULL
);


ALTER TABLE core.authorization_dependencies OWNER TO postgres;

--
-- Name: authorizations; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.authorizations (
    name character varying(255) NOT NULL,
    auth_level integer,
    auth_group character varying(50),
    visible boolean DEFAULT true NOT NULL
);


ALTER TABLE core.authorizations OWNER TO postgres;

--
-- Name: devices; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.devices (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    phone_number character varying(255),
    model character varying(2048),
    brand character varying(2048),
    os character varying(256),
    identifier character varying(512),
    version_number character varying(32),
    application_id bigint NOT NULL,
    manufacturer character varying(256),
    product character varying(256),
    release character varying(256),
    blacklisted boolean DEFAULT false
);


ALTER TABLE core.devices OWNER TO postgres;

--
-- Name: groups; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.groups (
    description character varying(255),
    name character varying(255) NOT NULL,
    id bigint NOT NULL,
    application_id bigint
);


ALTER TABLE core.groups OWNER TO postgres;

--
-- Name: groups_users; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.groups_users (
    group_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE core.groups_users OWNER TO postgres;

--
-- Name: role_grants_authorization; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.role_grants_authorization (
    role_id bigint NOT NULL,
    authorization_name character varying(255) NOT NULL
);


ALTER TABLE core.role_grants_authorization OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.roles (
    id bigint NOT NULL,
    application_id bigint,
    editable boolean DEFAULT true NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    auth_level integer,
    description character varying(500),
    name character varying(500)
);


ALTER TABLE core.roles OWNER TO postgres;

--
-- Name: seq_authorizable_entities; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_authorizable_entities
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_authorizable_entities OWNER TO postgres;

--
-- Name: seq_authorizable_entities_authorizations; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_authorizable_entities_authorizations
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_authorizable_entities_authorizations OWNER TO postgres;

--
-- Name: seq_authorizations; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_authorizations
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_authorizations OWNER TO postgres;

--
-- Name: seq_brand_devices; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_brand_devices
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_brand_devices OWNER TO postgres;

--
-- Name: seq_core_roles; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_core_roles
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_core_roles OWNER TO postgres;

--
-- Name: seq_devices; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_devices
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_devices OWNER TO postgres;

--
-- Name: seq_model_devices; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_model_devices
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_model_devices OWNER TO postgres;

--
-- Name: seq_tokens; Type: SEQUENCE; Schema: core; Owner: postgres
--

CREATE SEQUENCE core.seq_tokens
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE core.seq_tokens OWNER TO postgres;

--
-- Name: tokens; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.tokens (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    token character varying(255) NOT NULL,
    expires timestamp with time zone,
    purpose integer NOT NULL,
    grantee_id bigint NOT NULL,
    granter_id bigint,
    application_id bigint
);


ALTER TABLE core.tokens OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.users (
    expirationdate date,
    first_name character varying(512) NOT NULL,
    language character varying(255),
    last_name character varying(512),
    mail character varying(250),
    password character varying(512) NOT NULL,
    id bigint NOT NULL,
    default_application bigint,
    former_mail character varying(512),
    system_administrator boolean DEFAULT false NOT NULL,
    secure_password character varying(256),
    salt character varying(64)
);


ALTER TABLE core.users OWNER TO postgres;

--
-- Name: users_devices; Type: TABLE; Schema: core; Owner: postgres
--

CREATE TABLE core.users_devices (
    user_id bigint,
    device_id bigint
);


ALTER TABLE core.users_devices OWNER TO postgres;

--
-- Name: element_instances; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.element_instances (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    "position" integer NOT NULL,
    required boolean,
    visible boolean,
    prototype_id bigint,
    page_id bigint,
    field_name character varying(1024),
    instance_id character varying(255),
    default_value_column character varying(512),
    default_value_lookup bigint
);


ALTER TABLE forms.element_instances OWNER TO postgres;

--
-- Name: element_prototypes; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.element_prototypes (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    required boolean NOT NULL,
    visible boolean NOT NULL,
    pool_id bigint,
    application_id bigint,
    lock_version integer,
    root_id bigint,
    version bigint NOT NULL,
    instantiability integer DEFAULT 0 NOT NULL,
    default_language character varying(3) NOT NULL
);


ALTER TABLE forms.element_prototypes OWNER TO postgres;

--
-- Name: element_prototypes_last_version_view; Type: VIEW; Schema: forms; Owner: postgres
--

CREATE VIEW forms.element_prototypes_last_version_view AS
 SELECT root_id,
    max(version) AS version
   FROM forms.element_prototypes ep
  GROUP BY root_id;


ALTER VIEW forms.element_prototypes_last_version_view OWNER TO postgres;

--
-- Name: elements_barcodes; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_barcodes (
    id bigint NOT NULL
);


ALTER TABLE forms.elements_barcodes OWNER TO postgres;

--
-- Name: elements_checkboxes; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_checkboxes (
    checked boolean,
    id bigint NOT NULL
);


ALTER TABLE forms.elements_checkboxes OWNER TO postgres;

--
-- Name: elements_filters; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_filters (
    id bigint NOT NULL,
    filter_type integer NOT NULL,
    column_name character varying(512) NOT NULL,
    comparison_operator integer NOT NULL,
    element_instance_id bigint NOT NULL,
    right_value character varying(512)
);


ALTER TABLE forms.elements_filters OWNER TO postgres;

--
-- Name: elements_headlines; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_headlines (
    id bigint NOT NULL
);


ALTER TABLE forms.elements_headlines OWNER TO postgres;

--
-- Name: elements_inputs; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_inputs (
    max_length integer,
    min_length integer,
    read_only boolean NOT NULL,
    type character varying(255),
    id bigint NOT NULL,
    default_value character varying(255)
);


ALTER TABLE forms.elements_inputs OWNER TO postgres;

--
-- Name: elements_labels; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_labels (
    element_id bigint NOT NULL,
    value character varying(1024),
    language character varying(16) NOT NULL
);


ALTER TABLE forms.elements_labels OWNER TO postgres;

--
-- Name: elements_locations; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_locations (
    id bigint NOT NULL,
    default_latitude double precision,
    default_longitude double precision
);


ALTER TABLE forms.elements_locations OWNER TO postgres;

--
-- Name: elements_photos; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_photos (
    filename character varying(255),
    id bigint NOT NULL,
    camera_only boolean DEFAULT false NOT NULL
);


ALTER TABLE forms.elements_photos OWNER TO postgres;

--
-- Name: elements_selects; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_selects (
    lookup_label character varying(255),
    lookup_value character varying(255),
    multiple boolean NOT NULL,
    id bigint NOT NULL,
    lookup_identifier bigint,
    option_source smallint DEFAULT '0'::smallint NOT NULL,
    default_value character varying(255)
);


ALTER TABLE forms.elements_selects OWNER TO postgres;

--
-- Name: elements_signatures; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.elements_signatures (
    id bigint NOT NULL
);


ALTER TABLE forms.elements_signatures OWNER TO postgres;

--
-- Name: flows; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.flows (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    default_target character varying(255)
);


ALTER TABLE forms.flows OWNER TO postgres;

--
-- Name: flows_targets; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.flows_targets (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    operator character varying(255) NOT NULL,
    element_id character varying(255) NOT NULL,
    preaction character varying(255),
    target character varying(255),
    element_value character varying(255) NOT NULL,
    flow_id bigint NOT NULL
);


ALTER TABLE forms.flows_targets OWNER TO postgres;

--
-- Name: form_xml_cache; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.form_xml_cache (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    form_id bigint NOT NULL
);


ALTER TABLE forms.form_xml_cache OWNER TO postgres;

--
-- Name: form_xml_cache_xml; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.form_xml_cache_xml (
    form_xml_cache_id bigint NOT NULL,
    value text,
    language character varying(16) NOT NULL
);


ALTER TABLE forms.form_xml_cache_xml OWNER TO postgres;

--
-- Name: forms; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.forms (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    acceptdata boolean,
    dataset_definition character varying(255),
    default_language character varying(16) NOT NULL,
    published boolean NOT NULL,
    root_id bigint,
    project_id bigint NOT NULL,
    version bigint DEFAULT '1'::bigint NOT NULL,
    dataset_version bigint,
    lock_version integer,
    was_published boolean DEFAULT false NOT NULL,
    published_date timestamp with time zone,
    published_version bigint,
    provide_location boolean DEFAULT false
);


ALTER TABLE forms.forms OWNER TO postgres;

--
-- Name: forms_labels; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.forms_labels (
    form_id bigint NOT NULL,
    value character varying(1024),
    language character varying(16) NOT NULL
);


ALTER TABLE forms.forms_labels OWNER TO postgres;

--
-- Name: forms_languages; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.forms_languages (
    form_id bigint NOT NULL,
    languages character varying(255)
);


ALTER TABLE forms.forms_languages OWNER TO postgres;

--
-- Name: forms_last_version_view; Type: VIEW; Schema: forms; Owner: postgres
--

CREATE VIEW forms.forms_last_version_view AS
 SELECT root_id,
    max(version) AS version
   FROM forms.forms f
  GROUP BY root_id;


ALTER VIEW forms.forms_last_version_view OWNER TO postgres;

--
-- Name: forms_published_view; Type: VIEW; Schema: forms; Owner: postgres
--

CREATE VIEW forms.forms_published_view AS
 SELECT root_id,
    max(version) AS version
   FROM forms.forms f
  GROUP BY root_id, published
 HAVING (published = true);


ALTER VIEW forms.forms_published_view OWNER TO postgres;

--
-- Name: forms_was_published_view; Type: VIEW; Schema: forms; Owner: postgres
--

CREATE VIEW forms.forms_was_published_view AS
 SELECT DISTINCT root_id
   FROM forms.forms f
  GROUP BY root_id, was_published
 HAVING (was_published = true);


ALTER VIEW forms.forms_was_published_view OWNER TO postgres;

--
-- Name: pages; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.pages (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    on_load character varying(255),
    on_unload character varying(255),
    "position" integer NOT NULL,
    save boolean NOT NULL,
    flow_id bigint,
    form_id bigint NOT NULL,
    instance_id character varying(255),
    default_language character varying(3) NOT NULL
);


ALTER TABLE forms.pages OWNER TO postgres;

--
-- Name: pages_labels; Type: TABLE; Schema: forms; Owner: postgres
--

CREATE TABLE forms.pages_labels (
    page_id bigint NOT NULL,
    value character varying(1024),
    language character varying(16) NOT NULL
);


ALTER TABLE forms.pages_labels OWNER TO postgres;

--
-- Name: seq_element_instances; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_element_instances
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_element_instances OWNER TO postgres;

--
-- Name: seq_element_prototypes; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_element_prototypes
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_element_prototypes OWNER TO postgres;

--
-- Name: seq_elements_filters; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_elements_filters
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_elements_filters OWNER TO postgres;

--
-- Name: seq_flows; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_flows
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_flows OWNER TO postgres;

--
-- Name: seq_flows_targets; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_flows_targets
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_flows_targets OWNER TO postgres;

--
-- Name: seq_forms; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_forms
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_forms OWNER TO postgres;

--
-- Name: seq_forms_xml_cache; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_forms_xml_cache
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_forms_xml_cache OWNER TO postgres;

--
-- Name: seq_pages; Type: SEQUENCE; Schema: forms; Owner: postgres
--

CREATE SEQUENCE forms.seq_pages
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE forms.seq_pages OWNER TO postgres;

--
-- Name: labels; Type: TABLE; Schema: i18n; Owner: postgres
--

CREATE TABLE i18n.labels (
    language_id bigint NOT NULL,
    value character varying(1024),
    key character varying(512) NOT NULL
);


ALTER TABLE i18n.labels OWNER TO postgres;

--
-- Name: languages; Type: TABLE; Schema: i18n; Owner: postgres
--

CREATE TABLE i18n.languages (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    iso_language character varying(255) NOT NULL,
    name character varying(255)
);


ALTER TABLE i18n.languages OWNER TO postgres;

--
-- Name: seq_languages; Type: SEQUENCE; Schema: i18n; Owner: postgres
--

CREATE SEQUENCE i18n.seq_languages
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE i18n.seq_languages OWNER TO postgres;

--
-- Name: logins; Type: TABLE; Schema: log; Owner: postgres
--

CREATE TABLE log.logins (
    id integer NOT NULL,
    login_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id bigint,
    application_id bigint,
    login_type_value character varying(255)
);


ALTER TABLE log.logins OWNER TO postgres;

--
-- Name: seq_logins; Type: SEQUENCE; Schema: log; Owner: postgres
--

CREATE SEQUENCE log.seq_logins
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE log.seq_logins OWNER TO postgres;

--
-- Name: seq_uncaught_exceptions; Type: SEQUENCE; Schema: log; Owner: postgres
--

CREATE SEQUENCE log.seq_uncaught_exceptions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE log.seq_uncaught_exceptions OWNER TO postgres;

--
-- Name: uncaught_exceptions; Type: TABLE; Schema: log; Owner: postgres
--

CREATE TABLE log.uncaught_exceptions (
    id integer NOT NULL,
    exception_type character varying(250),
    insert_time timestamp with time zone DEFAULT now() NOT NULL,
    offending_class character varying(250),
    url character varying(250),
    user_agent character varying(250),
    user_id bigint,
    stack_trace text
);


ALTER TABLE log.uncaught_exceptions OWNER TO postgres;

--
-- Name: queue; Type: TABLE; Schema: mail; Owner: postgres
--

CREATE TABLE mail.queue (
    id bigint NOT NULL,
    body text,
    mail_from character varying(255),
    inserted timestamp with time zone DEFAULT now() NOT NULL,
    sent boolean NOT NULL,
    subject character varying(255),
    mail_to character varying(255),
    html boolean DEFAULT false NOT NULL,
    attempts bigint DEFAULT 0 NOT NULL
);


ALTER TABLE mail.queue OWNER TO postgres;

--
-- Name: seq_mail_queue; Type: SEQUENCE; Schema: mail; Owner: postgres
--

CREATE SEQUENCE mail.seq_mail_queue
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mail.seq_mail_queue OWNER TO postgres;

--
-- Name: connectors; Type: TABLE; Schema: mf_data; Owner: postgres
--

CREATE TABLE mf_data.connectors (
    id bigint NOT NULL,
    application_id bigint,
    name character varying(250),
    connector_type character varying(50),
    direction character varying(50),
    user_id bigint
);


ALTER TABLE mf_data.connectors OWNER TO postgres;

--
-- Name: lookuptables; Type: TABLE; Schema: mf_data; Owner: postgres
--

CREATE TABLE mf_data.lookuptables (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    project_id bigint,
    dataset_definition character varying(250) NOT NULL,
    next_version bigint,
    previous_version bigint,
    default_language character varying(16),
    dataset_version bigint DEFAULT 0 NOT NULL,
    option_source smallint DEFAULT '0'::smallint,
    application_id bigint,
    owner_id bigint NOT NULL,
    last_ddl_ip character varying(39),
    is_rest boolean DEFAULT false,
    identifier character varying(250),
    name character varying(250)
);


ALTER TABLE mf_data.lookuptables OWNER TO postgres;

--
-- Name: seq_connectors_id; Type: SEQUENCE; Schema: mf_data; Owner: postgres
--

CREATE SEQUENCE mf_data.seq_connectors_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mf_data.seq_connectors_id OWNER TO postgres;

--
-- Name: seq_lookuptable_id; Type: SEQUENCE; Schema: mf_data; Owner: postgres
--

CREATE SEQUENCE mf_data.seq_lookuptable_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mf_data.seq_lookuptable_id OWNER TO postgres;

--
-- Name: seq_uploads; Type: SEQUENCE; Schema: mf_data; Owner: postgres
--

CREATE SEQUENCE mf_data.seq_uploads
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mf_data.seq_uploads OWNER TO postgres;

--
-- Name: uploads; Type: TABLE; Schema: mf_data; Owner: postgres
--

CREATE TABLE mf_data.uploads (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    device_id character varying(255) NOT NULL,
    size bigint NOT NULL,
    received bigint,
    status character varying(255) NOT NULL,
    random_str character varying(32),
    created_at timestamp with time zone DEFAULT now(),
    modified_at timestamp with time zone DEFAULT now(),
    error_desc text,
    document_id character varying(255),
    completed_at timestamp with time zone,
    saved_at timestamp with time zone,
    bypass_uniqueness_check boolean DEFAULT false NOT NULL,
    application_id bigint
);


ALTER TABLE mf_data.uploads OWNER TO postgres;

--
-- Name: pools; Type: TABLE; Schema: pools; Owner: postgres
--

CREATE TABLE pools.pools (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    description character varying(255),
    name character varying(255),
    application_id bigint,
    owner_id bigint NOT NULL
);


ALTER TABLE pools.pools OWNER TO postgres;

--
-- Name: seq_pools; Type: SEQUENCE; Schema: pools; Owner: postgres
--

CREATE SEQUENCE pools.seq_pools
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pools.seq_pools OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: projects; Owner: postgres
--

CREATE TABLE projects.projects (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    defaultlanguage character varying(255) DEFAULT 'en'::character varying NOT NULL,
    application_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    lock_version integer
);


ALTER TABLE projects.projects OWNER TO postgres;

--
-- Name: projects_details; Type: TABLE; Schema: projects; Owner: postgres
--

CREATE TABLE projects.projects_details (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    description character varying(255),
    label character varying(255) NOT NULL,
    language character varying(255) NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE projects.projects_details OWNER TO postgres;

--
-- Name: seq_projects; Type: SEQUENCE; Schema: projects; Owner: postgres
--

CREATE SEQUENCE projects.seq_projects
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE projects.seq_projects OWNER TO postgres;

--
-- Name: seq_projects_details; Type: SEQUENCE; Schema: projects; Owner: postgres
--

CREATE SEQUENCE projects.seq_projects_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE projects.seq_projects_details OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(63) NOT NULL,
    author character varying(63) NOT NULL,
    filename character varying(200) NOT NULL,
    dateexecuted timestamp with time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp with time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hibernate_sequence OWNER TO postgres;

--
-- Name: queries; Type: TABLE; Schema: reports; Owner: postgres
--

CREATE TABLE reports.queries (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    form_id bigint NOT NULL,
    default_query boolean DEFAULT false NOT NULL,
    selected_table_columns text,
    selected_csv_columns text,
    filter_options text,
    download_locations_as_links boolean DEFAULT false NOT NULL,
    selected_sorting_columns text,
    elements_file_names text
);


ALTER TABLE reports.queries OWNER TO postgres;

--
-- Name: seq_querys; Type: SEQUENCE; Schema: reports; Owner: postgres
--

CREATE SEQUENCE reports.seq_querys
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports.seq_querys OWNER TO postgres;

--
-- Name: seq_querys_column; Type: SEQUENCE; Schema: reports; Owner: postgres
--

CREATE SEQUENCE reports.seq_querys_column
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports.seq_querys_column OWNER TO postgres;

--
-- Name: seq_querys_filters; Type: SEQUENCE; Schema: reports; Owner: postgres
--

CREATE SEQUENCE reports.seq_querys_filters
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports.seq_querys_filters OWNER TO postgres;

--
-- Name: scripts; Type: TABLE; Schema: scripting; Owner: postgres
--

CREATE TABLE scripting.scripts (
    id bigint NOT NULL,
    script_name character varying(255) NOT NULL,
    script_code text NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE scripting.scripts OWNER TO postgres;

--
-- Name: seq_script; Type: SEQUENCE; Schema: scripting; Owner: postgres
--

CREATE SEQUENCE scripting.seq_script
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scripting.seq_script OWNER TO postgres;

--
-- Name: acme_launchers; Type: TABLE; Schema: sys; Owner: postgres
--

CREATE TABLE sys.acme_launchers (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    launch_type smallint NOT NULL,
    js_code character varying(500),
    view_id integer,
    js_amd character varying(100),
    authorization_name character varying(255)
);


ALTER TABLE sys.acme_launchers OWNER TO postgres;

--
-- Name: acme_tree_menu; Type: TABLE; Schema: sys; Owner: postgres
--

CREATE TABLE sys.acme_tree_menu (
    id integer NOT NULL,
    i18n_title character varying(100) NOT NULL,
    i18n_description character varying(100),
    toolbox boolean NOT NULL,
    parent_id integer,
    tree_lft integer,
    tree_rgt integer,
    "position" integer,
    root integer,
    launcher_id integer,
    visible boolean DEFAULT true,
    active boolean DEFAULT true
);


ALTER TABLE sys.acme_tree_menu OWNER TO postgres;

--
-- Name: acme_views; Type: TABLE; Schema: sys; Owner: postgres
--

CREATE TABLE sys.acme_views (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    js_amd character varying(100),
    url_view character varying(250),
    toolbox_root integer,
    show_menu boolean,
    show_toolbox boolean,
    show_navigator boolean,
    trigger_navigator_link boolean DEFAULT true
);


ALTER TABLE sys.acme_views OWNER TO postgres;

--
-- Name: authorizations_groups; Type: TABLE; Schema: sys; Owner: postgres
--

CREATE TABLE sys.authorizations_groups (
    i18n_name character varying(50) NOT NULL,
    "position" integer DEFAULT 0
);


ALTER TABLE sys.authorizations_groups OWNER TO postgres;

--
-- Name: parameters; Type: TABLE; Schema: sys; Owner: postgres
--

CREATE TABLE sys.parameters (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    description character varying(255),
    label character varying(255),
    type integer,
    value character varying(255)
);


ALTER TABLE sys.parameters OWNER TO postgres;

--
-- Name: seq_acme_launchers; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_acme_launchers
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sys.seq_acme_launchers OWNER TO postgres;

--
-- Name: seq_acme_module; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_acme_module
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sys.seq_acme_module OWNER TO postgres;

--
-- Name: seq_acme_tree_menu; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_acme_tree_menu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sys.seq_acme_tree_menu OWNER TO postgres;

--
-- Name: seq_acme_views; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_acme_views
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sys.seq_acme_views OWNER TO postgres;

--
-- Name: seq_deploy; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_deploy
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sys.seq_deploy OWNER TO postgres;

--
-- Name: seq_parameters; Type: SEQUENCE; Schema: sys; Owner: postgres
--

CREATE SEQUENCE sys.seq_parameters
    START WITH 1050
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
    CYCLE;


ALTER SEQUENCE sys.seq_parameters OWNER TO postgres;

--
-- Name: multiselect_conf; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.multiselect_conf (
    id character varying(512) NOT NULL,
    service_name character varying(512) NOT NULL
);


ALTER TABLE ui.multiselect_conf OWNER TO postgres;

--
-- Name: seq_states; Type: SEQUENCE; Schema: workflow; Owner: postgres
--

CREATE SEQUENCE workflow.seq_states
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflow.seq_states OWNER TO postgres;

--
-- Name: seq_transitions; Type: SEQUENCE; Schema: workflow; Owner: postgres
--

CREATE SEQUENCE workflow.seq_transitions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflow.seq_transitions OWNER TO postgres;

--
-- Name: states; Type: TABLE; Schema: workflow; Owner: postgres
--

CREATE TABLE workflow.states (
    id bigint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    description character varying(1000),
    form_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    initial boolean,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now()
);


ALTER TABLE workflow.states OWNER TO postgres;

--
-- Name: states_roles; Type: TABLE; Schema: workflow; Owner: postgres
--

CREATE TABLE workflow.states_roles (
    state_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE workflow.states_roles OWNER TO postgres;

--
-- Name: transitions; Type: TABLE; Schema: workflow; Owner: postgres
--

CREATE TABLE workflow.transitions (
    id bigint NOT NULL,
    active boolean DEFAULT true,
    description character varying(255),
    origin_state bigint,
    target_state bigint NOT NULL,
    created timestamp with time zone DEFAULT now() NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    modified timestamp with time zone DEFAULT now(),
    form_id bigint NOT NULL
);


ALTER TABLE workflow.transitions OWNER TO postgres;

--
-- Name: transitions_roles; Type: TABLE; Schema: workflow; Owner: postgres
--

CREATE TABLE workflow.transitions_roles (
    transition_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE workflow.transitions_roles OWNER TO postgres;

--
-- Data for Name: application_users; Type: TABLE DATA; Schema: applications; Owner: postgres
--

COPY applications.application_users (user_id, application_id, status) FROM stdin;
2	1	0
3	1	0
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: applications; Owner: postgres
--

COPY applications.applications (id, active, created, deleted, modified, defaultlanguage, name, owner_id, initial_setup_ready, default_time_zone, has_workflow) FROM stdin;
1	t	2021-03-20 15:55:13.833055+00	f	\N	en	TestAppMF	2	f	\N	f
\.


--
-- Data for Name: parameters; Type: TABLE DATA; Schema: applications; Owner: postgres
--

COPY applications.parameters (id, active, created, deleted, modified, parameter_id, description, label, type, value, application_id) FROM stdin;
\.


--
-- Data for Name: authorizable_entities; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.authorizable_entities (id, active, created, deleted, modified) FROM stdin;
1	t	2021-03-20 15:55:13.67944+00	f	\N
2	t	2021-03-20 15:55:13.809965+00	f	\N
3	t	2023-12-09 18:25:31.617211+00	f	\N
4	t	2023-12-09 18:38:01.823875+00	f	\N
5	f	2023-12-09 20:08:37.442591+00	t	\N
\.


--
-- Data for Name: authorizable_entities_authorizations; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.authorizable_entities_authorizations (authorizable_entity_id, role_id, application_id, project_id, form_id, id, pool_id, auth_level) FROM stdin;
1	1	\N	\N	\N	1	\N	0
2	2	1	\N	\N	2	\N	1
2	4	\N	1	\N	3	\N	2
2	5	\N	\N	1	4	\N	3
3	7	1	\N	\N	5	\N	1
1	3	1	\N	\N	6	\N	1
1	4	\N	2	\N	7	\N	2
1	5	\N	\N	3	8	\N	3
1	4	\N	3	\N	9	\N	2
1	5	\N	\N	4	10	\N	3
\.


--
-- Data for Name: authorization_dependencies; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.authorization_dependencies (base_auth, granted_auth) FROM stdin;
pool.read	application.processItem.list
pool.read	application.menu.processManager
pool.read	application.pool.list
pool.edit	application.processItem.list
pool.edit	pool.read
pool.edit	application.menu.processManager
pool.edit	application.pool.list
pool.delete	application.processItem.list
pool.delete	pool.read
pool.delete	application.menu.processManager
pool.delete	application.pool.list
form.read.web	application.menu.processManager
form.read.web	form.open
form.read.web	application.form.list
form.edit	application.menu.processManager
form.edit	form.read.web
form.edit	form.open
form.edit	application.form.list
form.delete	application.menu.processManager
form.delete	form.read.web
form.delete	form.open
form.delete	application.form.list
form.design	application.menu.processManager
form.design	form.read.web
form.design	form.open
form.design	application.form.list
form.publish	application.menu.processManager
form.publish	form.read.web
form.publish	form.open
form.publish	application.form.list
form.viewReport	application.menu.processManager
form.viewReport	form.read.web
form.viewReport	application.form.list
form.createReport	form.viewReport
form.createReport	application.menu.processManager
form.createReport	form.read.web
form.createReport	application.form.list
form.createReport	form.deleteReport
form.mobile	application.rest.lookupTables.read
form.mobile	project.read.mobile
application.rest.lookupTables.read	application.rest.lookupTables.list
application.rest.lookupTables.read	application.menu.lookupTables
project.read.web	application.project.list
project.read.web	application.menu.processManager
project.edit	application.project.list
project.edit	project.read.web
project.edit	application.menu.processManager
project.delete	application.project.list
project.delete	project.read.web
project.delete	application.menu.processManager
project.create.form	application.toolbox.form.new
project.create.form	application.menu.processManager
application.project.cancreate	application.toolbox.project.new
application.project.cancreate	application.menu.processManager
application.pool.cancreate	application.processItem.list
application.pool.cancreate	application.menu.processManager
application.pool.cancreate	application.toolbox.pool.new
application.pool.cancreate	application.pool.list
application.pool.cancreate	application.toolbox.processItem.new
application.diassociateDevice	application.user.list
application.diassociateDevice	application.menu.usersAndGroups
application.user.list	application.menu.usersAndGroups
application.user.edit	application.user.list
application.user.edit	application.menu.usersAndGroups
application.user.delete	application.user.list
application.user.delete	application.menu.usersAndGroups
application.user.cancreate	application.user.edit
application.user.cancreate	application.user.list
application.user.cancreate	application.menu.usersAndGroups
application.user.cancreate	application.toolbox.user.new
application.group.list	application.menu.usersAndGroups
application.group.edit	application.menu.usersAndGroups
application.group.edit	application.group.list
application.group.delete	application.menu.usersAndGroups
application.group.delete	application.group.list
application.group.cancreate	application.menu.usersAndGroups
application.group.cancreate	application.toolbox.group.new
application.group.cancreate	application.group.list
application.group.cancreate	application.group.edit
application.role.administration	application.role.list
application.role.administration	application.menu.roles
application.role.administration	application.role.delete
application.role.administration	application.role.edit
application.role.administration	application.toolbox.role.new
application.lookupTable.administration	application.menu.dataImport
application.lookupTable.administration	application.lookupTable.read
application.lookupTable.administration	application.lookupTable.create
application.lookupTable.administration	application.lookupTable.edit
application.lookupTable.administration	application.menu.lookupTables
application.rest.lookupTables.list	application.menu.lookupTables
application.rest.lookupTables.modify	application.rest.lookupTables.read
application.rest.lookupTables.modify	application.rest.lookupTables.list
application.rest.lookupTables.modify	application.menu.lookupTables
application.rest.lookupTables.insert	application.rest.lookupTables.read
application.rest.lookupTables.insert	application.rest.lookupTables.list
application.rest.lookupTables.insert	application.menu.lookupTables
application.rest.lookupTables.create	application.menu.dataImport
application.rest.lookupTables.create	application.rest.lookupTables.list
application.rest.lookupTables.create	application.menu.lookupTables
\.


--
-- Data for Name: authorizations; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.authorizations (name, auth_level, auth_group, visible) FROM stdin;
pool.read	4	authorizationGroup.pool	t
pool.edit	4	authorizationGroup.pool	t
pool.delete	4	authorizationGroup.pool	t
form.edit	3	authorizationGroup.form	t
form.mobile	3	authorizationGroup.form	t
form.read.web	3	authorizationGroup.form	t
form.design	3	authorizationGroup.form	t
form.publish	3	authorizationGroup.form	t
form.viewReport	3	authorizationGroup.form	t
form.createReport	3	authorizationGroup.form	t
form.deleteReport	3	authorizationGroup.form	t
form.delete	3	authorizationGroup.form	t
project.edit	2	authorizationGroup.project	t
project.delete	2	authorizationGroup.project	t
project.read.web	2	authorizationGroup.project	t
project.create.form	2	authorizationGroup.form	t
application.project.cancreate	1	authorizationGroup.project	t
application.pool.cancreate	1	authorizationGroup.pool	t
application.user.list	1	authorizationGroup.userAccess	t
application.user.delete	1	authorizationGroup.userAccess	t
application.user.cancreate	1	authorizationGroup.userAccess	t
application.user.edit	1	authorizationGroup.userAccess	t
application.group.list	1	authorizationGroup.userAccess	t
application.group.cancreate	1	authorizationGroup.userAccess	t
application.project.list	1	authorizationGroup.hidden	f
application.pool.list	1	authorizationGroup.hidden	f
application.form.list	1	authorizationGroup.hidden	f
application.config	1	authorizationGroup.application	f
application.menu.roles	1	authorizationGroup.menu	f
application.role.list	1	authorizationGroup.userAccess	f
application.role.edit	1	authorizationGroup.userAccess	f
application.processItem.list	1	authorizationGroup.hidden	f
application.role.delete	1	authorizationGroup.userAccess	f
application.role.cancreate	1	authorizationGroup.userAccess	f
application.toolbox.project.new	1	authorizationGroup.toolbox	f
application.toolbox.role.new	1	authorizationGroup.toolbox	f
application.toolbox.user.new	1	authorizationGroup.toolbox	f
application.toolbox.pool.new	1	authorizationGroup.toolbox	f
application.toolbox.form.new	1	authorizationGroup.toolbox	f
application.toolbox.processItem.new	1	authorizationGroup.toolbox	f
application.toolbox.group.new	1	authorizationGroup.toolbox	f
application.toolbox.device.new	1	authorizationGroup.toolbox	f
application.menu.processManager	1	authorizationGroup.menu	f
application.menu.dataImport	1	authorizationGroup.menu	f
application.menu.usersAndGroups	1	authorizationGroup.menu	f
application.menu.devices	1	authorizationGroup.menu	f
application.menu.config	1	authorizationGroup.menu	f
application.license	1	authorizationGroup.userAccess	f
application.menu.lookupTables	1	authorizationGroup.menu	f
application.lookupTable.create	1	authorizationGroup.hidden	f
application.lookupTable.edit	1	authorizationGroup.hidden	f
application.lookupTable.read	1	authorizationGroup.hidden	f
form.inputData.web	3	authorizationGroup.form	f
form.open	3	authorizationGroup.form	f
project.read.mobile	2	authorizationGroup.project	f
form.workflow.read	3	authorizationGroup.form	f
form.workflow.transition	3	authorizationGroup.form	f
application.group.edit	1	authorizationGroup.userAccess	t
application.group.delete	1	authorizationGroup.userAccess	t
application.role.administration	1	authorizationGroup.userAccess	t
application.diassociateDevice	1	authorizationGroup.userAccess	t
application.lookupTable.administration	1	authorizationGroup.connector	t
application.rest.lookupTables.create	1	authorizationGroup.REST	t
application.rest.lookupTables.list	1	authorizationGroup.REST	t
application.rest.lookupTables.insert	1	authorizationGroup.REST	t
application.rest.lookupTables.modify	1	authorizationGroup.REST	t
application.rest.lookupTables.read	1	authorizationGroup.REST	t
application.workflow.administration	1	authorizationGroup.userAccess	t
sys.allmighty	0	authorizationGroup.system	t
sys.menu	0	authorizationGroup.system	t
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.devices (id, active, created, deleted, modified, phone_number, model, brand, os, identifier, version_number, application_id, manufacturer, product, release, blacklisted) FROM stdin;
1	t	2023-12-09 18:28:28.751216+00	f	\N	\N	sdk_gphone64_x86_64	google	ANDROID	682620578eda4b04	31	1	Google	sdk_gphone64_x86_64	12	\N
2	t	2024-02-02 00:13:31.879982+00	f	\N	\N	sdk_gphone64_x86_64	google	ANDROID	2d9b433f085992f7	31	1	Google	sdk_gphone64_x86_64	12	\N
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.groups (description, name, id, application_id) FROM stdin;
Ciudadanía en general	ciudadanos	4	1
\.


--
-- Data for Name: groups_users; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.groups_users (group_id, user_id) FROM stdin;
4	3
\.


--
-- Data for Name: role_grants_authorization; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.role_grants_authorization (role_id, authorization_name) FROM stdin;
1	sys.allmighty
2	application.project.cancreate
2	application.pool.cancreate
2	application.group.cancreate
2	application.user.delete
2	application.user.cancreate
2	application.role.cancreate
2	project.edit
2	project.read.web
2	project.create.form
2	project.delete
2	form.edit
2	form.mobile
2	form.publish
2	form.design
2	form.read.web
2	form.inputData.web
2	form.viewReport
2	form.createReport
2	form.deleteReport
2	form.delete
2	pool.read
2	pool.edit
2	application.role.administration
2	application.lookupTable.create
2	application.lookupTable.edit
2	application.lookupTable.read
2	application.user.list
2	application.user.edit
2	application.group.list
2	application.group.edit
2	application.group.delete
2	application.project.list
2	application.form.list
2	application.pool.list
2	application.processItem.list
2	application.menu.processManager
2	application.menu.dataImport
2	application.menu.roles
2	application.menu.usersAndGroups
2	application.menu.devices
2	application.menu.lookupTables
2	application.toolbox.project.new
2	application.toolbox.form.new
2	application.toolbox.pool.new
2	application.toolbox.processItem.new
2	application.toolbox.user.new
2	application.toolbox.group.new
2	application.toolbox.device.new
2	application.config
2	application.menu.config
2	application.license
2	application.rest.lookupTables.create
2	application.rest.lookupTables.list
2	application.rest.lookupTables.modify
2	application.rest.lookupTables.insert
2	application.rest.lookupTables.read
2	application.diassociateDevice
2	application.workflow.administration
3	application.project.cancreate
3	application.pool.cancreate
3	application.group.cancreate
3	application.user.delete
3	application.user.cancreate
3	application.role.cancreate
3	project.edit
3	project.read.web
3	project.create.form
3	project.delete
3	form.edit
3	form.mobile
3	form.publish
3	form.design
3	form.read.web
3	form.inputData.web
3	form.viewReport
3	form.createReport
3	form.delete
3	pool.read
3	pool.edit
3	application.role.administration
3	application.lookupTable.create
3	application.lookupTable.edit
3	application.lookupTable.read
3	application.user.list
3	application.user.edit
3	application.group.list
3	application.group.edit
3	application.group.delete
3	application.project.list
3	application.form.list
3	application.pool.list
3	application.processItem.list
3	application.menu.processManager
3	application.menu.dataImport
3	application.menu.roles
3	application.menu.usersAndGroups
3	application.menu.devices
3	application.menu.lookupTables
3	application.toolbox.project.new
3	application.toolbox.form.new
3	application.toolbox.pool.new
3	application.toolbox.processItem.new
3	application.toolbox.user.new
3	application.toolbox.group.new
3	application.toolbox.device.new
3	application.config
3	application.menu.config
3	application.license
3	application.diassociateDevice
3	application.workflow.administration
4	project.edit
4	project.delete
4	project.read.web
4	project.create.form
4	form.edit
4	form.mobile
4	form.read.web
4	form.inputData.web
4	form.design
4	form.publish
4	form.delete
5	form.edit
5	form.mobile
5	form.read.web
5	form.inputData.web
5	form.design
5	form.publish
5	form.viewReport
5	form.createReport
5	form.delete
6	pool.edit
7	form.mobile
6	pool.read
6	pool.delete
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.roles (id, application_id, editable, active, created, deleted, modified, auth_level, description, name) FROM stdin;
1	\N	f	t	2021-03-20 15:55:13.199753+00	f	\N	0	\N	SYS_ALL_MIGHTY
2	\N	f	t	2021-03-20 15:55:13.214152+00	f	\N	1	\N	ROLE_APP_OWNER
3	\N	f	t	2021-03-20 15:55:13.214152+00	f	\N	1	\N	ROLE_APP_ADMIN
4	\N	f	t	2021-03-20 15:55:13.550058+00	f	\N	2	\N	ROLE_PROJECT_OWNER
5	\N	f	t	2021-03-20 15:55:13.593986+00	f	\N	3	\N	ROLE_FORM_OWNER
6	\N	f	t	2021-03-20 15:55:13.626225+00	f	\N	4	\N	ROLE_POOL_OWNER
7	1	t	t	2023-12-09 20:18:33.820714+00	f	\N	2	Reporter	Reporter
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.tokens (id, active, created, deleted, modified, token, expires, purpose, grantee_id, granter_id, application_id) FROM stdin;
1	t	2023-12-09 20:08:37.442591+00	f	2023-12-09 20:08:37.46+00	GgeDox5Yyz8ZdfeU4Bre2I43Wl37NWWs	2024-01-08 20:08:37.457+00	3	5	2	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.users (expirationdate, first_name, language, last_name, mail, password, id, default_application, former_mail, system_administrator, secure_password, salt) FROM stdin;
\N	admin	en	admin	root@mobileforms.sodep.com.py	123456	1	\N	\N	t	-32165760745dda38b3b75a3c6f73fef8ecb9785458e571a4	tDBd9wR4EOdVOzKQBxCRUKvCjeoQWt7zfFTTAJSaBvu9tYzgsfJ7rKP1Ck5m6XCB
\N	admin	en	admin	admin@testappmf.sodep.com.py	123456	2	1	\N	f	-792ba0cdd3ee8459142e492be6d83080757f71c41f0fc21a	GBS5mD4c8lmceOGBgRVGMBt288Q9WkRs06eLUNTBjSlYECVfPyXU7YuE39MpLxoM
\N	Ale	en	Feltes	\N	123456	5	1	ale@feltesq.com	f	29261b01fd3c5c3608574b1392b616d7c680afa854ab0914	OsAMjv2uK1mTmWJ6NcTe3fOYdwTLuRby6b3m5PlgWUkP9P9qQ74XfU2F6RVCgLpV
\N	Chake	en	Denuncias	chake@feltesq.com	123456	3	1	\N	f	10dd7abb1a666d678d82283d1baba74690366eec0c34797b	sSypuZKwNuMacj7BnSQb9PBXbjzUv4COb2tU4Yerbp2eMWYgeDTcngnNQ59aR2Nv
\.


--
-- Data for Name: users_devices; Type: TABLE DATA; Schema: core; Owner: postgres
--

COPY core.users_devices (user_id, device_id) FROM stdin;
3	1
2	1
5	1
3	2
\.


--
-- Data for Name: element_instances; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.element_instances (id, active, created, deleted, modified, "position", required, visible, prototype_id, page_id, field_name, instance_id, default_value_column, default_value_lookup) FROM stdin;
1	t	2023-12-09 18:31:44.801615+00	t	2024-02-02 00:17:55.457+00	0	t	\N	17	1	element1	element1	\N	\N
2	t	2023-12-09 18:31:44.801615+00	t	2024-02-02 00:17:55.457+00	1	t	\N	18	1	element2	element2	\N	\N
3	t	2024-02-02 00:15:32.788807+00	t	2024-02-02 00:17:55.477+00	0	t	\N	19	2	element1	element1	\N	\N
4	t	2024-02-02 00:15:32.788807+00	t	2024-02-02 00:17:55.477+00	1	t	\N	20	2	element2	element2	\N	\N
5	t	2024-02-02 00:15:32.788807+00	t	2024-02-02 00:17:55.477+00	2	\N	\N	21	2	element5	element5	\N	\N
6	t	2024-02-02 00:19:05.629377+00	t	2024-02-03 13:40:57.755+00	0	t	\N	22	3	element6	element6	\N	\N
7	t	2024-02-02 00:19:05.629377+00	t	2024-02-03 13:40:57.755+00	1	t	\N	23	3	element7	element7	\N	\N
8	t	2024-02-03 13:41:53.10564+00	f	\N	0	\N	\N	24	4	element8	element8	\N	\N
9	t	2024-02-03 13:41:53.10564+00	f	\N	1	\N	\N	25	4	element9	element9	\N	\N
10	t	2024-02-03 13:41:53.10564+00	f	\N	2	\N	\N	26	4	element10	element10	\N	\N
\.


--
-- Data for Name: element_prototypes; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.element_prototypes (id, active, created, deleted, modified, required, visible, pool_id, application_id, lock_version, root_id, version, instantiability, default_language) FROM stdin;
3	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	3	1	2	en
4	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	4	1	2	en
5	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	5	1	2	en
6	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	6	1	2	en
7	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	7	1	2	en
8	t	2021-03-20 14:51:29.890175+00	f	2021-03-20 14:51:29.890175+00	f	t	\N	\N	1	8	1	2	en
11	t	2021-03-20 14:51:30.263958+00	f	2021-03-20 14:51:30.263958+00	f	t	\N	\N	1	11	1	2	en
12	t	2021-03-20 14:51:30.62345+00	f	2021-03-20 14:51:30.62345+00	f	t	\N	\N	1	12	1	2	en
13	t	2021-03-20 14:51:30.630636+00	f	2021-03-20 14:51:30.630636+00	f	t	\N	\N	1	13	1	2	en
14	t	2021-03-20 14:51:30.693338+00	f	2021-03-20 14:51:30.693338+00	f	t	\N	\N	1	14	1	2	en
15	t	2021-03-20 14:51:30.710009+00	f	2021-03-20 14:51:30.710009+00	f	t	\N	\N	1	15	1	2	en
16	t	2021-03-20 14:51:30.722483+00	f	2021-03-20 14:51:30.722483+00	f	t	\N	\N	1	16	1	2	en
17	t	2023-12-09 18:31:44.801615+00	f	2023-12-09 18:31:44.843+00	f	t	\N	1	2	10	1	1	en
18	t	2023-12-09 18:31:44.801615+00	f	2023-12-09 18:31:44.846+00	f	t	\N	1	2	9	1	1	en
19	t	2024-02-02 00:15:32.788807+00	f	2023-12-09 18:31:44.843+00	f	t	\N	1	0	10	1	1	en
20	t	2024-02-02 00:15:32.788807+00	f	2023-12-09 18:31:44.846+00	f	t	\N	1	0	9	1	1	en
2	t	2021-03-20 14:51:29.890175+00	f	2024-02-02 00:15:32.828+00	f	t	\N	\N	2	2	1	2	en
21	t	2024-02-02 00:15:32.788807+00	f	2024-02-02 00:15:32.835+00	f	t	\N	1	2	2	1	1	en
22	t	2024-02-02 00:19:05.629377+00	f	2024-02-02 00:19:05.658+00	f	t	\N	1	2	10	1	1	en
23	t	2024-02-02 00:19:05.629377+00	f	2024-02-02 00:19:05.662+00	f	t	\N	1	2	9	1	1	en
10	t	2021-03-20 14:51:29.890175+00	f	2024-02-03 13:41:53.243+00	f	t	\N	\N	4	10	1	2	en
24	t	2024-02-03 13:41:53.10564+00	f	2024-02-03 13:41:53.243+00	f	t	\N	1	1	10	1	1	en
9	t	2021-03-20 14:51:29.890175+00	f	2024-02-03 13:41:53.287+00	f	t	\N	\N	4	9	1	2	en
25	t	2024-02-03 13:41:53.10564+00	f	2024-02-03 13:41:53.287+00	f	t	\N	1	1	9	1	1	en
1	t	2021-03-20 14:51:29.890175+00	f	2024-02-03 13:41:53.345+00	f	t	\N	\N	2	1	1	2	en
26	t	2024-02-03 13:41:53.10564+00	f	2024-02-03 13:41:53.345+00	f	t	\N	1	1	1	1	1	en
\.


--
-- Data for Name: elements_barcodes; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_barcodes (id) FROM stdin;
15
\.


--
-- Data for Name: elements_checkboxes; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_checkboxes (checked, id) FROM stdin;
f	14
\.


--
-- Data for Name: elements_filters; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_filters (id, filter_type, column_name, comparison_operator, element_instance_id, right_value) FROM stdin;
\.


--
-- Data for Name: elements_headlines; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_headlines (id) FROM stdin;
11
\.


--
-- Data for Name: elements_inputs; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_inputs (max_length, min_length, read_only, type, id, default_value) FROM stdin;
100	0	f	TEXT	1	\N
\N	\N	f	DATE	2	\N
20	6	f	PASSWORD	5	\N
255	0	f	TEXTAREA	6	\N
\N	\N	f	TIME	7	\N
\N	\N	f	DECIMAL	3	\N
\N	\N	f	INTEGER	4	\N
\N	\N	f	EMAIL	12	\N
\N	\N	t	EXTERNAL_LINK	13	\N
\N	\N	f	DATE	21	\N
100	0	f	TEXT	26	\N
\.


--
-- Data for Name: elements_labels; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_labels (element_id, value, language) FROM stdin;
1	Text	en
2	Date	en
3	Decimal	en
4	Integer	en
5	Password	en
6	Text Area	en
7	Time	en
8	Dropdown	en
9	Location	en
10	Photo	en
11	Headline	en
1	Texto	es
2	Fecha	es
3	Decimal	es
4	Entero	es
5	Contraseña	es
7	Hora	es
8	Lista desplegable	es
9	Ubicación	es
10	Fotografía	es
11	Encabezado	es
6	Area de Texto	es
12	E-mail	en
12	Correo Electrónico	es
13	External Link	en
13	Enlace Externo	es
14	Checkbox	en
14	Casilla de verificación	es
15	Barcode	en
15	Código de barras	es
16	Signature	en
16	Firma	es
17	Foto del bache	en
18	Ubicación	en
19	Foto del bache	en
20	Ubicación	en
21	Fecha	en
22	Foto	en
23	Ubicación	en
24	Photo	en
25	Location	en
26	Text	en
\.


--
-- Data for Name: elements_locations; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_locations (id, default_latitude, default_longitude) FROM stdin;
9	\N	\N
18	\N	\N
20	\N	\N
23	\N	\N
25	\N	\N
\.


--
-- Data for Name: elements_photos; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_photos (filename, id, camera_only) FROM stdin;
\N	10	f
\N	17	f
\N	19	f
\N	22	f
\N	24	f
\.


--
-- Data for Name: elements_selects; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_selects (lookup_label, lookup_value, multiple, id, lookup_identifier, option_source, default_value) FROM stdin;
\N	\N	f	8	\N	0	\N
\.


--
-- Data for Name: elements_signatures; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.elements_signatures (id) FROM stdin;
16
\.


--
-- Data for Name: flows; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.flows (id, active, created, deleted, modified, default_target) FROM stdin;
\.


--
-- Data for Name: flows_targets; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.flows_targets (id, active, created, deleted, modified, operator, element_id, preaction, target, element_value, flow_id) FROM stdin;
\.


--
-- Data for Name: form_xml_cache; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.form_xml_cache (id, active, created, deleted, modified, form_id) FROM stdin;
\.


--
-- Data for Name: form_xml_cache_xml; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.form_xml_cache_xml (form_xml_cache_id, value, language) FROM stdin;
\.


--
-- Data for Name: forms; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.forms (id, active, created, deleted, modified, acceptdata, dataset_definition, default_language, published, root_id, project_id, version, dataset_version, lock_version, was_published, published_date, published_version, provide_location) FROM stdin;
1	t	2023-12-09 18:30:52.975005+00	t	2024-02-02 00:17:55.457+00	t	6574b29283fe85d45c919571	en	f	1	1	1	0	4	t	2023-12-09 18:31:46.453+00	\N	f
2	t	2024-02-02 00:15:32.788807+00	t	2024-02-02 00:17:55.476+00	t	6574b29283fe85d45c919571	en	f	1	1	2	0	1	f	\N	1	f
3	t	2024-02-02 00:18:25.688411+00	t	2024-02-03 13:40:57.754+00	t	65bc34fb847ec2f1a3ebfca3	en	f	3	2	1	0	4	t	2024-02-02 00:19:07.6+00	\N	f
4	t	2024-02-03 13:41:28.01866+00	f	2024-02-03 13:41:57.559+00	t	65be42a3847e6f40c50ed877	en	t	4	3	1	0	2	t	2024-02-03 13:41:57.559+00	4	f
\.


--
-- Data for Name: forms_labels; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.forms_labels (form_id, value, language) FROM stdin;
1	Baches	en
2	Baches	en
3	Baches	en
4	demoform	en
\.


--
-- Data for Name: forms_languages; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.forms_languages (form_id, languages) FROM stdin;
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.pages (id, active, created, deleted, modified, on_load, on_unload, "position", save, flow_id, form_id, instance_id, default_language) FROM stdin;
1	t	2023-12-09 18:31:44.801615+00	t	2024-02-02 00:17:55.457+00	\N	\N	0	t	\N	1	page1	en
2	t	2024-02-02 00:15:32.788807+00	t	2024-02-02 00:17:55.476+00	\N	\N	0	t	\N	2	page1	en
3	t	2024-02-02 00:19:05.629377+00	t	2024-02-03 13:40:57.755+00	\N	\N	0	t	\N	3	page3	en
4	t	2024-02-03 13:41:53.10564+00	f	2024-02-03 13:41:53.368+00	\N	\N	0	t	\N	4	page4	en
\.


--
-- Data for Name: pages_labels; Type: TABLE DATA; Schema: forms; Owner: postgres
--

COPY forms.pages_labels (page_id, value, language) FROM stdin;
1	Bache	en
2	Bache	en
3	New Page	en
4	viales	en
\.


--
-- Data for Name: labels; Type: TABLE DATA; Schema: i18n; Owner: postgres
--

COPY i18n.labels (language_id, value, key) FROM stdin;
1	Captura	web.generic.title
1	Captura	web.generic.brand
1	Home	web.generic.home
1	Name	web.generic.name
1	Login	web.generic.login
1	Create an account	web.generic.register
1	Logout	web.generic.logout
1	Project	web.generic.project
1	Lookup table	web.generic.lookup_table
1	Projects	web.generic.projects
1	My Projects	web.generic.myprojects
1	Description	web.generic.description
1	Password	web.generic.password
1	Password	web.generic.enterPassword
1	Confirm Password	web.generic.confirmPassword
1	User	web.generic.user
1	Users	web.generic.users
1	First Name	web.generic.firstname
1	Last Name	web.generic.lastname
1	Email	web.generic.mail
1	Form	web.generic.form
1	Forms	web.generic.forms
1	My Forms	web.generic.myforms
1	Configuration	web.generic.myaccount
1	Group	web.generic.group
1	Groups	web.generic.groups
1	Role	web.generic.role
1	Roles	web.generic.roles
1	Pool	web.generic.pool
1	Pools	web.generic.pools
1	OK	web.generic.ok
1	Submit	web.generic.submit
1	Cancel	web.generic.cancel
1	Page	web.generic.page
1	Action	web.generic.action
1	Error	web.generic.error
1	Information	web.generic.information
1	Unexpected Exception	web.generic.unexpectedException
1	Password cannot be empty	web.generic.empty_password
1	Passwords don't match	web.generic.password_not_equal
1	Latitude	web.generic.latitude
1	Longitude	web.generic.longitude
1	Required Field	web.generic.requiredField
1	Not yet implemented	web.generic.notYetImplemented
1	Save	web.generic.save
1	Save as	web.generic.saveas
1	Delete	web.generic.delete
1	Next	web.generic.next
1	Previous	web.generic.previous
1	Not enough permissions to execute the action	web.generic.not.enough.permissions
1	Loading...	web.generic.loading
1	Add User	web.generic.addUser
1	Add Group	web.generic.addGroup
1	Add Form	web.generic.addForm
1	Clear	web.generic.clear
1	Clean	web.generic.clean
1	Add	web.generic.add
1	Edit	web.generic.edit
1	Associate	web.generic.associate
1	Select file	web.generic.selectFile
1	Version	web.generic.version
1	Version Published	web.generic.versionPublished
1	Published Version	web.generic.publishedVersion
1	Publish	web.generic.publish
1	Unpublish	web.generic.unpublish
1	Publish Last Version	web.generic.publishLastVersion
1	None	web.generic.none
1	Save And Submit	web.generic.saveAndSubmit
1	Items	web.generic.processItems
1	TOOLBOX	web.generic.toolbox
1	Profile	web.generic.profile
1	SODEP 2012	web.generic.footer
1	Create Label	web.generic.newLabel
1	Users in Group	web.generic.usersInGroup
1	Available Users	web.generic.availableUsers
1	Available Roles	web.generic.availableRoles
1	Assigned Roles	web.generic.assignedRoles
1	Available Groups	web.generic.availableGroups
1	Groups containing User	web.generic.groupsContainingUser
1	Reload Grid	web.generic.reloadGrid
1	Upgrade	web.generic.upgrade
1	Upgrade All	web.generic.upgradeAll
1	Available	web.generic.available
1	Selected	web.generic.selected
1	Yes	web.generic.yes
1	No	web.generic.no
1	Sorry	web.generic.sorry
1	Warning	web.generic.warning
1	Revoke the authorization to the user	web.generic.revokeAuthorization.user
1	Revoke the authorization to the group	web.generic.revokeAuthorization.group
1	Welcome To Captura!	web.index.label01
1	For more information on how Captura can help you and your company leverage the full potential of smartphones please take a tour	web.index.label02
1	This is FUN!	web.index.label03
1	Take the tour	web.index.tour
1	Captura	web.index.title
1	Register a new user	web.registration.title
1	Prove you're not a bot	web.registration.captcha
1	Create an account	web.registration.label01
1	Register	web.registration.submit
1	Registration temporarily disabled	web.registration.disabled
1	Empty field	web.registration.error.emptyField
1	A required field was left empty	web.registration.error.requiredFieldEmpty
1	We can't be sure that you are not a bot. Please try again	web.registration.error.catpcha
1	Passwords don't match	web.registration.passwordsDontMatch
1	Soon you will be able to... 	web.registration.marketing.title
1	Use our powerful editor to design your forms	web.registration.marketing.opt1
1	Let people on the field use their devices to send the data you are looking for.	web.registration.marketing.opt2
1	Work even if your device is offline	web.registration.marketing.opt3
1	View the uploaded data on the web	web.registration.marketing.opt4
1	Manage user rights	web.registration.marketing.opt5
1	Much more...	web.registration.marketing.opt6
1	Sign In	web.login.title
1	Log in to your account	web.login.label01
1	Sign In	web.login.submit
1	Can't access your account?	web.login.cantAccesAccount
1	Email is empty	web.login.emailEmpty
1	Password is empty	web.login.passwordEmpty
1	Invalid E-mail address	web.validation.user.invalidmail
1	Password should be at least 8 characters long	web.validation.user.password
1	First name should be at least 2 characters long	web.validation.user.firstName
1	Last name should be at least 2 characters long	web.validation.user.lastName
1	Captura	web.home.title
1	{0} {1}, Welcome to Captura!	web.home.welcome
1	Main	web.home.main
1	Data	web.home.data
1	Form Designer	web.home.editor
1	Admin	web.home.admin
1	ACME UI Components	web.home.acmeui
1	Are you sure you want to change your App?	web.home.appchanger.dialog.message
1	Change Application?	web.home.appchanger.dialog.title
1	Processes	web.home.processes
1	Users & Groups	web.home.usersAndGroups
1	Devices	web.home.devices
1	Reports of 	web.home.reports
1	Roles	web.home.rolesAndPermissions
1	Roles Definition	web.home.rolesDefinition
1	Connectors	web.home.connectors
1	Settings	web.home.settings
1	License	web.home.license
1	Legacy	web.home.legacy
1	Process manager	web.home.processManager
1	Management	web.home.management
1	Administration	web.home.administration
1	System Administration	web.home.systemAdministration
1	My account	web.home.myaccount
1	My preferences	web.home.myaccount.preferences.title
1	Connector Repository preferences	web.home.myaccount.connector.title
1	Password configuration	web.home.myaccount.password.title
1	Old password:	web.home.myaccount.password.field.old
1	New password:	web.home.myaccount.password.field.new
1	Confirm password:	web.home.myaccount.password.field.confirm
1	Change password	web.home.myaccount.password.change
1	Successfully changed the password	web.home.myaccount.password.change.success.title
1	The confirmation password doesn't match the new password	web.home.myaccount.password.error.confirm
1	The old password is not valid	web.home.myaccount.password.error.old
1	User Data	web.home.myaccount.userData.title
1	Application Settings	web.home.application_settings
1	The application hasn't been setup.	web.home.first.setup.message
1	Setup the Application	web.home.first.setup.link
1	Uncaught Exceptions	web.home.uncaughtException
1	You are currently involved in these projects	web.dashboard.your_projects
1	View Data	web.dashboard.view_data
1	Build or Design Forms	web.dashboard.build_edit
1	Manage App	web.dashboard.admin
1	Reports	web.home.reports.title
1	List of queries	web.home.reports.querys.title
1	Create Query	web.home.reports.newQuery
1	Query	web.home.reports.query
1	No Form version is published	web.home.reports.noVersionIsPublished
1	User	web.home.reports.column.meta.mail
1	Received At	web.home.reports.column.meta.receivedAt
1	Location	web.home.reports.column.meta.location
1	Download CSV	web.home.reports.downloadCSV
1	Available on:	web.home.reports.exportOptions
1	Search	web.home.reports.button.search
1	UTF-8 CSV file	web.home.reports.csv.tooltip
1	Binary Excel file	web.home.reports.xls.tooltip
1	PDF Format	web.home.reports.pdf.tooltip
1	Edit this query	web.home.reports.edit.tooltip
1	Create a new query	web.home.reports.createQuery.tooltip
1	Error generating report	web.home.reports.error.emptyReport.title
1	There is no data to generate the report	web.home.reports.error.emptyReport.message
1	Create Query	web.home.querys.new.title
1	Edit Query	web.home.querys.edit.title
1	Query Name	web.home.querys.name
1	Table Columns	web.home.querys.tableColumns
1	CSV Columns	web.home.querys.csvColumns
1	Query saved successfully	web.home.querys.saved.title
1	Query {0} saved successfully	web.home.querys.saved.message
1	Query not saved	web.home.querys.notsaved.title
1	Another user already updated or created the query {0}	web.home.querys.notsaved.message
1	Back to Reports	web.home.querys.backToReports
1	A Query with the provided name already exist for this Form version	web.home.querys.invalid.duplicated
1	Set as default Query	web.home.querys.setAsDefaultQuery
1	System data	web.home.querys.metadataLabel
1	Choose a column	web.home.querys.addFilterDialog.title
1	Download locations as Google Maps Links	web.home.querys.googleMapsLinks
1	Equals	web.home.reports.operator.equals
1	Greater	web.home.reports.operator.greater
1	Less	web.home.reports.operator.less
1	Between	web.home.reports.operator.between
1	Like	web.home.reports.operator.like
1	Add a new Filter	web.home.querys.addFilterButton
1	Choose an Item	web.home.querys.addFilterDialog_title
1	Query deleted	web.home.querys.deleted.title
1	The query {0} has been deleted	web.home.querys.deleted.message
1	Delete Query	web.home.querys.delete.confirmation.title
1	Are you sure you want to delete this Query?	web.home.querys.delete.confirmation.message
1	Search options	web.home.querys.searchOptions_title
1	Step	web.home.querys.step
1	General Information	web.home.querys.section.generalInfo
1	Select visible columns	web.home.querys.section.tableColumns
1	Choose the columns that are going to be displayed on this query	web.home.querys.section.tableColumns.help
1	Select the sorting columns	web.home.querys.section.sortingColumns
1	The selected columns will be used as sorting criteria	web.home.querys.section.sortingColumns.help
1	Select filters	web.home.querys.section.filter
1	Register filters that will be used by default on this query	web.home.querys.section.filter.help
1	The query could not be saved	web.home.querys.save.error.title
1	Check for errors and try again	web.home.querys.save.error.message
1	Show Data	web.home.data.show
1	Download CSV Data	web.home.data.downloadcsv
1	Input Data	web.home.data.input
1	Input Data	web.home.data.input.title
1	Show Data	web.home.data.show.title
1	Minimum length is {0}	web.home.data.input.error.minlenght
1	Maximum length is {0}	web.home.data.input.error.maxlenght
1	Minimum value is {0}	web.home.data.input.error.minvalue
1	Maximum value is {0}	web.home.data.input.error.maxvalue
1	Form Data Saved Successfully	web.data.input.save.ok
1	Error. Form Not Saved	web.data.input.save.error
1	Data type error on field {0}	web.data.input.save.error.field.wrongType
1	The field {0} is not on definition	web.data.input.save.error.field.wrongField
1	Select a Value	web.data.input.select.initialLabel
1	Unable to uplaod the file	web.data.input.file.upload.exception
1	Show Data	web.data.show.button
1	Select a Project	web.data.select.project
1	Select a Form	web.data.select.form
1	Select a Version	web.data.select.version
1	Form Empty	web.data.form.empty
1	The Form {0} do not have metadata	web.data.form.empty.message
1	This Form does not have fields to show	web.data.show.noFields
1	Show Image	web.data.show.showImage
1	Loading Image	web.data.show.image.loading
1	No Image	web.data.show.noImage
1	Not Available	web.data.show.not_available
1	Show signature	web.data.show.showSignature
1	No signature	web.data.show.noSignature
1	Users	web.home.admin.users
1	Groups	web.home.admin.groups
1	Projects	web.home.admin.projects
1	Roles	web.home.admin.roles
1	Forms	web.home.admin.forms
1	Items	web.home.admin.process_items
1	Pools	web.home.admin.pools
1	Devices	web.home.admin.devices
1	Identifier	web.home.admin.devices.field.identifier
1	The unique device ID, for example, the IMEI for GSM and the MEID or ESN for CDMA phones. On Android dial *#06#	web.home.admin.devices.identifier.msg
1	This might not be available on certain devices and a custom hardware ID will be used depending on the platform.	web.home.admin.devices.identifier.msg2
1	Brand	web.home.admin.devices.field.brand
1	Model	web.home.admin.devices.field.model
1	Phone number	web.home.admin.devices.field.phone_number
1	OS	web.home.admin.devices.field.os
1	The user doesn't have any associated device	web.home.admin.no_devices
1	Application management	web.home.admin.application_management
1	Create Project	web.home.admin.project.new
1	Project Configuration	web.home.admin.project.edit
1	Project Configuration	web.home.admin.project.manager
1	Create Form	web.home.admin.form.new
1	Design Form	web.home.admin.form.edit
1	Form Configuration	web.home.admin.form.manager
1	Add Device	web.home.admin.device.new
1	Edit Device	web.home.admin.device.edit
1	Create Group	web.home.admin.group.new
1	Edit Group	web.home.admin.group.edit
1	Create User	web.home.admin.user.new
1	Edit User	web.home.admin.user.edit
1	Create Pool	web.home.admin.pool.new
1	Edit Pool	web.home.admin.pool.edit
1	Pool Manager	web.home.admin.pool.manager
1	Item Manager	web.home.admin.processitem.manager
1	Users & Groups	web.home.admin.application_management.usersAndGroups
1	Process	web.home.admin.application_management.process
1	Process Manager	web.home.admin.application_management.processManager
1	Reports	web.home.admin.application_management.reports
1	Devices	web.home.admin.application_management.devices
1	Roles and Permissions	web.home.admin.application_management.rolesAndPermissions
1	Application Settings	web.home.admin.application_management.settings
1	Licenses	web.home.admin.application_management.licenses
1	Connectors	web.home.admin.application_management.connectors
1	Add Users	admin.cruds.group.addUsers
1	Remove From Group	admin.cruds.group.removeFromGroup
1	The application reached its maximum of {0} users. Contact your salesman to buy a larger license.	web.home.admin.license.max_user.reached
1	Email address already in use	services.user.register.mail.duplicate
1	The account has already been deleted and cannot be added again	services.user.register.mail.deleted
1	License grants up to {0} users, Current count is {1}	services.user.new.license.max_user.reached
1	Create User	web.controller.register.newUser
1	User created	web.controller.register.userCreated
1	Registration complete, you should receive an email to activate your account soon.	web.controller.register.ok
1	Could not register due to some invalid information, please check the registration form	web.controller.register.invalid
1	{0} is already registered. Please proceed to login	web.controller.register.alreadyActive
1	The account already exists but it's not Active. Click <strong><a href="javascript:void(0)" id="resendLink">here</a></strong> if you want the activation mail to be resent	web.controller.register.confirmResend
1	We just sent another activation mail to {0}. Please be patient. Thank you!	web.controller.register.mailResent
1	No such user account	web.controller.register.noSuchUser
1	Pending activation	web.controller.register.pendingActivation
1	Pending approval	web.controller.register.pendingApproval
1	Select a Lookup table	web.data.select.lookup_table
1	Lookup tables	web.home.data.lookup_table
1	Currently, there are no lookup tables in the system	web.home.data.lookup_table.emptyTable
1	Empty Lookup table ID provided	web.data.lookup_table.validation.emptyLutParam
1	Invalid lookup table ID. Not a number	web.data.lookup_table.validation.invalidLutId
1	Lookup table empty	web.data.lookup_table.empty.message
1	Lookup table successfully deleted	web.data.lookup_table.delete.success
1	Illegal lookup table to delete	web.data.lookup_table.delete.failure.illegalArgument
1	Delete LookupTable	web.data.lookup_table.delete.confirm.title
1	Are you sure that you want to delete the lookup Table? 	web.data.lookup_table.delete.confirm.message
1	Users	admin.cruds.user.title
1	ID	admin.cruds.user.cols.id
1	First Name	admin.cruds.user.cols.firstName
1	Last name	admin.cruds.user.cols.lastName
1	Mail	admin.cruds.user.cols.mail
1	Username	admin.cruds.user.cols.username
1	Password	admin.cruds.user.cols.password
1	Active	admin.cruds.user.cols.active
1	Groups	admin.cruds.user.cols.groups
1	Roles	admin.cruds.user.cols.roles
1	Devices	admin.cruds.user.cols.devices
1	Last Login	admin.cruds.user.cols.lastLogin
1	Groups of User {0}	admin.cruds.user.groups.dialog.title
1	Roles of User {0}	admin.cruds.user.roles.dialog.title
1	User {0} saved	admin.cruds.user.saved.message
1	User saved	admin.cruds.user.saved.title
1	User {0} deleted	admin.cruds.user.deleted.message
1	User deleted	admin.cruds.user.deleted.title
1	The device {0} was deassociated from the user {1}	admin.cruds.user.diassociate.message
1	Device deassociated	admin.cruds.user.diassociate.title
1	Diassociate device	admin.cruds.user.diassociate.warning.title
1	Do you really want to diassociate the device {0} ?	admin.cruds.user.diassociate.warning.msg
1	Send password reset mail	admin.cruds.user.password_reset_button.title
1	Mail sent	admin.cruds.user.password_reset.ok.title
1	Mail not sent	admin.cruds.user.password_reset.error.title
1	No user selected	admin.cruds.user.user_not_selected
1	Invalid user data	admin.cruds.user.invalid.message
1	Add User	admin.cruds.user.form.addCaption
1	Edit User	admin.cruds.user.form.editCaption
1	Create User	admin.cruds.user.new.title
1	Edit User	admin.cruds.user.edit.title
1	Add Groups	admin.cruds.user.addGroups
1	Remove Groups	admin.cruds.user.removeGroups
1	Assign	admin.cruds.user.addRoles
1	Remove	admin.cruds.user.removeRoles
1	A user with the provided mail already exist in this application	admin.cruds.user.invalid.duplicated
1	Invitation canceled	admin.cruds.user.invitation.cancel.title
1	Invitation to {0}, canceled	admin.cruds.user.invitation.cancel.message
1	Invite	admin.cruds.user.invite
1	Groups added to User successfully	admin.cruds.user.addGroups.title
1	Groups removed from User successfully 	admin.cruds.user.removeGroups.title
1	Roles assigned to User successfully	admin.cruds.user.addRoles.title
1	Roles removed from User successfully	admin.cruds.user.removeRoles.title
1	Groups	admin.cruds.group.title
1	ID	admin.cruds.group.cols.id
1	Group Name	admin.cruds.group.cols.name
1	Description	admin.cruds.group.cols.description
1	Active	admin.cruds.group.cols.active
1	Roles	admin.cruds.group.cols.roles
1	Group {0} saved	admin.cruds.group.saved.message
1	Group saved	admin.cruds.group.saved.title
1	Group {0} deleted	admin.cruds.group.deleted.message
1	Group deleted	admin.cruds.group.deleted.title
1	Roles of Group {0}	admin.cruds.group.roles.dialog.title
1	Invalid group data	admin.cruds.group.invalid.message
1	A group with the provided name already exist in the application	admin.cruds.group.invalid.duplicated
1	Create Group	admin.cruds.group.new.title
1	Edit Group	admin.cruds.group.edit.title
1	Assign	admin.cruds.group.addRoles
1	Remove	admin.cruds.group.removeRoles
1	Users added to Group successfully	admin.cruds.group.addUsers.title
1	Users removed from Group successfully 	admin.cruds.group.removeUsers.title
1	Roles added to Group successfully	admin.cruds.group.addRoles.title
1	Roles removed from Group successfully	admin.cruds.group.removeRoles.title
1	Projects	admin.cruds.project.title
1	Label not set in English	admin.cruds.project.label.not_set
1	Description not set in English	admin.cruds.project.description.not_set
1	ID	admin.cruds.project.cols.id
1	Label	admin.cruds.project.cols.label
1	Description	admin.cruds.project.cols.description
1	Default Language	admin.cruds.project.cols.language
1	Owner	admin.cruds.project.cols.owner
1	Created	admin.cruds.project.cols.created
1	Active	admin.cruds.project.cols.active
1	Edit	admin.cruds.project.cols.edit
1	Clone	admin.cruds.project.cols.clone
1	User Management	admin.cruds.project.cols.auths
1	User and Group Management of Project {0}	admin.cruds.project.auths.dialog.title
1	Project {0} saved	admin.cruds.project.saved.message
1	Project saved	admin.cruds.project.saved.title
1	Form {0} imported	admin.cruds.project.form.imported.message
1	Form imported	admin.cruds.project.form.imported.title
1	Roles in Project saved	admin.cruds.project.roles.saved.title
1	Roles in Project deleted	admin.cruds.project.roles.deleted.title
1	Project deleted	admin.cruds.project.deleted.title
1	Project {0} deleted	admin.cruds.project.deleted.message
1	An error occurred while tying to delete project {0}	admin.cruds.project.deleted.error
1	Invalid project data	admin.cruds.project.invalid.message
1	Project Configuration	admin.cruds.project.form.editCaption
1	Add Project	admin.cruds.project.form.addCaption
1	Create Project	admin.cruds.project.new.title
1	Project Configuration	admin.cruds.project.edit.title
1	Users List	admin.cruds.project.userGrid.title
1	Groups List	admin.cruds.project.groupGrid.title
1	Form List	admin.cruds.project.formGrid.title
1	User Repeated	admin.cruds.project.error.userRepeated
1	Group Repeated	admin.cruds.project.error.groupRepeated
1	Project not saved	admin.cruds.project.notsaved.title
1	Another user already updated or created the project {0}	admin.cruds.project.notsaved.message
1	Delete Project	admin.cruds.project.delete.confirmation.title
1	Are you sure you want to delete this project?. All Forms in the project will be deleted	admin.cruds.project.delete.confirmation.message
1	There is already a Project with the same name	admin.cruds.project.invalid.duplicated
1	Brands	web.home.admin.brands
1	Edit	admin.cruds.brand.cols.edit
1	Brands	admin.cruds.brand.title
1	ID	admin.cruds.brand.cols.id
1	Name	admin.cruds.brand.cols.name
1	Active	admin.cruds.brand.cols.active
1	Brand deleted	admin.cruds.brand.deleted.title
1	Brand {0} deleted	admin.cruds.brand.deleted.message
1	Brand saved	admin.cruds.brand.saved.title
1	Brand {0} saved	admin.cruds.brand.saved.message
1	Brand not saved	admin.cruds.brand.notsaved.title
1	Brand {0} not saved	admin.cruds.brand.notsaved.message
1	Duplicated brand	admin.cruds.brand.invalid.duplicated
1	Edit Brand	admin.cruds.brand.form.editCaption
1	Add Brand	admin.cruds.brand.form.addCaption
1	ID	admin.cruds.model.cols.id
1	Model	admin.cruds.model.cols.name
1	Brand	admin.cruds.model.cols.brand
1	Active	admin.cruds.model.cols.active
1	Model	admin.cruds.model.title
1	Add Model	admin.cruds.model.form.addCaption
1	Edit Model	admin.cruds.model.form.editCaption
1	Models	web.home.admin.models
1	Model already exists	admin.cruds.model.invalid.duplicated
1	Error while trying to create Model	admin.cruds.model.nonexist.brand.title
1	There are no active Brands to use.	admin.cruds.model.nonexist.brand.message
1	Roles	admin.cruds.role.title
1	ID	admin.cruds.role.cols.id
1	Name	admin.cruds.role.cols.name
1	Description	admin.cruds.role.cols.description
1	Level	admin.cruds.role.cols.level
1	Active	admin.cruds.role.cols.active
1	Manage Permissions	admin.cruds.role.cols.auths
1	Role {0} saved	admin.cruds.role.saved.message
1	Role saved	admin.cruds.role.saved.title
1	Role {0} deleted	admin.cruds.role.deleted.message
1	Role deleted	admin.cruds.role.deleted.title
1	Authorizations of Role {0}	admin.cruds.role.auths.dialog.title
1	Add Role	admin.cruds.role.form.addCaption
1	Edit Role	admin.cruds.role.form.editCaption
1	Manage Permission	web.home.admin.role.permission_management
1	A role with the provided label already exist in the application	admin.cruds.role.invalid.duplicated
1	Application	admin.cruds.role.level.application
1	Project	admin.cruds.role.level.project
1	Form	admin.cruds.role.level.form
1	Pool	admin.cruds.role.level.pool
1	Permissions	web.home.admin.role.permission
1	Permissions	admin.cruds.role.permission.title
1	Role	admin.cruds.role.permission.role
1	Description	admin.cruds.role.permission.description
1	{0} permissions saved	admin.cruds.role.permission.saved.message
1	Permissions saved	admin.cruds.role.permission.saved.title
1	Form Configuration	admin.cruds.form.title
1	ID	admin.cruds.form.cols.id
1	Label	admin.cruds.form.cols.label
1	Description	admin.cruds.form.cols.description
1	Version	admin.cruds.form.cols.version
1	Version Published	admin.cruds.form.cols.versionPublished
1	Published	admin.cruds.form.cols.published
1	Default Language	admin.cruds.form.cols.default_language
1	Accept Data	admin.cruds.form.cols.accept_data
1	Created	admin.cruds.form.cols.created
1	Project	admin.cruds.form.cols.project
1	Active	admin.cruds.form.cols.active
1	User Management	admin.cruds.form.cols.auths
1	User and Group Management of Form {0}	admin.cruds.form.auths.dialog.title
1	Form {0} saved	admin.cruds.form.saved.message
1	Form saved	admin.cruds.form.saved.title
1	Roles in Form saved	admin.cruds.form.roles.saved.title
1	Roles in Form deleted	admin.cruds.form.roles.deleted.title
1	Form {0} Published	admin.cruds.form.published.message
1	Form Published	admin.cruds.form.published.title
1	Form {0} Unpublished	admin.cruds.form.unpublished.message
1	Form Unpublished	admin.cruds.form.unpublished.title
1	Form {0} cannot be published because it has no items	admin.cruds.form.notPublished.noElements.message
1	Form cannot be published	admin.cruds.form.notPublished.noElements.title
1	Form {0} cannot be published because it is empty. Please use the Form Designer to add content	admin.cruds.form.notPublished.noPages.message
1	Form cannot be published	admin.cruds.form.notPublished.noPages.title
1	Form {0} deleted	admin.cruds.form.deleted.message
1	Form deleted	admin.cruds.form.deleted.title
1	An error occurred while tying to delete form {0}	admin.cruds.form.deleted.error
1	Invalid Form Data	admin.cruds.form.invalid.message
1	Error saving Form	admin.cruds.form.invalid.errorSaving
1	You cannot have two Forms with the same name in one Project	admin.cruds.form.invalid.duplicated
1	The Form or the Project it belongs-to was modified during the creation or edition	admin.cruds.form.invalid.lockError.creation
1	The Form or the project it belongs to was modified during the edition	admin.cruds.form.invalid.lockError.edition
1	Save And Go To Designer	admin.cruds.form.button.saveAndGoEditor
1	Go To Designer	admin.cruds.form.button.goEditor
1	Design Form	admin.cruds.form.cols.editForm
1	Open Designer	admin.cruds.form.cols.openEditor
1	Are you sure you want to delete this Form?	admin.cruds.form.delete.confirmation.message
1	Delete Form	admin.cruds.form.delete.confirmation.title
1	There are some required fields missing	admin.cruds.form.missingRequiredFields
1	Items	admin.cruds.processitem.title
1	ID	admin.cruds.processitem.cols.id
1	Label	admin.cruds.processitem.cols.label
1	Type	admin.cruds.processitem.cols.type
1	Required	admin.cruds.processitem.cols.required
1	Visible	admin.cruds.processitem.cols.visible
1	Created	admin.cruds.processitem.cols.created
1	Active	admin.cruds.processitem.cols.active
1	Pool	admin.cruds.processitem.cols.pool
1	Add an item	admin.cruds.processitem.add.title
1	Item {0} saved	admin.cruds.processitem.saved.message
1	Item saved	admin.cruds.processitem.saved.title
1	Item {0} deleted	admin.cruds.processitem.deleted.message
1	Item deleted	admin.cruds.processitem.deleted.title
1	An item with the provided label already exist in the application	admin.cruds.processitem.invalid.duplicated
1	Cannot save the item. No application selected	admin.cruds.processitem.invalid.applicationRequired
1	Item not saved	admin.cruds.processitem.notsaved.title
1	Another user already updated or created the item {0}	admin.cruds.processitem.notsaved.message
1	Save Item As	admin.processitem.dialog.saveas.title
1	Successful Item Upgrade	admin.processitem.upgrade.success
1	Successful Item Upgrade in all Forms	admin.processitem.upgradeAll.success
1	Item Version	admin.processitem.processItemVersion
1	Are you sure you want to delete this Item?	admin.cruds.processitem.delete.confirmation.message
1	Delete Item	admin.cruds.processitem.delete.confirmation.title
1	The following Forms depend on this item :	admin.cruds.processitem.delete.form.depends.on
1	Pool	admin.form.processitem.common.poolselect
1	Label	admin.form.processitem.common.label
1	Required	admin.form.processitem.common.required
1	Visible	admin.form.processitem.common.visible
1	Active	admin.form.processitem.common.active
1	Type	admin.form.processitem.common.type
1	Minimum	admin.form.processitem.input.minimum
1	Maximum	admin.form.processitem.input.maximum
1	Read only	admin.form.processitem.input.readonly
1	Depends on	admin.form.processitem.select.dependson
1	Lookup	admin.form.processitem.select.lookup
1	Collection	admin.form.processitem.select.collection
1	Option label	admin.form.processitem.select.label
1	Option value	admin.form.processitem.select.value
1	Text area	admin.form.processitem.select.textarea
1	Edit	admin.form.processitem.button.edit
1	Accept	admin.form.processitem.button.accept
1	Cancel	admin.form.processitem.button.cancel
1	Text	admin.form.processitem.type.text
1	Date	admin.form.processitem.type.date
1	Time	admin.form.processitem.type.time
1	Datetime	admin.form.processitem.type.datetime
1	Password	admin.form.processitem.type.password
1	Integer	admin.form.processitem.type.integer
1	Decimal	admin.form.processitem.type.decimal
1	Text area	admin.form.processitem.type.textarea
1	Dropdown	admin.form.processitem.type.select
1	Location	admin.form.processitem.type.location
1	Photo	admin.form.processitem.type.photo
1	Headline	admin.form.processitem.type.headline
1	Checkbox	admin.form.processitem.type.checkbox
1	Barcode	admin.form.processitem.type.barcode
1	Signature	admin.form.processitem.type.signature
1	E-mail	admin.form.processitem.type.email
1	External Link	admin.form.processitem.type.external_link
1	None	admin.form.processitem.select.none
1	Multiple	admin.form.processitem.select.multiple
1	Identifier	admin.form.processitem.select.identifier
1	Options	admin.form.processitem.select.optionLabel
1	Lookup table	admin.form.processitem.select.manualSource
1	Embbeded	admin.form.processitem.select.dynamicSource
1	Source	admin.form.processitem.select.source
1	Default value	admin.form.processitem.input.defaultValue
1	Option label	admin.form.processitem.select.optionlabel
1	Options	admin.form.processitem.select.options
1	Edit item	admin.cruds.processitem.edit.title
1	Default longitude	admin.form.processitem.input.defaultLongitude
1	Default latitude	admin.form.processitem.input.defaultLatitude
1	Stored in Pool	admin.form.processitem.common.storedinpool
1	Properties	admin.form.processitem.properties
1	Forms	admin.form.processitem.forms
1	No Forms using this item	admin.form.processitem.forms.noFormsUsingProcessItem
1	Forms using this item	admin.form.processitem.forms.title
1	Create Item	web.home.admin.processitem.new
1	Edit Item	web.home.admin.processitem.edit
1	Select Item	web.home.admin.processitem.list
1	Version info	admin.form.processitem.common.versionInfo
1	Version	admin.form.processitem.common.version
1	Not a real number	admin.form.processitem.validation.notRealNumber
1	Latitude	admin.form.processitem.location.latitude
1	Longitude	admin.form.processitem.location.longitude
1	The longitude and latitude used is not a valid coordinate	admin.form.processitem.validation.coordinate.invalid
1	The latitude and longitude are required	admin.form.processitem.validation.coordinate.required
1	Field is required	admin.processitem.validation.required
1	Field can not be null	admin.processitem.validation.notnull
1	Field is not an integer	admin.processitem.validation.notaninteger
1	Field is negative	admin.processitem.validation.isnegative
1	Maximum field is less than minimum field	admin.processitem.validation.maxlessthanmin
1	ERROR: This field can not be null	admin.processitem.error.isnull
1	At least one option is required	admin.processitem.validation.atleastoneoption
1	Duplicated options	admin.processitem.validation.optionalreadydefined
1	Invalid date value	admin.processitem.validation.invalid.date
1	Invalid datetime value	admin.processitem.validation.invalid.datetime
1	Invalid time value	admin.processitem.validation.invalid.time
1	Value can not be empty	admin.processitem.validation.invalid.empty
1	value is greater than maximum	admin.processitem.validation.invalid.greaterThanMaximum
1	value is less than minimum	admin.processitem.validation.invalid.lessThanMinimum
1	value is not an integer	admin.processitem.validation.invalid.integer
1	value is not decimal	admin.processitem.validation.invalid.decimal
1	max value exceed	admin.processitem.validation.maxExceed
1	Item successfully saved	admin.processitem.save.success
1	There were problems while trying to save the item	admin.processitem.save.failure
1	Items Pools	admin.cruds.pool.title
1	ID	admin.cruds.pool.cols.id
1	Name	admin.cruds.pool.cols.name
1	Description	admin.cruds.pool.cols.description
1	Active	admin.cruds.pool.cols.active
1	Invalid pool data	admin.cruds.pool.invalid.message
1	Pool {0} saved	admin.cruds.pool.saved.message
1	Pool saved	admin.cruds.pool.saved.title
1	Item {0} imported	admin.cruds.pool.processItem.imported.message
1	Item imported	admin.cruds.pool.processItem.imported.title
1	Roles in Pool saved	admin.cruds.pool.roles.saved.title
1	Roles in Pool deleted	admin.cruds.pool.roles.deleted.title
1	Pool {0} deleted	admin.cruds.pool.deleted.message
1	Pool deleted	admin.cruds.pool.deleted.title
1	Add Pool	admin.cruds.pool.form.addCaption
1	Edit Pool	admin.cruds.pool.form.editCaption
1	Create Pool	admin.cruds.pool.new.title
1	Edit Pool	admin.cruds.pool.edit.title
1	A Pool with the provided name already exist in the application	admin.cruds.pool.invalid.duplicated
1	Copy to current Pool	admin.cruds.pool.button.addProcessItem
1	Users List	admin.cruds.pool.userGrid.title
1	Groups List	admin.cruds.pool.groupGrid.title
1	Pool not saved	admin.cruds.pool.notsaved.title
1	Another user already updated or created the pool {0}	admin.cruds.pool.notsaved.message
1	Delete Pool	admin.cruds.pool.delete.confirmation.title
1	Are you sure you want to delete this pool?	admin.cruds.pool.delete.confirmation.message
1	Form {0} depends on these prototypes : 	admin.cruds.pool.delete.form.depends.on
1	Devices	admin.cruds.device.title
1	ID	admin.cruds.device.cols.id
1	Model	admin.cruds.device.cols.model
1	Brand	admin.cruds.device.cols.brand
1	Number	admin.cruds.device.cols.number
1	IMEI	admin.cruds.device.cols.imei
1	Active	admin.cruds.device.cols.active
1	Options	admin.cruds.device.cols.options
1	Associations	admin.cruds.device.cols.associations
1	Edit	admin.cruds.device.cols.edit.link
1	Manage Association	admin.cruds.device.cols.association.link
1	Device	admin.cruds.device.cols.device
1	Device {0} saved	admin.cruds.device.saved.message
1	Device saved	admin.cruds.device.saved.title
1	Device {0} deleted	admin.cruds.device.deleted.message
1	Device deleted	admin.cruds.device.deleted.title
1	Invalid Device data	admin.cruds.device.invalid.message
1	Create Device	admin.cruds.device.new.title
1	Edit Device	admin.cruds.device.edit.title
1	Manage Association	admin.cruds.device.association.title
1	Select a Brand	admin.cruds.device.brand.select
1	Select a Model	admin.cruds.device.model.select
1	Device not saved	admin.cruds.device.notsaved.title
1	Another user already updated or created the Device {0}	admin.cruds.device.notsaved.message
1	Device {0} is associated with {1}	admin.cruds.device.savedAssociation.message
1	Device Association saved	admin.cruds.device.savedAssociation.title
1	Device Association removed	admin.cruds.device.removeAssociation.title
1	Device {0} is not associated with any User	admin.cruds.device.removeAssociation.message
1	Remove Association	admin.cruds.device.cols.removeAssociation.link
1	<b>{0}, Welcome to Captura!</b><br /><br />To activate you account follow this link <a href="{1}">{1}</a><br /><br />The Captura team	services.mail.registration.body
1	Captura - Activation	services.mail.registration.subject
1	Your account has been activated.	web.controller.activation.activated
1	Invalid Request.	web.controller.activation.invalid
1	Please check that the requested URL is exactly as the one we sent to you per email.	web.controller.activation.invalid.hint
1	Your account is already active.	web.controller.activation.isActive
1	Create account at Captura	services.mail.credentials.subject
1	Hello {0}, your user's credentials at Captura are: <br/>user: {1}<br />password: {2}	services.mail.credentials.body
1	Set new password for Captura's account	services.mail.set_password.subject
1	Hello {0},<br/><br/>{1} thinks you might need to reset your password.<br/><br/>If you want to do it, please follow the link <a href="{2}">{2}</a><br /><br /><br />The Captura team	services.mail.set_password.body.sender
1	Hello {0},<br/><br/>Please use the following link to set your Captura's password <a href="{1}">{1}</a><br /><br /><br />The Captura team	services.mail.set_password.body.nosender
1	A mail was sent to {0} with instructions to reset the account's password	web.controller.password_reset.mailSent
1	Mail not sent	web.controller.password_reset.mailNotSent
1	Invalid user id	web.controller.password_reset.invalidId
1	Invalid Request	web.controller.password_reset.invalid
1	Set password for user {0}	web.controller.password_reset.greetings
1	Enter new password	web.controller.password_reset.new_password_label
1	Invalid password	web.controller.password_reset.invalidpasswords
1	Set new password	web.password_reset.title
1	New Password	web.password_reset.success.title
1	Your new password has been set. You may now <a href="{0}">login</a>	web.password_reset.success.message
1	Please follow the link: {0}	web.password_reset.dialog.body
1	Hello {0},<br /><br />{1} would like you to join Captura's Application {2}.<br /><br />If you wish to accept the invitation, follow this link <a href="{3}">{3}</a><br /><br /><br />The Captura team	services.mail.invitation.body
1	Join {0} at Captura	services.mail.invitation.subject
1	<p>You have successfully joined the App {0}.</p> <p>You may now login to access the application.</p>	web.controller.invitation.accepted
1	<p>You have successfully joined the App {0}.</p> <p>You have already been assigned a password. If you don't know it please contact {1}</p>	web.controller.invitation.accepted_no_password
1	Sorry, we couldn't accept the invitation. Please contact with the person that invited you. Thanks.	web.controller.invitation.notAccepted
1	Invalid invitation	web.controller.invitation.token.invalid
1	Invitation sent	web.controller.invitation.sent.ok
1	An invitation mail was sent to {0}	web.controller.invitation.mailSent
1	Invitation not sent	web.controller.invitation.sent.error
1	Invitation mail not sent	web.controller.invitation.mailNotSent
1	Invalid user id	web.controller.invitation.invalidId
1	You have now joined the Application {0} at Captura. You need to setup your password before you login. We just sent you an e-mail with instructions	web.controller.invitation.setPasswordMail
1	Select a Project	web.editor.select.project
1	Empty Form list	web.editor.select.project.noForms
1	New	web.editor.mainbuttons.new
1	Open	web.editor.mainbuttons.open
1	Save	web.editor.mainbuttons.save
1	Save As	web.editor.mainbuttons.saveAs
1	Cancel	web.editor.mainbuttons.cancel
1	Create Form	web.editor.dialog.title.newForm
1	Open Form	web.editor.dialog.title.openForm
1	Save Form As	web.editor.dialog.title.saveAs
1	OK	web.editor.dialog.buttons.ok
1	Cancel	web.editor.dialog.buttons.cancel
1	Invalid Name	web.editor.dialog.form.invalidName
1	Invalid Form	web.editor.dialog.form.notSelected
1	Error loading toolbox!, Twitter's blue whale kinda error!	web.editor.toolbox.loadError
1	Add Page	web.editor.mainlayer.button.newPage
1	Properties	web.editor.properties
1	Select an item	web.editor.properties.selectItem
1	Form	web.editor.properties.type.form
1	Input	web.editor.properties.type.input
1	Dropdown	web.editor.properties.type.select
1	Page	web.editor.properties.type.page
1	Label	web.editor.properties.label
1	Position	web.editor.properties.position
1	Required	web.editor.properties.required
1	Final	web.editor.properties.saveable
1	Description	web.editor.properties.description
1	Minimum Length	web.editor.properties.minlength
1	Maximum Length	web.editor.properties.maxlength
1	Minimum Value	web.editor.properties.minvalue
1	Maximum Value	web.editor.properties.maxvalue
1	Default Value	web.editor.properties.defaultValue
1	Default Latitude	web.editor.properties.defaultLatitude
1	Default Longitude	web.editor.properties.defaultLongitude
1	Field	web.editor.properties.fieldName
1	Read Only	web.editor.properties.readOnly
1	Embedded	web.editor.properties.select.source.embedded
1	Lookup Table	web.editor.properties.select.source.lookup_table
1	Source	web.editor.properties.select.source
1	Lookup Table	web.editor.properties.select.lookuptable
1	Value Column	web.editor.properties.select.lookuptable.value
1	Label Column	web.editor.properties.select.lookuptable.label
1	Values	web.editor.properties.select.embedded.values
1	Camera Only	web.editor.properties.photo.cameraOnly
1	Checked	web.editor.properties.checkbox.checked
1	New Page	web.editor.form.newPage.label
1	ID	web.editor.page.id
1	Other Items	web.editor.toolbox.poolLess
1	Items	web.editor.toolbox.systemPool
1	Items	web.editor.toolbox.title
1	Create Item	web.editor.newProcessItem.label
1	There are no changes to save	web.editor.noChanges
1	No changes	web.editor.noChanges.Title
1	There are unsaved changes. Please, save the changes to publish the Form	web.editor.publish.unsavedChanges
1	Unsaved Changes	web.editor.publish.unsavedChanges.title
1	Form saved	web.editor.saved
1	An error occurred while trying to save the Form	web.editor.error.notSaved
1	Info	web.editor.info
1	A start page was added to the Form	web.editor.form.automatic.newpage
1	There are unsaved changed. Do you want to leave this page?	web.editor.exit.unsaved
1	Unsaved Changes	web.editor.exit.unsaved.title
1	Move to Page >	web.editor.processItem.moveToPage
1	Form Designer	web.editor.title
1	Back to Form Configuration	web.editor.backToFormManager
1	Filter	web.editor.properties.select.filter.label
1	Show Filter Options	web.editor.properties.select.filter.button
1	Filters	web.editor.properties.dialogs.filter.label
1	Lookup Table	web.editor.properties.dialogs.lookuptable.label
1	Value	web.editor.properties.dialogs.value.label
1	A previous version of this Form was published	web.editor.dialog.incrementversion.confirmation.title
1	Saving the changes will increment the version number. To make the changes visible to the users, you have to publish this new version. Do you wish to continue?	web.editor.dialog.incrementversion.confirmation.message
1	Unreachable Pages	web.editor.unreachablePages
1	Your Form has unreachable pages. The pages are higlighted with red.	web.editor.unreachablePages.explanation
1	This page is unreachable	web.editor.page.warning.unreachable
1	Id	web.editor.element.id
1	{0} Setup	web.myaccount.myapps.settings.label
1	Invalid Session	web.session.invalid.title
1	Your session has expired or is invalid	web.session.invalid.message
1	Inactive Session	web.timeout.dialog.title
1	Your session has been inactive and might have expired	web.timeout.dialog.message
1	Error in Ajax request: {0}	web.ajax.error
1	Ajax Request Status: {0}	web.ajax.status
1	Unauthorized	web.ajax.unauthorized
1	Forbidden	web.ajax.forbidden
1	Can't connect to server	web.ajax.unreachable
1	Server temporarily unavailable	web.ajax.unavailable
1	Import Data	web.home.data.import
1	CSV data import	web.dataimport.label
1	Table Name	web.dataimport.lookuptable.name.label
1	CSV File	web.dataimport.csv.file.label
1	File	web.dataimport.file.label
1	Data successfully imported	web.data.import.success.title
1	The table {0} was created with the CSV data	web.data.import.success.message
1	Error in row: Field {0}, value {1}, with error {2}	web.data.import.error.row.label
1	Table name is empty	web.data.import.error.emptyTableName
1	Error on header {0} . It is not allowed to have an empty column name	web.data.import.error.emptyColumnName
1	Error on header {0} . It is not allowed to have a column with "." (dots) 	web.data.import.error.columnNameError
1	Important	web.data.import.important.title
1	Please include column names in the first line	web.data.import.important.msg1
1	The only supported column separator is currently a comma ","	web.data.import.important.msg2
1		web.dataimport.lookuptable.
1	All	web.dataimport.lookuptable.qualifier.all
1	None	web.dataimport.lookuptable.qualifier.none
1	Text qualifiers	web.dataimport.lookuptable.qualifier.label
1	Delimiter	web.dataimport.lookuptable.delimiter.label
1	Tab	web.dataimport.lookuptable.delimiter.tab
1	Semicolon	web.dataimport.lookuptable.delimiter.semicolon
1	Colon	web.dataimport.lookuptable.delimiter.colon
1	Comma	web.dataimport.lookuptable.delimiter.comma
1	Space	web.dataimport.lookuptable.delimiter.space
1	Column header	web.dataimport.lookuptable.columnheader.label
1	Import	web.dataimport.lookuptable.importButton.label
1	Use first row	web.dataimport.lookuptable.columnheader.usefirstrow
1	Choose a File	web.dataimport.lookuptable.chooseFile
1	Preview	web.dataimport.lookuptable.preview
1	The maximum number of columns is {0}	web.dataimport.lookuptable.maxColumns
1	Invalid ID	web.controller.id.invalid
1	Create Project	web.toolbox.project.create
1	Create Form	web.toolbox.form.create
1	Open Designer	web.toolbox.weditor.open
1	System Admin	web.system
1	Processes	web.home.v2.processes
1	Process Manager	web.home.v2.processesManager
1	Home	web.processes.home
1	Create Item	web.processes.toolbox.newProcessItem
1	Create Pool	web.processes.toolbox.newPool
1	Create Form	web.processes.toolbox.newForm
1	Create Project	web.processes.toolbox.newProject
1	Create User	web.application_management.toolbox.newUser
1	Add Device	web.application_management.toolbox.newDevice
1	Create Project	web.application_management.toolbox.newProject
1	Create Form	web.application_management.toolbox.newForm
1	Invalid User	mobile.login.controller.invalidlogin
1	Invalid id for the widget	web.multiselect.invalidId
1	Select All	web.multiselect.selectAll
1	Unselect All	web.multiselect.unselectAll
1	Search...	web.multiselect.filter
1	Add User	web.usersAndGroups.toolbox.newUser
1	Create Group	web.usersAndGroups.toolbox.newGroup
1	Edit	web.grid.row.edit
1	Delete	web.grid.row.delete
1	Reset Password	web.grid.users.row.resetPassword
1	Associated Devices	web.grid.users.row.deviceDetails
1	Cancel invitation	web.grid.users.row.cancelInvitation
1	Send another invitation	web.grid.users.row.resendInvitation
1	OK	web.dialog.buttons.ok
1	Cancel	web.dialog.buttons.cancel
1	Yes	web.dialog.buttons.yes
1	No	web.dialog.buttons.no
1	Do you want to delete the group {0}?	web.usersAndGroups.deleteGroup.confirm
1	Do you want to delete the user {0}?	web.usersAndGroups.deleteUser.confirm
1	Do you want to cancel the invitation to {0}	web.usersAndGroups.cancelInvitation.confirm
1	Users in group {0}	web.usersAndGroups.users.grid.title
1	Invalid input content	web.content.invalid
1	Invalid	web.content.invalid.title
1	User deleted	admin.cruds.user.delete.ok.title
1	Error while deleting user	admin.cruds.user.delete.error.title
1	Do you wish to send {0} an invitation to join Captura and {1}?	admin.cruds.user.presave.confirm.newUser
1	{0} is already in Captura, invite the user to join {1}?	admin.cruds.user.presave.confirm.addUser
1	Canceled	admin.cruds.user.save.cancelled.title
1	User was not saved	admin.cruds.user.save.cancelled
1	Sorry, an application with the same name already exists. Please choose another name.	web.application.settings.nameInUse
1	Invalid name	web.application.settings.nameInUse.title
1	Have you forgotten your password?	web.account.recovery.title
1	Please enter the email address of your Captura's account.	web.account.recovery.message
1	Your account's email	web.account.recovery.mail.placeholder
1	Continue	web.account.recovery.mail.continue
1	mail	web.new-user.mail.label
1	User's email address	web.new-user.mail.placeholder
1	User's username	web.new-user.username.placeholder
1	Next	web.new-user.mail.next
1	An account for {0} already exists on the system <br/><i class="icon-info-sign"></i> <strong>If you proceed an invitation will be sent to the user to join this application.</strong>	web.new-user.alreadyExists
1	An account for {0} already exists on the system <br/><i class="icon-info-sign"></i> <strong>If you proceed the user will be directly joined to this application.</strong>	web.new-user.addDirectly.alreadyExists
1	An account will be created for {0}. Please fill in the information.<br/> <i class="icon-info-sign"></i> <strong>The user will receive an activation email before he can login</strong>	web.new-user.addNewAccount
1	An account will be created for {0}. Please fill in the information.<br/> <i class="icon-info-sign"></i> <strong>The user will be directly added to this application</strong>	web.new-user.addDirectly.addNewAccount
1	Clear	web.new-user.mail.clear
1	Cancel	web.new-user.cancel
1	<i class="icon-exclamation-sign"></i> <strong>{0} has already been invited or is a member of the application</strong>	web.new-user.alreadyInApp
1	Assign a password to the user	web.new-user.assignPassword
1	The user should assign his/her password later (Instructions will be sent via Email)	web.new-user.userAssignsHisPassword
1	Activate/Deactivate application	web.admin.home.activation
1	Are you sure you want to activate application: 	web.admin.home.activation.confirmation
1	Are you sure you want to deactivate application: 	web.admin.home.activation.desconfirmation
1	Only Active	web.admin.home.onlyActive
1	Total Apps	web.admin.home.totalApps
1	Active Apps	web.admin.home.activeApps
1	Inactive Apps	web.admin.home.inactiveApps
1	OS Release	web.home.admin.devices.field.release
1	System	authorizationGroup.system.label
1	Application	authorizationGroup.application.label
1	Project	authorizationGroup.project.label
1	Form	authorizationGroup.form.label
1	Pool	authorizationGroup.pool.label
1	Toolbox access	authorizationGroup.toolbox.label
1	Menu access	authorizationGroup.menu.label
1	User access	authorizationGroup.userAccess.label
1	Connector Repository	authorizationGroup.connector.label
1	Lookup Tables	authorizationGroup.REST.label
1	Configure Application	application.config.label
1	Authorization that allows the user to change the app settings	application.config.description
1	Create Projects	application.project.cancreate.label
1	Allows a user to create projects	application.project.cancreate.description
1	Create Pool	application.pool.cancreate.label
1	Authorization that allows a user to create a pool	application.pool.cancreate.description
1	List Users	application.user.list.label
1	Authorizations that allow a user to search other existing users	application.user.list.description
1	Create Users	application.user.cancreate.label
1	Authorization that allow a user to create another user	application.user.cancreate.description
1	Edit Users	application.user.edit.label
1	Authorization that allow a user to edit another user	application.user.edit.description
1	Delete Users	application.user.delete.label
1	Authorization that allow a user to delete another user	application.user.delete.description
1	List Groups	application.group.list.label
1	Authorization that allow a user to search existing groups	application.group.list.description
1	Create Groups	application.group.cancreate.label
1	Authorization that allow a user to create groups	application.group.cancreate.description
1	Edit Groups	application.group.edit.label
1	Authorization that allow a user to edit groups	application.group.edit.description
1	Delete Groups	application.group.delete.label
1	Authorization that allow a user to delete groups	application.group.delete.description
1	List Roles	application.role.list.label
1	Authorization that allow a user to search existing roles	application.role.list.description
1	Edit Role	application.role.edit.label
1	Authorization that allow a user to edit roles	application.role.edit.description
1	Create Role	application.role.cancreate.label
1	Authorization that allow a user to create roles	application.role.cancreate.description
1	Roles Administration	application.role.administration.label
1	Authorization that allow a user to create,edit,delete and configure roles	application.role.administration.description
1	Workflow Administration	application.workflow.administration.label
1	Authorization that allow a user to configure workflow	application.workflow.administration.description
1	List Projects	application.project.list.label
1	Allows to see the project list in the Process Manager	application.project.list.description
1	List Forms	application.form.list.label
1	Allows to see the Form list in the Process Manager	application.form.list.description
1	List Pools	application.pool.list.label
1	Allows to see the pool list in the Process Manager	application.pool.list.description
1	List Items	application.processItem.list.label
1	Allows to see the item list in the Process Manager	application.processItem.list.description
1	Create Labels of Items	application.processItem.create.label
1	Edit Labels of Items	application.processItem.edit.label
1	Create Lookup Table	application.lookupTable.create.label
1	Allows to create a lookup table inside an application	application.lookupTable.create.description
1	Edit Lookup Table	application.lookupTable.edit.label
1	Allows to edit the lookup table and its data, and also remove lookup tables	application.lookupTable.edit.description
1	Read Lookup Table	application.lookupTable.read.label
1	 Allows to read the content of a lookup table	application.lookupTable.read.description
1	Lookup Table	application.lookupTable.administration.label
1	Grants access to create,edit and delete lookup tables. In addition, allows the import of data from CSV files	application.lookupTable.administration.description
1	Diassociate Devices	application.diassociateDevice.label
1	 Allows to diassociate devices from other users	application.diassociateDevice.description
1	Lookup table delete	lookupTable.delete.confirmation.title
1	Do you want to delete the lookup table ?	lookupTable.delete.confirmation.message
1	The identifier {0} already exists. Please use another one	lookupTable.definition.identifier.duplicate
1	The maximum number of fields or columns of a lookup table is {0}	lookupTable.definition.max_fields
1	Process Manager	application.menu.processManager.label
1	Allows to access the Process Manager Page	application.menu.processManager.description
1	Data Import	application.menu.dataImport.label
1	Allows to access the Data Import Page	application.menu.dataImport.description
1	Roles	application.menu.roles.label
1	Allows to access the Roles Page	application.menu.roles.description
1	Users and Groups	application.menu.usersAndGroups.label
1	Allows to access the Users and Groups Page	application.menu.usersAndGroups.description
1	Devices	application.menu.devices.label
1	Allows to access the Devices Page	application.menu.devices.description
1	Show Data	application.menu.showData.label
1	Allows to access the Show Data Page	application.menu.showData.description
1	Application Settings	application.menu.config.label
1	Allows to access the Application Settings Page	application.menu.config.description
1	Licenses	application.menu.licenses.label
1	Allows to access the Application Licenses Page	application.menu.licenses.description
1	Lookup Tables	application.menu.lookupTables.label
1	Allows to access the Lookup tables Page	application.menu.lookupTables.description
1	Create Project	application.toolbox.project.new.label
1	Allows to create a project from the toolbox	application.toolbox.project.new.description
1	Create Form	application.toolbox.form.new.label
1	Allows to create a Form from the toolbox	application.toolbox.form.new.description
1	Create Pool	application.toolbox.pool.new.label
1	Allows to create a pool from the toolbox	application.toolbox.pool.new.description
1	Create Item	application.toolbox.processItem.new.label
1	Allows to create an item from the toolbox	application.toolbox.processItem.new.description
1	Create User	application.toolbox.user.new.label
1	Allows to create a user from the toolbox	application.toolbox.user.new.description
1	Create Group	application.toolbox.group.new.label
1	Allows to create a group from the toolbox	application.toolbox.group.new.description
1	Create Device	application.toolbox.device.new.label
1	Allows to create a device from the toolbox	application.toolbox.device.new.description
1	Project Configuration	project.edit.label
1	The user can change the label and description of the project, add Forms and grant authorization to users and groups	project.edit.description
1	Read Project Mobile	project.read.mobile.label
1	A mobile user has authorization to see a project in the mobile device. Otherwise, the project is not visible	project.read.mobile.description
1	View Project	project.read.web.label
1	Allows a user to see a project in the Web application. Otherwise, the project is not visible	project.read.web.description
1	Create Forms	project.create.form.label
1	The user can create Forms inside a Project	project.create.form.description
1	Delete Project	project.delete.label
1	Allows a user to delete a Project	project.delete.description
1	Form Configuration	form.edit.label
1	Allows a user to configure a Form in the Web application	form.edit.description
1	View Forms	form.read.web.label
1	Allows a user to see a Form in the Web application. Without this authorization the user won't see the Form in the list of Forms	form.read.web.description
1	Delete Forms	form.delete.label
1	Allows a user to delete Forms	form.delete.description
1	Mobile User	form.mobile.label
1	Allows a user to upload data from a mobile device. Without this authorization the user won't be able to upload data from a mobile device	form.mobile.description
1	Publish Forms	form.publish.label
1	Allows a user to publish Forms	form.publish.description
1	Design Forms	form.design.label
1	Allows a user to design Forms using the Form Designer in the Web application	form.design.description
1	Input Data Web	form.inputData.web.label
1	A web user that has authorization to post data on a Form	form.inputData.web.description
1	View Reports	form.viewReport.label
1	Allows a user to see the Report of a Form in the Web application	form.viewReport.description
1	Create Reports	form.createReport.label
1	Allows a user to create Reports of a Form in the Web application	form.createReport.description
1	Delete Reports	form.deleteReport.label
1	Allows a user to delete Reports of a Form in the Web application	form.deleteReport.description
1	Read Pool	pool.read.label
1	Authorization that allow a user to read pools and the items within them	pool.read.description
1	Edit Pools	pool.edit.label
1	Authorization that allow a user to edit pools and the items within them	pool.edit.description
1	Delete Pools	pool.delete.label
1	Authorization that allow a user to delete pools and the items within them	pool.delete.description
1	Project Configuration	web.processes.project.tooltip.manager
1	Form Configuration	web.processes.form.tooltip.manager
1	Show Reports	web.processes.form.tooltip.reports
1	Design Form	web.processes.form.tooltip.editor
1	Open Pool Manager	web.processes.pool.tooltip.manager
1	Open Item	web.processes.processitem.tooltip.manager
1	Equals	web.editor.properties.dialogs.operators.equals
1	Contains	web.editor.properties.dialogs.operators.contains
1	Distinct	web.editor.properties.dialogs.operators.distinct
1	Select a Column	web.editor.properties.dialogs.selectColumn
1	Select a Condition	web.editor.properties.dialogs.selectOperator
1	Select an Element	web.editor.properties.dialogs.selectElement
1	Select a Lookup table	web.editor.properties.dialogs.selectLookup
1	Provide Location	web.editor.form.properties.provideLocation
1	Conditional jumps	web.editor.properties.page.navigation.label
1	Set conditional jumps	web.editor.properties.page.navigation.button
1	Conditional Jumps	web.editor.properties.dialogs.page.navigation.targets.label
1	Value	web.editor.properties.dialogs.page.navigation.value
1	If none of the conditions above is true, then jump to page	web.editor.properties.dialogs.page.navigation.default.label
1	Select a page	web.editor.properties.dialogs.selectPage
1	Define conditional jumps for page : "{0}"	web.editor.properties.dialogs.page.navigation.title
1	Define the next page jump target based on selected values	web.editor.properties.dialogs.page.navigation.heading
1	When pressing "Next" on the device, conditions will be checked one after the other, the first being true will trigger the jump to the associated target page.	web.editor.properties.dialogs.page.navigation.explanation
1	Conditional jumps changed	web.editor.properties.dialogs.page.navigation.notification.changes.title
1	Conditional jumps for page "{0}" were changed	web.editor.properties.dialogs.page.navigation.notification.changes.message
1	No changes	web.editor.properties.dialogs.page.navigation.notification.noChanges.title
1	No changes for page "{0}"	web.editor.properties.dialogs.page.navigation.notification.noChanges.message
1	Page is final	web.editor.properties.dialogs.page.navigation.finalPage.notPossible.title
1	Page is final, conditional jumps are not possible	web.editor.properties.dialogs.page.navigation.finalPage.notPossible
1	If this page is made final, then the jumps from this page will be discarded. Do you want to proceed?	web.editor.properties.dialogs.page.navigation.makefinal
1	Page with conditional jumps	web.editor.properties.dialogs.page.navigation.makefinal.title
1	Default value of "{0}"	web.editor.properties.dialogs.defaultvalue.title
1	Set dynamically the default value of this element based on values of other elements	web.editor.properties.dialogs.defaultvalue.heading
1	Select the Lookup Table and Column from which the default value will be picked	web.editor.properties.dialogs.defaultvalue.section1.explanation
1	Define matching condition(s) for selecting the default value	web.editor.properties.dialogs.defaultvalue.section2.explanation
1	Please, select a lookup table first	web.editor.properties.dialogs.dropdown.filters.selectLookupFirst
1	Select dynamically the data available in this element based on the value of other elements	web.editor.properties.dialogs.dropdown.filters.heading
1	Show only data that fulfills all of the following condition(s)	web.editor.properties.dialogs.dropdown.filters.explanation
1	Filter for data available in "{0}"	web.editor.properties.dialogs.dropdown.filters.title
1	Static	web.editor.properties.defaultvalue.static
1	Lookup Table	web.editor.properties.defaultvalue.dynamic
1	Manage Publication	web.editor.properties.manage.publication
1	No final page	web.editor.save.nofinalPage.title
1	There's no final page. Do you want to make the page "{0}" final?	web.editor.save.nofinalPage.message
1	The element has a static default value, if you continue it will be overridden. Do you wish to continue?	web.editor.properties.staticDefaultValueWillBeLost
1	The element has a dynamic default value, if you continue it will be overridden. Do you wish to continue?	web.editor.properties.dynamicDefaultValueWillBeLost
1	Please check the filters	web.editor.properties.dialogs.checkFilters
1	The property min value of the element {0} must be a numeric value	services.commandService.validation.integerField.minValue.numeric
1	The property min value of the element {0} must be a numeric value	services.commandService.validation.integerField.maxValue.numeric
1	{0} has source set as Lookup Table, but no table was selected	services.commandService.validation.dropdown.noLookupTable
1	{0} has source set as Lookup Table, but no field was selected as label	services.commandService.validation.dropdown.noLookupLabel
1	{0} has source set as Lookup Table, but no field was selected as value	services.commandService.validation.dropdown.noLookupValue
1	{0} has no embedded data	services.commandService.validation.dropdown.noEmbeddedData
1	Form cannot be emtpy	services.commandService.validation.form.isEmpty
1	Lookup Column	web.editor.properties.dialogs.dropdown.lookupColumn
1	Condition	web.editor.properties.dialogs.dropdown.condition
1	Value Of	web.editor.properties.dialogs.dropdown.valueOf
1	Lookup Column	web.editor.properties.dialogs.defaultvalue.lookupColumn
1	Condition	web.editor.properties.dialogs.defaultvalue.condition
1	Value of	web.editor.properties.dialogs.defaultvalue.valueOf
1	Element	web.editor.properties.dialogs.page.navigation.element
1	Condition	web.editor.properties.dialogs.page.navigation.condition
1	Target Page	web.editor.properties.dialogs.page.navigation.targetPage
1	CSV File too Big	web.data.input.file.csvTooBig.title
1	Currently we do not support CSV files with more than {0} lines	web.data.input.file.csvTooBig.message
1	My account	myAccount.title
1	Preferred Language	myAccount.language
1	Change preferences	myAccount.changePreferences
1	Settings saved	myAccount.success.title
1	Your default language has changed. You will be redirected to the home page to load the changes	myAccount.success.languageChangedMessage
1	Settings saved	myAccount.success.message
1	Download Connector Repository configuration	myAccount.downloadCRConfiguration
1	Default Application	myAccount.defaultApplication
1	User Data	myAccount.userData.title
1	User Data has changed. You will be redirected to the home page to load the changes	myAccount.userData.success.message
1	Server error	web.data.upload.serverError
1	Interrupt Exception	web.data.upload.interruptException
1	No more pages	web.editor.properties.dialogs.noMorePages.title
1	No more pages to jump to	web.editor.properties.dialogs.noMorePages.message
1	Click to enable location	web.editor.enable_location
1	Click to disable location	web.editor.disable_location
1	Exc No	admin.views.uncaughtException.cols.id
1	Exception Type	admin.views.uncaughtException.cols.exceptionType
1	Offending Class	admin.views.uncaughtException.cols.offendingClass
1	User ID	admin.views.uncaughtException.cols.userId
1	Insert Time	admin.views.uncaughtException.cols.inserTime
1	Stack Trace	admin.views.uncaughtException.cols.stackTrace
1	Url	admin.views.uncaughtException.cols.url
1	User Agent	admin.views.uncaughtException.cols.userAgent
1	no Stack Trace	admin.views.uncaughtException.msg.noStackTrace
1	Please proceed to 	web.invitation.proceed_to
1	login	web.invitation.login
1	DONE!	web.password_reset.done
1	This user does not have access to any functionality. Please contact the administrator	web.noUserRights
1	System Administrator Home	web.sysadmin.home.title
1	App Admin	web.admin.home.title
1	Create Additional Application	web.root.home.toolbox.createApp
1	Reload Parameters	web.root.home.toolbox.reloadParameters
1	Reload i18n	web.root.home.toolbox.reloadi18n
1	App Admin	web.admin.home.breadCrumb
1	Go to application	web.admin.home.enterApp
1	An unexpected error occurred	web.generic.unknownError
1	<b>The account first needs to be activated.</b><br />In the first part of the registration process a mail should have been sent to you with instructions on how to activate your account. You can request that mail again. 	web.account.recover.inactiveAccount
1	Soon you should receive an email at {0}, with instructions on how to reset the account's password	web.account.recover.mailSent
1	User {0} doesn't exist	web.account.recover.invalidUser
1	Resend activation mail	web.account.recover.resendActivationMail
1	Insert page before	web.editor.page.contextmenu.insertPage.before
1	Insert page after	web.editor.page.contextmenu.insertPage.after
1	Form cannot be deleted	admin.cruds.form.cannot.delete.published.title
1	Form {0} cannot be deleted. It needs to be unplished first	admin.cruds.form.cannot.delete.published.message
1	ID	web.lookup.cols.id
1	Name	web.lookup.cols.label
1	Remote	web.lookup.cols.isRemote
1	Remote Identifier	web.lookup.cols.remoteIdentifier
1	Yes	web.lookup.model.remote.true
1	No	web.lookup.model.remote.false
1	The lookup table is in use	web.lookup.error.inuse.title
1	Delete the current lookup table	web.lookup.actions.delete.tooltip
1	View the data of this lookup table	web.lookup.actions.view.tooltip
1	Lookup Table data	web.home.data.lookup_table_data
1	Application created	web.root.createApp.success.title
1	Application {0} successfully created	web.root.createApp.success.msg
1	Not created	web.root.createApp.error.title
1	Application {0} wasn't created	web.root.createApp.error.message
1	Application Options	web.root.appOptions.tooltip
1	Application Options	web.root.appOptions.popup
1	Workflow	web.root.appOptions.popup.workflow.label
1	Enable workflow	web.root.appOptions.popup.workflow.checkbox
1	With the workflow you can set up states for your documents and keep track of them.	web.root.appOptions.popup.workflow.description
1	System Parameters	web.home.systemParameters
1	ID	admin.cruds.parameter.cols.id
1	Description	admin.cruds.parameter.cols.description
1	Label	admin.cruds.parameter.cols.label
1	Type	admin.cruds.parameter.cols.type
1	Value	admin.cruds.parameter.cols.value
1	String	admin.cruds.parameter.type.string
1	Boolean	admin.cruds.parameter.type.boolean
1	Long	admin.cruds.parameter.type.long
1	List	admin.cruds.parameter.type.list
1	Add System Parameter	admin.cruds.parameter.form.addCaption
1	Edit System Parameter	admin.cruds.parameter.form.editCaption
1	Save Parameter	admin.cruds.parameter.saved.title
1	Parameter saved successfully	admin.cruds.parameter.saved.message
1	Parameter deleted sucessfully	admin.cruds.parameter.deleted.message
1	Delete Paramter	admin.cruds.parameter.deleted.title
1	System Parameters	admin.cruds.parameter.title
1	Pending Activations	web.root.home.toolbox.pendingRegistrations
1	Registrations awaiting activation	web.root.pendingRegistration.grid.caption
1	ID	web.root.pendingRegistration.grid.id
1	Mail	web.root.pendingRegistration.grid.mail
1	Name	web.root.pendingRegistration.grid.name
1	Last name	web.root.pendingRegistration.grid.lastName
1	Registration time	web.root.pendingRegistration.grid.time
1	Activate Account	web.root.pendingRegistration.grid.activationToken
1	Options	web.root.pendingRegistration.grid.options
1	Activate	web.root.pendingRegistration.accept
1	Cancelled	web.root.pendingRegistration.cancelled.title
1	Pending activation cancelled	web.root.pendingRegistration.cancelled.message
1	Not Cancelled	web.root.pendingRegistration.not_cancelled.title
1	Pending activation id:{0} was not cancelled	web.root.pendingRegistration.not_cancelled.message
1	Owner	web.root.createApp.owner
1	Register user	web.root.home.toolbox.register
1	Your registration needs to be approved by a system administrator	web.controller.register.awaiting_approval
1	We already have a registration request on your behalf. Your registration needs to be approved by a system administrator	web.controller.register.awaiting_approval_again
1	Account registration is done only by approval of a system administrator	web.controller.register.by_approval_only
1	{0} is of type "Date" and cannot be assigned as value of a dropdown	web.editor.properties.dropdown.date_not_allowed_as_value
1	Application license	web.settings.applicationLicense
1	Application ID	web.settings.applicationLicense.applicationId
1	Maximum number of mobile devices per user	web.settings.applicationLicense.maxDevices
1	Maximum number of users	web.settings.applicationLicense.maxUsers
1	Application Owner	web.settings.applicationLicense.owner
1	Valid until	web.settings.applicationLicense.validUntil
1	License File	web.settings.applicationLicense.licenseFile
1	Upload License	web.settings.applicationLicense.upload
1	License Uploaded	web.settings.applicationLicense.licenseUpload
1	The license is not valid for this application	web.settings.applicationLicense.invalid
1	No limit	web.settings.applicationLicense.validUntil.unlimited
1	Preferences	web.settings.preferences
1	Application Name	web.settings.preferences.applicationName
1	Default Language	web.settings.preferences.defaultLanguage
1	Application Information	web.settings.aplicationInfo
1	Application owner name	web.settings.aplicationInfo.owner_name
1	Application owner email	web.settings.aplicationInfo.owner_mail
1	Application Id	web.settings.aplicationInfo.appId
1	Preferences saved	web.settings.preferences.saved.title
1	Would you like to upload a new license ?	web.settings.license.invitation
1	Application preferences were successfully saved	web.settings.preferences.saved.message
1	Application name	web.application.application.name.label
1	The server reached its maximum of {0} applications. Contact your salesman to buy a larger license.	web.root.max_apps.reached
1	An application with the name "{0}", already exists	web.root.app.duplicate
1	Invalid value on page {0} navigation rules for item {1}	services.commandService.validation.flow.invalidNumericValue
1	Greater than	web.editor.properties.dialogs.operators.greater_than
1	Less than	web.editor.properties.dialogs.operators.less_than
1	New Registration	web.controller.register.notification.subject
1	A new account has been registered for the user {0} {1} with email {2}	web.controller.register.notification.body
1	The account couldn't be activated because the server has reached its application limit	web.controller.activation.tooManyApplications
1	The issue has been reported to the server admin. We will contact you as soon as soon as possible	web.controller.activation.tooManyApplications.hint
1	Registration failed - too many applications	web.controller.register.notification.fail.tooMayApplications.title
1	The user {0} {1} ({2}) tried to create a new application, but the application limit on the server has been reached and no more applications can be created<br/><br/>Please contact support at mf@mf.com to enable more applications<br/><br/>Regards,<br/><br/>The Captura team	web.controller.register.notification.fail.tooMayApplications.subject
1	The Application's license is about to Expire	web.home.application.license.aboutToExpire
1	The Application's license has expired	web.home.application.license.expired
1	User cannot be deleted	admin.cruds.user.owner_cant_deleted.title
1	{0} is the application owner and cannot be deleted	admin.cruds.user.owner_cant_deleted.message
1	Activation status was succesfully changed	web.application.state.message
1	Activation was changed.	web.application.state.title
1	Server License properties	web.root.home.toolbox.serverInfoPopup
1	Server Info	web.root.home.toolbox.serverInfo
1	Server Identifier	web.root.license.serverId
1	Creation Date	web.root.license.creationDate
1	Valid Days	web.root.license.validDays
1	Expiration Date	web.root.license.expirationDate
1	Maximum number of applications allowed	web.root.license.maxApplications
1	Number of applications in use	web.root.license.applicationsInUse
1	Applications available	web.root.license.applicationsRemaining
1	Default application valid days	web.root.license.application.validDays
1	Default application maximum devices	web.root.license.application.maxDevices
1	Default application maximum users	web.root.license.application.maxUsers
1	Other Properties	web.root.license.otherProperties
1	Remove Device	web.home.admin.devices.removeDevice
1	Blacklist Device	web.home.admin.devices.blacklistDevice
1	Devices' blacklist	web.devices.blacklist.caption
1	Remove from blacklist	web.devices.removeFromBlackList
1	Add device to blacklist?	admin.cruds.user.blacklist.warning.title
1	The device will be removed and added to a blacklist	admin.cruds.user.blacklist.warning.msg
1	Devices of {0} {0}	web.home.admin.devices.devicePopup.title
1	The device was added to the blacklist	web.home.admin.devices.addToBlacklist.success.msg
1	Added	web.home.admin.devices.addToBlacklist.success.title
1	The device couldn't be added to the blacklist	web.home.admin.devices.addToBlacklist.fail.msg
1	Failed	web.home.admin.devices.addToBlacklist.fail.title
1	Removed	web.home.admin.devices.removeFromBlacklist.success.title
1	The device was removed to the blacklist	web.home.admin.devices.removeFromBlacklist.success.msg
1	Failed	web.home.admin.devices.removeFromBlacklist.fail.title
1	The device couldn't be added to the blacklist	web.home.admin.devices.removeFromBlacklist.fail.msg
1	Sorry, an internal server error ocurred	web.api.exception.standardMessage
1	Sorry, your device has been blacklisted	web.api.authentication.verification.blacklisted
1	Sorry, there's a problem with the server's license. Please contact the administrator	web.api.authentication.licenseException
1	Invalid User	web.api.authentication.invalidUser
1	Password in null	web.api.authentication.passwordIsNull
1	User is null	web.api.authentication.userIsNull
1	Sorry, you are not a member of the application	web.api.authorization.notMember
1	Sorry, your device doesn't seem like a valid one. Please try login in again	web.api.authorization.deviceNotAssociated
1	Sorry, the application you are trying to use is inactive	web.api.authorization.inactiveApplication
1	Sorry, the application's license has expired	web.api.authorization.licenseExpired
1	Sorry, the application is invalid	web.api.authorization.invalidApplication
1	Sorry, an error ocurred while saving the document in the server	web.api.documents.upload.IOExceptionInFile
1	Create Lookup Tables	application.rest.lookupTables.create.label
1	Allows the client the creation of Lookup Tables	application.rest.lookupTables.create.description
1	List Lookup Tables	application.rest.lookupTables.list.label
1	Allows the client to get a list of Lookup Tables	application.rest.lookupTables.list.description
1	Insert data	application.rest.lookupTables.insert.label
1	Allows the client to insert data in Lookp Tables	application.rest.lookupTables.insert.description
1	Modify data	application.rest.lookupTables.modify.label
1	Allows the client to modify data in Lookp Tables	application.rest.lookupTables.modify.description
1	Read data	application.rest.lookupTables.read.label
1	Allows the client to read data in Lookp Tables	application.rest.lookupTables.read.description
1	Forbidden. You don't have the required authorization	web.api.noauth
1	Usage statistics	web.admin.home.usage_statistics
1	Data Usage	web.root.home.toolbox.dataUsage
1	Failed Documents	web.root.home.toolbox.failedDocuments
1	<b>Upload description:</b><br /><br />{0}<br /><br /><b>Error description:</b><br /><br />{1}	services.mail.failed_document.body
1	Document Failed in Captura. {0}	services.mail.failed_document.subject
1	Notifications are disabled	web.admin.failed_document.notification_disabled
1	Notifications enabled to {0}	web.admin.failed_document.notification_enabled
1	Photo file names	web.home.querys.section.elementsFileNames
1	Choose the file name for each photo downloaded with the 'ZIP with Photos' option. Use [elementName] in places where an element's value should go	web.home.querys.section.elementsFileNames.help
1	ZIP format with excel file and photos	web.home.reports.xlswithphotos.tooltip
1	Type [ followed by the name of the element	web.home.querys.section.elementsFileNames.inputHelp
1	Download	web.generic.download
1	Saved in Device	web.home.reports.column.meta.savedAt
1	State	web.home.reports.column.meta.state
1	Help	web.generic.help
1	Privacy	web.generic.privacy
1	Grid	web.generic.grid
1	Select a row (double-click) in the "Grid" tab	web.home.reports.formView.emptyMsg
1	Showing document	web.home.reports.formView.showingDoc
2	Captura	web.generic.title
2	Captura	web.generic.brand
2	Inicio	web.generic.home
2	Nombre	web.generic.name
2	Ingresar	web.generic.login
2	Crear una cuenta	web.generic.register
2	Salir	web.generic.logout
2	Proyecto	web.generic.project
2	Tabla de Datos	web.generic.lookup_table
2	Proyectos	web.generic.projects
2	Mis Proyectos	web.generic.myprojects
2	Descripción	web.generic.description
2	Contraseña	web.generic.password
2	Contraseña	web.generic.enterPassword
2	Confirmar Contraseña	web.generic.confirmPassword
2	Usuario	web.generic.user
2	Usuarios	web.generic.users
2	Nombre	web.generic.firstname
2	Apellido	web.generic.lastname
2	Email	web.generic.mail
2	Formulario	web.generic.form
2	Formularios	web.generic.forms
2	Mis Formularios	web.generic.myforms
2	Configuración	web.generic.myaccount
2	Grupo	web.generic.group
2	Grupos	web.generic.groups
2	Rol	web.generic.role
2	Roles	web.generic.roles
2	Contenedor	web.generic.pool
2	Contenedores	web.generic.pools
2	Ok	web.generic.ok
2	Enviar	web.generic.submit
2	Cancelar	web.generic.cancel
2	Página	web.generic.page
2	Acción	web.generic.action
2	Error	web.generic.error
2	Información	web.generic.information
2	Excepción inesperada	web.generic.unexpectedException
2	La contraseña no puede ser vacía	web.generic.empty_password
2	Las contraseñas no coinciden	web.generic.password_not_equal
2	Latitud	web.generic.latitude
2	Longitud	web.generic.longitude
2	Campo Requerido Faltante	web.generic.requiredField
2	No implementado/Desarrollado	web.generic.notYetImplemented
2	Guardar	web.generic.save
2	Guardar como	web.generic.saveas
2	Borrar	web.generic.delete
2	Siguiente	web.generic.next
2	Anterior	web.generic.previous
2	No cuenta con suficientes permisos para ejecutar la acción	web.generic.not.enough.permissions
2	Cargando...	web.generic.loading
2	Agregar Usuario	web.generic.addUser
2	Agregar Grupo	web.generic.addGroup
2	Agregar Formulario	web.generic.addForm
2	Vaciar	web.generic.clear
2	Limpiar	web.generic.clean
2	Agregar	web.generic.add
2	Editar	web.generic.edit
2	Asociar	web.generic.associate
2	Seleccione el archivo	web.generic.selectFile
2	Versión	web.generic.version
2	Versión publicada	web.generic.versionPublished
2	Versión publicada	web.generic.publishedVersion
2	Publicar	web.generic.publish
2	Remover publicación	web.generic.unpublish
2	Publicar última versión	web.generic.publishLastVersion
2	Ninguno	web.generic.none
2	Guardar y Enviar	web.generic.saveAndSubmit
2	Items	web.generic.processItems
2	Barra de Herramientas	web.generic.toolbox
2	Perfil	web.generic.profile
2	SODEP 2012	web.generic.footer
2	Crear Etiqueta	web.generic.newLabel
2	Usuarios en el Grupo	web.generic.usersInGroup
2	Usuarios diponibles	web.generic.availableUsers
2	Roles disponibles	web.generic.availableRoles
2	Roles asignados	web.generic.assignedRoles
2	Grupos disponibles	web.generic.availableGroups
2	Grupos que contienen al Usuario	web.generic.groupsContainingUser
2	Recargar lista	web.generic.reloadGrid
2	Actualizar	web.generic.upgrade
2	Actualizar todos	web.generic.upgradeAll
2	Disponibles	web.generic.available
2	Seleccionados	web.generic.selected
2	Si	web.generic.yes
2	No	web.generic.no
2	Lo siento	web.generic.sorry
2	Precaución	web.generic.warning
2	Revocar la autorization al usuario	web.generic.revokeAuthorization.user
2	Revocar la autorization al grupo	web.generic.revokeAuthorization.group
2	Bienvenido a Captura	web.index.label01
2	Para más información sobre como Captura puede ayudarlo a Ud. y a su empresa a aprovechar el potencial de los teléfonos celulares inteligentes por favor tome el tour	web.index.label02
2	¡Esto es divertido!	web.index.label03
2	Tomar el tour	web.index.tour
2	Captura	web.index.title
2	Registrar un nuevo usuario	web.registration.title
2	Prueba que no eres un robot	web.registration.captcha
2	Crea tu cuenta de Captura	web.registration.label01
2	Registrar	web.registration.submit
2	Registro de usuarios  temporalmente deshabilitado	web.registration.disabled
2	Campo vacío	web.registration.error.emptyField
2	Un campo requerido está vacío	web.registration.error.requiredFieldEmpty
2	No podemos estar seguro que no eres un robot. Por favor intentanlo de nuevo	web.registration.error.catpcha
2	Las contraseñas no coinciden	web.registration.passwordsDontMatch
2	Pronto usted podrá... 	web.registration.marketing.title
2	Usar nuestro poderoso editor para diseñar sus formularios	web.registration.marketing.opt1
2	Permitir que distintas personas envien desde sus dispositivos móbiles los datos que usted está buscando.	web.registration.marketing.opt2
2	Funciona inclusive sin conexión	web.registration.marketing.opt3
2	Visualice datos enviados en la web	web.registration.marketing.opt4
2	Maneje permisos de usuarios	web.registration.marketing.opt5
2	Mucho más...	web.registration.marketing.opt6
2	Ingresar	web.login.title
2	Iniciar sesión con tu cuenta	web.login.label01
2	Ingresar	web.login.submit
2	¿No puede acceder a su cuenta?	web.login.cantAccesAccount
2	Email está vacío	web.login.emailEmpty
2	Password está vacio	web.login.passwordEmpty
2	Email inválido	web.validation.user.invalidmail
2	El password debe tener una longitud mínima de 8 caracteres	web.validation.user.password
2	El nombre debe tener una longitud mínima de 2 caracteres	web.validation.user.firstName
2	El apellido debe tener una longitud mínima de 2 caracteres	web.validation.user.lastName
2	Captura	web.home.title
2	¡{0} {1}, Bienvenido a Captura!	web.home.welcome
2	Principal	web.home.main
2	Datos	web.home.data
2	Diseñador de Formularios	web.home.editor
2	Administración	web.home.admin
2	ACME UI Components	web.home.acmeui
2	¿Está seguro que desea cambiar de aplicación?	web.home.appchanger.dialog.message
2	¿Cambiar de aplicación?	web.home.appchanger.dialog.title
2	Procesos	web.home.processes
2	Usuarios y grupos	web.home.usersAndGroups
2	Dispositivos	web.home.devices
2	Reportes de 	web.home.reports
2	Roles	web.home.rolesAndPermissions
2	Definición de Roles	web.home.rolesDefinition
2	Conectores	web.home.connectors
2	Preferencias	web.home.settings
2	Licencia	web.home.license
2	Legacy	web.home.legacy
2	Manejador de procesos	web.home.processManager
2	Configuración	web.home.management
2	Administración	web.home.administration
2	Administración del Sistema	web.home.systemAdministration
2	Mi cuenta	web.home.myaccount
2	Mis preferencias	web.home.myaccount.preferences.title
2	Configuración del conector remoto	web.home.myaccount.connector.title
2	Configuración de la contraseña	web.home.myaccount.password.title
2	Contraseña anterior:	web.home.myaccount.password.field.old
2	Nueva contraseña:	web.home.myaccount.password.field.new
2	Confirmar contraseña:	web.home.myaccount.password.field.confirm
2	Cambiar contraseña	web.home.myaccount.password.change
2	La contraseña se cambió exitosamente	web.home.myaccount.password.change.success.title
2	La confirmación no coincide con la nueva contraseña	web.home.myaccount.password.error.confirm
2	La contraseña anterior no es válida	web.home.myaccount.password.error.old
2	Configuración de Aplicación	web.home.application_settings
2	La aplicación no ha sido configurada.	web.home.first.setup.message
2	Configurar la aplicación	web.home.first.setup.link
2	Uncaught Exceptions	web.home.uncaughtException
2	Estos son sus Proyectos	web.dashboard.your_projects
2	Ver Datos	web.dashboard.view_data
2	Crear o editar Formularios	web.dashboard.build_edit
2	Administrar la Aplicación	web.dashboard.admin
2	Reportes	web.home.reports.title
2	Lista de consultas	web.home.reports.querys.title
2	Nueva Consulta	web.home.reports.newQuery
2	Consulta	web.home.reports.query
2	No existe versión publicada del Formulario	web.home.reports.noVersionIsPublished
2	Usuario	web.home.reports.column.meta.mail
2	Recibido al	web.home.reports.column.meta.receivedAt
2	Ubicación	web.home.reports.column.meta.location
2	Descargar CSV	web.home.reports.downloadCSV
2	Disponible en:	web.home.reports.exportOptions
2	Buscar	web.home.reports.button.search
2	CSV en UTF-8	web.home.reports.csv.tooltip
2	Archivo binario de Excel	web.home.reports.xls.tooltip
2	Formato PDF	web.home.reports.pdf.tooltip
2	Editar esta consulta	web.home.reports.edit.tooltip
2	Crear una nueva consulta	web.home.reports.createQuery.tooltip
2	Error al generar el reporte	web.home.reports.error.emptyReport.title
2	No hay datos para generar el reporte	web.home.reports.error.emptyReport.message
2	Nueva Consulta	web.home.querys.new.title
2	Editar Consulta	web.home.querys.edit.title
2	Nombre de la Consulta	web.home.querys.name
2	Columnas a ser visualizadas	web.home.querys.tableColumns
2	Columnas en el CSV	web.home.querys.csvColumns
2	Reporte guardado exitosamente	web.home.querys.saved.title
2	Reporte {0} guardado exitosamente	web.home.querys.saved.message
2	Reporte no guardado	web.home.querys.notsaved.title
2	Otro usuario ha actualizado o creado el reporte {0}	web.home.querys.notsaved.message
2	Volver a Reportes	web.home.querys.backToReports
2	Un reporte con el mismo nombre ya existe para esta version del Formulario	web.home.querys.invalid.duplicated
2	Reporte predeterminado	web.home.querys.setAsDefaultQuery
2	Datos del sistema	web.home.querys.metadataLabel
2	Escoja una columna	web.home.querys.addFilterDialog.title
2	Descargar las ubicaciones como links a Google Maps	web.home.querys.googleMapsLinks
2	Igual	web.home.reports.operator.equals
2	Mayor	web.home.reports.operator.greater
2	Menor	web.home.reports.operator.less
2	Entre	web.home.reports.operator.between
2	Como	web.home.reports.operator.like
2	Agrega un filtro	web.home.querys.addFilterButton
2	Escoge un Item de Proceso	web.home.querys.addFilterDialog_title
2	Reporte Borrado	web.home.querys.deleted.title
2	El reporte {0} ha sido borrado	web.home.querys.deleted.message
2	Borrar Reporte	web.home.querys.delete.confirmation.title
2	¿Está seguro de querer borrar el Reporte?	web.home.querys.delete.confirmation.message
2	Opciones para búsqueda	web.home.querys.searchOptions_title
2	Paso	web.home.querys.step
2	Información general	web.home.querys.section.generalInfo
2	Columnas visibles	web.home.querys.section.tableColumns
2	Elije las columnas que seran visibles en este reporte	web.home.querys.section.tableColumns.help
2	Seleccione las columnas para el ordenamiento	web.home.querys.section.sortingColumns
2	Las columnas seleccionadas seran utilizadas como criterio de ordenamiento	web.home.querys.section.sortingColumns.help
2	Seleccionar filtros	web.home.querys.section.filter
2	Registrar los filtros que seran utilizados por default en esta consulta	web.home.querys.section.filter.help
2	La consulta no ha sido guardada	web.home.querys.save.error.title
2	Compruebe que no haya errores y pruebe de nuevo	web.home.querys.save.error.message
2	Mostrar Datos	web.home.data.show
2	Descargar a CSV	web.home.data.downloadcsv
2	Ingresar Datos	web.home.data.input
2	Ingresar Datos	web.home.data.input.title
2	Mostrar Datos	web.home.data.show.title
2	La longitud mínima es {0}	web.home.data.input.error.minlenght
2	La longitud máxima es {0}	web.home.data.input.error.maxlenght
2	El valor mínimo es {0}	web.home.data.input.error.minvalue
2	El valor máximo es {0}	web.home.data.input.error.maxvalue
2	Datos guardados exitosamente	web.data.input.save.ok
2	Error. El Formulario no se ha guardado	web.data.input.save.error
2	Tipo de dato erróneo en el campo {0}	web.data.input.save.error.field.wrongType
2	El campo de datos {0} no está en la definición	web.data.input.save.error.field.wrongField
2	Seleccione un valor	web.data.input.select.initialLabel
2	No fue posible subir el archivo	web.data.input.file.upload.exception
2	Mostrar Datos	web.data.show.button
2	Seleccione un Proyecto	web.data.select.project
2	Seleccione un Formulario	web.data.select.form
2	Seleccione una Versión	web.data.select.version
2	Formulario vacío	web.data.form.empty
2	El formulario {0} no tiene metadatos	web.data.form.empty.message
2	Este formulario no posee campos para mostrar	web.data.show.noFields
2	Mostrar Imagen	web.data.show.showImage
2	Cargando Imagen	web.data.show.image.loading
2	Sin imagen	web.data.show.noImage
2	No disponible	web.data.show.not_available
2	Mostrar firma	web.data.show.showSignature
2	Sin firma	web.data.show.noSignature
2	Usuarios	web.home.admin.users
2	Grupos	web.home.admin.groups
2	Proyectos	web.home.admin.projects
2	Roles	web.home.admin.roles
2	Formularios	web.home.admin.forms
2	Items	web.home.admin.process_items
2	Contenedores	web.home.admin.pools
2	Dispositivos	web.home.admin.devices
2	Identificador	web.home.admin.devices.field.identifier
2	El ID único para cada dispositivo, por ejemplo, el IMEI para GSM o el MEID o ESN para telefonos CDMA. En Android marcar *#06#	web.home.admin.devices.identifier.msg
2	Esto puede no estar disponible para ciertos dispositivos	web.home.admin.devices.identifier.msg2
2	Marca	web.home.admin.devices.field.brand
2	Modelo	web.home.admin.devices.field.model
2	Número de teléfono	web.home.admin.devices.field.phone_number
2	OS	web.home.admin.devices.field.os
2	El usuario no tiene dispositivos asociados	web.home.admin.no_devices
2	Manejo de aplicaciones	web.home.admin.application_management
2	Crear Proyecto	web.home.admin.project.new
2	Configurar Proyecto	web.home.admin.project.edit
2	Configurar Proyecto	web.home.admin.project.manager
2	Crear Formulario	web.home.admin.form.new
2	Editar Formulario	web.home.admin.form.edit
2	Configurar Formulario	web.home.admin.form.manager
2	Agregar Dispositivo	web.home.admin.device.new
2	Editar Dispositivo	web.home.admin.device.edit
2	Crear Grupo	web.home.admin.group.new
2	Editar Grupo	web.home.admin.group.edit
2	Crear Usuario	web.home.admin.user.new
2	Editar Usuario	web.home.admin.user.edit
2	Crear Contenedor	web.home.admin.pool.new
2	Editar Contenedor	web.home.admin.pool.edit
2	Administrador de Contenedor	web.home.admin.pool.manager
2	Administrador de Items	web.home.admin.processitem.manager
2	Activar/Desactivar aplicación	web.admin.home.activation
2	¿Está seguro que quiere activar la aplicación: 	web.admin.home.activation.confirmation
2	¿Está seguro que quiere desactivar la aplicación	web.admin.home.activation.desconfirmation
2	Sólo activas	web.admin.home.onlyActive
2	Total Aplicaciones	web.admin.home.totalApps
2	Aplicaciones Activas	web.admin.home.activeApps
2	Aplicaciones Inactivas	web.admin.home.inactiveApps
2	OS Release	web.home.admin.devices.field.release
2	Usuarios y Grupos	web.home.admin.application_management.usersAndGroups
2	Procesos	web.home.admin.application_management.process
2	Manejador de Procesos	web.home.admin.application_management.processManager
2	Reportes	web.home.admin.application_management.reports
2	Dispositivos	web.home.admin.application_management.devices
2	Roles y Permisos	web.home.admin.application_management.rolesAndPermissions
2	Configuración de la aplicacion	web.home.admin.application_management.settings
2	Licencias	web.home.admin.application_management.licenses
2	Conectores	web.home.admin.application_management.connectors
2	La aplicación llegó a su máximo de {0} usuarios. Contacte con su agente de cuenta para adquirir una nueva licencia	web.home.admin.license.max_user.reached
2	La licencia de la aplicación está por expirar	web.home.application.license.aboutToExpire
2	La licencia de la aplicación ha expirado	web.home.application.license.expired
2	Esa dirección ya fue registrada	services.user.register.mail.duplicate
2	La cuenta ya ha sido eliminada y no puede agregarse nuevamente	services.user.register.mail.deleted
2	Otorgamiento de licencia de hasta {0} usuarios. Cantidad actual es {1}	services.user.new.license.max_user.reached
2	Crear Usuario	web.controller.register.newUser
2	Usuario creado	web.controller.register.userCreated
2	El usuario ha sido registrado. En breve recibirá un mail para activar la cuenta.	web.controller.register.ok
2	No se pudo registrar al usuario debido a datos inválidos, por favor revise el formulario de registro	web.controller.register.invalid
2	{0} ya está registrado. Por favor proceda a ingresar	web.controller.register.alreadyActive
2	La cuenta ya existe pero aún no ha sido activada. Pinche con el mouse <a href="#" id="resendLink">aquí</a> si quiere re-enviar el email de activación.	web.controller.register.confirmResend
2	Un email de activación ha sido enviado a {0}	web.controller.register.mailResent
2	No existe esa cuenta de Usuario	web.controller.register.noSuchUser
2	Activación pendiente	web.controller.register.pendingActivation
2	Aprobación pendiente	web.controller.register.pendingApproval
2	Seleccione una Tabla de Datos	web.data.select.lookup_table
2	Tablas de datos	web.home.data.lookup_table
2	Actualmente, no hay ninguna Tabla de Datos en el sistema	web.home.data.lookup_table.emptyTable
2	Identificador de Tabla de Datos vacío	web.data.lookup_table.validation.emptyLutParam
2	Identificador de Tabla de Datos inválido. No es un número	web.data.lookup_table.validation.invalidLutId
2	Tabla de Datos vacía	web.data.lookup_table.empty.message
2	Tabla de Datos borrada con éxito	web.data.lookup_table.delete.success
2	Tabla de Datos a borrar es inválida	web.data.lookup_table.delete.failure.illegalArgument
2	Borrar tabla de datos	web.data.lookup_table.delete.confirm.title
2	¿Está seguro que desea borrar la tabla de datos?	web.data.lookup_table.delete.confirm.message
2	Usuarios	admin.cruds.user.title
2	ID	admin.cruds.user.cols.id
2	Nombre	admin.cruds.user.cols.firstName
2	Apellido	admin.cruds.user.cols.lastName
2	Mail	admin.cruds.user.cols.mail
2	Username	admin.cruds.user.cols.username
2	Contraseña	admin.cruds.user.cols.password
2	Activo	admin.cruds.user.cols.active
2	Grupos	admin.cruds.user.cols.groups
2	Roles	admin.cruds.user.cols.roles
2	Dispositivos	admin.cruds.user.cols.devices
2	Último Login	admin.cruds.user.cols.lastLogin
2	Grupos a los que pertenece el usuario {0}	admin.cruds.user.groups.dialog.title
2	Roles del usuario {0}	admin.cruds.user.roles.dialog.title
2	Usuario {0} guardado	admin.cruds.user.saved.message
2	Usuario guardado	admin.cruds.user.saved.title
2	Usuario {0} eliminado	admin.cruds.user.deleted.message
2	Usuario eliminado	admin.cruds.user.deleted.title
2	El dispositivo {0} fue desasociado del usuario {1}	admin.cruds.user.diassociate.message
2	Dispositivo desasociado	admin.cruds.user.diassociate.title
2	Desasociar dispositivo	admin.cruds.user.diassociate.warning.title
2	¿Está seguro que desea desasociar el dispositivo {0}?	admin.cruds.user.diassociate.warning.msg
2	Enviar correo para reestablecer la contraseña	admin.cruds.user.password_reset_button.title
2	Mail enviado	admin.cruds.user.password_reset.ok.title
2	Mail no enviado	admin.cruds.user.password_reset.error.title
2	Seleccione un usuario	admin.cruds.user.user_not_selected
2	Datos del usuario no son válidos	admin.cruds.user.invalid.message
2	Agregar Usuario	admin.cruds.user.form.addCaption
2	Editar Usuario	admin.cruds.user.form.editCaption
2	Crear Usuario	admin.cruds.user.new.title
2	Editar Usuario	admin.cruds.user.edit.title
2	Agregar Grupos	admin.cruds.user.addGroups
2	Eliminar Grupos	admin.cruds.user.removeGroups
2	Asignar Roles	admin.cruds.user.addRoles
2	Eliminar Roles	admin.cruds.user.removeRoles
2	Ya existe un usuario con la dirección de email indicada	admin.cruds.user.invalid.duplicated
2	Invitación cancelada	admin.cruds.user.invitation.cancel.title
2	La invitación a {0} ha sido cancelada	admin.cruds.user.invitation.cancel.message
2	Invitar	admin.cruds.user.invite
2	Usuario agregado exitosamente a Grupos	admin.cruds.user.addGroups.title
2	Usuario eliminado exitosamente de Grupos	admin.cruds.user.removeGroups.title
2	Roles asignados a Usuarios exitosamente	admin.cruds.user.addRoles.title
2	Roles eliminados del Usuario exitosamente	admin.cruds.user.removeRoles.title
2	Grupos	admin.cruds.group.title
2	ID	admin.cruds.group.cols.id
2	Nombre del Grupo	admin.cruds.group.cols.name
2	Descripción	admin.cruds.group.cols.description
2	Activo	admin.cruds.group.cols.active
2	Roles	admin.cruds.group.cols.roles
2	Grupo {0} guardado	admin.cruds.group.saved.message
2	Grupo guardado	admin.cruds.group.saved.title
2	Grupo {0} eliminado	admin.cruds.group.deleted.message
2	Grupo eliminado	admin.cruds.group.deleted.title
2	Roles asignados al Grupo {0}	admin.cruds.group.roles.dialog.title
2	Datos invalidos	admin.cruds.group.invalid.message
2	Ya exite un grupo con ese nombre	admin.cruds.group.invalid.duplicated
2	Crear Grupo	admin.cruds.group.new.title
2	Editar Grupo	admin.cruds.group.edit.title
2	Agregar Usuarios	admin.cruds.group.addUsers
2	Eliminar del Grupo	admin.cruds.group.removeFromGroup
2	Asignar Roles	admin.cruds.group.addRoles
2	Eliminar Roles	admin.cruds.group.removeRoles
2	Usuarios agregados al grupo exitosamente	admin.cruds.group.addUsers.title
2	Usuarios eliminados del grupo exitosamente	admin.cruds.group.removeUsers.title
2	Roles asignados al grupo exitosamente	admin.cruds.group.addRoles.title
2	Roles eliminados del grupo exitosamente	admin.cruds.group.removeRoles.title
2	Proyectos	admin.cruds.project.title
2	Etiqueta no disponible en Español	admin.cruds.project.label.not_set
2	Descripción no disponible en Español	admin.cruds.project.description.not_set
2	ID	admin.cruds.project.cols.id
2	Etiqueta	admin.cruds.project.cols.label
2	Descripción	admin.cruds.project.cols.description
2	Idioma predeterminado	admin.cruds.project.cols.language
2	Dueño	admin.cruds.project.cols.owner
2	Creado	admin.cruds.project.cols.created
2	Activo	admin.cruds.project.cols.active
2	Editar	admin.cruds.project.cols.edit
2	Clonar	admin.cruds.project.cols.clone
2	Permisos de Usuarios	admin.cruds.project.cols.auths
2	Autorización del Proyecto {0}	admin.cruds.project.auths.dialog.title
2	Proyecto {0} Guardado	admin.cruds.project.saved.message
2	Proyecto guardado	admin.cruds.project.saved.title
2	Formulario {0} importado	admin.cruds.project.form.imported.message
2	Formulario importado	admin.cruds.project.form.imported.title
2	Roles en el Proyecto guardados	admin.cruds.project.roles.saved.title
2	Roles en el Proyecto borrados	admin.cruds.project.roles.deleted.title
2	Proyecto eliminado	admin.cruds.project.deleted.title
2	Proyecto {0} eliminado	admin.cruds.project.deleted.message
2	Ha ocurrido un error al intentar borrar el Proyecto {0}	admin.cruds.project.deleted.error
2	Datos inválidos	admin.cruds.project.invalid.message
2	Configurar Proyecto	admin.cruds.project.form.editCaption
2	Agregar Proyecto	admin.cruds.project.form.addCaption
2	Crear Proyecto	admin.cruds.project.new.title
2	Configurar Proyecto	admin.cruds.project.edit.title
2	Lista de Usuarios	admin.cruds.project.userGrid.title
2	Lista de Grupos	admin.cruds.project.groupGrid.title
2	Lista de Formularios	admin.cruds.project.formGrid.title
2	Usuario Repetido	admin.cruds.project.error.userRepeated
2	Grupo Repetido	admin.cruds.project.error.groupRepeated
2	Proyecto no guardaddo	admin.cruds.project.notsaved.title
2	Otro usuario ha creado o actualizado el proyecto {0}	admin.cruds.project.notsaved.message
2	Borrar Proyecto	admin.cruds.project.delete.confirmation.title
2	¿Está seguro que quiere borrar este Proyecto? Todos los formularios del proyecto también serán borrados.	admin.cruds.project.delete.confirmation.message
2	There is already a Project with the same name	admin.cruds.project.invalid.duplicated
2	Marcas	web.home.admin.brands
2	Editar	admin.cruds.brand.cols.edit
2	Marcas	admin.cruds.brand.title
2	ID	admin.cruds.brand.cols.id
2	Nombre	admin.cruds.brand.cols.name
2	Activo	admin.cruds.brand.cols.active
2	Marca eliminada	admin.cruds.brand.deleted.title
2	Marca {0} eliminada	admin.cruds.brand.deleted.message
2	Marca guardada	admin.cruds.brand.saved.title
2	Marca {0} guardada	admin.cruds.brand.saved.message
2	Brand no guardada	admin.cruds.brand.notsaved.title
2	Marca {0} no guardada	admin.cruds.brand.notsaved.message
2	Marca duplicada	admin.cruds.brand.invalid.duplicated
2	Editar Marca	admin.cruds.brand.form.editCaption
2	Agregar Marca	admin.cruds.brand.form.addCaption
2	ID	admin.cruds.model.cols.id
2	Modelo	admin.cruds.model.cols.name
2	Marca	admin.cruds.model.cols.brand
2	Activo	admin.cruds.model.cols.active
2	Modelo	admin.cruds.model.title
2	Agregar Modelo	admin.cruds.model.form.addCaption
2	Editar Modelo	admin.cruds.model.form.editCaption
2	Modelos	web.home.admin.models
2	Modelo existente	admin.cruds.model.invalid.duplicated
2	Error al intentar agregar Modelo	admin.cruds.model.nonexist.brand.title
2	No hay Marcas activas disponibles.	admin.cruds.model.nonexist.brand.message
2	Roles	admin.cruds.role.title
2	ID	admin.cruds.role.cols.id
2	Nombre	admin.cruds.role.cols.name
2	Descripcion	admin.cruds.role.cols.description
2	Nivel	admin.cruds.role.cols.level
2	Activo	admin.cruds.role.cols.active
2	Manejar Permisos	admin.cruds.role.cols.auths
2	Rol {0} guardado	admin.cruds.role.saved.message
2	Rol guardado	admin.cruds.role.saved.title
2	Rol {0} eliminado	admin.cruds.role.deleted.message
2	Rol eliminado	admin.cruds.role.deleted.title
2	Permisos del Rol {0}	admin.cruds.role.auths.dialog.title
2	Agregar Rol	admin.cruds.role.form.addCaption
2	Editar Rol	admin.cruds.role.form.editCaption
2	Administrar Permisos	web.home.admin.role.permission_management
2	Ya existe un Rol con ese nombre	admin.cruds.role.invalid.duplicated
2	Aplicación	admin.cruds.role.level.application
2	Proyecto	admin.cruds.role.level.project
2	Formulario	admin.cruds.role.level.form
2	Contenedor	admin.cruds.role.level.pool
2	Permisos	web.home.admin.role.permission
2	Permisos	admin.cruds.role.permission.title
2	Rol	admin.cruds.role.permission.role
2	Descripcion	admin.cruds.role.permission.description
2	Permisos de {0} guardados	admin.cruds.role.permission.saved.message
2	Permisos guardados	admin.cruds.role.permission.saved.title
2	Administrar Formularios	admin.cruds.form.title
2	ID	admin.cruds.form.cols.id
2	Etiqueta	admin.cruds.form.cols.label
2	Descripción	admin.cruds.form.cols.description
2	Version	admin.cruds.form.cols.version
2	Version Publicada	admin.cruds.form.cols.versionPublished
2	Publicado	admin.cruds.form.cols.published
2	Idioma por defecto	admin.cruds.form.cols.default_language
2	Aceptar Datos	admin.cruds.form.cols.accept_data
2	Creado	admin.cruds.form.cols.created
2	Proyecto	admin.cruds.form.cols.project
2	Activo	admin.cruds.form.cols.active
2	Manejo de Permisos	admin.cruds.form.cols.auths
2	Manejo de Usuarios y Grupos del Formulario {0}	admin.cruds.form.auths.dialog.title
2	Formulario {0} guardado	admin.cruds.form.saved.message
2	Formulario guardado	admin.cruds.form.saved.title
2	Roles en el formulario guardados	admin.cruds.form.roles.saved.title
2	Roles en el formulario borrados	admin.cruds.form.roles.deleted.title
2	Formulario {0} Publicado	admin.cruds.form.published.message
2	Formulario Publicado	admin.cruds.form.published.title
2	Formulario {0} no Publicado	admin.cruds.form.unpublished.message
2	Formulario no Publicado	admin.cruds.form.unpublished.title
2	El formulario {0} no puede ser publicado porque no tiene elementos	admin.cruds.form.notPublished.noElements.message
2	El formulario no puede ser publicado	admin.cruds.form.notPublished.noElements.title
2	El formulario {0} no puede ser publicado porque está vacío. Use el Diseñado para agregar elementos	admin.cruds.form.notPublished.noPages.message
2	El formulario no puede ser publicado	admin.cruds.form.notPublished.noPages.title
2	Formulario {0} eliminado	admin.cruds.form.deleted.message
2	Formulario eliminado	admin.cruds.form.deleted.title
2	Ha ocurrido un error al intentar borrar el Formulario {0}	admin.cruds.form.deleted.error
2	Datos inválidos	admin.cruds.form.invalid.message
2	Error al guardar el Formulario	admin.cruds.form.invalid.errorSaving
2	No se pueden guardar dos Formularios con el mismo nombre en el mismo Proyecto	admin.cruds.form.invalid.duplicated
2	El Formulario o el Proyecto al cual este pertenece fue modificado durante su creación o edición	admin.cruds.form.invalid.lockError.creation
2	El Formulario o el Proyecto al cual este pertenece fue modificado durante su edición	admin.cruds.form.invalid.lockError.edition
2	Guardar e ir al Diseñador	admin.cruds.form.button.saveAndGoEditor
2	Ir al Diseñador	admin.cruds.form.button.goEditor
2	Diseñar Formulario	admin.cruds.form.cols.editForm
2	Abrir Diseñador	admin.cruds.form.cols.openEditor
2	¿Está seguro de querer borrar este Formulario? Esta acción no puede ser deshecha.	admin.cruds.form.delete.confirmation.message
2	Borrar Formulario	admin.cruds.form.delete.confirmation.title
2	Hay elementos requeridos que no fueron completados	admin.cruds.form.missingRequiredFields
2	Items	admin.cruds.processitem.title
2	ID	admin.cruds.processitem.cols.id
2	Etiqueta	admin.cruds.processitem.cols.label
2	Tipo	admin.cruds.processitem.cols.type
2	Requerido	admin.cruds.processitem.cols.required
2	Visible	admin.cruds.processitem.cols.visible
2	Creado	admin.cruds.processitem.cols.created
2	Activo	admin.cruds.processitem.cols.active
2	Contenedor	admin.cruds.processitem.cols.pool
2	Agregar un Item de Proceso	admin.cruds.processitem.add.title
2	Item de Proceso {0} guardado	admin.cruds.processitem.saved.message
2	Item de Proceso guardadoP	admin.cruds.processitem.saved.title
2	Item de Proceso {0} borrado	admin.cruds.processitem.deleted.message
2	Item de Proceso borrado	admin.cruds.processitem.deleted.title
2	Un Item de Proceso con el mismo nombre ya existe en la aplicacion	admin.cruds.processitem.invalid.duplicated
2	No se puede guardar el Item de Proceso. No hay una applicacion seleccionada	admin.cruds.processitem.invalid.applicationRequired
2	Item de proceso no guardado	admin.cruds.processitem.notsaved.title
2	Otro usuario ha creado o actualizado el Item de Proceso  denominado {0}	admin.cruds.processitem.notsaved.message
2	Guardar Item de Proceso como	admin.processitem.dialog.saveas.title
2	Actualización correcta del Item de Proceso	admin.processitem.upgrade.success
2	Actualización correcta del Item de Proceso en todos los Formularios	admin.processitem.upgradeAll.success
2	Versión del Item de Proceso	admin.processitem.processItemVersion
2	¿Está seguro que desea borrar este Item de Proceso? Esta acción no puede ser deshecha.	admin.cruds.processitem.delete.confirmation.message
2	Borrar Item de Proceso	admin.cruds.processitem.delete.confirmation.title
2	Los siguientes Formularios dependen de este Item de Proceso: 	admin.cruds.processitem.delete.form.depends.on
2	Contenedor	admin.form.processitem.common.poolselect
2	Etiqueta	admin.form.processitem.common.label
2	Requerido	admin.form.processitem.common.required
2	Visible	admin.form.processitem.common.visible
2	Activo	admin.form.processitem.common.active
2	Tipo	admin.form.processitem.common.type
2	Mínimo	admin.form.processitem.input.minimum
2	Máximo	admin.form.processitem.input.maximum
2	Solo lectura	admin.form.processitem.input.readonly
2	Depende de	admin.form.processitem.select.dependson
2	Tabla de Datos	admin.form.processitem.select.lookup
2	Colección	admin.form.processitem.select.collection
2	Etiqueta de opción	admin.form.processitem.select.label
2	Valor de opción	admin.form.processitem.select.value
2	Area de Texto	admin.form.processitem.select.textarea
2	Editar	admin.form.processitem.button.edit
2	Aceptar	admin.form.processitem.button.accept
2	Cancelar	admin.form.processitem.button.cancel
2	Texto	admin.form.processitem.type.text
2	Fecha	admin.form.processitem.type.date
2	Hora	admin.form.processitem.type.time
2	Fecha tiempo	admin.form.processitem.type.datetime
2	Contraseña	admin.form.processitem.type.password
2	Entero	admin.form.processitem.type.integer
2	Decimal	admin.form.processitem.type.decimal
2	Area de Texto	admin.form.processitem.type.textarea
2	Lista desplegable	admin.form.processitem.type.select
2	Ubicación	admin.form.processitem.type.location
2	Fotografía	admin.form.processitem.type.photo
2	Encabezado	admin.form.processitem.type.headline
2	Casilla de verificación	admin.form.processitem.type.checkbox
2	Código de barra	admin.form.processitem.type.barcode
2	Firma	admin.form.processitem.type.signature
2	Correo Electrónico	admin.form.processitem.type.email
2	Enlace Externo	admin.form.processitem.type.external_link
2	Ninguno	admin.form.processitem.select.none
2	Múltiple	admin.form.processitem.select.multiple
2	Identificador	admin.form.processitem.select.identifier
2	Opciones	admin.form.processitem.select.optionLabel
2	Tabla de Datos	admin.form.processitem.select.manualSource
2	Manual	admin.form.processitem.select.dynamicSource
2	Fuente	admin.form.processitem.select.source
2	Valor por defecto	admin.form.processitem.input.defaultValue
2	Etiqueta de opción	admin.form.processitem.select.optionlabel
2	Opciones	admin.form.processitem.select.options
2	Editar Item de Proceso	admin.cruds.processitem.edit.title
2	Longitud por defecto	admin.form.processitem.input.defaultLongitude
2	Latitud por defecto	admin.form.processitem.input.defaultLatitude
2	Guardado en Contenedor	admin.form.processitem.common.storedinpool
2	Propiedades	admin.form.processitem.properties
2	Formularios	admin.form.processitem.forms
2	No existen Formularios usando este Item de Proceso	admin.form.processitem.forms.noFormsUsingProcessItem
2	Formularios usando este Item de Proceso	admin.form.processitem.forms.title
2	Crear Item	web.home.admin.processitem.new
2	Editar Item	web.home.admin.processitem.edit
2	Lista de Items	web.home.admin.processitem.list
2	Información de la versión	admin.form.processitem.common.versionInfo
2	Versión	admin.form.processitem.common.version
2	No es un número real	admin.form.processitem.validation.notRealNumber
2	Latitud	admin.form.processitem.location.latitude
2	Longitud	admin.form.processitem.location.longitude
2	La latitud y longitud utilizada no representan coordenadas válidas	admin.form.processitem.validation.coordinate.invalid
2	Latitud y longitud son requeridas	admin.form.processitem.validation.coordinate.required
2	Campo requerido	admin.processitem.validation.required
2	Campo no puede ser nulo	admin.processitem.validation.notnull
2	Campo no es un número entero	admin.processitem.validation.notaninteger
2	El campo es negativo	admin.processitem.validation.isnegative
2	El campo máximo es menor al mínimo	admin.processitem.validation.maxlessthanmin
2	ERROR: Este campo no puede ser nulo	admin.processitem.error.isnull
2	Al menos una opción es requerida 	admin.processitem.validation.atleastoneoption
2	Opciones duplicadas	admin.processitem.validation.optionalreadydefined
2	Valor de fecha inválido	admin.processitem.validation.invalid.date
2	Valor de fechatiempo inválido	admin.processitem.validation.invalid.datetime
2	Valor de tiempo inválido	admin.processitem.validation.invalid.time
2	Campo no puede ser vacío	admin.processitem.validation.invalid.empty
2	Valor no puede ser mayor al máximo	admin.processitem.validation.invalid.greaterThanMaximum
2	Valor no puede ser menor al mínimo	admin.processitem.validation.invalid.lessThanMinimum
2	Valor no es entero	admin.processitem.validation.invalid.integer
2	Valor no es decimal	admin.processitem.validation.invalid.decimal
2	Valor máximo sobrepasado	admin.processitem.validation.maxExceed
2	El Item de Proceso fue guardado	admin.processitem.save.success
2	Hubo problemas al intentar guardar el Item de Proceso	admin.processitem.save.failure
2	Contenedores de Items	admin.cruds.pool.title
2	ID	admin.cruds.pool.cols.id
2	Nombre	admin.cruds.pool.cols.name
2	Descripción	admin.cruds.pool.cols.description
2	Activo	admin.cruds.pool.cols.active
2	Datos inválidos	admin.cruds.pool.invalid.message
2	Contenedor {0} guardado	admin.cruds.pool.saved.message
2	Contenedor guardado	admin.cruds.pool.saved.title
2	Process Item {0} importado	admin.cruds.pool.processItem.imported.message
2	Process Item importado	admin.cruds.pool.processItem.imported.title
2	Roles en el Contenedor guardado	admin.cruds.pool.roles.saved.title
2	Roles en el Contenedor borrados	admin.cruds.pool.roles.deleted.title
2	Contenedor {0} borrado	admin.cruds.pool.deleted.message
2	Contenedor borrado	admin.cruds.pool.deleted.title
2	Agregar Contenedor	admin.cruds.pool.form.addCaption
2	Editar Contenedor	admin.cruds.pool.form.editCaption
2	Crear Contenedor	admin.cruds.pool.new.title
2	Editar Contenedor	admin.cruds.pool.edit.title
2	Un Contenedor con el mismo nombre ya existe en la aplicacion	admin.cruds.pool.invalid.duplicated
2	Copiar al Contenedor actual	admin.cruds.pool.button.addProcessItem
2	Lista de Usuarios	admin.cruds.pool.userGrid.title
2	Lista de Grupos	admin.cruds.pool.groupGrid.title
2	Contenedor no guardado	admin.cruds.pool.notsaved.title
2	Otro usuario ha guardado o actualizado el Contenddor {0}	admin.cruds.pool.notsaved.message
2	Borrar Contenedor	admin.cruds.pool.delete.confirmation.title
2	¿Está seguro que desea borrar el Contenedor? Esta acción no puede ser deshecha.	admin.cruds.pool.delete.confirmation.message
2	El Formulario {0} depende de estos PROTOTIPOS: 	admin.cruds.pool.delete.form.depends.on
2	Dispositivos	admin.cruds.device.title
2	ID	admin.cruds.device.cols.id
2	Modelo	admin.cruds.device.cols.model
2	Marca	admin.cruds.device.cols.brand
2	Numero	admin.cruds.device.cols.number
2	IMEI	admin.cruds.device.cols.imei
2	Activo	admin.cruds.device.cols.active
2	Opciones	admin.cruds.device.cols.options
2	Asociaciones	admin.cruds.device.cols.associations
2	Editar	admin.cruds.device.cols.edit.link
2	Administrar Asociaciones	admin.cruds.device.cols.association.link
2	Dispositivo	admin.cruds.device.cols.device
2	Dispositivo {0} guardado	admin.cruds.device.saved.message
2	Dispositivo guardado	admin.cruds.device.saved.title
2	Dispositivo {0} borrado	admin.cruds.device.deleted.message
2	Dispositivo borrado	admin.cruds.device.deleted.title
2	Datos de Dispositivo inválidos	admin.cruds.device.invalid.message
2	Agregar Dispositivo	admin.cruds.device.new.title
2	Editar Dispositivo	admin.cruds.device.edit.title
2	Administrar Asociacion	admin.cruds.device.association.title
2	Seleccione una Marca	admin.cruds.device.brand.select
2	Seleccione un Modelo	admin.cruds.device.model.select
2	Dispositivo no guardado	admin.cruds.device.notsaved.title
2	Otro usuario ha actualizado o creado el dispositivo {0}	admin.cruds.device.notsaved.message
2	Dispositivo {0} esta asociado con {1}	admin.cruds.device.savedAssociation.message
2	Asociacion del Dispositivo guadardo	admin.cruds.device.savedAssociation.title
2	Asociacion de Dispositivo eliminada	admin.cruds.device.removeAssociation.title
2	Dispositivo {0} no esta asociado a ningun Usuario	admin.cruds.device.removeAssociation.message
2	Eliminar Asociacion	admin.cruds.device.cols.removeAssociation.link
2	Parámetros de sistema	web.home.systemParameters
2	ID	admin.cruds.parameter.cols.id
2	Descripción	admin.cruds.parameter.cols.description
2	Etiqueta	admin.cruds.parameter.cols.label
2	Tipo	admin.cruds.parameter.cols.type
2	Valor	admin.cruds.parameter.cols.value
2	Caracteres	admin.cruds.parameter.type.string
2	Si/No Verdadero/Falso	admin.cruds.parameter.type.boolean
2	Numérico	admin.cruds.parameter.type.long
2	Lista	admin.cruds.parameter.type.list
2	Agregar Parámetro de sistema	admin.cruds.parameter.form.addCaption
2	Editar Parámetro de sistema	admin.cruds.parameter.form.editCaption
2	Guardar Parámetro	admin.cruds.parameter.saved.title
2	Parámetro guardado correctamente	admin.cruds.parameter.saved.message
2	Parámetro borrado correctamente	admin.cruds.parameter.deleted.message
2	Borrar Parámetro	admin.cruds.parameter.deleted.title
2	Parámetros de Sistema	admin.cruds.parameter.title
2	<b>{0}, Bienvenido a Captura!</b><br /><br />Para activar su cuenta siga el siguiente enlace <a href="{1}">{1}</a><br /><br />El equipo de Captura	services.mail.registration.body
2	Captura - Activación	services.mail.registration.subject
2	Su cuenta ha sido activada.	web.controller.activation.activated
2	Solicitud Inválida	web.controller.activation.invalid
2	Por favor compruebe que el URL es exactamente igual al que le enviamos por email.	web.controller.activation.invalid.hint
2	Su cuenta se encuentra activa.	web.controller.activation.isActive
2	Nueva cuenta en Captura	services.mail.credentials.subject
2	Hola {0}, se te ha creado una cuenta en la aplicación {1} de Captura. <br/>usuario: {2}<br />contraseña: {3}	services.mail.credentials.body
2	Cambiar de contraseña de Captura	services.mail.set_password.subject
2	Hola {0},<br/><br/>El uszario {1} cree que deberías reestablecer tu contraseña. Si deseas hacerlo sigue el enlace <a href="{2}">{2}</a><br /><br /><br /> El equipo de Captura	services.mail.set_password.body.sender
2	Hola {0},<br/><br/>Por favor sigue el siguiente enlace para definir tu contraseña para Captura <a href="{1}">{1}</a><br /><br /><br />El equipo de Captura	services.mail.set_password.body.nosender
2	Se ha enviado un mail al usuario {0} con instrucciones para reestablecer su contraseña	web.controller.password_reset.mailSent
2	No se ha enviado el mail	web.controller.password_reset.mailNotSent
2	ID de usuario inválida	web.controller.password_reset.invalidId
2	Solicitud inválida	web.controller.password_reset.invalid
2	Reestablecer la contraseña para el usuario {0}	web.controller.password_reset.greetings
2	Ingrese la nueva contraseña	web.controller.password_reset.new_password_label
2	Contraseña inválida	web.controller.password_reset.invalidpasswords
2	Reestablecer contraseña	web.password_reset.title
2	Nueva contraseña	web.password_reset.success.title
2	Se ha guardado su nueva contraseña. Si lo desea, puede <a href="{0}">ingresar</a>	web.password_reset.success.message
2	Sigue el enlace: {0}	web.password_reset.dialog.body
2	Hola {0},<br /><br />¿{1} deseas ingresar a la aplicación {2} de Captura?<br /><br />Si deseas aceptar la invitación sigue el enlace <a href="{3}">{3}</a><br /><br /><br />El equipo de Captura.	services.mail.invitation.body
2	Únete a {0} en Captura	services.mail.invitation.subject
2	Te has unido a la aplicación {0}. Ya puedes ingresar a la aplicación.	web.controller.invitation.accepted
2	<p>Ahora eres miembro de la aplicación {0}.</p> <p>Se te ha asignado una contraseña. Si no sabes cuál es, contacta con {1}</p>	web.controller.invitation.accepted_no_password
2	Lo sentimos, no hemos podido aceptar el pedido. Por favor contacta a la persona que te ha invitado.	web.controller.invitation.notAccepted
2	Invitación inválida	web.controller.invitation.token.invalid
2	Invitación enviada	web.controller.invitation.sent.ok
2	Una invitación ha sido enviada a {0}	web.controller.invitation.mailSent
2	Invitación no enviada	web.controller.invitation.sent.error
2	Email de invitación no enviado	web.controller.invitation.mailNotSent
2	Identificación de usuario no válida	web.controller.invitation.invalidId
2	Has accedido a la aplicación {0} de Captura. Debes configurar tu contraseña antes de poder ingresar. En breve recibirás un email con instrucciones.	web.controller.invitation.setPasswordMail
2	Elija un Proyecto	web.editor.select.project
2	Lista de Formularios vacía	web.editor.select.project.noForms
2	Nuevo	web.editor.mainbuttons.new
2	Abrir	web.editor.mainbuttons.open
2	Guardar	web.editor.mainbuttons.save
2	Guardar como	web.editor.mainbuttons.saveAs
2	Cancelar	web.editor.mainbuttons.cancel
2	Crear Formulario	web.editor.dialog.title.newForm
2	Abrir Formulario	web.editor.dialog.title.openForm
2	Guardar Formulario como	web.editor.dialog.title.saveAs
2	Aceptar	web.editor.dialog.buttons.ok
2	Cancelar	web.editor.dialog.buttons.cancel
2	Nombre inválido	web.editor.dialog.form.invalidName
2	Formulario inválido	web.editor.dialog.form.noSelected
2	Error al cargar el la Barra de Herramientas, contacte al servicio de soporte.	web.editor.toolbox.loadError
2	Agregar Página	web.editor.mainlayer.button.newPage
2	Propiedades	web.editor.properties
2	Elija un item	web.editor.properties.selectItem
2	Formulario	web.editor.properties.type.form
2	Input	web.editor.properties.type.input
2	Lista despleglable	web.editor.properties.type.select
2	Página	web.editor.properties.type.page
2	Etiqueta	web.editor.properties.label
2	Posición	web.editor.properties.position
2	Requerido	web.editor.properties.required
2	Final	web.editor.properties.saveable
2	Descripción	web.editor.properties.description
2	Longitud mínima	web.editor.properties.minlength
2	Longitud máxima	web.editor.properties.maxlength
2	Valor mínimo	web.editor.properties.minvalue
2	Valor máximo	web.editor.properties.maxvalue
2	Valor por defecto	web.editor.properties.defaultValue
2	Latitud por defecto	web.editor.properties.defaultLatitude
2	Longitud por defecto	web.editor.properties.defaultLongitude
2	Campo	web.editor.properties.fieldName
2	Solo lectura	web.editor.properties.readOnly
2	Manual	web.editor.properties.select.source.embedded
2	Tabla de Datos	web.editor.properties.select.source.lookup_table
2	Fuente	web.editor.properties.select.source
2	Tabla de Datos	web.editor.properties.select.lookuptable
2	Columna del valor	web.editor.properties.select.lookuptable.value
2	Columna de la etiqueta	web.editor.properties.select.lookuptable.label
2	Valores	web.editor.properties.select.embedded.values
2	Solo Cámara	web.editor.properties.photo.cameraOnly
2	Seleccionada	web.editor.properties.checkbox.checked
2	Página nueva	web.editor.form.newPage.label
2	ID	web.editor.page.id
2	Otros Items	web.editor.toolbox.poolLess
2	Items	web.editor.toolbox.systemPool
2	Items	web.editor.toolbox.title
2	Crear Item de Proceso	web.editor.newProcessItem.label
2	No hay cambios para guardar	web.editor.noChanges
2	Sin cambios	web.editor.noChanges.Title
2	Existen cambios no guardados. Por favor guarde los cambios antes de intentar publicar el Formulario.	web.editor.publish.unsavedChanges
2	Cambios no guardados	web.editor.publish.unsavedChanges.title
2	Formulario guardado	web.editor.saved
2	Ha ocurrido un error al intentar guardar el Formulario	web.editor.error.notSaved
2	Información	web.editor.info
2	Una página inicial fue agregada al Formulario	web.editor.form.automatic.newpage
2	Dispositivos asociados	web.grid.users.row.deviceDetails
2	Si abandona la página sus cambios serán descartados. ¿Desea continuar?	web.editor.exit.unsaved
2	Cambios no guardados	web.editor.exit.unsaved.title
2	Mover a la página >	web.editor.processItem.moveToPage
2	Diseñador de Formularios	web.editor.title
2	Configuración del Formulario	web.editor.backToFormManager
2	Filtro	web.editor.properties.select.filter.label
2	Mostrar opciones de Filtro	web.editor.properties.select.filter.button
2	Filtros	web.editor.properties.dialogs.filter.label
2	Tabla de Datos	web.editor.properties.dialogs.lookuptable.label
2	Valor	web.editor.properties.dialogs.value.label
2	Una versión anterior de este Formulario ha sido publicada	web.editor.dialog.incrementversion.confirmation.title
2	Guardar los cambios incremantará el número de versión. Si desea hacer los cambios visibles en los dispositivos móviles debe publicar esta nueva versión. Desea continuar?	web.editor.dialog.incrementversion.confirmation.message
2	Páginas inalcanzables	web.editor.unreachablePages
2	El formulario contienen páginas inalcanzables. Las páginas están marcadas con rojo.	web.editor.unreachablePages.explanation
2	Esta página es inalcanzable	web.editor.page.warning.unreachable
2	id	web.editor.element.id
2	Configurar {0}	web.myaccount.myapps.settings.label
2	Sesión Inválida	web.session.invalid.title
2	Su sesión es inválida o ha expirado	web.session.invalid.message
2	Sesión inactiva	web.timeout.dialog.title
2	Su sesión ha estado inactiva y podría haber expirado	web.timeout.dialog.message
2	Error en solucitud ajax: {0}	web.ajax.error
2	Status solicitud ajax: {0}	web.ajax.status
2	Sin autorización	web.ajax.unauthorized
2	Prohibido	we.ajax.forbidden
2	No se pudo establecer una conexión al servidor	web.ajax.unreachable
2	Servidor temporalmente no disponible	web.ajax.unavailable
2	Importar Datos	web.home.data.import
2	Importación de datos CSV	web.dataimport.label
2	Nombre de la Tabla	web.dataimport.lookuptable.name.label
2	Archivo CSV	web.dataimport.csv.file.label
2	Archivo	web.dataimport.file.label
2	Datos importados exitosamente	web.data.import.success.title
2	La tabla {0} ha sido creada con los datos CSV	web.data.import.success.message
2	Error en fila: campo {0}, valor {1}, con error {2}	web.data.import.error.row.label
2	El nombre de la tabla no puede ser vacio	web.data.import.error.emptyTableName
2	Error en encabezado {0} . No esta permitido un nombre vacio	web.data.import.error.emptyColumnName
2	Error en encabezado {0} . No esta permitido usar "." (puntos) 	web.data.import.error.columnNameError
2	Importante	web.data.import.important.title
2	Por favor incluya los nombres de las columnas en la primera linea	web.data.import.important.msg1
2	El unico separador soportado actualmente es la coma ","	web.data.import.important.msg2
2		web.dataimport.lookuptable.
2	Todos	web.dataimport.lookuptable.qualifier.all
2	Ninguno	web.dataimport.lookuptable.qualifier.none
2	Qualificadores de texto	web.dataimport.lookuptable.qualifier.label
2	Delimitadores	web.dataimport.lookuptable.delimiter.label
2	Tabulador	web.dataimport.lookuptable.delimiter.tab
2	Punto y coma	web.dataimport.lookuptable.delimiter.semicolon
2	Punto	web.dataimport.lookuptable.delimiter.colon
2	Coma	web.dataimport.lookuptable.delimiter.comma
2	Espacio	web.dataimport.lookuptable.delimiter.space
2	Título de columna	web.dataimport.lookuptable.columnheader.label
2	Importar	web.dataimport.lookuptable.importButton.label
2	Utilizar la primera fila	web.dataimport.lookuptable.columnheader.usefirstrow
2	Elegir un archivo	web.dataimport.lookuptable.chooseFile
2	Vista Previa	web.dataimport.lookuptable.preview
2	El número máximo de columnas es {0}	web.dataimport.lookuptable.maxColumns
2	ID Inválido	web.controller.id.invalid
2	Crear Proyecto	web.toolbox.project.create
2	Crear Formulario	web.toolbox.form.create
2	Abrir Diseñador	web.toolbox.weditor.open
2	Administración del Sistema	web.system
2	Procesos	web.home.v2.processes
2	Administrador de Procesos	web.home.v2.processesManager
2	Principal	web.processes.home
2	Crear Item de Proceso	web.processes.toolbox.newProcessItem
2	Crear Contenedor	web.processes.toolbox.newPool
2	Crear Formulario	web.processes.toolbox.newForm
2	Crear Proyecto	web.processes.toolbox.newProject
2	Crear Usuario	web.application_management.toolbox.newUser
2	Agregar Dispositivo	web.application_management.toolbox.newDevice
2	Crear Proyecto	web.application_management.toolbox.newProject
2	Crear Formulario	web.application_management.toolbox.newForm
2	Usuario inválido	mobile.login.controller.invalidlogin
2	Id inválido para el elemento de interfáz	web.multiselect.invalidId
2	Seleccionar todos	web.multiselect.selectAll
2	Deseleccionar todos	web.multiselect.unselectAll
2	Buscar...	web.multiselect.filter
2	Agregar Usuario	web.usersAndGroups.toolbox.newUser
2	Crear Grupo	web.usersAndGroups.toolbox.newGroup
2	Editar	web.grid.row.edit
2	Eliminar	web.grid.row.delete
2	Reestablecer contraseña	web.grid.users.row.resetPassword
2	Cancelar invitación	web.grid.users.row.cancelInvitation
2	Reenviar invitación	web.grid.users.row.resendInvitation
2	OK	web.dialog.buttons.ok
2	Cancelar	web.dialog.buttons.cancel
2	Si	web.dialog.buttons.yes
2	No	web.dialog.buttons.no
2	Desea eliminar el grupo {0}?	web.usersAndGroups.deleteGroup.confirm
2	Desea eliminar el usuario {0}?	web.usersAndGroups.deleteUser.confirm
2	Desea cancelar la invitación a {0} ?	web.usersAndGroups.cancelInvitation.confirm
2	Usuarios en el grupo {0}	web.usersAndGroups.users.grid.title
2	Invalid input content	web.content.invalid
2	Invalid	web.content.invalid.title
2	Usuario eliminado	admin.cruds.user.delete.ok.title
2	Error al intentar eliminar usuario	admin.cruds.user.delete.error.title
2	Desea enviar a {0} una invitación para unirse a {1} en Captura?	admin.cruds.user.presave.confirm.newUser
2	{0} ya existe en Captura, desea invitarla/o a unirse a {1}?	admin.cruds.user.presave.confirm.addUser
2	Cancelado	admin.cruds.user.save.cancelled.title
2	El usuario no ha sido guardado	admin.cruds.user.save.cancelled
2	Disculpe, ya existe una aplicación con ese nombre. Seleccione otro nombre por favor.	web.application.settings.nameInUse
2	Nombre inválido	web.application.settings.nameInUse.title
2	Ha olvidado su contraseña?	web.account.recovery.title
2	Ingrese la dirección de correo registrada en su cuenta de Captura.	web.account.recovery.message
2	Su dirección de correo	web.account.recovery.mail.placeholder
2	Continuar	web.account.recovery.mail.continue
2	correo	web.new-user.mail.label
2	Dirección de correo del Usuario	web.new-user.mail.placeholder
2	Username del Usuario	web.new-user.username.placeholder
2	Siguiente	web.new-user.mail.next
2	Captura ya tiene registrado a {0} . <br/> <i class="icon-info-sign"></i> <strong>Si continua el sistema enviará al usuario una invitación para unirse a esta aplicación. </strong>	web.new-user.alreadyExists
2	Captura ya tiene registrado a {0} . <br/> <i class="icon-info-sign"></i> <strong>Si continua el sistema unirá al usuario a esta aplicación. </strong>	web.new-user.addDirectly.alreadyExists
2	Se creará una cuenta para {0}. Por favor ingrese la información requerida.<br/><i class="icon-info-sign"></i> <strong> El usuario recibira un email de activación antes de poder ingresar</strong>	web.new-user.addNewAccount
2	Se creará una cuenta para {0}. Por favor ingrese la información requerida.<br/><i class="icon-info-sign"></i> <strong> El usuario se agregará directamente a la aplicacion</strong>	web.new-user.addDirectly.addNewAccount
2	Limpiar	web.new-user.mail.clear
2	Cancelar	web.new-user.cancel
2	<i class="icon-exclamation-sign"></i> <strong>{0} ya ha sido invitado o ya es un miembro de la aplicación</strong>	web.new-user.alreadyInApp
2	Asignar una contraseña	web.new-user.assignPassword
2	El usuario deberá definir su contraseña (Las instrucciones seran enviadas por Email)	web.new-user.userAssignsHisPassword
2	Sistema	authorizationGroup.system.label
2	Applicación	authorizationGroup.application.label
2	Proyecto	authorizationGroup.project.label
2	Formulario	authorizationGroup.form.label
2	Contenedor	authorizationGroup.pool.label
2	Acceso a la barra de herramientas	authorizationGroup.toolbox.label
2	Acceso al menu	authorizationGroup.menu.label
2	Acceso a usuarios	authorizationGroup.userAccess.label
2	Connector Repository	authorizationGroup.connector.label
2	Tabla de datos	authorizationGroup.REST.label
2	Configure la Aplicación	application.config.label
2	Permiso que permite al usuario cambiar la configuración de la aplicación	application.config.description
2	Crear Proyectos	application.project.cancreate.label
2	Permite al usuario crear proyectos	application.project.cancreate.description
2	Crear Contenedor	application.pool.cancreate.label
2	Habilita al usuario a crear un Contenedor	application.pool.cancreate.description
2	Listar Usuarios	application.user.list.label
2	Permite al usuario listar otros usuarios	application.user.list.description
2	Agregar Usuarios	application.user.cancreate.label
2	Permite la creación de otros usuarios	application.user.cancreate.description
2	Editar Usuarios	application.user.edit.label
2	Permite la edición de usuarios	application.user.edit.description
2	Elimina Usuarios	application.user.delete.label
2	Permite la eliminación de usuarios	application.user.delete.description
2	Listar Grupos	application.group.list.label
2	Permite ver grupos	application.group.list.description
2	Crear Grupos	application.group.cancreate.label
2	Premite la creación de grupos	application.group.cancreate.description
2	Editar Grupos	application.group.edit.label
2	Permite la edición de Grupos	application.group.edit.description
2	Listar Roles	application.role.list.label
2	Permite listar/visualizar roles	application.role.list.description
2	Editar Rol	application.role.edit.label
2	Permite la edición de roles	application.role.edit.description
2	Elimina Grupos	application.group.delete.label
2	Permite la eliminación de grupos	application.group.delete.description
2	Crear Roles	application.role.cancreate.label
2	Permite la creación de roles	application.role.cancreate.description
2	Administración de Roles	application.role.administration.label
2	Permite la creación, edición, borrado y configuración roles	application.role.administration.description
2	Administración de Workflow	application.workflow.administration.label
2	Permite la configuración de un workflow	application.workflow.administration.description
2	Listar Proyectos	application.project.list.label
2	Permite listar Proyectos en el Inicio	application.project.list.description
2	Listar Formularios	application.form.list.label
2	Permite listar/visualizar la lista de formularios en el Inicio	application.form.list.description
2	Listar Contenedores	application.pool.list.label
2	Permite visualizar la lista de Contenedores en el Inicio	application.pool.list.description
2	Listar Ítems de Proceso	application.processItem.list.label
2	Permite listar/visualizar la lista de Ítems de Proceso en el Inicio	application.processItem.list.description
2	Permite crear etiquetas de Ítems de Proceso	application.processItem.create.label
2	Permite editar etiquetas de Ítems de Proceso	application.processItem.edit.label
2	Crear Tabla de Datos	application.lookupTable.create.label
2	Permite la creación de Tablas de Datos	application.lookupTable.create.description
2	Editar Tablas de Datos	application.lookupTable.edit.label
2	Permite la edición de Tablas de Datos	application.lookupTable.edit.description
2	Leer Tabla de Datos	application.lookupTable.read.label
2	 Permite leer el contenido de Tablas de Datos	application.lookupTable.read.description
2	Tabla de datos	application.lookupTable.administration.label
2	Permite la creación, edición y eliminación de tabla de datos. Además concede acceso a la importación desde archivos CSV	application.lookupTable.administration.description
2	Lookup table delete	lookupTable.delete.confirmation.title
2	Desasociar dispositivo	application.diassociateDevice.label
2	Permite a los usuarios desasociar dispositivos de cualquier usuario	application.diassociateDevice.description
2	Desea eliminar la tabla de datos remotos?	lookupTable.delete.confirmation.message
2	El identificador {0} ya existe. Por favor utilice otro	lookupTable.definition.identifier.duplicate
2	El número máximo de campos o columnas para una tabla de lookup es {0}	lookupTable.definition.max_fields
2	Manejador de Proceso	application.menu.processManager.label
2	Permite el acceso al Manejador de Procesos	application.menu.processManager.description
2	Importar Datos	application.menu.dataImport.label
2	Permite el acceso a la opción de Importar Datos	application.menu.dataImport.description
2	Roles	application.menu.roles.label
2	Permite el acceso a la página de Roles	application.menu.roles.description
2	Usuarios y Grupos	application.menu.usersAndGroups.label
2	Permite el acceso a la página de Usuarios y Grupos	application.menu.usersAndGroups.description
2	Dispositivos	application.menu.devices.label
2	Permite el acceso a la página de Dispositivos Móviles	application.menu.devices.description
2	Mostrar Reportes	application.menu.showData.label
2	Permite el acceso a la página de Reportes	application.menu.showData.description
2	Configuración de la Aplicación	application.menu.config.label
2	Permite el acceso a la página de Configuración de la Aplicación	application.menu.config.description
2	Licencias	application.menu.licenses.label
2	Permite el acceso a la página de Licencias	application.menu.licenses.description
2	Tablas de Datos	application.menu.lookupTables.label
2	Permite el acceso a la página de Tablas de Datos	application.menu.lookupTables.description
2	Crear Proyecto	application.toolbox.project.new.label
2	Permite la creación de proyectos desde la Barra de Herramientas	application.toolbox.project.new.description
2	Crear Formulario	application.toolbox.form.new.label
2	Permite la creación de Formularios desde la Barra de Herramientas	application.toolbox.form.new.description
2	Crear Contenedor	application.toolbox.pool.new.label
2	Permite la creación de un Contenedor desde la barra de herramientas	application.toolbox.pool.new.description
2	Crear Item de Proceso	application.toolbox.processItem.new.label
2	Permite la creación de Items desde la Barra de Herramientas	application.toolbox.processItem.new.description
2	Agregar Usuario	application.toolbox.user.new.label
2	Permite la creación de Usuarios desde la Barra de Herramientas	application.toolbox.user.new.description
2	Crear Grupo	application.toolbox.group.new.label
2	Permite la creación de Grupos desde la Barra de Herramientas	application.toolbox.group.new.description
2	Agregar Dispositivos	application.toolbox.device.new.label
2	Permite agregar dispositivos desde la Barra de Herramientas	application.toolbox.device.new.description
2	Configurar Proyectos	project.edit.label
2	Permite cambiar el nombre y la descripción de Proyectos, agregar Formularios y asignar Roles en ese contexto a Usuarios y Grupos.	project.edit.description
2	Ver Proyecto Mobile	project.read.mobile.label
2	El proyecto podrá ser visualizado en un dispositivo móvil. Sin este permiso el proyecto no es visible en el dispositivo del usuario.	project.read.mobile.description
2	Ver Proyectos	project.read.web.label
2	Un usuario tiene permisos para ver un proyecto en la aplicación web. Sin este permiso no pueden verse estos proyectos.	project.read.web.description
2	Crear Formularios	project.create.form.label
2	El usuario puede crear Formularios	project.create.form.description
2	Eliminar Proyectos	project.delete.label
2	Permite a un usuario eliminar Proyectos	project.delete.description
2	Configurar Formularios	form.edit.label
2	Permite configurar formularios en la aplicación Web	form.edit.description
2	Ver Formularios	form.read.web.label
2	Permite ver Formularios en la aplicación Web. Sin esta autorización los formularios no serán visibles en la lista de formularios del usuario.	form.read.web.description
2	Eliminar Formularios	form.delete.label
2	Permite eliminar Formularios en la aplicación Web	form.delete.description
2	Usuario móvil	form.mobile.label
2	Otorga permisos para cargar datos desde un dispositivo móvil. Sin este permiso el usuario no puede cargar datos desde un dispositivo móvil	form.mobile.description
2	Publicar Formularios	form.publish.label
2	Permite publicar Formularios en la aplicación Web	form.publish.description
2	Diseñar Formularios	form.design.label
2	Permite diseñar formularios en la aplicación Web	form.design.description
2	Ingreso de Datos Web	form.inputData.web.label
2	Un usuario web puede ingresar datos en Formularios desde la interfáz Web	form.inputData.web.description
2	Ver Reportes	form.viewReport.label
2	Permite ver reportes en la aplicación Web	form.viewReport.description
2	Crear Reportes	form.createReport.label
2	Permite crear y guardar reportes en la aplicación Web	form.createReport.description
2	Eliminar Reportes	form.deleteReport.label
2	Permite eliminar reportes en la aplicación Web	form.deleteReport.description
2	Visualiza Contenedor	pool.read.label
2	Puede visualizar Contenedores y los Ítem de Proceso dentro del Contenedor	pool.read.description
2	Editar Contenedores	pool.edit.label
2	Habilitado a editar Contenedores y los Ítem de Proceso dentro del Contenedor	pool.edit.description
2	Elimina Pools	pool.delete.label
2	Habilitado a eliminar Contenedores y los Ítem de Proceso dentro del Contenedor	pool.delete.description
2	Configurar Proyecto	web.processes.project.tooltip.manager
2	Configurar Formulario	web.processes.form.tooltip.manager
2	Reportes	web.processes.form.tooltip.reports
2	Diseñar Formulario	web.processes.form.tooltip.editor
2	Abrir Manejador de Contenedores	web.processes.pool.tooltip.manager
2	Abrir Manejador de Ítem de Proceso	web.processes.processitem.tooltip.manager
2	Igual a	web.editor.properties.dialogs.operators.equals
2	Contiene	web.editor.properties.dialogs.operators.contains
2	Distinto a	web.editor.properties.dialogs.operators.distinct
2	Seleccione una Columna	web.editor.properties.dialogs.selectColumn
2	Seleccione una Condición	web.editor.properties.dialogs.selectOperator
2	Selecccione un Elemento	web.editor.properties.dialogs.selectElement
2	Seleccione una Tabla de Datos	web.editor.properties.dialogs.selectLookup
2	Indicar Ubicación	web.editor.form.properties.provideLocation
2	Saltos Condicionales	web.editor.properties.page.navigation.label
2	Definir saltos condicionales	web.editor.properties.page.navigation.button
2	Saltos Condicionales	web.editor.properties.dialogs.page.navigation.targets.label
2	Valor	web.editor.properties.dialogs.page.navigation.value
2	Si ninguna de las condiciones anteriores se cumple, saltar a la página	web.editor.properties.dialogs.page.navigation.default.label
2	Seleccione una página	web.editor.properties.dialogs.selectPage
2	Definir saltos condicionales para página: "{0}"	web.editor.properties.dialogs.page.navigation.title
2	Definir la página siguiente de acuerdo a valores seleccionados en elementos	web.editor.properties.dialogs.page.navigation.heading
2	Al presionar "Siguiente" en el Formulario las condiciones serán verificadas en orden y la primera que se cumpla determinará el destino del salto.	web.editor.properties.dialogs.page.navigation.explanation
2	Se han modificado los Saltos Condicionales	web.editor.properties.dialogs.page.navigation.notification.changes.title
2	Los Saltos Condicionales para la página "{0}" han sido modificados	web.editor.properties.dialogs.page.navigation.notification.changes.message
2	Sin cambios	web.editor.properties.dialogs.page.navigation.notification.noChanges.title
2	Sin cambios en la página: "{0}"	web.editor.properties.dialogs.page.navigation.notification.noChanges.message
2	Página marcada como Finaö	web.editor.properties.dialogs.page.navigation.finalPage.notPossible.title
2	Página Final, no es posible definir Saltos Condicionales	web.editor.properties.dialogs.page.navigation.finalPage.notPossible
2	Si esta página es marcada como Final, entonces todos los saltos asociados serán eliminados. Desea continuar?	web.editor.properties.dialogs.page.navigation.makefinal
2	Página con saltos condicionales	web.editor.properties.dialogs.page.navigation.makefinal.title
2	Valor por defecto de "{0}"	web.editor.properties.dialogs.defaultvalue.title
2	Definir dinámicamente el valor por defecto de este elemento dependiendo de valores seleccionados por el usuario en otros elementos	web.editor.properties.dialogs.defaultvalue.heading
2	Seleccione la Tabla de Datos y una Columna de la cual será tomado el valor por defecto	web.editor.properties.dialogs.defaultvalue.section1.explanation
2	Defina la(s) condicion(es) para seleccionar el valor por defecto	web.editor.properties.dialogs.defaultvalue.section2.explanation
2	Seleccione una Tabla de Datos primero	web.editor.properties.dialogs.dropdown.filters.selectLookupFirst
2	Seleccione de manera automática los datos disponibles en este elemento dependiendo de valores seleccionados por el usuario en otros elementos	web.editor.properties.dialogs.dropdown.filters.heading
2	Solo muestre datos que cumplen con todas las condiciones siguientes	web.editor.properties.dialogs.dropdown.filters.explanation
2	Filtro para datos disponibles en "{0}"	web.editor.properties.dialogs.dropdown.filters.title
2	Estático	web.editor.properties.defaultvalue.static
2	Tabla de Datos	web.editor.properties.defaultvalue.dynamic
2	Manejar Publicación	web.editor.properties.manage.publication
2	No es página final	web.editor.save.nofinalPage.title
2	No hay una página final (requerido). Desea convertir la página "{0}" en final?	web.editor.save.nofinalPage.message
2	El elemento tiene un valor por defecto estático, si continua este será sobreescrito. Desea continuar?	web.editor.properties.staticDefaultValueWillBeLost
2	El elemento tiene un valor por defecto dinámico, si continúna este será sobreescrito. Desea continuar?	web.editor.properties.dynamicDefaultValueWillBeLost
2	Por favor verifique los Filtros	web.editor.properties.dialogs.checkFilters
2	La propiedad mínimo valor del elemento {0} debe ser un número	services.commandService.validation.integerField.minValue.numeric
2	La propiedad máximo valor del elemento {0} debe ser un número	services.commandService.validation.integerField.maxValue.numeric
2	{0} tiene como fuente una Tabla de Datos, pero ninguna ha sido seleccionada aún	services.commandService.validation.dropdown.noLookupTable
2	{0} tiene como fuente una Tabla de Datos, pero ninguna columna ha sido seleccionada aún para la etiqueta a mostrarse	services.commandService.validation.dropdown.noLookupLabel
2	{0} tiene como fuente una Tabla de Datos, pero ninguna columna ha sido seleccionada aún para el valor asociado a almacenarse	services.commandService.validation.dropdown.noLookupValue
2	{0} no tiene datos	services.commandService.validation.dropdown.noEmbeddedData
2	Formularios no pueden ser vacíos	services.commandService.validation.form.isEmpty
2	Columna de Tabla de Datos	web.editor.properties.dialogs.dropdown.lookupColumn
2	Condición	web.editor.properties.dialogs.dropdown.condition
2	Valor de	web.editor.properties.dialogs.dropdown.valueOf
2	Columna de Tabla de Datos	web.editor.properties.dialogs.defaultvalue.lookupColumn
2	Condición	web.editor.properties.dialogs.defaultvalue.condition
2	Valor de	web.editor.properties.dialogs.defaultvalue.valueOf
2	Ìtem de Proceso	web.editor.properties.dialogs.page.navigation.element
2	Condición	web.editor.properties.dialogs.page.navigation.condition
2	Página destino	web.editor.properties.dialogs.page.navigation.targetPage
2	Archivo CSV muy grande	web.data.input.file.csvTooBig.title
2	Actualmente no soportamos archivos CSV con más de {0} líneas	web.data.input.file.csvTooBig.message
2	Mi cuenta	myAccount.title
2	Idioma por defecto	myAccount.language
2	Guardar preferencias	myAccount.changePreferences
2	Preferencias guardadas	myAccount.success.title
2	Ha cambiado su idioma por defecto. Será redirigido a la página principal para cargar los cambios	myAccount.success.languageChangedMessage
2	Preferencias guardadas	myAccount.success.message
2	Bajar configuración para el Connector Respository	myAccount.downloadCRConfiguration
2	Aplicación por defecto	myAccount.defaultApplication
2	Datos del usuario	myAccount.userData.title
2	Los datos del usuario han cambiado. Será redirigido a la página principal para recargar los cambios	myAccount.userData.success.message
2	Error en el servidor	web.data.upload.serverError
2	Excepción de interrupción	web.data.upload.interruptException
2	No hay más páginas	web.editor.properties.dialogs.noMorePages.title
2	No hay más páginas a las cuales saltar	web.editor.properties.dialogs.noMorePages.message
2	Click para activar ubicación	web.editor.enable_location
2	Click para desactivar ubicación	web.editor.disable_location
2	Por favor procesa al 	web.invitation.proceed_to
2	login	web.invitation.login
2	¡Listo!	web.password_reset.done
2	Este usuario no tiene permisos asignados. Por favor contacte con el administrador	web.noUserRights
2	Página del Administrador del Sistema	web.sysadmin.home.title
2	App Admin	web.admin.home.title
2	Crear Aplicación	web.root.home.toolbox.createApp
2	Recargar parametros	web.root.home.toolbox.reloadParameters
2	Recargar valores i18n	web.root.home.toolbox.reloadi18n
2	App Admin	web.admin.home.breadCrumb
2	Ir a aplicación	web.admin.home.enterApp
2	Ha ocurrido un error inesperado	web.generic.unknownError
2	<b>La cuenta debe ser activada.</b><br />Luego de registrarse debería haber recibido un mail con instrucciones para activar su cuenta. Puede solicitar un mail de activación nuevamente. 	web.account.recover.inactiveAccount
2	Pronto recibirá un mail en {0} con instrucciones sobre como reestablecer la contraseña	web.account.recover.mailSent
2	El usuario {0} no existe	web.account.recover.invalidUser
2	Reenviar mail de activación	web.account.recover.resendActivationMail
2	Insertar página antes	web.editor.page.contextmenu.insertPage.before
2	Insertar página después	web.editor.page.contextmenu.insertPage.after
2	No se puede borrar el formulario	admin.cruds.form.cannot.delete.published.title
2	El formulario {0} no puede ser borrado. Debe ser despublicado antes	admin.cruds.form.cannot.delete.published.message
2	ID	web.lookup.cols.id
2	Nombre	web.lookup.cols.label
2	Remoto	web.lookup.cols.isRemote
2	Identificador Remoto	web.lookup.cols.remoteIdentifier
2	Si	web.lookup.model.remote.true
2	No	web.lookup.model.remote.false
2	La tabla de datos esta en uso	web.lookup.error.inuse.title
2	Borrar la actual Tabla de datos	web.lookup.actions.delete.tooltip
2	Ver los datos de esta tabla	web.lookup.actions.view.tooltip
2	Datos de la tabla	web.home.data.lookup_table_data
2	Aplicación creada	web.root.createApp.success.title
2	La aplicación {0} fue creada	web.root.createApp.success.msg
2	Aplicación no creada	web.root.createApp.error.title
2	La Aplicación {0} no pudo ser creada	web.root.createApp.error.message
2	Opciones de Aplicación	web.root.appOptions.tooltip
2	Opciones de Aplicación	web.root.appOptions.popup
2	Workflow	web.root.appOptions.popup.workflow.label
2	Habilitar el workflow	web.root.appOptions.popup.workflow.checkbox
2	Con el workflow se puede mantener un flujo de estados por cada uno de los documentos digitalizados	web.root.appOptions.popup.workflow.description
2	Activaciones pendientes	web.root.home.toolbox.pendingRegistrations
2	Registros pendientes de activación	web.root.pendingRegistration.grid.caption
2	ID	web.root.pendingRegistration.grid.id
2	Mail	web.root.pendingRegistration.grid.mail
2	Nombre	web.root.pendingRegistration.grid.name
2	Apellido	web.root.pendingRegistration.grid.lastName
2	Hora de Registro	web.root.pendingRegistration.grid.time
2	Activar cuenta	web.root.pendingRegistration.grid.activationToken
2	Opciones	web.root.pendingRegistration.grid.options
2	Activar	web.root.pendingRegistration.accept
2	Cancelar	web.root.pendingRegistration.cancelled.title
2	Activación pendiente cancelada	web.root.pendingRegistration.cancelled.message
2	No cancelada	web.root.pendingRegistration.not_cancelled.title
2	Activación pendiente con id:{0} no fue cancelada	web.root.pendingRegistration.not_cancelled.message
2	Dueño	web.root.createApp.owner
2	Registrar usuario	web.root.home.toolbox.register
2	Su registro debe ser aprobado por un administrador del sistema	web.controller.register.awaiting_approval
2	El mail ya fue previamente registrado. El registro debe ser aprobado por un administrador del sistema	web.controller.register.awaiting_approval_again
2	El registro es solo mediante aprobación de un administrador de sistema	web.controller.register.by_approval_only
2	{0} es del tipo Fecha y no puede ser asignado como valor en una lista	web.editor.properties.dropdown.date_not_allowed_as_value
2	Licencia de aplicación	web.settings.applicationLicense
2	Id de aplicación	web.settings.applicationLicense.applicationId
2	Cantidad máxima de dispositivos por usuario	web.settings.applicationLicense.maxDevices
2	Cantidad máxima de usuarios	web.settings.applicationLicense.maxUsers
2	Dueño de la aplicación	web.settings.applicationLicense.owner
2	Válida hasta	web.settings.applicationLicense.validUntil
2	Archivo de licencia	web.settings.applicationLicense.licenseFile
2	Subir licencia	web.settings.applicationLicense.upload
2	License actualizada	web.settings.applicationLicense.licenseUpload
2	La licencia no es válida para esta aplicación	web.settings.applicationLicense.invalid
2	Sin límite	web.settings.applicationLicense.validUntil.unlimited
2	Preferencias	web.settings.preferences
2	Nombre de aplicación	web.settings.preferences.applicationName
2	Idioma predeterminado	web.settings.preferences.defaultLanguage
2	Información de la aplicación	web.settings.aplicationInfo
2	Nombre del dueño de la aplicación	web.settings.aplicationInfo.owner_name
2	Email del dueño de la aplicación	web.settings.aplicationInfo.owner_mail
2	Id de aplicacion	web.settings.aplicationInfo.appId
2	Preferencias guardadas	web.settings.preferences.saved.title
2	¿Le gustaría subir una nueva licencia?	web.settings.license.invitation
2	Los datos han sido guardados	web.settings.preferences.saved.message
2	Nombre	web.application.application.name.label
2	El servidor llegó a su máximo de {0} aplicaciones. Contacte con su agente de cuenta para adquirir una nueva licencia	web.root.max_apps.reached
2	Ya existe una aplicación con el nombre "{0}"	web.root.app.duplicate
2	Valor inválido en las reglas de navegación de la página {0} para el elemento {1}	services.commandService.validation.flow.invalidNumericValue
2	Mayor que	web.editor.properties.dialogs.operators.greater_than
2	Menor que	web.editor.properties.dialogs.operators.less_than
2	Nuevo registro	web.controller.register.notification.subject
2	Se ha registrado una nueva cuenta para el usuario {0} {1} con email {2}	web.controller.register.notification.body
2	La cuenta no pudo ser activada porque el servidor llegó a su máximo de aplicaciones	web.controller.activation.tooManyApplications
2	El problema será reportado al administrador. Lo contactaremos en cuanto hayamos solucionado el inconveniente	web.controller.activation.tooManyApplications.hint
2	Registro fallido - demasiadas aplicaciones	web.controller.register.notification.fail.tooMayApplications.title
2	El usuario {0} {1} ({2}) intentó crear una aplicación pero se alcanzó el límite de aplicaciones en el servidor<br/><br/>Por favor contacte a mf@mf.com para poder crear más aplicaciones<br/><br/>Saludos,<br/><br/>El equipo de Captura	web.controller.register.notification.fail.tooMayApplications.subject
2	El ususario no puede ser eliminado	admin.cruds.user.owner_cant_deleted.title
2	{0} es el dueño de la aplicación y no puede ser eliminado de la misma	admin.cruds.user.owner_cant_deleted.message
2	El estado de activación fue cambiado exitosamente	web.application.state.message
2	Activación cambiada	web.application.state.title
2	Propiedades de la licencia del Server	web.root.home.toolbox.serverInfoPopup
2	Server Info	web.root.home.toolbox.serverInfo
2	Identificador del Servidor	web.root.license.serverId
2	Fecha de Creación	web.root.license.creationDate
2	Días de validez	web.root.license.validDays
2	Fecha de expiración	web.root.license.expirationDate
2	Número máximo de aplicaciones permitidas	web.root.license.maxApplications
2	Aplicaciones en uso	web.root.license.applicationsInUse
2	Aplicaciones disponibles	web.root.license.applicationsRemaining
2	Días válidos para aplicación por defecto	web.root.license.application.validDays
2	Máxima cantidad de dispositivos para aplicación por defecto	web.root.license.application.maxDevices
2	Máxima cantidad de usuarios para aplicación por defecto	web.root.license.application.maxUsers
2	Otras propiedades	web.root.license.otherProperties
2	Remover dispositivo	web.home.admin.devices.removeDevice
2	Rechazar dispositivo	web.home.admin.devices.blacklistDevice
2	Lista de dispositivos rechazados	web.devices.blacklist.caption
2	Eliminar de la lista	web.devices.removeFromBlackList
2	Rechazar dispositivo?	admin.cruds.user.blacklist.warning.title
2	El dispositivo será removido y agregado a una lista negra	admin.cruds.user.blacklist.warning.msg
2	Dispositivos de {0} {0}	web.home.admin.devices.devicePopup.title
2	El dipositivo fue agregado a la lista negra	web.home.admin.devices.addToBlacklist.success.msg
2	Agregado	web.home.admin.devices.addToBlacklist.success.title
2	El dispositivo no pudo ser agregado a la lista negra	web.home.admin.devices.addToBlacklist.fail.msg
2	Error	web.home.admin.devices.addToBlacklist.fail.title
2	Removido	web.home.admin.devices.removeFromBlacklist.success.title
2	El dispositivo fue removido de la lista negra	web.home.admin.devices.removeFromBlacklist.success.msg
2	Error	web.home.admin.devices.removeFromBlacklist.fail.title
2	El dispositivo no pudo ser removido de la lista negra	web.home.admin.devices.removeFromBlacklist.fail.msg
2	Lo sentimos, ocurrió un error interno del servidor	web.api.exception.standardMessage
2	Lo sentimos, su dispositivo fue agregado a la lista negra	web.api.authentication.verification.blacklisted
2	Usuario inválido	web.api.authentication.invalidUser
2	La contraseña es nula	web.api.authentication.passwordIsNull
2	Usuario es nulo	web.api.authentication.userIsNull
2	Lo sentimos, existe un problema con la licencia del servidor. Por favor contacte con el administrador	web.api.authentication.licenseException
2	Lo sentimos, no está como miembro de la aplicación	web.api.authorization.notMember
2	Lo sentimos, su dispositivo no parece haber sido validado. Por favor intente iniciar sesión de nuevo	web.api.authorization.deviceNotAssociated
2	Lo sentimos, la aplicación no está activa	web.api.authorization.inactiveApplication
2	Lo sentimos, la licencia de la aplicación ha expirado	web.api.authorization.licenseExpired
2	Lo sentimos, la aplicación es inválida	web.api.authorization.invalidApplication
2	Lo sentimos, ocurrió un error en el servidor al guardar el documento	web.api.documents.upload.IOExceptionInFile
2	Crear tabla de datos	application.rest.lookupTables.create.label
2	Permite al cliente la creación de tabla de datos	application.rest.lookupTables.create.description
2	Listar tabla de datos	application.rest.lookupTables.list.label
2	Permite al cliente obtener la lista de tabla de datos	application.rest.lookupTables.list.description
2	Insertar datos	application.rest.lookupTables.insert.label
2	Permite al cliente insertar datos en la tabla de datos	application.rest.lookupTables.insert.description
2	Modificar datos	application.rest.lookupTables.modify.label
2	Permite al cliente modificar los datos de la tabla de datos	application.rest.lookupTables.modify.description
2	Leer datos	application.rest.lookupTables.read.label
2	Permite al cliente leer datos de una tabla de datos	application.rest.lookupTables.read.description
2	Acceso restringido. No cuenta con la autorización requerida	web.api.noauth
2	Estadísticas de uso	web.admin.home.usage_statistics
2	Uso de datos	web.root.home.toolbox.dataUsage
2	Documentos fallidos	web.root.home.toolbox.failedDocuments
2	<b>Descripción del documento:</b><br /><br />{0}<br /><br /><b>Descripción del error:</b><br /><br />{1}	services.mail.failed_document.body
2	Documento fallido en Captura. {0}	services.mail.failed_document.subject
2	Notificaciones deshabilitadas	web.admin.failed_document.notification_disabled
2	Notificaciones habilitadas a {0}	web.admin.failed_document.notification_enabled
2	Exc No	admin.views.uncaughtException.cols.id
2	Tipo de Excepción	admin.views.uncaughtException.cols.exceptionType
2	Clase Ofendida	admin.views.uncaughtException.cols.offendingClass
2	User ID	admin.views.uncaughtException.cols.userId
2	Hora de inserción	admin.views.uncaughtException.cols.inserTime
2	Stack Trace	admin.views.uncaughtException.cols.stackTrace
2	Url	admin.views.uncaughtException.cols.url
2	User Agent	admin.views.uncaughtException.cols.userAgent
2	sin Stack Trace	admin.views.uncaughtException.msg.noStackTrace
2	Nombre de archivo para fotos	web.home.querys.section.elementsFileNames
2	Elija el nombre de archivo para cada foto a ser descargada con la opción 'ZIP con Fotos'. Use [nombreElemento] en lugares donde debe ir el valor de un elemento	web.home.querys.section.elementsFileNames.help
2	Formato ZIP con archivo Excel y las fotos	web.home.reports.xlswithphotos.tooltip
2	Ingrese [ seguido del nombre del elemento	web.home.querys.section.elementsFileNames.inputHelp
2	Descargar	web.generic.download
2	Guardado en Móvil	web.home.reports.column.meta.savedAt
2	Estado	web.home.reports.column.meta.state
2	Ayuda	web.generic.help
2	Privacidad	web.generic.privacy
2	Grilla	web.generic.grid
2	Seleccione una fila (doble click) en la pestaña "Grilla"	web.home.reports.formView.emptyMsg
2	Mostrando documento	web.home.reports.formView.showingDoc
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: i18n; Owner: postgres
--

COPY i18n.languages (id, active, created, deleted, modified, iso_language, name) FROM stdin;
1	t	2021-03-20 14:51:29.113523+00	f	2021-03-20 14:51:29.113523+00	en	English US
2	t	2021-03-20 14:51:29.113523+00	f	2021-03-20 14:51:29.113523+00	es	Spanish
\.


--
-- Data for Name: logins; Type: TABLE DATA; Schema: log; Owner: postgres
--

COPY log.logins (id, login_at, user_id, application_id, login_type_value) FROM stdin;
1	2021-03-20 15:56:15.377391+00	1	-1	WEB
2	2023-12-09 18:18:52.202699+00	1	-1	WEB
3	2023-12-09 18:24:54.788152+00	2	1	WEB
4	2023-12-09 18:28:28.65008+00	3	1	DEVICE
5	2023-12-09 18:32:07.924841+00	3	1	DEVICE
6	2023-12-09 18:36:47.919787+00	3	1	DEVICE
7	2023-12-09 18:42:08.024752+00	3	1	DEVICE
8	2023-12-09 18:45:57.822697+00	3	1	DEVICE
9	2023-12-09 18:46:11.677098+00	3	1	DEVICE
10	2023-12-09 18:47:04.262169+00	2	1	DEVICE
11	2023-12-09 18:54:59.787697+00	3	1	DEVICE
12	2023-12-09 18:55:14.136262+00	2	1	WEB
13	2023-12-09 19:00:28.914881+00	3	1	DEVICE
14	2023-12-09 19:44:14.412753+00	3	1	DEVICE
15	2023-12-09 19:44:21.942427+00	3	1	DEVICE
16	2023-12-09 19:44:41.275662+00	2	1	DEVICE
17	2023-12-09 19:53:02.58318+00	1	-1	WEB
18	2023-12-09 20:07:42.064133+00	2	1	WEB
19	2023-12-09 20:13:24.372268+00	5	1	DEVICE
20	2023-12-09 20:20:06.337751+00	3	1	DEVICE
21	2024-02-01 23:59:44.380814+00	1	-1	WEB
22	2024-02-02 00:13:31.776008+00	3	1	DEVICE
23	2024-02-02 00:15:47.368223+00	1	-1	WEB
24	2024-02-02 00:16:25.07198+00	1	-1	WEB
25	2024-02-02 00:17:37.602915+00	1	-1	WEB
26	2024-02-02 00:18:58.524729+00	3	1	DEVICE
27	2024-02-03 13:39:54.834883+00	1	-1	WEB
28	2024-02-03 13:40:18.834717+00	1	-1	WEB
29	2024-02-03 13:43:10.397654+00	1	-1	WEB
30	2024-02-03 13:47:21.442402+00	1	-1	WEB
\.


--
-- Data for Name: uncaught_exceptions; Type: TABLE DATA; Schema: log; Owner: postgres
--

COPY log.uncaught_exceptions (id, exception_type, insert_time, offending_class, url, user_agent, user_id, stack_trace) FROM stdin;
1	py.com.sodep.mobileforms.impl.services.data.MFDataAccessException	2024-02-02 00:15:34.031818+00	org.springframework.web.method.HandlerMethod	http://localhost:8080/mf/editor/publish.ajax	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:122.0) Gecko/20100101 Firefox/122.0	1	Couldn't find the dataSet 6574b29283fe85d45c919571\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-incrementDDLVersion(Line 163)\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-storeDDL(Line 104)\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-addDefinition(Line 186)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy69-addDefinition(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormService-defineDataSet(Line 98)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.transaction.interceptor.TransactionInterceptor$1-proceedWithInvocation(Line 99)\norg.springframework.transaction.interceptor.TransactionAspectSupport-invokeWithinTransaction(Line 283)\norg.springframework.transaction.interceptor.TransactionInterceptor-invoke(Line 96)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy70-defineDataSet(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 162)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 224)\nsun.reflect.NativeMethodAcc
2	py.com.sodep.mobileforms.impl.services.data.MFDataAccessException	2024-02-02 00:15:52.758728+00	org.springframework.web.method.HandlerMethod	http://localhost:8080/mf/editor/publish.ajax	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:122.0) Gecko/20100101 Firefox/122.0	1	Couldn't find the dataSet 6574b29283fe85d45c919571\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-incrementDDLVersion(Line 163)\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-storeDDL(Line 104)\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-addDefinition(Line 186)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy69-addDefinition(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormService-defineDataSet(Line 98)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.transaction.interceptor.TransactionInterceptor$1-proceedWithInvocation(Line 99)\norg.springframework.transaction.interceptor.TransactionAspectSupport-invokeWithinTransaction(Line 283)\norg.springframework.transaction.interceptor.TransactionInterceptor-invoke(Line 96)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy70-defineDataSet(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 162)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 224)\nsun.reflect.NativeMethodAcc
3	py.com.sodep.mobileforms.impl.services.data.MFDataAccessException	2024-02-02 00:16:44.659945+00	org.springframework.web.method.HandlerMethod	http://localhost:8080/mf/editor/publish.ajax	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:122.0) Gecko/20100101 Firefox/122.0	1	Couldn't find the dataSet 6574b29283fe85d45c919571\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-incrementDDLVersion(Line 163)\npy.com.sodep.mobileforms.impl.services.data.DataDefinitionService-storeDDL(Line 104)\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-addDefinition(Line 186)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy69-addDefinition(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormService-defineDataSet(Line 98)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.transaction.interceptor.TransactionInterceptor$1-proceedWithInvocation(Line 99)\norg.springframework.transaction.interceptor.TransactionAspectSupport-invokeWithinTransaction(Line 283)\norg.springframework.transaction.interceptor.TransactionInterceptor-invoke(Line 96)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy70-defineDataSet(Line -1)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 162)\npy.com.sodep.mobileforms.impl.services.metadata.forms.FormModificationService-publish(Line 224)\nsun.reflect.NativeMethodAcc
4	py.com.sodep.mobileforms.impl.services.data.MFDataAccessException	2024-02-03 13:40:05.610302+00	org.springframework.web.method.HandlerMethod	http://localhost:8080/mf/reports/read.ajax	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:122.0) Gecko/20100101 Firefox/122.0	1	Didn't find the dataset 65bc34fb847ec2f1a3ebfca3 , version = 0\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-getDataSetDefinition(Line 195)\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-listData(Line 840)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy69-listData(Line -1)\npy.com.sodep.mobileforms.impl.services.data.FormDataAccessService-getFormData(Line 180)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy83-getFormData(Line -1)\npy.com.sodep.mobileforms.web.controllers.report.ReportController-read(Line 228)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.web.method.support.InvocableHandlerMethod-doInvoke(Line 205)\norg.springframework.web.method.support.InvocableHandlerMethod-invokeForRequest(Line 133)\norg.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod-invokeAndHandle(Line 97)\norg.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter-invokeHandlerMethod(Line 854)\norg.spr
\.


--
-- Data for Name: queue; Type: TABLE DATA; Schema: mail; Owner: postgres
--

COPY mail.queue (id, body, mail_from, inserted, sent, subject, mail_to, html, attempts) FROM stdin;
1	Hello Ale Feltes,<br /><br />admin admin (admin@testappmf.sodep.com.py) would like you to join Captura's Application TestAppMF.<br /><br />If you wish to accept the invitation, follow this link <a href="http://dev.sodep.com.py/fs-web/api/public/invitation/accept/ale@feltesq.com/GgeDox5Yyz8ZdfeU4Bre2I43Wl37NWWs">http://dev.sodep.com.py/fs-web/api/public/invitation/accept/ale@feltesq.com/GgeDox5Yyz8ZdfeU4Bre2I43Wl37NWWs</a><br /><br /><br />The Captura team	noreply@captura-forms.com	2023-12-09 20:08:37.442591+00	f	Join TestAppMF at Captura	ale@feltesq.com	t	2
2	<b>Upload description:</b><br /><br />id: 3<br />applicationId: 1<br />userId: 3<br />createdAt: 2024/02/01 21:14:48<br />applicationName: TestAppMF<br /><br /><b>Error description:</b><br /><br />Didn't find the dataset 6574b29283fe85d45c919571 , version = 0<br />py.com.sodep.mobileforms.impl.services.data.DataAccessService-getDataSetDefinition(Line 195)<br />py.com.sodep.mobileforms.impl.services.data.DataAccessService-listData(Line 819)<br />sun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)<br />sun.reflect.NativeMethodAccessorImpl-invoke(Line 62)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)<br />org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)<br />py.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)<br />sun.reflect.GeneratedMethodAccessor91-invoke(Line -1)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)<br />org.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)<br />py.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)<br />sun.reflect.GeneratedMethodAccessor90-invoke(Line -1)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)<br />org.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)<br />com.sun.proxy.$Proxy69-listData(Line -1)<br />py.com.sodep.mobileforms.impl.services.data.FormDataAccessService-getFormData(Line 205)<br />sun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)<br />sun.reflect.NativeMethodAccessorImpl-invoke(Line 62)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)<br />org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)<br />py.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)<br />sun.reflect.GeneratedMethodAccessor91-invoke(Line -1)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)<br />org.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)<br />py.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)<br />sun.reflect.GeneratedMethodAccessor90-invoke(Line -1)<br />sun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)<br />java.lang.reflect.Method-invoke(Line 498)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)<br />org.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)<br />org.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)<br />org.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)<br />org.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)<br />com.sun.proxy.$Proxy83-getFormData(Line -1)<br />py.com.sodep.mobileforms.impl.services.workers.DocumentProcessorWorker-doesNotExist(Line 303)<br />py.com.sodep.mobileforms.impl.services.workers.DocumentProcessorWorker-doWork(Line 175)<br />py.com.sodep.mobileforms.impl.services.workers.BackgroundWorker-run(Line 20)<br />java.util.concurrent.ThreadPoolExecutor-runWorker(Line 1149)<br />java.util.concurrent.ThreadPoolExecutor$Worker-run(Line 624)<br />java.lang.Thread-run(Line 748)<br /><br /> CAUSE: 	noreply@captura-forms.com	2024-02-02 00:14:49.16163+00	f	Document Failed in Captura. id: 3, applicationId: 1	soporte@captura-forms.com	t	2
\.


--
-- Data for Name: connectors; Type: TABLE DATA; Schema: mf_data; Owner: postgres
--

COPY mf_data.connectors (id, application_id, name, connector_type, direction, user_id) FROM stdin;
\.


--
-- Data for Name: lookuptables; Type: TABLE DATA; Schema: mf_data; Owner: postgres
--

COPY mf_data.lookuptables (id, active, created, deleted, modified, project_id, dataset_definition, next_version, previous_version, default_language, dataset_version, option_source, application_id, owner_id, last_ddl_ip, is_rest, identifier, name) FROM stdin;
\.


--
-- Data for Name: uploads; Type: TABLE DATA; Schema: mf_data; Owner: postgres
--

COPY mf_data.uploads (id, user_id, device_id, size, received, status, random_str, created_at, modified_at, error_desc, document_id, completed_at, saved_at, bypass_uniqueness_check, application_id) FROM stdin;
1	2	682620578eda4b04	321182	\N	SAVED	YD1e6cyy	2023-12-09 18:51:30.377489+00	2023-12-09 18:51:30.568+00	\N	1-1702158687000	2023-12-09 18:51:30.457+00	2023-12-09 18:51:30.567+00	f	1
2	3	682620578eda4b04	320907	\N	SAVED	HQ3x3Lmi	2023-12-09 20:22:40.077422+00	2023-12-09 20:22:40.278+00	\N	1-1702164157000	2023-12-09 20:22:40.177+00	2023-12-09 20:22:40.277+00	f	1
3	3	2d9b433f085992f7	320185	\N	FAIL	J3hYXzSy	2024-02-02 00:14:48.420279+00	2024-02-02 00:14:49.152+00	Didn't find the dataset 6574b29283fe85d45c919571 , version = 0\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-getDataSetDefinition(Line 195)\npy.com.sodep.mobileforms.impl.services.data.DataAccessService-listData(Line 819)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy69-listData(Line -1)\npy.com.sodep.mobileforms.impl.services.data.FormDataAccessService-getFormData(Line 205)\nsun.reflect.NativeMethodAccessorImpl-invoke0(Line -2)\nsun.reflect.NativeMethodAccessorImpl-invoke(Line 62)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.support.AopUtils-invokeJoinpointUsingReflection(Line 333)\norg.springframework.aop.framework.ReflectiveMethodInvocation-invokeJoinpoint(Line 190)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 157)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.ElapsedTimeAspect-authorizationWrapper(Line 39)\nsun.reflect.GeneratedMethodAccessor91-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint-proceed(Line 84)\npy.com.sodep.mobileforms.impl.authorization.AuthorizationAspect-authorizationWrapper(Line 334)\nsun.reflect.GeneratedMethodAccessor90-invoke(Line -1)\nsun.reflect.DelegatingMethodAccessorImpl-invoke(Line 43)\njava.lang.reflect.Method-invoke(Line 498)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethodWithGivenArgs(Line 627)\norg.springframework.aop.aspectj.AbstractAspectJAdvice-invokeAdviceMethod(Line 616)\norg.springframework.aop.aspectj.AspectJAroundAdvice-invoke(Line 70)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.interceptor.ExposeInvocationInterceptor-invoke(Line 92)\norg.springframework.aop.framework.ReflectiveMethodInvocation-proceed(Line 179)\norg.springframework.aop.framework.JdkDynamicAopProxy-invoke(Line 213)\ncom.sun.proxy.$Proxy83-getFormData(Line -1)\npy.com.sodep.mobileforms.impl.services.workers.DocumentProcessorWorker-doesNotExist(Line 303)\npy.com.sodep.mobileforms.impl.services.workers.DocumentProcessorWorker-doWork(Line 175)\npy.com.sodep.mobileforms.impl.services.workers.BackgroundWorker-run(Line 20)\njava.util.concurrent.ThreadPoolExecutor-runWorker(Line 1149)\njava.util.concurrent.ThreadPoolExecutor$Worker-run(Line 624)\njava.lang.Thread-run(Line 748)\n\n CAUSE: 	1-1706843686000	2024-02-02 00:14:49.105+00	\N	f	1
4	3	2d9b433f085992f7	320496	\N	SAVED	1sfycxe8	2024-02-02 00:24:43.232656+00	2024-02-02 00:24:43.793+00	\N	2-1706844281000	2024-02-02 00:24:43.335+00	2024-02-02 00:24:43.791+00	f	1
\.


--
-- Data for Name: pools; Type: TABLE DATA; Schema: pools; Owner: postgres
--

COPY pools.pools (id, active, created, deleted, modified, description, name, application_id, owner_id) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: projects; Owner: postgres
--

COPY projects.projects (id, active, created, deleted, modified, defaultlanguage, application_id, owner_id, lock_version) FROM stdin;
1	t	2023-12-09 18:30:26.105838+00	t	2024-02-02 00:18:00.158+00	en	1	2	2
2	t	2024-02-02 00:18:12.111904+00	t	2024-02-03 13:41:10.864+00	en	1	1	2
3	t	2024-02-03 13:41:15.752172+00	f	2024-02-03 13:41:28.122+00	en	1	1	1
\.


--
-- Data for Name: projects_details; Type: TABLE DATA; Schema: projects; Owner: postgres
--

COPY projects.projects_details (id, active, created, deleted, modified, description, label, language, project_id) FROM stdin;
1	t	2023-12-09 18:30:26.105838+00	f	\N	Todo lo que tenga que ver con calles, señalización, etc.	Denuncias viales	en	1
2	t	2024-02-02 00:18:12.111904+00	f	\N	Viales	Denuncias viales	en	2
3	t	2024-02-03 13:41:15.752172+00	f	\N	1	test	en	3
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
1334075590730-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.176678+00	1	EXECUTED	3:f6e75c00789ec51dfffd82b32518e843	Custom SQL		\N	2.0.3
1334075590730-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.190531+00	2	EXECUTED	3:72c5a87f64a49c0913c813057859ab17	Create Table		\N	2.0.3
1334075590730-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.199527+00	3	EXECUTED	3:5c38342f64354e2a02530048eb44b930	Create Table		\N	2.0.3
1334075590730-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.214955+00	4	EXECUTED	3:87a0558f3ab8f559a4b5956094cbc0f9	Create Table		\N	2.0.3
1334075590730-4	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.227204+00	5	EXECUTED	3:e096580482e3aaeadbe05f47948087e9	Create Table		\N	2.0.3
1334075590730-5	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.238624+00	6	EXECUTED	3:7f31ee03c0f1a3ddb7f842239fcea2fb	Create Table		\N	2.0.3
1334075590730-6	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.245624+00	7	EXECUTED	3:3c2b2fe2c53202db20afbdb8a0da1ed0	Create Table		\N	2.0.3
1334075590730-7	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.25011+00	8	EXECUTED	3:05f0a2f038c155e689db3dca22cf953e	Create Table		\N	2.0.3
1334075590730-8	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.261352+00	9	EXECUTED	3:eda31379e369007a872d56ae2371d1db	Create Table		\N	2.0.3
1334075590730-9	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.271573+00	10	EXECUTED	3:4e3276d258ba36899b7326138ca53a62	Add Unique Constraint		\N	2.0.3
1334075590730-10	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.279916+00	11	EXECUTED	3:7e9946905485bec2c3a1b2ba7e565549	Add Unique Constraint		\N	2.0.3
1334075590730-11	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.28697+00	12	EXECUTED	3:d32a95b35bd0e08bc8c9cfaa7992cc29	Add Unique Constraint		\N	2.0.3
1334075590730-12	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.294259+00	13	EXECUTED	3:e90ade4f61dd0602d2f4d78aac5f85af	Add Foreign Key Constraint		\N	2.0.3
1334075590730-13	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.300908+00	14	EXECUTED	3:1558472c3c59063d7b02a52c5602b01b	Add Foreign Key Constraint		\N	2.0.3
1334075590730-14	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.308869+00	15	EXECUTED	3:204dafe0a73f32efa717d82b5e447280	Add Foreign Key Constraint		\N	2.0.3
1334075590730-15	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.315845+00	16	EXECUTED	3:983fa0828e4ea79db27de32c1bcee591	Add Foreign Key Constraint		\N	2.0.3
1334075590730-16	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.322082+00	17	EXECUTED	3:d15fc529d4e7ca01a40da9b1acf37bc2	Add Foreign Key Constraint		\N	2.0.3
1334075590730-17	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.328044+00	18	EXECUTED	3:bcdda31fcf05655e74fdb8fdcc7297b8	Add Foreign Key Constraint		\N	2.0.3
1334075590730-18	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.33444+00	19	EXECUTED	3:2355e0dbfdba2c5f4b60941e7b9ac423	Add Foreign Key Constraint		\N	2.0.3
1334075590730-19	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.34108+00	20	EXECUTED	3:6965063584caf72f3289906a50e45ae5	Add Foreign Key Constraint		\N	2.0.3
1334075590730-20	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.345738+00	21	EXECUTED	3:dbc6e04ed82ab3c384d09227ab3850af	Add Foreign Key Constraint		\N	2.0.3
1334075590730-21	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.350097+00	22	EXECUTED	3:cf4c9b397723e5d6b8484abc828ecbf0	Create Sequence		\N	2.0.3
1334075590730-22	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.355245+00	23	EXECUTED	3:a6290c450c57feb72e4331ec2e04ad6b	Create Sequence		\N	2.0.3
1334075590730-23	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.361382+00	24	EXECUTED	3:f86dd5794755cc0d560e26c6f29cd424	Create Sequence		\N	2.0.3
1334075605413-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.366204+00	25	EXECUTED	3:6d23b3eae534e93698ab67e7c7c44286	Custom SQL		\N	2.0.3
1334075605413-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.373662+00	26	EXECUTED	3:76ba020a878c8eece4d70327c06b86e5	Create Table		\N	2.0.3
1334075605413-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.387351+00	27	EXECUTED	3:e558284da54f19fd2d02c5aad82ac535	Create Table		\N	2.0.3
1334075605413-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.394626+00	28	EXECUTED	3:99cde1d3143de280fd4e2d31bb114af0	Add Primary Key		\N	2.0.3
1334075595300-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.398964+00	29	EXECUTED	3:c3c55413592deb8a642266cca75d286b	Custom SQL		\N	2.0.3
1334075595300-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.408129+00	30	EXECUTED	3:f9c0438db1b058038f3791a997adb1dd	Create Table		\N	2.0.3
1334075595300-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.419718+00	31	EXECUTED	3:533cbd9b6dacd2aaf2758db5e39895d2	Create Table		\N	2.0.3
1334075595300-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.426013+00	32	EXECUTED	3:9ab53fe07d9e6c862a8e0bf3d441a578	Add Primary Key		\N	2.0.3
1334075595300-4	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.433024+00	33	EXECUTED	3:057ab06082ffef5541bdf3dd9bce5422	Add Unique Constraint		\N	2.0.3
1334075595300-5	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.439444+00	34	EXECUTED	3:b6b300898909d95f6210828e2ed4092a	Add Foreign Key Constraint		\N	2.0.3
1334075595300-6	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.445183+00	35	EXECUTED	3:2f1dba166eaa34a6c688763a2e87d92f	Create Sequence		\N	2.0.3
1334075596891-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.450477+00	36	EXECUTED	3:dbb944064818d8c07974a7bf75fea00d	Custom SQL		\N	2.0.3
1334075596891-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.467586+00	37	EXECUTED	3:e600632d704ac76756a8971287b8f2e1	Create Table		\N	2.0.3
1334075596891-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.473064+00	38	EXECUTED	3:907eebd58ac856a399e07830128395e5	Create Sequence		\N	2.0.3
1334075598475-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.477508+00	39	EXECUTED	3:1affc05e974e2e5cd5488665246711b4	Custom SQL		\N	2.0.3
1334075598475-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.487358+00	40	EXECUTED	3:2385526ecd10002e25cc6972b0ee4661	Create Table		\N	2.0.3
1334075598475-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.492876+00	41	EXECUTED	3:f3e8fdf1f1a7f260bf4116fbf50f184b	Create Sequence		\N	2.0.3
1334075603514-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.497388+00	42	EXECUTED	3:a7709e8e66db8b13e7decc6d38b13838	Custom SQL		\N	2.0.3
1334075603514-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.507973+00	43	EXECUTED	3:a10083d9dd65b90a42a1b2526c9fdd7d	Create Table		\N	2.0.3
1334075603514-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.515099+00	44	EXECUTED	3:b16d6ae0b2db1c223b46462d54ee781c	Add Foreign Key Constraint		\N	2.0.3
1334075603514-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.520756+00	45	EXECUTED	3:692302730058e8681db1cc07d26b4140	Create Sequence		\N	2.0.3
1334088907142-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.525746+00	46	EXECUTED	3:c6c31a612c5ee7e32ff4b9ce3adbbdab	Custom SQL		\N	2.0.3
1334088907142-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.531133+00	47	EXECUTED	3:8c76872efcb9b8666bf77aaf2165f5f8	Create Table		\N	2.0.3
1334088907142-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.544146+00	48	EXECUTED	3:99f01a360e4afebab7625f89ed444ec7	Create Table		\N	2.0.3
1334088907142-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.55081+00	49	EXECUTED	3:295e990a856802a21ac3057041a1383c	Add Foreign Key Constraint		\N	2.0.3
1334088907142-4	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.555945+00	50	EXECUTED	3:d74683abe0afd25a9a5b93abc9682670	Add Foreign Key Constraint		\N	2.0.3
1334088907142-5	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.560683+00	51	EXECUTED	3:54406927c5fce484d130b111bc6bd584	Add Foreign Key Constraint		\N	2.0.3
1334088907142-6	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.565282+00	52	EXECUTED	3:2d784da34c024bfdc2b176f1f22b34b0	Create Sequence		\N	2.0.3
1334075600319-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.569208+00	53	EXECUTED	3:90ccd1ecc88a644ab29cd5c8eeb647d8	Custom SQL		\N	2.0.3
1334075600319-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.577543+00	54	EXECUTED	3:e81c6df14b4f1657f996fc74e5fbbed3	Create Table		\N	2.0.3
1334075600319-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.584077+00	55	EXECUTED	3:90ac569d1bbdc0165760f6a498a32878	Create Table		\N	2.0.3
1334075600319-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.593926+00	56	EXECUTED	3:a3adbe73cf4822fa302527b2676ba1bf	Create Table		\N	2.0.3
1334075600319-4	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.599495+00	57	EXECUTED	3:959785b8ca930ab49bff5138d69fe653	Add Primary Key		\N	2.0.3
1334075600319-5	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.6048+00	58	EXECUTED	3:cae3c29f21a2e23a3a501e3109f38faa	Add Unique Constraint		\N	2.0.3
1334075600319-6	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.610542+00	59	EXECUTED	3:82763ba83a8f4ffd253623626aceca8a	Add Foreign Key Constraint		\N	2.0.3
1334075600319-7	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.617339+00	60	EXECUTED	3:60ae732e262886efc6b37c3acd51fab9	Add Foreign Key Constraint		\N	2.0.3
1334075600319-8	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.622144+00	61	EXECUTED	3:326c4ce6cebd0e0512c3ee60605db55e	Add Foreign Key Constraint		\N	2.0.3
1334075600319-9	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.626668+00	62	EXECUTED	3:8e31758115f437ebc56994b6e3ff0fd0	Add Foreign Key Constraint		\N	2.0.3
1334075600319-10	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.631484+00	63	EXECUTED	3:a59bf39e08222f9aee94dc66a814d978	Add Foreign Key Constraint		\N	2.0.3
1334075600319-11	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.635692+00	64	EXECUTED	3:0d467e861eca8840788c7f9482815103	Add Foreign Key Constraint		\N	2.0.3
1334075600319-12	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.639569+00	65	EXECUTED	3:8e23d5019d37703f015f98cd5e36c7b9	Create Sequence		\N	2.0.3
1334075600319-13	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.6438+00	66	EXECUTED	3:5c5325b3bbf1acab31d09e106af49a8b	Create Sequence		\N	2.0.3
1334075593508-0	danicricco	database/db-changelog-init.xml	2021-03-20 14:51:28.648066+00	67	EXECUTED	3:5ac6075fabb4a88e06e8d771c4386dea	Custom SQL		\N	2.0.3
1334075593508-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.656123+00	68	EXECUTED	3:d51834bdde5e9d0bde5564e4dea33bf3	Create Table		\N	2.0.3
1334075593508-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.664916+00	69	EXECUTED	3:4fe7904a46acf15c7266eabacd337aff	Create Table		\N	2.0.3
1334075593508-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.672623+00	70	EXECUTED	3:dfb12bea1b6d191badae2ea39c911586	Create Table		\N	2.0.3
1334075593508-4	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.680969+00	71	EXECUTED	3:3464d56dd5bd217aa5c2a6e8b69ac74e	Create Table		\N	2.0.3
1334075593508-5	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.687852+00	72	EXECUTED	3:cc43e80efd6d7d08909299a5e7e6b072	Create Table		\N	2.0.3
1334075593508-6	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.694479+00	73	EXECUTED	3:7e3c785bd247c43f48df625e26f29fe2	Create Table		\N	2.0.3
1334075593508-7	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.700723+00	74	EXECUTED	3:85e1502a2054f5f6719bd0ad5ef72587	Create Table		\N	2.0.3
1334075593508-8	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.71067+00	75	EXECUTED	3:96cd3e8fde79809abc83412870fa226c	Create Table		\N	2.0.3
1334075593508-9	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.717942+00	76	EXECUTED	3:237e77fded5279d2033e61d3291e0145	Create Table		\N	2.0.3
1334075593508-10	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.725951+00	77	EXECUTED	3:14cff8f2444bdf77cea6e6a238e991b3	Create Table		\N	2.0.3
1334075593508-11	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.735694+00	78	EXECUTED	3:13e5dc439de9d85aa2989b7cb62ae974	Create Table		\N	2.0.3
1334075593508-12	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.747654+00	79	EXECUTED	3:3c1c1d08904aa3238d044a15b2a14e40	Create Table		\N	2.0.3
1334075593508-13	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.75568+00	80	EXECUTED	3:c5ab9444ef4d1a979433367fb16ae724	Create Table		\N	2.0.3
1334075593508-14	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.763237+00	81	EXECUTED	3:bc35f4ebb883e9f9b146447101155fe6	Create Table		\N	2.0.3
1334075593508-15	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.774174+00	82	EXECUTED	3:032999e4ebeb3d545094ee8112a23454	Create Table		\N	2.0.3
1334075593508-16	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.780539+00	83	EXECUTED	3:9fa47531693c8cf5dd6a5ff969ec8031	Create Table		\N	2.0.3
1334075593508-17	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.787679+00	84	EXECUTED	3:e3ae89e9caebbc9a5aa35e9acfb6f659	Create Table		\N	2.0.3
1334075593508-18	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.792111+00	85	EXECUTED	3:743855f0ed9883e726a7af913884d4f8	Create Table		\N	2.0.3
1334075593508-19	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.800127+00	86	EXECUTED	3:2e56e0a75eb7671fb9f5c9ccb5a8bec9	Create Table		\N	2.0.3
1334075593508-20	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.811549+00	87	EXECUTED	3:062972ac25ff4e3755de49ba899e20e6	Create Table		\N	2.0.3
1334075593508-21	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.819041+00	88	EXECUTED	3:57bf332d9abe37fe98ea7f9bf4742258	Create Table		\N	2.0.3
1334075593508-22	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.826114+00	89	EXECUTED	3:49d2467872db6ae43f3c7b4c91b5d1a6	Create Table		\N	2.0.3
1334075593508-23	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.835577+00	90	EXECUTED	3:c3eb7e0e6dcd96e41f3ae424f5fec9fa	Create Table		\N	2.0.3
1334075593508-24	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.842528+00	91	EXECUTED	3:f9afe2f74358e67893694d9b2f3a12bd	Add Primary Key		\N	2.0.3
1334075593508-25	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.850021+00	92	EXECUTED	3:86feeed8a3c894045eb0c4858184b839	Add Primary Key		\N	2.0.3
1334075593508-26	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.855552+00	93	EXECUTED	3:638ac2854604fd429058827ddc4ef91a	Add Primary Key		\N	2.0.3
1334075593508-27	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.862001+00	94	EXECUTED	3:c20a18bce46089c1059a078ca7d9077b	Add Primary Key		\N	2.0.3
1334075593508-28	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.868957+00	95	EXECUTED	3:71be9c384275725f6ec879ec248305e7	Add Primary Key		\N	2.0.3
1334075593508-29	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.875498+00	96	EXECUTED	3:626b6b37a010e8f552428092731f5255	Add Primary Key		\N	2.0.3
1334075593508-30	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.881489+00	97	EXECUTED	3:f625bf10b091761341f7eff4c1ac63c2	Add Primary Key		\N	2.0.3
1334075593508-31	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.886985+00	98	EXECUTED	3:da8902681967147af5ca2babae7bf2d8	Add Primary Key		\N	2.0.3
1334075593508-32	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.892995+00	99	EXECUTED	3:79de90e425e195f1be2c14e395ed493e	Add Primary Key		\N	2.0.3
1334075593508-33	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.899732+00	100	EXECUTED	3:019cfe69eee17749ef311a2d4edfa32f	Add Unique Constraint		\N	2.0.3
1334075593508-34	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.907762+00	101	EXECUTED	3:9d1edfea3d41fd5c262f30e9ee84c47f	Add Unique Constraint		\N	2.0.3
1334075593508-35	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.914137+00	102	EXECUTED	3:6e40567e3ad2a96aca0963d0d9fb3fc8	Add Unique Constraint		\N	2.0.3
1334075593508-36	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.919245+00	103	EXECUTED	3:df9f2f99a816440fdf1e3ae00e312d9f	Add Foreign Key Constraint		\N	2.0.3
1334075593508-37	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.923924+00	104	EXECUTED	3:d8350eb312e48ff5120cf7b4496111f3	Add Foreign Key Constraint		\N	2.0.3
1334075593508-38	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.9297+00	105	EXECUTED	3:b3d90ec59546e62049b359a8699aff8d	Add Foreign Key Constraint		\N	2.0.3
1334075593508-39	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.934706+00	106	EXECUTED	3:55c091264674dc21bcde5703ad6c8028	Add Foreign Key Constraint		\N	2.0.3
1334075593508-40	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.93886+00	107	EXECUTED	3:92111a3a72adf24cc7c738cd1b043460	Add Foreign Key Constraint		\N	2.0.3
1334075593508-41	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.943589+00	108	EXECUTED	3:e5349744a2e0c583353b779c4ff849a6	Add Foreign Key Constraint		\N	2.0.3
1334075593508-42	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.948672+00	109	EXECUTED	3:2b2b8ead917f6d0ba40585a5f7ec6202	Add Foreign Key Constraint		\N	2.0.3
1334075593508-43	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.953808+00	110	EXECUTED	3:5135f1becea36484f0293ad520530c1b	Add Foreign Key Constraint		\N	2.0.3
1334075593508-44	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.958441+00	111	EXECUTED	3:4d791e4dd0247acb8678e1cd2b5b6629	Add Foreign Key Constraint		\N	2.0.3
1334075593508-45	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.963698+00	112	EXECUTED	3:62b4a73be7b8ce00ba5cd8b7ea3941fd	Add Foreign Key Constraint		\N	2.0.3
1334075593508-46	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.969186+00	113	EXECUTED	3:48f856295e3bdffc05db9e418271c534	Add Foreign Key Constraint		\N	2.0.3
1334075593508-47	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.974388+00	114	EXECUTED	3:010f4d6f2298b0a53c27bb3581f3d7e7	Add Foreign Key Constraint		\N	2.0.3
1334075593508-48	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.980873+00	115	EXECUTED	3:61532964689c5e09633be75263426c13	Add Foreign Key Constraint		\N	2.0.3
1334075593508-49	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.986807+00	116	EXECUTED	3:639aacd05f43a9d50a4afd8d93e108e0	Add Foreign Key Constraint		\N	2.0.3
1334075593508-50	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.992333+00	117	EXECUTED	3:82f062b58b6266e8807acc2b9fb25f01	Add Foreign Key Constraint		\N	2.0.3
1334075593508-51	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:28.998142+00	118	EXECUTED	3:730168c665516aa5317293f50521d39c	Add Foreign Key Constraint		\N	2.0.3
1334075593508-52	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.003526+00	119	EXECUTED	3:6b1152ca060481b10f513e2a271509c3	Add Foreign Key Constraint		\N	2.0.3
1334075593508-53	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.008428+00	120	EXECUTED	3:75dbbb5a056e8cbf7c44b182b2141077	Add Foreign Key Constraint		\N	2.0.3
1334075593508-54	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.013528+00	121	EXECUTED	3:7ecbac50a887ea5c5e00a09a582761fa	Add Foreign Key Constraint		\N	2.0.3
1334075593508-55	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.018853+00	122	EXECUTED	3:23bb08e407526cbd00e9b6161083fcee	Add Foreign Key Constraint		\N	2.0.3
1334075593508-56	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.023418+00	123	EXECUTED	3:4844a808e20a4df8de5c6f7fe0951704	Add Foreign Key Constraint		\N	2.0.3
1334075593508-57	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.028059+00	124	EXECUTED	3:57cfdba6d957a0e85221ac9677469a45	Add Foreign Key Constraint		\N	2.0.3
1334075593508-58	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.033133+00	125	EXECUTED	3:136929d4436a1ea5c3e25445ed71afc0	Add Foreign Key Constraint		\N	2.0.3
1334075593508-59	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.037349+00	126	EXECUTED	3:80cf197fd82b4cfb603086871e27ef55	Add Foreign Key Constraint		\N	2.0.3
1334075593508-60	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.041772+00	127	EXECUTED	3:5b78abc4883597f305d4805919bdb3ef	Add Foreign Key Constraint		\N	2.0.3
1334075593508-61	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.046595+00	128	EXECUTED	3:788e221888ab6e7fb2bbbaf47c0b145e	Add Foreign Key Constraint		\N	2.0.3
1334075593508-62	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.051249+00	129	EXECUTED	3:5b3bb0225316b14e29a5441fbc888b46	Add Foreign Key Constraint		\N	2.0.3
1334075593508-63	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.055813+00	130	EXECUTED	3:490461a8f2b0719a731c9b4b2c1af49c	Add Foreign Key Constraint		\N	2.0.3
1334075593508-64	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.060727+00	131	EXECUTED	3:ca7a97709b9b943e7279e14bc0775d41	Create Sequence		\N	2.0.3
1334075593508-65	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.065258+00	132	EXECUTED	3:41ff59c8ac5d9745c8cb89c461160478	Create Sequence		\N	2.0.3
1334075593508-66	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.069554+00	133	EXECUTED	3:cb30c77d23309f399483655b7274f81b	Create Sequence		\N	2.0.3
1334075593508-67	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.074144+00	134	EXECUTED	3:78ef2d40300b5e72d9e5dec1fbc66d44	Create Sequence		\N	2.0.3
1334075593508-68	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.078457+00	135	EXECUTED	3:111d795e59fffda78146689653dac44c	Create Sequence		\N	2.0.3
1334075593508-69	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.082889+00	136	EXECUTED	3:a3599c1cee7fad82fc18b74492da4b94	Create Sequence		\N	2.0.3
1334075593508-70	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.087402+00	137	EXECUTED	3:53b4793cba5010adc293f3a4d534242a	Create Sequence		\N	2.0.3
1334075593508-71	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.090871+00	138	EXECUTED	3:8faa5ca32cf7277861d0e4382d2baa0e	Create Sequence		\N	2.0.3
1334075601927-1	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.10012+00	139	EXECUTED	3:c5f611d41795a232263a0a1d9f5b3a88	Create Table		\N	2.0.3
1334075601927-2	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.106517+00	140	EXECUTED	3:0d43f4e26d3e0597a5912c2370ad2fba	Create Table		\N	2.0.3
1334075601927-3	danicricco (generated)	database/db-changelog-init.xml	2021-03-20 14:51:29.110754+00	141	EXECUTED	3:428b8c0350a798771580fd2b268d7e88	Create Sequence		\N	2.0.3
1	danicricco	database/db-changelog.xml	2021-03-20 14:51:29.117279+00	142	EXECUTED	3:a5ab2d7e4c6ca045991fedee77eb32d8	SQL From File		\N	2.0.3
1	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.126005+00	143	EXECUTED	3:1cb127ee06108fdc45cc73915c582d4b	Create Table		\N	2.0.3
1	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.133037+00	144	EXECUTED	3:d809b79bf44196cf65354ce82f66ffa5	Add Column		\N	2.0.3
2	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.136826+00	145	EXECUTED	3:165c601627ae5f2948d2c897bb242141	Add Column		\N	2.0.3
3	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.168746+00	146	EXECUTED	3:61d673a9646cc45c7c63e2171ca03f32	SQL From File		\N	2.0.3
1	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.174023+00	147	EXECUTED	3:9f1c8a00180a1a438ac395746b693a9d	Drop Column (x2)		\N	2.0.3
2	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.178252+00	148	EXECUTED	3:8293ce3626df2fb877edbc9cc403f1a1	Rename Column		\N	2.0.3
3	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.182045+00	149	EXECUTED	3:9aece63ebfda650653df3887c853feaf	Rename Column		\N	2.0.3
4	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.192696+00	150	EXECUTED	3:f8028c9141736f3eae183fd331ef7aa7	Create Table		\N	2.0.3
5	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.198913+00	151	EXECUTED	3:00c802ebcf422754860ce41b6465fdc5	Add Unique Constraint		\N	2.0.3
6	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.204126+00	152	EXECUTED	3:7d131016bfa6cf31a0ab551f5ab4f7b3	Add Foreign Key Constraint		\N	2.0.3
7	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.208942+00	153	EXECUTED	3:14b3a2c26b56c8ecab6b7a1a463f529e	Create Sequence		\N	2.0.3
8	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.212997+00	154	EXECUTED	3:1ee36152523737a46e33e088ee139453	Drop Column		\N	2.0.3
9	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.228546+00	155	EXECUTED	3:ea101aa0f6345d19411e43f5fd6ca2ab	Create Table, Add Foreign Key Constraint (x2), Create Sequence		\N	2.0.3
10	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.236834+00	156	EXECUTED	3:fd36608635b44983dc3c4f881a014d71	Drop Column, Drop Table (x3)		\N	2.0.3
11	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.241407+00	157	EXECUTED	3:73a38b21780c7e0c4d0ef35e1fe48e04	Drop Column, Drop Table		\N	2.0.3
12	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.245025+00	158	EXECUTED	3:c3c969c9f82b3d16de8ab7ed24f48e93	Drop Column (x2)		\N	2.0.3
13	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.249394+00	159	EXECUTED	3:3d744d71d238b0daaa8c3d8191b8b9cb	Drop Column, Add Not-Null Constraint		\N	2.0.3
15	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.254863+00	160	EXECUTED	3:82ef8dde1941814aab2aeaa0b8eaaa51	Add Column, Add Foreign Key Constraint		\N	2.0.3
16	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.258342+00	161	EXECUTED	3:95abb30280a6cf12696c753a1a213d2c	Drop Not-Null Constraint		\N	2.0.3
2	danicricco=	database/db-changelog-evolution.xml	2021-03-20 14:51:29.261688+00	162	EXECUTED	3:48ffc6af2457ebe78c35c98b084f0db0	Custom SQL		\N	2.0.3
3	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.270262+00	163	EXECUTED	3:2cb37e652f260380840ea0771d7691ed	Create Table		\N	2.0.3
4	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.277976+00	164	EXECUTED	3:ef012a9d5bbe16699ccaa1bb592beca2	Create Table		\N	2.0.3
5	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.284673+00	165	EXECUTED	3:3495dbe5071344ffa97360961a393733	Add Primary Key		\N	2.0.3
6	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.290983+00	166	EXECUTED	3:399f885eb093098526d231a7e102ef03	Add Foreign Key Constraint		\N	2.0.3
7	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.295791+00	167	EXECUTED	3:58403e51204122ee8ed319fe72530009	Add Foreign Key Constraint		\N	2.0.3
8	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.300359+00	168	EXECUTED	3:19241622a80d0b7643a7412ed33e015e	Create Sequence		\N	2.0.3
9	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.305187+00	169	EXECUTED	3:6f447d1279a68f071b9cfe78f0601f5d	Add Column		\N	2.0.3
4	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.309018+00	170	EXECUTED	3:4c507c29d92026f8e16d4c2e4ac33ca3	Custom SQL		\N	2.0.3
5	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.317075+00	171	EXECUTED	3:330c4d5d687603a056c926702387d4fe	Create Table, Create Sequence		\N	2.0.3
6	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.329117+00	172	EXECUTED	3:a40453344d9631afe768baca71ad4de6	Create Table, Create Sequence, Add Foreign Key Constraint		\N	2.0.3
7	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.334201+00	173	EXECUTED	3:48fd82bf0baca6c3c6d680d5f7b48c27	Drop Sequence (x2)		\N	2.0.3
8	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.338485+00	174	EXECUTED	3:e881c8e432ecb320e76aef62f3fb1aee	Rename Column (x2)		\N	2.0.3
17	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.347394+00	175	EXECUTED	3:834ab3f35e91652078bed721bf76b7e1	Drop Table, Drop Column (x4), Add Column		\N	2.0.3
15	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.352468+00	176	EXECUTED	3:731b533243e3f509d25f074613f46a8f	Add Column		\N	2.0.3
16	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.357504+00	177	EXECUTED	3:0ff67a07f45fd421a5b4998f2d76ab52	Add Column, Rename Column		\N	2.0.3
17	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.361401+00	178	EXECUTED	3:6bff3f606b53bf1436e45fbf6944a8d1	Rename Column		\N	2.0.3
9	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.365608+00	179	EXECUTED	3:01e736db12d357904fedf8031fc581e4	Drop Not-Null Constraint		\N	2.0.3
18	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.370909+00	180	EXECUTED	3:b75a2ca732e49e50aae6540e7c7799c8	Add Column		\N	2.0.3
18	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.38054+00	181	EXECUTED	3:cc401927ae37198b75122172b67b6746	Custom SQL, Create Table		\N	2.0.3
10	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.38391+00	182	EXECUTED	3:2e1923edba4e96a4cadad8c8037f24c2	Rename Column		\N	2.0.3
11	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.387495+00	183	EXECUTED	3:b52e22b53c8afc7f5b8f78b0f9f4bae7	Drop Column		\N	2.0.3
13	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.393313+00	184	EXECUTED	3:c153afb0a8ce0e263cdfeb7555b3cad1	Add Column, Add Foreign Key Constraint		\N	2.0.3
19	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.401392+00	185	EXECUTED	3:d96ecbe85ac58f4a53640c3bbbfbb148	Add Column, Rename Column		\N	2.0.3
20	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.405532+00	186	EXECUTED	3:c3a8fc55184ab731eb76cf4ce7816525	Add Column		\N	2.0.3
19	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.409463+00	187	EXECUTED	3:cd38d46fb9e0ed850f57543011c76c05	Custom SQL		\N	2.0.3
10	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.418635+00	188	EXECUTED	3:9986afc6ee11880d923925626b3176c3	Create Table		\N	2.0.3
11	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.423813+00	189	EXECUTED	3:ef594c1ef1191844bcdeec1cde194aed	Create Sequence		\N	2.0.3
12	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.428801+00	190	EXECUTED	3:b1f406baee5e5f73a8cd1bd123a28069	Add Column		\N	2.0.3
13	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.435568+00	191	EXECUTED	3:9de31e3c891aad894e5546fe27bb8e58	SQL From File		\N	2.0.3
14	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.440313+00	192	EXECUTED	3:61794be0b2e966cf72a66287c4a3f940	Add Column		\N	2.0.3
15	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.449684+00	193	EXECUTED	3:32d92911bed6f6faa054791c8061211e	Create Table		\N	2.0.3
16	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.453664+00	194	EXECUTED	3:aae43a3d73428377555f4016051df11f	Custom SQL		\N	2.0.3
17	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.45692+00	195	EXECUTED	3:187141cbaf61b06040bfa71fc43d53ee	Drop Column		\N	2.0.3
18	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.460077+00	196	EXECUTED	3:8318a978ed12845ce5a5c5f8012534f9	Drop Column		\N	2.0.3
19	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.464085+00	197	EXECUTED	3:50a87b2717de824feeb01af8cc1a1572	Drop Column		\N	2.0.3
20	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.467736+00	198	EXECUTED	3:0da4c6d07d43e63d41c44bf33ecb7211	Drop Column		\N	2.0.3
21	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.471327+00	199	EXECUTED	3:b9872cf6b3e39c815ad0ff9b0157855f	Rename Table		\N	2.0.3
22	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.474674+00	200	EXECUTED	3:ad54b5ff269d2f37d3778db05056e82a	Add Column		\N	2.0.3
23	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.477512+00	201	EXECUTED	3:d789b96b0d38290f1b35d9182d744b89	Custom SQL		\N	2.0.3
24	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.480523+00	202	EXECUTED	3:6dbeaaedc53c8dab96368ba637e581dd	Rename Table		\N	2.0.3
25	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.484639+00	203	EXECUTED	3:9a3b12c703bb8b931b1cd8d148795178	Create Sequence		\N	2.0.3
26	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.48732+00	204	EXECUTED	3:7809af8194695b481c92225dd961e90b	Rename Column		\N	2.0.3
27	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.491871+00	205	EXECUTED	3:f984d79680fc301dc2f09e0af02b61a2	Add Foreign Key Constraint		\N	2.0.3
28	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.495448+00	206	EXECUTED	3:3cd146187d6d91dc521cc7f9339d78bb	Create Sequence		\N	2.0.3
29	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.498857+00	207	EXECUTED	3:9399d399dee901a8daefdb0d817022ff	Rename Column		\N	2.0.3
30	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.504894+00	208	EXECUTED	3:0f02847ecd81f437affaaf6a92a4ddcf	Create Table		\N	2.0.3
31	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.507493+00	209	EXECUTED	3:99c60a223005f834ab6c4b34316464d2	Custom SQL		\N	2.0.3
32	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.511394+00	210	EXECUTED	3:cca82885591a5ec29d7bb8152dc3147c	Create Sequence		\N	2.0.3
33	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.516183+00	211	EXECUTED	3:728d9d9f302c9a61c0edfd0fd9ff99eb	Drop Column (x2), Add Column		\N	2.0.3
34	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.519366+00	212	EXECUTED	3:4aa8322f26dd061f9f10d1411ec33e62	Custom SQL		\N	2.0.3
35	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.522841+00	213	EXECUTED	3:90b82a1c287cac82c1e44dbcf1a96508	Custom SQL		\N	2.0.3
36	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.528193+00	214	EXECUTED	3:5f4f9904537d75251a8e1b442cc6c94a	Add Foreign Key Constraint		\N	2.0.3
37	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.533318+00	215	EXECUTED	3:ed47fd2bf275f9e9aff31d74fcba0ce0	Custom SQL		\N	2.0.3
38	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.537205+00	216	EXECUTED	3:825f75ab2d2c4aa4a8c575903e2d62e0	Add Column		\N	2.0.3
39	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.54335+00	217	EXECUTED	3:4f23208a72e0c1db9442f5cdfe14b6d3	Drop Table (x2)		\N	2.0.3
40	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.547123+00	218	EXECUTED	3:972ecee6d22821e9f731028d7cc30784	Custom SQL		\N	2.0.3
41	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.55241+00	219	EXECUTED	3:511dc0a6a283528dc59e0efe680f908c	Add Column		\N	2.0.3
42	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.555867+00	220	EXECUTED	3:54a1cb6d49e5e0696f8e068cc10d626e	Custom SQL		\N	2.0.3
43	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.56707+00	221	EXECUTED	3:20c7661e6a4b3ccc305d4964f920c9a7	Custom SQL		\N	2.0.3
44	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.569818+00	222	EXECUTED	3:cc3de8e82f6f513e5af80ddc76f9eb25	Custom SQL		\N	2.0.3
14	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.572116+00	223	EXECUTED	3:1f67aeed9ead1d3d6ac6fb7983f8ff5c	Drop Not-Null Constraint		\N	2.0.3
45	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.5777+00	224	EXECUTED	3:bb95e96847a584865a6b89f99e97d154	Add Unique Constraint		\N	2.0.3
46	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.583218+00	225	EXECUTED	3:558fd729eaa00160c95f9c0724fae0c0	Add Foreign Key Constraint		\N	2.0.3
20	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.587637+00	226	EXECUTED	3:166d4d6094f589afb08411d48b4f47e5	Custom SQL		\N	2.0.3
16	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.598992+00	227	EXECUTED	3:c07e2a24c077c40c687706f48deb0259	Create Table, Add Unique Constraint, Add Column		\N	2.0.3
21	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.60519+00	228	EXECUTED	3:10cce245af74970227559044b6347b03	Add Column		\N	2.0.3
17	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.609699+00	229	EXECUTED	3:42e36d13365e038eaf9e4ef41f2ce4ef	Add Not-Null Constraint		\N	2.0.3
22	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.616884+00	230	EXECUTED	3:b5667ca58b969aa9f55d421e3bfc3c38	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
18	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.620954+00	231	EXECUTED	3:a4afbe3acaabb6daa7bb3eaf413d4acb	Rename Column		\N	2.0.3
19	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.625202+00	232	EXECUTED	3:c1106ea75032f171ecd7b2a17b9bf5c6	Drop Column		\N	2.0.3
20	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.629043+00	233	EXECUTED	3:f88cd699b99936114dd28d7d036100f0	Add Column		\N	2.0.3
21	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.633692+00	234	EXECUTED	3:cc86a4f927cf38f90ffbeee4ab1773fa	Add Default Value, Add Not-Null Constraint		\N	2.0.3
22	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.637705+00	235	EXECUTED	3:31bdfe911aee0e84b0208caae1865255	Custom SQL		\N	2.0.3
23	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.641522+00	236	EXECUTED	3:f77867f66fbbf8e03c91095cfac7f34a	Custom SQL		\N	2.0.3
21	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.647876+00	237	EXECUTED	3:ec1af6de643882151a10e02992613404	Add Column (x2), Custom SQL		\N	2.0.3
47	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.653011+00	238	EXECUTED	3:1da73b264101c4615e72308b710c0fc4	Add Column		\N	2.0.3
48	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.658012+00	239	EXECUTED	3:20cd7232f86b17f65257d263687e295c	Add Default Value (x2)		\N	2.0.3
49	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.662536+00	240	EXECUTED	3:fd785e8d0ca734a6dc352a3b894f2d50	Add Column		\N	2.0.3
24	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.668122+00	241	EXECUTED	3:e60144122b9372568df148d126248aac	Add Column, Add Foreign Key Constraint		\N	2.0.3
26	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.683837+00	242	EXECUTED	3:691995990d38d6eff4b3ebcd7a3b9640	Create Table (x2), Add Foreign Key Constraint, Add Column, Add Foreign Key Constraint		\N	2.0.3
27	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.688895+00	243	EXECUTED	3:f43166394800a5a63693972fee5d54dc	Rename Column (x2)		\N	2.0.3
28	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.699522+00	244	EXECUTED	3:037ae8b4f5f4d0b3eb4428a16c09f243	Add Column (x8)		\N	2.0.3
29	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.704695+00	245	EXECUTED	3:bb16a121619a1962ecca75a4f431217e	Drop Column (x4)		\N	2.0.3
30	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.707915+00	246	EXECUTED	3:25685db08ad642f3bf7c2269f9527dc3	Add Not-Null Constraint		\N	2.0.3
22	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.71157+00	247	EXECUTED	3:6dbbc7a6f555cca35f67ef3a326ef126	Create Sequence (x2)		\N	2.0.3
23	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.714287+00	248	EXECUTED	3:9c03e05233d5664cc7932c88ffae50db	Add Column		\N	2.0.3
23	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.717029+00	249	EXECUTED	3:b38e74c1a1708807625f4b7c84ad22c7	Drop Not-Null Constraint, Add Column		\N	2.0.3
24	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.72179+00	250	EXECUTED	3:4c6b3c51b0d3010154e93448d7252cd3	Drop Column, Add Column		\N	2.0.3
31	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.725959+00	251	EXECUTED	3:6ab6a5de2e8e79d5409a8bfedfeafa67	Add Column		\N	2.0.3
33	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.730525+00	252	EXECUTED	3:ba2424f332d7e4f3befb723917e4baf6	Custom SQL		\N	2.0.3
24	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.760419+00	253	EXECUTED	3:652502abf646cb3c9aeb9e1dcb43408a	Custom SQL, Create Table, Create Sequence, Add Foreign Key Constraint, Create Table, Create Sequence, Add Foreign Key Constraint (x2), Create Table, Create Sequence, Add Foreign Key Constraint		\N	2.0.3
34	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.764927+00	254	EXECUTED	3:96dc1ed721e44194bb5219fc1abb55a6	Custom SQL		\N	2.0.3
36	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.767794+00	255	EXECUTED	3:2b9577882081ac69987ae9f4e60b3832	Custom SQL		\N	2.0.3
37	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.770658+00	256	EXECUTED	3:1b3e315bbe6f523f1a47c5b127214948	Custom SQL		\N	2.0.3
38	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.773728+00	257	EXECUTED	3:58c63c7c0b9282f4c1b8a4522b8f62da	Drop Column		\N	2.0.3
39	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.777398+00	258	EXECUTED	3:0c41b90afdcddc7f084629006ad37280	Drop Column, Rename Column		\N	2.0.3
40	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.780187+00	259	EXECUTED	3:7369ebca79ff092a0ff07e2e06facea9	Rename Column		\N	2.0.3
41	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.782758+00	260	EXECUTED	3:079908e3bfa806a605ed45de57c23327	Custom SQL		\N	2.0.3
43	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.787578+00	261	EXECUTED	3:9b7c1591732a25308105808ece1d751b	Custom SQL		\N	2.0.3
44	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.792494+00	262	EXECUTED	3:9f0fbf80d419667336b2996088d6c5d3	Custom SQL		\N	2.0.3
46	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.796516+00	263	EXECUTED	3:457a18d3f763eb06fe96de1ee9383ebf	Add Column (x2)		\N	2.0.3
47	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.802493+00	264	EXECUTED	3:7f47c593db6b64633c954d28791ab0b9	Custom SQL		\N	2.0.3
49	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.811431+00	265	EXECUTED	3:91d9a69f5ee4ce98390b9171c503864f	Custom SQL		\N	2.0.3
50	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.815901+00	266	EXECUTED	3:cd3703a7d747c126265874210c396dec	Drop Not-Null Constraint, Add Column		\N	2.0.3
25	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.821425+00	267	EXECUTED	3:09676682700f7a41f6de5f37ac6bcb4b	Drop Not-Null Constraint, Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
25	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.826911+00	268	EXECUTED	3:533d8b18cb0bf29f23766bf32e523cc9	Add Column, Add Foreign Key Constraint		\N	2.0.3
26	haquino	database/db-changelog-evolution.xml	2021-03-20 14:51:29.831335+00	269	EXECUTED	3:460a3a5ec4ba02f863943108cdd948fe	Custom SQL		\N	2.0.3
51	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.835936+00	270	EXECUTED	3:a137e7d17a8faf790a5eb21f27227fc1	Custom SQL		\N	2.0.3
53	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.839754+00	271	EXECUTED	3:ec9afdc3f9fb019623c68d5a5850d8ac	Custom SQL		\N	2.0.3
54	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.842825+00	272	EXECUTED	3:4eb40f33ef4c36c2324f90ba96d000e7	Custom SQL		\N	2.0.3
26	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.846524+00	273	EXECUTED	3:a8daa2adf636dffa4213c57f026a02c7	Custom SQL		\N	2.0.3
27	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.854476+00	274	EXECUTED	3:c7cc722e6b631fa62099033b4764b75f	Add Primary Key, Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
56	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.858388+00	275	EXECUTED	3:d8290fd68ea7603dfc4c7c4119809840	Add Not-Null Constraint		\N	2.0.3
57	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.8627+00	276	EXECUTED	3:d76f1f9e43d9e86c39445d6b43bc403f	Custom SQL		\N	2.0.3
58	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.875509+00	277	EXECUTED	3:8a896899a3e603c80312a49f4936b4c8	Create Table, Add Primary Key, Add Foreign Key Constraint (x3)		\N	2.0.3
30	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.882139+00	278	EXECUTED	3:021b319eedfe548cf0a4b804227aed6e	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
59	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:29.886601+00	279	EXECUTED	3:71374460fc36104b0e5a7cc787641120	Custom SQL		\N	2.0.3
31	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:29.903815+00	280	EXECUTED	3:c7ad2cb06e3ef0c1b1d55ddb654aac2a	Custom SQL		\N	2.0.3
50	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.909507+00	281	EXECUTED	3:e7d674005528df98d927ff58e91c80a1	Add Column (x2), Drop All Foreign Key Constraints (x6)		\N	2.0.3
51	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.920685+00	282	EXECUTED	3:512b4d16a721d970d799d8280a2ec29d	Drop All Foreign Key Constraints, Custom SQL, Add Primary Key		\N	2.0.3
52	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.929152+00	283	EXECUTED	3:1cf24befcc92f0c7513cd253e7e203f8	Create Table		\N	2.0.3
53	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.933647+00	284	EXECUTED	3:540a900735e7a58283079d649ed94725	Create Sequence		\N	2.0.3
54	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.937954+00	285	EXECUTED	3:aa44cabf6e0d072c7b4c4ea81f4a5e1c	Custom SQL		\N	2.0.3
55	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.944858+00	286	EXECUTED	3:56675eed48141872273fec04ffd64fe1	Add Column		\N	2.0.3
56	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.950362+00	287	EXECUTED	3:47d2c5f6169a5a20420ea805b11ba858	Custom SQL		\N	2.0.3
57	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.961375+00	288	EXECUTED	3:c023bbdcafd60ecf0984bbf61354898b	Drop Table (x3)		\N	2.0.3
58	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.965843+00	289	EXECUTED	3:8dbe2b1ca0ba377fa79e8f1e55b5441b	Custom SQL		\N	2.0.3
59	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.972721+00	290	EXECUTED	3:ff86e9f482c8888ba3dd0ba12d7264ae	Drop Column, Add Foreign Key Constraint		\N	2.0.3
60	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.97959+00	291	EXECUTED	3:095b2923f67aeed3242aed417694bd92	Drop Column, Add Column, Add Foreign Key Constraint		\N	2.0.3
61	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.985676+00	292	EXECUTED	3:813a46f7c578edfcce8e493d94c97298	Custom SQL, Drop Column		\N	2.0.3
62	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.989511+00	293	EXECUTED	3:65cd9e9ed59b3f1ce4fcfb15fbe29829	Drop Column		\N	2.0.3
63	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:29.995579+00	294	EXECUTED	3:69080c7941e192105b244836b5a249b3	Add Primary Key		\N	2.0.3
64	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.00073+00	295	EXECUTED	3:aea017df28b6014150f2844858dd8f8a	Drop Column		\N	2.0.3
65	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.006786+00	296	EXECUTED	3:3ade8d458a4a2a5cd7051855d290b064	Add Column, Create Sequence, Add Primary Key		\N	2.0.3
66	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.010669+00	297	EXECUTED	3:5fabad66252589bbbf16a2cc97e0ae8b	Add Column		\N	2.0.3
67	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.014817+00	298	EXECUTED	3:21c678287fc8caa2fd7a4c3806b66e29	Add Column		\N	2.0.3
68	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.019605+00	299	EXECUTED	3:e7894db7d24f11ffc0c150840cc150d0	Drop Column, Add Column		\N	2.0.3
69	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.029536+00	300	EXECUTED	3:20522d3b50085478e7bdc397e4f39619	Drop Column (x8)		\N	2.0.3
70	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.039337+00	301	EXECUTED	3:f9f39982b89a0f00690b72cdf4e25664	Drop Column (x2), Add Column, Add Foreign Key Constraint		\N	2.0.3
71	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.045186+00	302	EXECUTED	3:7778286d7c5b93a2f683582161714ece	Add Primary Key		\N	2.0.3
72	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.049063+00	303	EXECUTED	3:ded488f3ce6a260cdb45aa97eed3a8d0	Drop Not-Null Constraint		\N	2.0.3
73	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.053084+00	304	EXECUTED	3:3f1723e88c726cf78e0ec2b7bed0ae54	Add Column		\N	2.0.3
74	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.059687+00	305	EXECUTED	3:0fad4085ff656debf6507339f68d9926	Add Column		\N	2.0.3
75	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.063712+00	306	EXECUTED	3:ed55efa2836f83b89ca9cf88d6759f74	Add Column		\N	2.0.3
76	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.066986+00	307	EXECUTED	3:94f7ee840d86b019ee228857c810e335	Drop Column		\N	2.0.3
77	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.070287+00	308	EXECUTED	3:762bade2e5371902a057f1e84aa5576e	Drop Column		\N	2.0.3
78	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.075206+00	309	EXECUTED	3:b7b48645fc741018fbb83380a07ed154	Add Primary Key		\N	2.0.3
79	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.078307+00	310	EXECUTED	3:33afa5703631424c2c2b88030e7dbc9d	Add Not-Null Constraint		\N	2.0.3
80	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.081938+00	311	EXECUTED	3:73c2237022494a8637efb31b3e909778	Add Column		\N	2.0.3
60	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.085409+00	312	EXECUTED	3:e911487a9525568ff0d007f561844590	Drop Foreign Key Constraint		\N	2.0.3
61	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.09081+00	313	EXECUTED	3:6dddaf8a5bb88b3a74ba853f9aca1bcd	Add Column, Add Foreign Key Constraint		\N	2.0.3
63	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.096487+00	314	EXECUTED	3:85a652d3413279ed45da0b13058a393c	Drop Table		\N	2.0.3
81	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.101916+00	315	EXECUTED	3:6cb01ac4317b553b7aeba8f3c08944fa	Add Column, Add Foreign Key Constraint		\N	2.0.3
32	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.106758+00	316	EXECUTED	3:cca1794c26ffc1f136ac4e2c4cc29107	Add Unique Constraint		\N	2.0.3
64	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.110181+00	317	EXECUTED	3:f79e1e3627c065f4470df5aac553c63d	Add Column		\N	2.0.3
66	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.113147+00	318	EXECUTED	3:7dd1b3d96c78fe3be278180704b2e6b8	Custom SQL		\N	2.0.3
67	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.119913+00	319	EXECUTED	3:4117ac7f3846a7a9f21c6fba8be09632	Create Table, Add Foreign Key Constraint		\N	2.0.3
68	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.124366+00	320	EXECUTED	3:deaf2c3ebb981ca591c16174600b0093	Rename Table		\N	2.0.3
69	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.131977+00	321	EXECUTED	3:6fc7054924aae51adb3d97fbb3462ce6	Create Table, Add Foreign Key Constraint		\N	2.0.3
70	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.136067+00	322	EXECUTED	3:e615c88b2d52c6fb545a946261c607a2	Rename Table		\N	2.0.3
71	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.144129+00	323	EXECUTED	3:68ef29e1ab54e5f740990d26533df3b5	Add Primary Key, Add Column, Add Foreign Key Constraint		\N	2.0.3
73	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.149475+00	324	EXECUTED	3:486cbb0f7249cc9c06892accb64fbea6	Add Primary Key		\N	2.0.3
74	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.154812+00	325	EXECUTED	3:a16f36186dffcdd73bf55fd83f0fdadc	Create Sequence (x2)		\N	2.0.3
76	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.166152+00	326	EXECUTED	3:0fb70148c37b402651e8d92eb82688e9	Create Table, Add Primary Key, Add Foreign Key Constraint (x2)		\N	2.0.3
77	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.172885+00	327	EXECUTED	3:625dc77c42e90c2739d2e7821a6c3396	Rename Table, Create Sequence, Drop Column (x2), Add Column		\N	2.0.3
78	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.176834+00	328	EXECUTED	3:e192530d1d4966aa95864e14f90f92b0	Rename Table		\N	2.0.3
80	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.1809+00	329	EXECUTED	3:45e0ba69b98d00eb243824c11457082c	Add Column		\N	2.0.3
33	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.210423+00	330	EXECUTED	3:24f5ccfd3649242de189e3e23b441216	Custom SQL, Create Table, Create Sequence, Create Table, Create Sequence, Add Foreign Key Constraint (x2), Add Column, Add Foreign Key Constraint		\N	2.0.3
34	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.215254+00	331	EXECUTED	3:13606731bc31d158565407a1402b4402	Add Column		\N	2.0.3
35	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.219976+00	332	EXECUTED	3:20806e13762ded463368877f2f32b511	Add Column, Add Foreign Key Constraint		\N	2.0.3
36	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.229125+00	333	EXECUTED	3:5706c241f7e289bfc629756ffd7afe10	Drop Column (x4), Drop Table, Drop Sequence, Add Column		\N	2.0.3
37	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.233176+00	334	EXECUTED	3:f05b5eb2ac6b138b03809d5222553b46	Custom SQL		\N	2.0.3
38	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.237299+00	335	EXECUTED	3:a9ade61b4642d214edcd173417b12e45	Add Column		\N	2.0.3
39	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.240807+00	336	EXECUTED	3:57a89933a4dac2bf1a732cfde81adf3b	Add Column		\N	2.0.3
40	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.243694+00	337	EXECUTED	3:0e3378c3807a4dd5d4cd0937703ea1ba	Rename Column		\N	2.0.3
81	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.246977+00	338	EXECUTED	3:318fbf04ee53fd68e089d9bc59dcf2e4	Add Column		\N	2.0.3
41	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.258837+00	339	EXECUTED	3:68a59701ee73cc3d6e1176cacf6573cd	Drop Table, Create Table, Add Foreign Key Constraint		\N	2.0.3
42	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.262475+00	340	EXECUTED	3:9458608d3fee7f9a1dfb02fa31f7f021	Rename Column		\N	2.0.3
43	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.267608+00	341	EXECUTED	3:d4558a622c85ab7a6a34840bdebe3c0f	Custom SQL		\N	2.0.3
44	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.270606+00	342	EXECUTED	3:e5aac5b86d5893c8356c703832c243ce	Rename Table		\N	2.0.3
45	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.275018+00	343	EXECUTED	3:f013ba2fd41ab4eb1219deedecc454a2	Drop Table		\N	2.0.3
46	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.281511+00	344	EXECUTED	3:9e98de159ab3a2470b521c41ea1eb784	Drop Table (x2)		\N	2.0.3
47	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.284532+00	345	EXECUTED	3:561e14fde215f6c89ef57304af0e2117	Drop Column		\N	2.0.3
48	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.288359+00	346	EXECUTED	3:1ac233cb0431ea5192562c96f4e5a98e	Drop Column (x2)		\N	2.0.3
49	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.291912+00	347	EXECUTED	3:25e1f196fc18b237a1362d8dc2d96acf	Drop Column		\N	2.0.3
83	rodrigovz	database/db-changelog-evolution.xml	2021-03-20 14:51:30.297311+00	348	EXECUTED	3:29746891e4c8c00f3b25e1ef38330cc1	Drop Not-Null Constraint, Add Column		\N	2.0.3
50	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.30117+00	349	EXECUTED	3:3710142b8045e07e168249ffaa258c45	Rename Column		\N	2.0.3
51	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.305517+00	350	EXECUTED	3:a10ffb0dccbd273c66a85954d0aa117d	Add Column, Custom SQL		\N	2.0.3
52	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.309252+00	351	EXECUTED	3:90cd83c07849e8ec9edd6b215188bcf9	Add Column, Custom SQL		\N	2.0.3
82	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.312215+00	352	EXECUTED	3:de24c931ecef2ffe2c6585d37c6eb1e8	Rename Table		\N	2.0.3
83	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.318094+00	353	EXECUTED	3:f3bb22957b9c42627187befb76292df6	Add Column		\N	2.0.3
84	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.321343+00	354	EXECUTED	3:a71f3e3bc125f723d24a36729980fd93	Add Column		\N	2.0.3
85	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.325177+00	355	EXECUTED	3:b58e9c2f4508ef871255ab262c18abe3	Add Column		\N	2.0.3
86	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.329945+00	356	EXECUTED	3:32582e2ec057da5ece2391daa7fd0230	Drop Table		\N	2.0.3
87	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.336+00	357	EXECUTED	3:c7c495a56097e2c1c16fdb8d8e2deaaa	Drop Table		\N	2.0.3
53	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.340361+00	358	EXECUTED	3:9f76204aec94c1226579f9b896054ec7	Custom SQL		\N	2.0.3
88	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.345542+00	359	EXECUTED	3:22c5ccb67a384b7c55c87dae18f0f23a	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
89	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.350783+00	360	EXECUTED	3:0ed56f99d5c5c2025de25dc2d813de10	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
90	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.35562+00	361	EXECUTED	3:58ed86eda65ed1c75016db2ed8457998	Drop Column, Add Column		\N	2.0.3
54	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.369767+00	362	EXECUTED	3:f6bf3a00de0a84d0b6f157e7f43e0213	Custom SQL		\N	2.0.3
55	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.383188+00	363	EXECUTED	3:c8885b3d999989d75b55abc746c86de7	Custom SQL, Create Table, Create Sequence, Add Unique Constraint		\N	2.0.3
56	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.388795+00	364	EXECUTED	3:2b3b00692ebb6a0ed521d4d1408cd08b	Add Column, Drop Column		\N	2.0.3
57	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.394719+00	365	EXECUTED	3:323f59848d7b5b469eaa82cd8543b55d	Add Column		\N	2.0.3
58	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.401672+00	366	EXECUTED	3:1bc9d9960d58f73d6090bb053dcc0b49	Custom SQL, Drop Column, Add Column		\N	2.0.3
59	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.405811+00	367	EXECUTED	3:306229ccf1306161d10fdb1134dd9cd8	Drop Column		\N	2.0.3
91	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.425754+00	368	EXECUTED	3:9eea435d09831c3bb5ab29d6c685bc53	Drop Table, Create Table, Create Sequence, Add Unique Constraint, Add Not-Null Constraint (x5)		\N	2.0.3
92	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.431965+00	369	EXECUTED	3:55265ed40d4ac9a58f0d770bd7acf6a4	Custom SQL		\N	2.0.3
93	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.438269+00	370	EXECUTED	3:e54afa1c64fdb3a52cf45ad628ea42be	Drop Column, Add Column		\N	2.0.3
60	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.445282+00	371	EXECUTED	3:28b8f9a76d2221184f109c32f76b2b2d	Add Unique Constraint		\N	2.0.3
94	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.451796+00	372	EXECUTED	3:4180ebb9dfc1ea61aafe7df8f4e131d3	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
95	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.461731+00	373	EXECUTED	3:4e97e38bcdc09d5f1aab833b56079d0f	Create Table, Add Primary Key		\N	2.0.3
61	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.473845+00	374	EXECUTED	3:2bb14f09b99bcde4643a944f2f762c3f	Add Column, Custom SQL, Drop Column, Rename Column, Add Unique Constraint, Create Index		\N	2.0.3
62	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.484488+00	375	EXECUTED	3:7c104adc1af572f43389d2660f3bdea0	Drop Column, Drop Table (x2), Add Column (x2)		\N	2.0.3
63	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.488794+00	376	EXECUTED	3:0d3558cd7f67ef43487dabf315452a49	Add Column		\N	2.0.3
64	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.494327+00	377	EXECUTED	3:4df40e2a7a1ea5ce99a3d66f30f640a3	Drop Column (x2)		\N	2.0.3
65	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.502578+00	378	EXECUTED	3:18ec1464eaebceb95f3609333218f10f	Create Table, Add Foreign Key Constraint (x2)		\N	2.0.3
66	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.507751+00	379	EXECUTED	3:11a6244df16f77dfa01aaf8e701f63a3	Add Column (x2)		\N	2.0.3
67	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.513633+00	380	EXECUTED	3:a7d40c07347c70f099ee479a01a23057	Add Unique Constraint		\N	2.0.3
68	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.517587+00	381	EXECUTED	3:b2ab852ca21d298341d416b3af31f6ed	Rename Column		\N	2.0.3
69	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.525012+00	382	EXECUTED	3:c4a212bf234a415d609c858a73d27ab5	Drop Unique Constraint, Add Unique Constraint		\N	2.0.3
70	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.531265+00	383	EXECUTED	3:7f2ed7d749cdc35797c15321b5d295fc	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
71	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.535639+00	384	EXECUTED	3:e2d425cd4621a50d7b2a3d62d1a56905	Custom SQL		\N	2.0.3
72	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.539175+00	385	EXECUTED	3:1cac1621e7721f1aba0b2e6990d6e103	Custom SQL		\N	2.0.3
96	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.544144+00	386	EXECUTED	3:7189e4c27f0bc51f618e7f14c193032b	Add Column (x2)		\N	2.0.3
73	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.548899+00	387	EXECUTED	3:69bf211f34ee17e81f208be85befa8fc	Custom SQL		\N	2.0.3
97	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.561361+00	388	EXECUTED	3:c4af60c4ac173c75ca71110f0f7f8f6b	Create Table, Add Primary Key, Add Foreign Key Constraint (x2), Create Sequence		\N	2.0.3
98	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.567495+00	389	EXECUTED	3:aace951dde717cd866449ead5a3a132c	Add Column (x3)		\N	2.0.3
99	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.572707+00	390	EXECUTED	3:89eaa300d17f9ae3b4b4445bf4c0acf6	Custom SQL, Add Not-Null Constraint, Add Foreign Key Constraint		\N	2.0.3
100	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.579514+00	391	EXECUTED	3:08f16cb304d8f6d56bd6dd91334ea692	Add Column, Custom SQL		\N	2.0.3
101	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.583399+00	392	EXECUTED	3:e06c11e7fcef8909ebd83da0b47876a8	Rename Column		\N	2.0.3
102	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.59037+00	393	EXECUTED	3:d5734b1b00eeb139bfbf0a1965392cf7	Add Column, Custom SQL, Drop Table		\N	2.0.3
74	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.598805+00	394	EXECUTED	3:3ed2d2c3a51143799a4bdd92b71634ed	Add Column, Add Foreign Key Constraint, Custom SQL, Add Not-Null Constraint		\N	2.0.3
75	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.60621+00	395	EXECUTED	3:40eabf904fa11172b6c67c0edf4d7961	Drop Unique Constraint, Add Unique Constraint		\N	2.0.3
76	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.615071+00	396	EXECUTED	3:ba9df5ecb7157c9c0af4c943bc8d914d	Drop Unique Constraint, Custom SQL, Add Unique Constraint		\N	2.0.3
103	danicricco	database/db-changelog-evolution.xml	2021-03-20 14:51:30.621266+00	397	EXECUTED	3:db3acfe825354767727a0f4f723051ca	Add Column (x3)		\N	2.0.3
104	amiranda	database/db-changelog-evolution.xml	2021-03-20 14:51:30.628496+00	398	EXECUTED	3:7f46ee441016cf133d07fb55e10e5437	Custom SQL		\N	2.0.3
105	amiranda	database/db-changelog-evolution.xml	2021-03-20 14:51:30.634482+00	399	EXECUTED	3:af54a9789dd7441633397b873c7f6fe4	Custom SQL		\N	2.0.3
1	dallen	database/db-changelog-evolution.xml	2021-03-20 14:51:30.640291+00	400	EXECUTED	3:1661c8a3023f875838a690bfa89b8972	Add Column		\N	2.0.3
77	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.645519+00	401	EXECUTED	3:52d9684de4e95ad5a29e800b8d88d2aa	Add Column		\N	2.0.3
2	dallen	database/db-changelog-evolution.xml	2021-03-20 14:51:30.650225+00	402	EXECUTED	3:18878a0df26f667606f47b5dc0ed29e1	Add Column		\N	2.0.3
1	afeltes	database/db-changelog-evolution.xml	2021-03-20 14:51:30.655986+00	403	EXECUTED	3:2d6833e239cedb78f12d0dacc823da8f	Create Sequence		\N	2.0.3
78	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.662253+00	404	EXECUTED	3:014c86fc7b19ca7b7013c5fcb5da496f	Add Column, Custom SQL, Add Not-Null Constraint		\N	2.0.3
79	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.671401+00	405	EXECUTED	3:d2bd21e6054a95c127de6293d96f778a	Create Table, Create Sequence		\N	2.0.3
80	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.678533+00	406	EXECUTED	3:ae7a18724af7ad1904634e268fef96bf	Add Column, Create Index		\N	2.0.3
81	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.683465+00	407	EXECUTED	3:85f2c6fda7e9a0c8a754250df65622b8	Add Column		\N	2.0.3
82	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.690628+00	408	EXECUTED	3:2fff4e94120dc7d20daa1cbaaf1b26f3	Add Column, Update Data, Add Not-Null Constraint		\N	2.0.3
83	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.703729+00	409	EXECUTED	3:e18cfcb19085afa327ca2625f8310a6e	Create Table, Add Foreign Key Constraint, Custom SQL		\N	2.0.3
84	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.70781+00	410	EXECUTED	3:eca9dde997fadd4e412d6e4d429b6191	Rename Column		\N	2.0.3
85	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.720033+00	411	EXECUTED	3:5efca67c5e4cbcc26aa30cac2dd94a62	Create Table, Add Foreign Key Constraint, Custom SQL		\N	2.0.3
86	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.732605+00	412	EXECUTED	3:80a8bc205235d14c87775f29cb78e9b7	Create Table, Add Foreign Key Constraint, Custom SQL		\N	2.0.3
87	mprieto	database/db-changelog-evolution.xml	2021-03-20 14:51:30.737013+00	413	EXECUTED	3:1869a14ce95ffb502b34d0a5e9aa72b0	Create Sequence		\N	2.0.3
0	rvillalba	database/db-changelog-evolution.xml	2021-03-20 14:51:30.740388+00	414	EXECUTED	3:6ae06159b8358ef28756d3a6dfceed0d	Add Column		\N	2.0.3
88	afeltes	database/db-changelog-evolution.xml	2021-03-20 14:51:30.745088+00	415	EXECUTED	3:09ccdd06528fd709ad1636b756dbcb51	Add Column (x2)		\N	2.0.3
89	afeltes	database/db-changelog-evolution.xml	2021-03-20 14:51:30.750161+00	416	EXECUTED	3:2b2eac17f7ea93661fee795c8950adb6	Custom SQL		\N	2.0.3
1	rvillalba	database/db-changelog-evolution.xml	2021-03-20 14:51:30.755259+00	417	EXECUTED	3:a43ca2ab108924823cceecc4c8e8b185	Add Column, Custom SQL		\N	2.0.3
1	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.759239+00	418	EXECUTED	3:2bcf72069cfd53e34a3bc2e9d4a5c08d	Custom SQL		\N	2.0.3
2	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.76882+00	419	EXECUTED	3:b0cb15579bbb0186bf6403580d302e32	Create Table		\N	2.0.3
3	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.772336+00	420	EXECUTED	3:0884651d1bf4560fd318cc314c9577c7	Create Sequence		\N	2.0.3
4	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.781446+00	421	EXECUTED	3:b2e6357deb58b0329e37f36576c8bf1a	Create Table, Add Primary Key, Add Foreign Key Constraint		\N	2.0.3
5	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.792752+00	422	EXECUTED	3:1d344edf7a22511c4f5375daad1e317d	Create Table, Add Foreign Key Constraint (x2)		\N	2.0.3
6	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.797215+00	423	EXECUTED	3:cd19ae55a727ba4e6628735eb414bf16	Create Sequence		\N	2.0.3
7	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.807446+00	424	EXECUTED	3:5150628e797407dca215fd881c30c19f	Create Table, Add Primary Key, Add Foreign Key Constraint		\N	2.0.3
8	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.811751+00	425	EXECUTED	3:7838372a71e84414fc3fd508f61484b7	Add Not-Null Constraint		\N	2.0.3
9	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.819596+00	426	EXECUTED	3:ac97bbaa73ac40339955ab61ad6d4283	Add Column		\N	2.0.3
10	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.828969+00	427	EXECUTED	3:eeea0100df0562f3fb73fb4bd2c16102	Add Column		\N	2.0.3
11	vrumich	database/db-changelog-evolution.xml	2021-03-20 14:51:30.833022+00	428	EXECUTED	3:5c7f4a0feb690de7fcf665c4434f96e8	Add Not-Null Constraint		\N	2.0.3
2	rvillalba	database/db-changelog-evolution.xml	2021-03-20 14:51:30.837459+00	429	EXECUTED	3:c369f0277b3288f73c5e740364b9550f	Add Column		\N	2.0.3
1	i18n	database/db-changelog-i18n.xml	2021-03-20 14:51:30.893575+00	430	EXECUTED	3:bfe4a6e9cb32f020055b2793eccc4769	SQL From File		\N	2.0.3
2	i18n	database/db-changelog-i18n.xml	2021-03-20 14:51:30.945033+00	431	EXECUTED	3:923e48ffe0fe0eb8d2d978052166324d	SQL From File		\N	2.0.3
1	parameters	database/db-changelog-parameters.xml	2021-03-20 14:51:30.954532+00	432	EXECUTED	3:86de9702fdebc0f1bddd92a668f773a0	SQL From File		\N	2.0.3
1	gui_definition	database/db-changelog.xml	2021-03-20 14:51:30.977827+00	433	EXECUTED	3:e75277515da88716ae7a7c2b83613020	SQL From File		\N	2.0.3
1	mf-testing	database/db-changelog.xml	2021-03-20 14:51:30.982088+00	434	EXECUTED	3:b633b0fd7d2c7037049ef485d164d41b	SQL From File		\N	2.0.3
1	captura-demo	database/db-changelog.xml	2021-03-20 14:51:30.985765+00	435	EXECUTED	3:ac061e73a69b5c6580bc2f8730dc76b3	SQL From File		\N	2.0.3
1	deploy_counter	database/db-changelog.xml	2021-03-20 14:51:30.988967+00	436	EXECUTED	3:4c8d9a03923f50cf67ed05ba576467f3	Custom SQL		\N	2.0.3
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: queries; Type: TABLE DATA; Schema: reports; Owner: postgres
--

COPY reports.queries (id, name, form_id, default_query, selected_table_columns, selected_csv_columns, filter_options, download_locations_as_links, selected_sorting_columns, elements_file_names) FROM stdin;
\.


--
-- Data for Name: scripts; Type: TABLE DATA; Schema: scripting; Owner: postgres
--

COPY scripting.scripts (id, script_name, script_code, user_id) FROM stdin;
\.


--
-- Data for Name: acme_launchers; Type: TABLE DATA; Schema: sys; Owner: postgres
--

COPY sys.acme_launchers (id, name, launch_type, js_code, view_id, js_amd, authorization_name) FROM stdin;
4	web.home.editor	0	\N	4	\N	\N
10	web.home.admin.roles	0	\N	10	\N	application.menu.roles
12	web.home.data.import	0	\N	12	\N	application.menu.dataImport
13	web.home.data.lookup_table	0	\N	13	\N	application.menu.lookupTables
14	web.system	0	\N	14	\N	\N
15	web.home.admin.devices	0	\N	15	\N	application.menu.devices
16	web.home.acmeui	0	\N	16	\N	\N
17	web.processes.home	0	\N	17	\N	application.menu.processManager
19	web.home.usersAndGroups	0	\N	19	\N	application.menu.usersAndGroups
21	web.home.connectors	0	\N	21	\N	\N
24	web.home.myaccount	0	\N	24	\N	\N
25	web.home.application_settings	0	\N	25	\N	application.menu.config
26	web.home.admin.project.new	0	\N	26	\N	application.toolbox.project.new
27	web.home.admin.role.permission	0	\N	27	\N	\N
28	web.home.admin.project.edit	0	\N	28	\N	\N
29	web.home.admin.form.new	0	\N	29	\N	application.toolbox.form.new
30	web.home.admin.form.edit	0	\N	30	\N	\N
33	web.home.admin.group.new	0	\N	33	\N	application.toolbox.group.new
34	web.home.admin.group.edit	0	\N	34	\N	\N
35	web.home.admin.user.new	0	\N	35	\N	application.toolbox.user.new
36	web.home.admin.user.edit	0	\N	36	\N	\N
37	web.home.admin.pool.new	0	\N	37	\N	application.toolbox.pool.new
38	web.home.admin.pool.edit	0	\N	38	\N	\N
39	web.home.admin.processitem.new	0	\N	39	\N	application.toolbox.processItem.new
40	web.home.admin.processitem.edit	0	\N	40	\N	\N
41	web.home.reports	0	\N	41	\N	\N
42	web.home.reports.query	0	\N	42	\N	\N
43	web.home.uncaughtException	0	\N	43	\N	sys.menu
44	web.home.data.lookup_table_data	0	\N	44	\N	application.menu.lookupTables
1004	web.home.admin.systemParameters	0	\N	46	\N	\N
1002	web.home.admin.form.new	1	newForm	\N	home/admin/new-project-crud-amd	application.toolbox.project.new
1003	web.home.admin.pool.new	1	newProcessItem	\N	home/admin/new-pool-crud-amd	application.toolbox.pool.new
\.


--
-- Data for Name: acme_tree_menu; Type: TABLE DATA; Schema: sys; Owner: postgres
--

COPY sys.acme_tree_menu (id, i18n_title, i18n_description, toolbox, parent_id, tree_lft, tree_rgt, "position", root, launcher_id, visible, active) FROM stdin;
401	web.home.devices	web.home.devices	f	400	2	3	1	400	15	t	t
701	web.system	web.system	f	700	2	3	1	700	14	f	t
700	web.home.legacy	web.home.legacy	f	\N	1	4	6	700	\N	f	t
5004	web.home.data.import	web.home.data.import	t	5002	3	4	1	500	12	f	t
5003	web.home.data.lookup_table_data	web.home.data.lookup_table	f	5002	5	6	2	500	44	t	t
5002	web.home.data.lookup_table	web.home.data.lookup_table	f	500	2	7	2	500	13	t	t
500	web.home.connectors	web.home.connectors	f	\N	1	8	4	500	\N	t	t
3003	web.home.uncaughtException	web.home.uncaughtException	f	300	2	3	1	300	43	t	t
300	web.home.systemAdministration	web.home.systemAdministration	f	\N	1	4	3	300	\N	t	t
4021	web.usersAndGroups.toolbox.newUser	web.usersAndGroups.toolbox.newUser	t	402	5	6	1	400	35	f	t
4022	web.home.admin.user.edit	web.home.admin.user.edit	t	402	7	8	2	400	36	f	t
4023	web.usersAndGroups.toolbox.newGroup	web.usersAndGroups.toolbox.newGroup	t	402	9	10	3	400	33	f	t
4024	web.home.admin.group.edit	web.home.admin.group.edit	t	402	11	12	4	400	34	f	t
402	web.home.usersAndGroups	web.home.usersAndGroups	f	400	4	13	2	400	19	t	t
404	web.home.rolesDefinition	web.home.rolesDefinition	f	403	15	16	1	400	27	f	t
403	web.home.rolesAndPermissions	web.home.rolesAndPermissions	f	400	14	17	3	400	10	t	t
405	web.home.application_settings	web.home.application_settings	f	400	18	19	4	400	25	t	t
400	web.home.administration	web.home.administration	f	\N	1	20	2	400	\N	t	t
80001	web.processes.toolbox.newProject	web.processes.toolbox.newProject	t	80000	2	3	1	80000	26	t	t
80002	web.processes.toolbox.newForm	web.processes.toolbox.newForm	t	80000	4	5	2	80000	29	t	t
80000	web.generic.toolbox	\N	t	\N	1	6	1	80000	\N	t	t
60001	web.usersAndGroups.toolbox.newUser	web.usersAndGroups.toolbox.newUser	t	60000	2	3	1	60000	35	t	t
60002	web.usersAndGroups.toolbox.newGroup	web.usersAndGroups.toolbox.newGroup	t	60000	4	5	2	60000	33	t	t
60000	web.generic.toolbox	\N	t	\N	1	6	1	60000	\N	t	t
70001	web.home.data.import	web.home.data.import	t	70000	2	3	1	70000	12	t	t
70000	web.generic.toolbox	\N	t	\N	1	4	1	70000	\N	t	t
10001	web.processes.toolbox.newProject	web.processes.toolbox.newProject	t	10000	2	3	1	10000	26	t	t
10002	web.processes.toolbox.newForm	web.processes.toolbox.newForm	t	10000	4	5	2	10000	29	t	t
10000	web.generic.toolbox	\N	t	\N	1	6	1	10000	\N	t	t
800	web.home.myaccount	web.home.myaccount	f	\N	1	2	1	800	24	f	t
1012	web.home.admin.project.manager	web.home.admin.project.manager	t	100	6	7	2	100	28	f	t
1013	web.home.admin.form.manager	web.home.admin.form.manager	t	100	8	9	3	100	29	f	t
1014	web.home.admin.form.manager	web.home.admin.form.manager	t	100	10	11	4	100	30	f	t
1015	web.home.admin.pool.manager	web.home.admin.pool.manager	t	100	12	13	5	100	37	f	t
1016	web.home.admin.pool.manager	web.home.admin.pool.manager	t	100	14	15	6	100	38	f	t
1017	web.home.admin.processitem.manager	web.home.admin.processitem.manager	f	100	16	17	7	100	39	f	t
1018	web.home.admin.processitem.manager	web.home.admin.processitem.manager	f	100	18	19	8	100	40	f	t
1021	web.home.reports.query	web.home.reports.query	f	1020	21	22	1	100	42	f	t
1020	web.home.reports	web.home.reports	f	100	20	23	9	100	41	f	t
100	web.processes.home	web.processes.home	f	\N	1	24	1	100	17	t	t
20001	web.processes.toolbox.newProject	web.processes.toolbox.newProject	t	20000	2	3	1	20000	26	t	t
20002	web.processes.toolbox.newForm	web.processes.toolbox.newForm	t	20000	4	5	2	20000	1002	t	t
20000	web.generic.toolbox	\N	t	\N	1	6	1	20000	\N	t	t
1019	web.home.editor	web.home.editor	f	100	2	3	1	100	4	f	t
1011	web.home.admin.project.manager	web.home.admin.project.manager	t	100	4	5	1	100	26	f	t
\.


--
-- Data for Name: acme_views; Type: TABLE DATA; Schema: sys; Owner: postgres
--

COPY sys.acme_views (id, name, js_amd, url_view, toolbox_root, show_menu, show_toolbox, show_navigator, trigger_navigator_link) FROM stdin;
10	web.home.admin.roles	home/admin/role-crud-amd	/home/pages/admin/role.mob	\N	t	f	t	t
12	web.home.data.import	home/data/data-import-amd	/home/pages/data/data-import.mob	\N	t	f	t	t
14	web.system	\N	/system.mob	\N	t	f	t	t
15	web.home.admin.devices	home/v2/devices/devices-amd	/home/pages/v2/devices/devices.mob	\N	t	f	t	t
16	web.home.acmeui	ui-examples/ui-examples	/testUI/loadUIComponentExamples.mob	\N	t	f	t	t
21	web.home.connectors	home/v2/misc/not-yet-implemented-amd	/home/pages/v2/misc/not-yet-implemented.mob	\N	t	f	t	t
24	web.home.myaccount	home/my-account/my-account	/settings/my-account.mob	\N	t	f	t	t
25	web.home.application_settings	home/application/settings	/application/settings.mob	\N	t	f	t	t
27	web.home.admin.role.permission	home/admin/role-permissions-amd	/home/pages/admin/role-permissions.mob	\N	t	f	t	f
33	web.home.admin.group.new	home/v2/users-and-groups/new-group-amd	/home/pages/v2/users-and-groups/new-group.mob	\N	t	f	t	f
34	web.home.admin.group.edit	home/v2/users-and-groups/new-group-amd	/home/pages/v2/users-and-groups/edit-group.mob	\N	t	f	t	f
35	web.home.admin.user.new	home/v2/users-and-groups/new-user-amd	/home/pages/v2/users-and-groups/new-user.mob	\N	t	f	t	f
36	web.home.admin.user.edit	home/v2/users-and-groups/new-user-amd	/home/pages/v2/users-and-groups/edit-user.mob	\N	t	f	t	f
41	web.home.reports	home/reports/reports-amd	/home/pages/reports/reports.mob	\N	t	f	t	f
42	web.home.reports.query	home/reports/query-amd	/home/pages/reports/query.mob	\N	t	f	t	f
43	web.home.uncaughtException	home/sysadmin/uncaughtException-amd	/sysadmin/uncaughtException.mob	\N	t	f	t	f
44	web.home.data.lookup_table_data	home/data/lookuptable-data-amd	/home/pages/data/lookuptable-data.mob	\N	t	f	t	t
46	web.home.systemParameters	home/sysadmin/systemParameters-crud-amd	/sysadmin/systemParameters.mob	\N	t	f	t	t
17	web.processes.home	home/v2/processes/processes-amd	/home/pages/v2/processes/processes.mob	10000	t	t	t	t
26	web.home.admin.project.new	home/admin/new-project-crud-amd	/home/pages/admin/new-project-crud.mob	10000	t	t	t	f
28	web.home.admin.project.edit	home/admin/new-project-crud-amd	/home/pages/admin/edit-project-crud.mob	20000	t	t	t	f
29	web.home.admin.form.new	home/admin/new-form-crud-amd	/home/pages/admin/new-form-crud.mob	10000	t	t	t	f
30	web.home.admin.form.edit	home/admin/new-form-crud-amd	/home/pages/admin/edit-form-crud.mob	10000	t	t	t	f
37	web.home.admin.pool.new	home/admin/new-pool-crud-amd	/home/pages/admin/new-pool-crud.mob	10000	t	t	t	f
38	web.home.admin.pool.edit	home/admin/new-pool-crud-amd	/home/pages/admin/edit-pool-crud.mob	80000	t	t	t	f
39	web.home.admin.processitem.new	home/process-item/process-item-amd	/home/pages/process-item/process-item.mob	10000	t	t	t	f
40	web.home.admin.processitem.edit	home/process-item/process-item-amd	/home/pages/process-item/process-item.mob	10000	t	t	t	f
19	web.home.usersAndGroups	home/v2/users-and-groups/users-and-groups-amd	/home/pages/v2/users-and-groups/users-and-groups.mob	60000	t	t	t	t
4	web.home.editor	editor/editor-amd	/home/pages/editor.mob	\N	t	f	f	f
13	web.home.data.lookup_table	home/data/lookuptable-amd	/home/pages/data/lookuptable.mob	70000	t	t	t	t
\.


--
-- Data for Name: authorizations_groups; Type: TABLE DATA; Schema: sys; Owner: postgres
--

COPY sys.authorizations_groups (i18n_name, "position") FROM stdin;
authorizationGroup.pool	0
authorizationGroup.form	0
authorizationGroup.project	0
authorizationGroup.application	0
authorizationGroup.userAccess	0
authorizationGroup.hidden	0
authorizationGroup.connector	0
authorizationGroup.toolbox	0
authorizationGroup.menu	0
authorizationGroup.REST	0
authorizationGroup.system	0
\.


--
-- Data for Name: parameters; Type: TABLE DATA; Schema: sys; Owner: postgres
--

COPY sys.parameters (id, active, created, deleted, modified, description, label, type, value) FROM stdin;
1005	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Number of data to show during the import of a CSV file	SYS_DATAIMPORT_ROWSTOSHOW	1	10
1006	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Max Number of rows to send on each http iteration to download data 	SYS_SYNCHRONIZATION_ROWSPERITERATION	1	100
1008	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Create a test application on startup	CREATE_TEST_APP	2	true
1009	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default role assigned to an application owner	DEFAULT_ROLE_APP_OWNER	0	ROLE_APP_OWNER
1010	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default role assigned to a project owner	DEFAULT_ROLE_PROJECT_OWNER	0	ROLE_PROJECT_OWNER
1011	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default role assigned to a form owner	DEFAULT_ROLE_FORM_OWNER	0	ROLE_FORM_OWNER
1012	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default role assigned to a pool owner	DEFAULT_ROLE_POOL_OWNER	0	ROLE_POOL_OWNER
1013	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default role assigned to a member of an app	DEFAULT_ROLE_APP_MEMBER	0	ROLE_APP_MEMBER
1014	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Maximum Attempts to send a Email	MAX_ATTEMPTS_EMAIL_SEND	1	2
1016	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Whether to send the activation mail or not	SEND_ACTIVATION_MAIL_AFTER_REGISTRATION	2	true
1017	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Max number of rows on a rest API that query lookup tables	REST_LOOKUP_DATA_MAXROWS	1	1000
1018	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	The device's polling time in seconds	DEVICE_POLLING_TIME_IN_SECONDS	1	1800
1020	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	A user with authorization to see the application's settings will see "the license is about to expire", N days before the expiration date. N is defined by this parameter	ABOUT_TO_EXPIRE_NOTIFICATION	1	15
1022	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Allows to enable or disable error mail notifications, i.e. sending an email when a document was not uploaded.	SYS_NOTIFICATION_ERROR_DISABLED	2	false
1023	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Support email address. Used by the system to notify events inside the application	SYS_NOTIFICATION_SUPPORT_MAIL_ADDRESS	0	soporte@captura-forms.com
1000	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Default system language	default language	0	en
1003	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	This is used to create external URIs	SYSTEM_MAIL_ADDRESS	0	noreply@captura-forms.com
1004	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	This is used to disable or enable the user registration (false for enable registration)	SYS_REGISTRATION_DISABLED	2	true
1015	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Logout after an unexpected error	LOGOUT_AFTER_ERROR	2	true
1019	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Email to which a notification will be sent when a user registers	REGISTRATION_NOTIFICATION_MAIL	0	info@captura-forms.com
1024	t	2021-03-20 14:51:30.949481+00	f	2021-03-20 14:51:30.949481+00	Installation id (incremented every time liquibase is run) 	SYS_DEPLOY	0	1
1002	f	2021-03-20 14:51:30.949481+00	f	2023-12-09 18:22:19.199+00	This is used to create external URIs	CONTEXT_PATH	0	http://dev.sodep.com.py/fs-web/
1021	f	2021-03-20 14:51:30.949481+00	f	2023-12-09 18:22:44.44+00	URL for uploading files	UPLOAD_URL	0	http://dev.sodep.com.py:8080/fs-web/api/document/upload/file?handle={handle}
\.


--
-- Data for Name: multiselect_conf; Type: TABLE DATA; Schema: ui; Owner: postgres
--

COPY ui.multiselect_conf (id, service_name) FROM stdin;
forms	multiselect.forms
projects	multiselect.projects
pools	multiselect.pools
processItems	multiselect.processItems
users	multiselect.users
groups	multiselect.groups
roles	multiselect.roles
usersNotInGroup	multiselect.usersNotInGroup
groupsNotContainingUser	multiselect.groupsNotContainingUser
rolesNotContainingEntity	multiselect.rolesNotContainingEntity
formsPublished	multiselect.formsPublished
formsWasPublished	multiselect.formsWasPublished
applications	multiselect.applications
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

COPY workflow.states (id, active, description, form_id, name, initial, created, deleted, modified) FROM stdin;
\.


--
-- Data for Name: states_roles; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

COPY workflow.states_roles (state_id, role_id) FROM stdin;
\.


--
-- Data for Name: transitions; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

COPY workflow.transitions (id, active, description, origin_state, target_state, created, deleted, modified, form_id) FROM stdin;
\.


--
-- Data for Name: transitions_roles; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

COPY workflow.transitions_roles (transition_id, role_id) FROM stdin;
\.


--
-- Name: seq_applications; Type: SEQUENCE SET; Schema: applications; Owner: postgres
--

SELECT pg_catalog.setval('applications.seq_applications', 1, true);


--
-- Name: seq_applications_parameters; Type: SEQUENCE SET; Schema: applications; Owner: postgres
--

SELECT pg_catalog.setval('applications.seq_applications_parameters', 1, false);


--
-- Name: seq_authorizable_entities; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_authorizable_entities', 5, true);


--
-- Name: seq_authorizable_entities_authorizations; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_authorizable_entities_authorizations', 10, true);


--
-- Name: seq_authorizations; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_authorizations', 1, false);


--
-- Name: seq_brand_devices; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_brand_devices', 1, false);


--
-- Name: seq_core_roles; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_core_roles', 7, true);


--
-- Name: seq_devices; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_devices', 2, true);


--
-- Name: seq_model_devices; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_model_devices', 1, false);


--
-- Name: seq_tokens; Type: SEQUENCE SET; Schema: core; Owner: postgres
--

SELECT pg_catalog.setval('core.seq_tokens', 1, true);


--
-- Name: seq_element_instances; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_element_instances', 10, true);


--
-- Name: seq_element_prototypes; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_element_prototypes', 26, true);


--
-- Name: seq_elements_filters; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_elements_filters', 1, false);


--
-- Name: seq_flows; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_flows', 1, false);


--
-- Name: seq_flows_targets; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_flows_targets', 1, false);


--
-- Name: seq_forms; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_forms', 4, true);


--
-- Name: seq_forms_xml_cache; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_forms_xml_cache', 1, false);


--
-- Name: seq_pages; Type: SEQUENCE SET; Schema: forms; Owner: postgres
--

SELECT pg_catalog.setval('forms.seq_pages', 4, true);


--
-- Name: seq_languages; Type: SEQUENCE SET; Schema: i18n; Owner: postgres
--

SELECT pg_catalog.setval('i18n.seq_languages', 2, true);


--
-- Name: seq_logins; Type: SEQUENCE SET; Schema: log; Owner: postgres
--

SELECT pg_catalog.setval('log.seq_logins', 30, true);


--
-- Name: seq_uncaught_exceptions; Type: SEQUENCE SET; Schema: log; Owner: postgres
--

SELECT pg_catalog.setval('log.seq_uncaught_exceptions', 4, true);


--
-- Name: seq_mail_queue; Type: SEQUENCE SET; Schema: mail; Owner: postgres
--

SELECT pg_catalog.setval('mail.seq_mail_queue', 2, true);


--
-- Name: seq_connectors_id; Type: SEQUENCE SET; Schema: mf_data; Owner: postgres
--

SELECT pg_catalog.setval('mf_data.seq_connectors_id', 1, false);


--
-- Name: seq_lookuptable_id; Type: SEQUENCE SET; Schema: mf_data; Owner: postgres
--

SELECT pg_catalog.setval('mf_data.seq_lookuptable_id', 1, false);


--
-- Name: seq_uploads; Type: SEQUENCE SET; Schema: mf_data; Owner: postgres
--

SELECT pg_catalog.setval('mf_data.seq_uploads', 4, true);


--
-- Name: seq_pools; Type: SEQUENCE SET; Schema: pools; Owner: postgres
--

SELECT pg_catalog.setval('pools.seq_pools', 1, false);


--
-- Name: seq_projects; Type: SEQUENCE SET; Schema: projects; Owner: postgres
--

SELECT pg_catalog.setval('projects.seq_projects', 3, true);


--
-- Name: seq_projects_details; Type: SEQUENCE SET; Schema: projects; Owner: postgres
--

SELECT pg_catalog.setval('projects.seq_projects_details', 3, true);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- Name: seq_querys; Type: SEQUENCE SET; Schema: reports; Owner: postgres
--

SELECT pg_catalog.setval('reports.seq_querys', 1, false);


--
-- Name: seq_querys_column; Type: SEQUENCE SET; Schema: reports; Owner: postgres
--

SELECT pg_catalog.setval('reports.seq_querys_column', 1, false);


--
-- Name: seq_querys_filters; Type: SEQUENCE SET; Schema: reports; Owner: postgres
--

SELECT pg_catalog.setval('reports.seq_querys_filters', 1, false);


--
-- Name: seq_script; Type: SEQUENCE SET; Schema: scripting; Owner: postgres
--

SELECT pg_catalog.setval('scripting.seq_script', 1, false);


--
-- Name: seq_acme_launchers; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_acme_launchers', 1004, true);


--
-- Name: seq_acme_module; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_acme_module', 1, false);


--
-- Name: seq_acme_tree_menu; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_acme_tree_menu', 80002, true);


--
-- Name: seq_acme_views; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_acme_views', 46, true);


--
-- Name: seq_deploy; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_deploy', 1, true);


--
-- Name: seq_parameters; Type: SEQUENCE SET; Schema: sys; Owner: postgres
--

SELECT pg_catalog.setval('sys.seq_parameters', 1050, false);


--
-- Name: seq_states; Type: SEQUENCE SET; Schema: workflow; Owner: postgres
--

SELECT pg_catalog.setval('workflow.seq_states', 1, false);


--
-- Name: seq_transitions; Type: SEQUENCE SET; Schema: workflow; Owner: postgres
--

SELECT pg_catalog.setval('workflow.seq_transitions', 1, false);


--
-- Name: application_users application_users_pkey; Type: CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.application_users
    ADD CONSTRAINT application_users_pkey PRIMARY KEY (user_id, application_id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: parameters pk_applications_parameters; Type: CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.parameters
    ADD CONSTRAINT pk_applications_parameters PRIMARY KEY (id);


--
-- Name: parameters unique_parameter_id_application_id; Type: CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.parameters
    ADD CONSTRAINT unique_parameter_id_application_id UNIQUE (parameter_id, application_id);


--
-- Name: authorizable_entities_authorizations authorizable_entities_authorizations_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizable_entities_authorizations
    ADD CONSTRAINT authorizable_entities_authorizations_pkey PRIMARY KEY (id);


--
-- Name: authorizable_entities authorizable_entities_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizable_entities
    ADD CONSTRAINT authorizable_entities_pkey PRIMARY KEY (id);


--
-- Name: authorization_dependencies authorization_dependencies_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorization_dependencies
    ADD CONSTRAINT authorization_dependencies_pkey PRIMARY KEY (base_auth, granted_auth);


--
-- Name: authorizations authorizations_name_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizations
    ADD CONSTRAINT authorizations_name_key UNIQUE (name);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: authorizations pk_authorizations; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizations
    ADD CONSTRAINT pk_authorizations PRIMARY KEY (name);


--
-- Name: roles pk_roles; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (id);


--
-- Name: tokens pk_tokens; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tokens
    ADD CONSTRAINT pk_tokens PRIMARY KEY (id);


--
-- Name: role_grants_authorization role_grants_authorization_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.role_grants_authorization
    ADD CONSTRAINT role_grants_authorization_pkey PRIMARY KEY (role_id, authorization_name);


--
-- Name: devices unique_device; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.devices
    ADD CONSTRAINT unique_device UNIQUE (model, brand, os, identifier, application_id);


--
-- Name: users users_mail_key; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users
    ADD CONSTRAINT users_mail_key UNIQUE (mail);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: element_instances element_instances_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_instances
    ADD CONSTRAINT element_instances_pkey PRIMARY KEY (id);


--
-- Name: element_prototypes element_prototypes_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_prototypes
    ADD CONSTRAINT element_prototypes_pkey PRIMARY KEY (id);


--
-- Name: elements_barcodes elements_barcodes_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_barcodes
    ADD CONSTRAINT elements_barcodes_pkey PRIMARY KEY (id);


--
-- Name: elements_checkboxes elements_checkboxes_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_checkboxes
    ADD CONSTRAINT elements_checkboxes_pkey PRIMARY KEY (id);


--
-- Name: elements_inputs elements_inputs_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_inputs
    ADD CONSTRAINT elements_inputs_pkey PRIMARY KEY (id);


--
-- Name: elements_labels elements_labels_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_labels
    ADD CONSTRAINT elements_labels_pkey PRIMARY KEY (element_id, language);


--
-- Name: elements_locations elements_locations_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_locations
    ADD CONSTRAINT elements_locations_pkey PRIMARY KEY (id);


--
-- Name: elements_photos elements_photos_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_photos
    ADD CONSTRAINT elements_photos_pkey PRIMARY KEY (id);


--
-- Name: elements_selects elements_selects_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_selects
    ADD CONSTRAINT elements_selects_pkey PRIMARY KEY (id);


--
-- Name: elements_signatures elements_signatures_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_signatures
    ADD CONSTRAINT elements_signatures_pkey PRIMARY KEY (id);


--
-- Name: elements_headlines elements_texts_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_headlines
    ADD CONSTRAINT elements_texts_pkey PRIMARY KEY (id);


--
-- Name: flows flows_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.flows
    ADD CONSTRAINT flows_pkey PRIMARY KEY (id);


--
-- Name: flows_targets flows_targets_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.flows_targets
    ADD CONSTRAINT flows_targets_pkey PRIMARY KEY (id);


--
-- Name: form_xml_cache form_xml_cache_form_id_key; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.form_xml_cache
    ADD CONSTRAINT form_xml_cache_form_id_key UNIQUE (form_id);


--
-- Name: form_xml_cache form_xml_cache_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.form_xml_cache
    ADD CONSTRAINT form_xml_cache_pkey PRIMARY KEY (id);


--
-- Name: form_xml_cache_xml form_xml_cache_xml_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.form_xml_cache_xml
    ADD CONSTRAINT form_xml_cache_xml_pkey PRIMARY KEY (form_xml_cache_id, language);


--
-- Name: forms_labels forms_labels_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms_labels
    ADD CONSTRAINT forms_labels_pkey PRIMARY KEY (form_id, language);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: forms forms_root_id_version_key; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms
    ADD CONSTRAINT forms_root_id_version_key UNIQUE (root_id, version);


--
-- Name: pages pages_flow_id_key; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages
    ADD CONSTRAINT pages_flow_id_key UNIQUE (flow_id);


--
-- Name: pages_labels pages_labels_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages_labels
    ADD CONSTRAINT pages_labels_pkey PRIMARY KEY (page_id, language);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: elements_filters pk_elements_filters; Type: CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_filters
    ADD CONSTRAINT pk_elements_filters PRIMARY KEY (id);


--
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: i18n; Owner: postgres
--

ALTER TABLE ONLY i18n.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (language_id, key);


--
-- Name: languages languages_iso_language_key; Type: CONSTRAINT; Schema: i18n; Owner: postgres
--

ALTER TABLE ONLY i18n.languages
    ADD CONSTRAINT languages_iso_language_key UNIQUE (iso_language);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: i18n; Owner: postgres
--

ALTER TABLE ONLY i18n.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: logins logins_pkey; Type: CONSTRAINT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.logins
    ADD CONSTRAINT logins_pkey PRIMARY KEY (id);


--
-- Name: uncaught_exceptions uncaught_exceptions_pkey; Type: CONSTRAINT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.uncaught_exceptions
    ADD CONSTRAINT uncaught_exceptions_pkey PRIMARY KEY (id);


--
-- Name: queue queue_pkey; Type: CONSTRAINT; Schema: mail; Owner: postgres
--

ALTER TABLE ONLY mail.queue
    ADD CONSTRAINT queue_pkey PRIMARY KEY (id);


--
-- Name: connectors connectors_pkey; Type: CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.connectors
    ADD CONSTRAINT connectors_pkey PRIMARY KEY (id);


--
-- Name: uploads pk_data_uploads; Type: CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.uploads
    ADD CONSTRAINT pk_data_uploads PRIMARY KEY (id);


--
-- Name: lookuptables pk_lookuptable; Type: CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.lookuptables
    ADD CONSTRAINT pk_lookuptable PRIMARY KEY (id);


--
-- Name: uploads unique_document_upload; Type: CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.uploads
    ADD CONSTRAINT unique_document_upload UNIQUE (user_id, device_id, document_id);


--
-- Name: pools pools_pkey; Type: CONSTRAINT; Schema: pools; Owner: postgres
--

ALTER TABLE ONLY pools.pools
    ADD CONSTRAINT pools_pkey PRIMARY KEY (id);


--
-- Name: projects_details projects_details_pkey; Type: CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects_details
    ADD CONSTRAINT projects_details_pkey PRIMARY KEY (id);


--
-- Name: projects_details projects_details_project_id_language_label_key; Type: CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects_details
    ADD CONSTRAINT projects_details_project_id_language_label_key UNIQUE (project_id, language, label);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: databasechangelog pk_databasechangelog; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangelog
    ADD CONSTRAINT pk_databasechangelog PRIMARY KEY (id, author, filename);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: queries querys_id_pkey; Type: CONSTRAINT; Schema: reports; Owner: postgres
--

ALTER TABLE ONLY reports.queries
    ADD CONSTRAINT querys_id_pkey PRIMARY KEY (id);


--
-- Name: scripts scripts_pkey; Type: CONSTRAINT; Schema: scripting; Owner: postgres
--

ALTER TABLE ONLY scripting.scripts
    ADD CONSTRAINT scripts_pkey PRIMARY KEY (id);


--
-- Name: authorizations_groups authorizations_groups_pkey; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.authorizations_groups
    ADD CONSTRAINT authorizations_groups_pkey PRIMARY KEY (i18n_name);


--
-- Name: parameters parameters_pkey; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.parameters
    ADD CONSTRAINT parameters_pkey PRIMARY KEY (id);


--
-- Name: acme_launchers pk_acme_launcher; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_launchers
    ADD CONSTRAINT pk_acme_launcher PRIMARY KEY (id);


--
-- Name: acme_tree_menu pk_acme_modules; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_tree_menu
    ADD CONSTRAINT pk_acme_modules PRIMARY KEY (id);


--
-- Name: acme_views pk_acme_views; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_views
    ADD CONSTRAINT pk_acme_views PRIMARY KEY (id);


--
-- Name: acme_launchers unique_acme_launchers_view; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_launchers
    ADD CONSTRAINT unique_acme_launchers_view UNIQUE (view_id);


--
-- Name: authorizations_groups unique_name_authorizations_groups; Type: CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.authorizations_groups
    ADD CONSTRAINT unique_name_authorizations_groups UNIQUE (i18n_name);


--
-- Name: multiselect_conf pk_multiselect_conf; Type: CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.multiselect_conf
    ADD CONSTRAINT pk_multiselect_conf PRIMARY KEY (id);


--
-- Name: states pk_states; Type: CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.states
    ADD CONSTRAINT pk_states PRIMARY KEY (id);


--
-- Name: states_roles pk_states_roles; Type: CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.states_roles
    ADD CONSTRAINT pk_states_roles PRIMARY KEY (state_id, role_id);


--
-- Name: transitions pk_transitions; Type: CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.transitions
    ADD CONSTRAINT pk_transitions PRIMARY KEY (id);


--
-- Name: transitions_roles pk_transitions_roles; Type: CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.transitions_roles
    ADD CONSTRAINT pk_transitions_roles PRIMARY KEY (transition_id, role_id);


--
-- Name: upload_application_ix; Type: INDEX; Schema: mf_data; Owner: postgres
--

CREATE INDEX upload_application_ix ON mf_data.uploads USING btree (application_id);


--
-- Name: user_device_ix; Type: INDEX; Schema: mf_data; Owner: postgres
--

CREATE INDEX user_device_ix ON mf_data.uploads USING btree (device_id, user_id);


--
-- Name: applications fk37dca5237e8074d6; Type: FK CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.applications
    ADD CONSTRAINT fk37dca5237e8074d6 FOREIGN KEY (owner_id) REFERENCES core.users(id);


--
-- Name: application_users fk_applications_users_applications; Type: FK CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.application_users
    ADD CONSTRAINT fk_applications_users_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: application_users fk_applications_users_users; Type: FK CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.application_users
    ADD CONSTRAINT fk_applications_users_users FOREIGN KEY (user_id) REFERENCES core.users(id);


--
-- Name: parameters fk_parameters_applications; Type: FK CONSTRAINT; Schema: applications; Owner: postgres
--

ALTER TABLE ONLY applications.parameters
    ADD CONSTRAINT fk_parameters_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: users fk6a68e0873d0bfd8; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users
    ADD CONSTRAINT fk6a68e0873d0bfd8 FOREIGN KEY (id) REFERENCES core.authorizable_entities(id);


--
-- Name: authorizations fk_authorization_group; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizations
    ADD CONSTRAINT fk_authorization_group FOREIGN KEY (auth_group) REFERENCES sys.authorizations_groups(i18n_name);


--
-- Name: devices fk_device_applications; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.devices
    ADD CONSTRAINT fk_device_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: users_devices fk_devices_users_devices; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users_devices
    ADD CONSTRAINT fk_devices_users_devices FOREIGN KEY (device_id) REFERENCES core.devices(id);


--
-- Name: users_devices fk_devices_users_users; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users_devices
    ADD CONSTRAINT fk_devices_users_users FOREIGN KEY (user_id) REFERENCES core.users(id);


--
-- Name: groups fk_groups_applications; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.groups
    ADD CONSTRAINT fk_groups_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: tokens fk_tokens_applications; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tokens
    ADD CONSTRAINT fk_tokens_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: tokens fk_tokens_grantee; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tokens
    ADD CONSTRAINT fk_tokens_grantee FOREIGN KEY (grantee_id) REFERENCES core.users(id);


--
-- Name: tokens fk_tokens_granter; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.tokens
    ADD CONSTRAINT fk_tokens_granter FOREIGN KEY (granter_id) REFERENCES core.users(id);


--
-- Name: groups fkb63dd9d473d0bfd8; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.groups
    ADD CONSTRAINT fkb63dd9d473d0bfd8 FOREIGN KEY (id) REFERENCES core.authorizable_entities(id);


--
-- Name: authorizable_entities_authorizations fkf0a0cd6f8ab7080b; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.authorizable_entities_authorizations
    ADD CONSTRAINT fkf0a0cd6f8ab7080b FOREIGN KEY (authorizable_entity_id) REFERENCES core.authorizable_entities(id);


--
-- Name: groups_users fkf4231bdd1299c4be; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.groups_users
    ADD CONSTRAINT fkf4231bdd1299c4be FOREIGN KEY (user_id) REFERENCES core.users(id);


--
-- Name: groups_users fkf4231bdd6de4def6; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.groups_users
    ADD CONSTRAINT fkf4231bdd6de4def6 FOREIGN KEY (group_id) REFERENCES core.groups(id);


--
-- Name: users users_default_application; Type: FK CONSTRAINT; Schema: core; Owner: postgres
--

ALTER TABLE ONLY core.users
    ADD CONSTRAINT users_default_application FOREIGN KEY (default_application) REFERENCES applications.applications(id);


--
-- Name: element_prototypes element_prototype_application_pk; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_prototypes
    ADD CONSTRAINT element_prototype_application_pk FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: elements_barcodes elements_barcodes_fk; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_barcodes
    ADD CONSTRAINT elements_barcodes_fk FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: elements_checkboxes elements_checkboxes_fk; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_checkboxes
    ADD CONSTRAINT elements_checkboxes_fk FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: elements_signatures elements_signatures_fk; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_signatures
    ADD CONSTRAINT elements_signatures_fk FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: elements_headlines elements_texts_element_prototypes; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_headlines
    ADD CONSTRAINT elements_texts_element_prototypes FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: elements_photos fk12e610c94f6a35ee; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_photos
    ADD CONSTRAINT fk12e610c94f6a35ee FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: forms_languages fk1e10300b1fadaa84; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms_languages
    ADD CONSTRAINT fk1e10300b1fadaa84 FOREIGN KEY (form_id) REFERENCES forms.forms(id);


--
-- Name: element_instances fk24328cfb4e47fe8f; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_instances
    ADD CONSTRAINT fk24328cfb4e47fe8f FOREIGN KEY (page_id) REFERENCES forms.pages(id);


--
-- Name: element_instances fk24328cfbed9dca2b; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_instances
    ADD CONSTRAINT fk24328cfbed9dca2b FOREIGN KEY (prototype_id) REFERENCES forms.element_prototypes(id);


--
-- Name: elements_locations fk2e1e8a164f6a35ee; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_locations
    ADD CONSTRAINT fk2e1e8a164f6a35ee FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: flows_targets fk3010b7c85083862f; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.flows_targets
    ADD CONSTRAINT fk3010b7c85083862f FOREIGN KEY (flow_id) REFERENCES forms.flows(id);


--
-- Name: form_xml_cache_xml fk3d472f776d9c994; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.form_xml_cache_xml
    ADD CONSTRAINT fk3d472f776d9c994 FOREIGN KEY (form_xml_cache_id) REFERENCES forms.form_xml_cache(id);


--
-- Name: forms fk5d18c2fa792579a; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms
    ADD CONSTRAINT fk5d18c2fa792579a FOREIGN KEY (root_id) REFERENCES forms.forms(id);


--
-- Name: forms fk5d18c2fe183ca11; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms
    ADD CONSTRAINT fk5d18c2fe183ca11 FOREIGN KEY (project_id) REFERENCES projects.projects(id);


--
-- Name: pages fk657efc41fadaa84; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages
    ADD CONSTRAINT fk657efc41fadaa84 FOREIGN KEY (form_id) REFERENCES forms.forms(id);


--
-- Name: pages fk657efc45083862f; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages
    ADD CONSTRAINT fk657efc45083862f FOREIGN KEY (flow_id) REFERENCES forms.flows(id);


--
-- Name: elements_inputs fk7492a314f6a35ee; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_inputs
    ADD CONSTRAINT fk7492a314f6a35ee FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: forms_labels fk93308e0f1fadaa84; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.forms_labels
    ADD CONSTRAINT fk93308e0f1fadaa84 FOREIGN KEY (form_id) REFERENCES forms.forms(id);


--
-- Name: form_xml_cache fk96bd179f1fadaa84; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.form_xml_cache
    ADD CONSTRAINT fk96bd179f1fadaa84 FOREIGN KEY (form_id) REFERENCES forms.forms(id);


--
-- Name: pages_labels fk9a53e8da4e47fe8f; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.pages_labels
    ADD CONSTRAINT fk9a53e8da4e47fe8f FOREIGN KEY (page_id) REFERENCES forms.pages(id);


--
-- Name: elements_filters fk_elements_filters_elements; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_filters
    ADD CONSTRAINT fk_elements_filters_elements FOREIGN KEY (element_instance_id) REFERENCES forms.element_instances(id);


--
-- Name: elements_labels fkba9e84771be4a11; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_labels
    ADD CONSTRAINT fkba9e84771be4a11 FOREIGN KEY (element_id) REFERENCES forms.element_prototypes(id);


--
-- Name: element_prototypes fkd9f0c0b4c8143202; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.element_prototypes
    ADD CONSTRAINT fkd9f0c0b4c8143202 FOREIGN KEY (pool_id) REFERENCES pools.pools(id);


--
-- Name: elements_selects fke33eebaf4f6a35ee; Type: FK CONSTRAINT; Schema: forms; Owner: postgres
--

ALTER TABLE ONLY forms.elements_selects
    ADD CONSTRAINT fke33eebaf4f6a35ee FOREIGN KEY (id) REFERENCES forms.element_prototypes(id);


--
-- Name: labels fkbdd05fffa100b5bd; Type: FK CONSTRAINT; Schema: i18n; Owner: postgres
--

ALTER TABLE ONLY i18n.labels
    ADD CONSTRAINT fkbdd05fffa100b5bd FOREIGN KEY (language_id) REFERENCES i18n.languages(id);


--
-- Name: connectors fk_connectors_application; Type: FK CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.connectors
    ADD CONSTRAINT fk_connectors_application FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: connectors fk_devices_users_users; Type: FK CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.connectors
    ADD CONSTRAINT fk_devices_users_users FOREIGN KEY (user_id) REFERENCES core.users(id);


--
-- Name: lookuptables fk_lookuptable_application; Type: FK CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.lookuptables
    ADD CONSTRAINT fk_lookuptable_application FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: lookuptables fk_lookuptable_project; Type: FK CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.lookuptables
    ADD CONSTRAINT fk_lookuptable_project FOREIGN KEY (project_id) REFERENCES projects.projects(id);


--
-- Name: lookuptables fk_lookuptables_owner; Type: FK CONSTRAINT; Schema: mf_data; Owner: postgres
--

ALTER TABLE ONLY mf_data.lookuptables
    ADD CONSTRAINT fk_lookuptables_owner FOREIGN KEY (owner_id) REFERENCES core.users(id);


--
-- Name: pools fk_pool_owner_id; Type: FK CONSTRAINT; Schema: pools; Owner: postgres
--

ALTER TABLE ONLY pools.pools
    ADD CONSTRAINT fk_pool_owner_id FOREIGN KEY (owner_id) REFERENCES core.users(id);


--
-- Name: pools fk_pools_applications; Type: FK CONSTRAINT; Schema: pools; Owner: postgres
--

ALTER TABLE ONLY pools.pools
    ADD CONSTRAINT fk_pools_applications FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: projects_details fk37e6977de183ca11; Type: FK CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects_details
    ADD CONSTRAINT fk37e6977de183ca11 FOREIGN KEY (project_id) REFERENCES projects.projects(id);


--
-- Name: projects fkc479187a7e8074d6; Type: FK CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects
    ADD CONSTRAINT fkc479187a7e8074d6 FOREIGN KEY (owner_id) REFERENCES core.users(id);


--
-- Name: projects fkc479187aaee64511; Type: FK CONSTRAINT; Schema: projects; Owner: postgres
--

ALTER TABLE ONLY projects.projects
    ADD CONSTRAINT fkc479187aaee64511 FOREIGN KEY (application_id) REFERENCES applications.applications(id);


--
-- Name: queries fk_reports_form_id; Type: FK CONSTRAINT; Schema: reports; Owner: postgres
--

ALTER TABLE ONLY reports.queries
    ADD CONSTRAINT fk_reports_form_id FOREIGN KEY (form_id) REFERENCES forms.forms(id);


--
-- Name: scripts fk72d449081299c4be; Type: FK CONSTRAINT; Schema: scripting; Owner: postgres
--

ALTER TABLE ONLY scripting.scripts
    ADD CONSTRAINT fk72d449081299c4be FOREIGN KEY (user_id) REFERENCES core.users(id);


--
-- Name: acme_views fk_acme_views; Type: FK CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_views
    ADD CONSTRAINT fk_acme_views FOREIGN KEY (toolbox_root) REFERENCES sys.acme_tree_menu(id);


--
-- Name: acme_launchers fk_launcher_view; Type: FK CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_launchers
    ADD CONSTRAINT fk_launcher_view FOREIGN KEY (view_id) REFERENCES sys.acme_views(id);


--
-- Name: acme_tree_menu fk_treemenu_module; Type: FK CONSTRAINT; Schema: sys; Owner: postgres
--

ALTER TABLE ONLY sys.acme_tree_menu
    ADD CONSTRAINT fk_treemenu_module FOREIGN KEY (launcher_id) REFERENCES sys.acme_launchers(id);


--
-- Name: states_roles fk_states_roles_state_id; Type: FK CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.states_roles
    ADD CONSTRAINT fk_states_roles_state_id FOREIGN KEY (state_id) REFERENCES workflow.states(id);


--
-- Name: transitions fk_transitions_origin_state; Type: FK CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.transitions
    ADD CONSTRAINT fk_transitions_origin_state FOREIGN KEY (origin_state) REFERENCES workflow.states(id);


--
-- Name: transitions_roles fk_transitions_roles_transition_id; Type: FK CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.transitions_roles
    ADD CONSTRAINT fk_transitions_roles_transition_id FOREIGN KEY (transition_id) REFERENCES workflow.transitions(id);


--
-- Name: transitions fk_transitions_target_state; Type: FK CONSTRAINT; Schema: workflow; Owner: postgres
--

ALTER TABLE ONLY workflow.transitions
    ADD CONSTRAINT fk_transitions_target_state FOREIGN KEY (target_state) REFERENCES workflow.states(id);


--
-- PostgreSQL database dump complete
--

