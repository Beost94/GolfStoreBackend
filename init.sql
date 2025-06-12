--
-- PostgreSQL database dump
--

-- Dumped from database version 17.3
-- Dumped by pg_dump version 17.3

-- Started on 2025-06-12 21:19:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 60887)
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA keycloak;


ALTER SCHEMA keycloak OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 241 (class 1259 OID 60888)
-- Name: admin_event_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE keycloak.admin_event_entity OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 60893)
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.associated_policy OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 60896)
-- Name: authentication_execution; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE keycloak.authentication_execution OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 60900)
-- Name: authentication_flow; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.authentication_flow OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 60908)
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.authenticator_config OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 60911)
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 60916)
-- Name: broker_link; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE keycloak.broker_link OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 60921)
-- Name: client; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 60939)
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.client_attributes OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 60944)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 60947)
-- Name: client_initial_access; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE keycloak.client_initial_access OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 60950)
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_node_registrations OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 60953)
-- Name: client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE keycloak.client_scope OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 60958)
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 60963)
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client_scope_client OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 60969)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 60972)
-- Name: client_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE keycloak.client_session OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 60977)
-- Name: client_session_auth_status; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 60980)
-- Name: client_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_note OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 60985)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 60988)
-- Name: client_session_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_role OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 60991)
-- Name: client_user_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_user_session_note OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 60996)
-- Name: component; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE keycloak.component OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 61001)
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.component_config OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 61006)
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE keycloak.composite_role OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 61009)
-- Name: credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.credential OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 61014)
-- Name: databasechangelog; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE keycloak.databasechangelog OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 61019)
-- Name: databasechangeloglock; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE keycloak.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 61022)
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.default_client_scope OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 61026)
-- Name: event_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE keycloak.event_entity OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 61031)
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE keycloak.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 61036)
-- Name: fed_user_consent; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.fed_user_consent OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 61041)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 61044)
-- Name: fed_user_credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.fed_user_credential OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 61049)
-- Name: fed_user_group_membership; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 61052)
-- Name: fed_user_required_action; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 61058)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 61061)
-- Name: federated_identity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_identity OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 61066)
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_user OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 61071)
-- Name: group_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_attribute OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 61077)
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_role_mapping OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 61080)
-- Name: identity_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.identity_provider OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 61091)
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.identity_provider_config OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 61096)
-- Name: identity_provider_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 61101)
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 61106)
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE keycloak.keycloak_group OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 61109)
-- Name: keycloak_role; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE keycloak.keycloak_role OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 61115)
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.migration_model OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 61119)
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE keycloak.offline_client_session OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 61126)
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.offline_user_session OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 61132)
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.policy_config OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 61137)
-- Name: protocol_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE keycloak.protocol_mapper OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 61142)
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 61147)
-- Name: realm; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE keycloak.realm OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 61180)
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE keycloak.realm_attribute OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 61185)
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_default_groups OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 61188)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 61191)
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 61194)
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE keycloak.realm_localizations OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 61199)
-- Name: realm_required_credential; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_required_credential OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 61206)
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 61211)
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 61214)
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.redirect_uris OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 61217)
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.required_action_config OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 61222)
-- Name: required_action_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE keycloak.required_action_provider OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 61229)
-- Name: resource_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_attribute OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 61235)
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_policy OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 61238)
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_scope OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 61241)
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE keycloak.resource_server OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 61246)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE keycloak.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 61251)
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE keycloak.resource_server_policy OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 61256)
-- Name: resource_server_resource; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_resource OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 61262)
-- Name: resource_server_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_scope OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 61267)
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.resource_uris OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 61270)
-- Name: role_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE keycloak.role_attribute OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 61275)
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_mapping OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 61278)
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_policy OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 61281)
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE keycloak.user_attribute OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 61287)
-- Name: user_consent; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.user_consent OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 61292)
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 61295)
-- Name: user_entity; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.user_entity OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 61303)
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_config OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 61308)
-- Name: user_federation_mapper; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 61313)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 61318)
-- Name: user_federation_provider; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.user_federation_provider OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 61323)
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_group_membership OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 61326)
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE keycloak.user_required_action OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 61330)
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_role_mapping OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 61333)
-- Name: user_session; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE keycloak.user_session OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 61339)
-- Name: user_session_note; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE keycloak.user_session_note OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 61344)
-- Name: username_login_failure; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE keycloak.username_login_failure OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 61349)
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: postgres
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.web_origins OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 54272)
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    brandid integer NOT NULL,
    brand_name character varying(50)
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 54275)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    categoryid integer NOT NULL,
    category character varying(50),
    parent_categoryid integer
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 54278)
-- Name: category_filter_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_filter_options (
    category_filter_optionsid integer NOT NULL,
    filter_optionid integer,
    categoryid integer
);


ALTER TABLE public.category_filter_options OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 54281)
-- Name: category_filter_options_category_filter_optionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_filter_options_category_filter_optionsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_filter_options_category_filter_optionsid_seq OWNER TO postgres;

--
-- TOC entry 5891 (class 0 OID 0)
-- Dependencies: 221
-- Name: category_filter_options_category_filter_optionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_filter_options_category_filter_optionsid_seq OWNED BY public.category_filter_options.category_filter_optionsid;


--
-- TOC entry 222 (class 1259 OID 54282)
-- Name: filter_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filter_options (
    filter_optionid integer NOT NULL,
    filter_name character varying(50),
    is_main_attribute boolean DEFAULT false
);


ALTER TABLE public.filter_options OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 54285)
-- Name: filter_options_filter_optionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filter_options_filter_optionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_options_filter_optionid_seq OWNER TO postgres;

--
-- TOC entry 5892 (class 0 OID 0)
-- Dependencies: 223
-- Name: filter_options_filter_optionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filter_options_filter_optionid_seq OWNED BY public.filter_options.filter_optionid;


--
-- TOC entry 224 (class 1259 OID 54286)
-- Name: filter_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filter_values (
    filter_valueid integer NOT NULL,
    filter_optionid integer,
    filter_value character varying(50)
);


ALTER TABLE public.filter_values OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 54289)
-- Name: filter_values_filter_valueid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filter_values_filter_valueid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filter_values_filter_valueid_seq OWNER TO postgres;

--
-- TOC entry 5893 (class 0 OID 0)
-- Dependencies: 225
-- Name: filter_values_filter_valueid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filter_values_filter_valueid_seq OWNED BY public.filter_values.filter_valueid;


--
-- TOC entry 226 (class 1259 OID 54290)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    imageid integer NOT NULL,
    imageurl text,
    productid integer
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 54295)
-- Name: images_imageid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_imageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_imageid_seq OWNER TO postgres;

--
-- TOC entry 5894 (class 0 OID 0)
-- Dependencies: 227
-- Name: images_imageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_imageid_seq OWNED BY public.images.imageid;


--
-- TOC entry 228 (class 1259 OID 54296)
-- Name: merker_merkeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.merker_merkeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.merker_merkeid_seq OWNER TO postgres;

--
-- TOC entry 5895 (class 0 OID 0)
-- Dependencies: 228
-- Name: merker_merkeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.merker_merkeid_seq OWNED BY public.brand.brandid;


--
-- TOC entry 229 (class 1259 OID 54297)
-- Name: product_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_variants (
    variantid integer NOT NULL,
    productid integer
);


ALTER TABLE public.product_variants OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 54300)
-- Name: product_variants_variantid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_variants_variantid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_variants_variantid_seq OWNER TO postgres;

--
-- TOC entry 5896 (class 0 OID 0)
-- Dependencies: 230
-- Name: product_variants_variantid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_variants_variantid_seq OWNED BY public.product_variants.variantid;


--
-- TOC entry 231 (class 1259 OID 54301)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    productid integer NOT NULL,
    productname character varying NOT NULL,
    price numeric NOT NULL,
    categoryid integer,
    description text,
    brandid integer,
    has_variants boolean,
    CONSTRAINT products_price_check CHECK ((price >= (0)::numeric))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 54307)
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_productid_seq OWNER TO postgres;

--
-- TOC entry 5897 (class 0 OID 0)
-- Dependencies: 232
-- Name: products_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_productid_seq OWNED BY public.products.productid;


--
-- TOC entry 233 (class 1259 OID 54308)
-- Name: productstock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productstock (
    stockid integer NOT NULL,
    productid integer NOT NULL,
    variantid integer,
    stockcount integer NOT NULL
);


ALTER TABLE public.productstock OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 54311)
-- Name: productstock_stockid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productstock_stockid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productstock_stockid_seq OWNER TO postgres;

--
-- TOC entry 5898 (class 0 OID 0)
-- Dependencies: 234
-- Name: productstock_stockid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productstock_stockid_seq OWNED BY public.productstock.stockid;


--
-- TOC entry 235 (class 1259 OID 54312)
-- Name: shoppingcart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shoppingcart (
    shoppingcartid integer NOT NULL,
    keycloakid uuid NOT NULL
);


ALTER TABLE public.shoppingcart OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 54315)
-- Name: shoppingcart_shoppingcartid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shoppingcart_shoppingcartid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shoppingcart_shoppingcartid_seq OWNER TO postgres;

--
-- TOC entry 5899 (class 0 OID 0)
-- Dependencies: 236
-- Name: shoppingcart_shoppingcartid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shoppingcart_shoppingcartid_seq OWNED BY public.shoppingcart.shoppingcartid;


--
-- TOC entry 237 (class 1259 OID 54316)
-- Name: shoppingcartitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shoppingcartitems (
    shoppingcartid integer NOT NULL,
    variantid integer NOT NULL,
    amount integer NOT NULL
);


ALTER TABLE public.shoppingcartitems OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 54319)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    keycloakid uuid NOT NULL,
    email character varying(50),
    firstname character varying(50),
    lastname character varying(50),
    adress character varying(50),
    phone character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 54322)
-- Name: variant_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variant_attributes (
    variant_attributeid integer NOT NULL,
    variantid integer,
    filter_optionid integer,
    filter_valueid integer
);


ALTER TABLE public.variant_attributes OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 54325)
-- Name: variant_attributes_variant_attributeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variant_attributes_variant_attributeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variant_attributes_variant_attributeid_seq OWNER TO postgres;

--
-- TOC entry 5900 (class 0 OID 0)
-- Dependencies: 240
-- Name: variant_attributes_variant_attributeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variant_attributes_variant_attributeid_seq OWNED BY public.variant_attributes.variant_attributeid;


--
-- TOC entry 5121 (class 2604 OID 54326)
-- Name: brand brandid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand ALTER COLUMN brandid SET DEFAULT nextval('public.merker_merkeid_seq'::regclass);


--
-- TOC entry 5122 (class 2604 OID 54327)
-- Name: category_filter_options category_filter_optionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_filter_options ALTER COLUMN category_filter_optionsid SET DEFAULT nextval('public.category_filter_options_category_filter_optionsid_seq'::regclass);


--
-- TOC entry 5123 (class 2604 OID 54328)
-- Name: filter_options filter_optionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_options ALTER COLUMN filter_optionid SET DEFAULT nextval('public.filter_options_filter_optionid_seq'::regclass);


--
-- TOC entry 5125 (class 2604 OID 54329)
-- Name: filter_values filter_valueid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_values ALTER COLUMN filter_valueid SET DEFAULT nextval('public.filter_values_filter_valueid_seq'::regclass);


--
-- TOC entry 5126 (class 2604 OID 54330)
-- Name: images imageid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN imageid SET DEFAULT nextval('public.images_imageid_seq'::regclass);


--
-- TOC entry 5127 (class 2604 OID 54331)
-- Name: product_variants variantid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN variantid SET DEFAULT nextval('public.product_variants_variantid_seq'::regclass);


--
-- TOC entry 5128 (class 2604 OID 54332)
-- Name: products productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN productid SET DEFAULT nextval('public.products_productid_seq'::regclass);


--
-- TOC entry 5129 (class 2604 OID 54333)
-- Name: productstock stockid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productstock ALTER COLUMN stockid SET DEFAULT nextval('public.productstock_stockid_seq'::regclass);


--
-- TOC entry 5130 (class 2604 OID 54334)
-- Name: shoppingcart shoppingcartid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart ALTER COLUMN shoppingcartid SET DEFAULT nextval('public.shoppingcart_shoppingcartid_seq'::regclass);


--
-- TOC entry 5131 (class 2604 OID 54335)
-- Name: variant_attributes variant_attributeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_attributes ALTER COLUMN variant_attributeid SET DEFAULT nextval('public.variant_attributes_variant_attributeid_seq'::regclass);


--
-- TOC entry 5794 (class 0 OID 60888)
-- Dependencies: 241
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 5795 (class 0 OID 60893)
-- Dependencies: 242
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.associated_policy (policy_id, associated_policy_id) FROM stdin;
28fb5e66-76ce-449b-bc7f-4b795ca3433c	d9e1d0e4-e798-4958-bcbd-082729c1a5c3
\.


--
-- TOC entry 5796 (class 0 OID 60896)
-- Dependencies: 243
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
656ffc13-d06d-4d96-aefa-6edf7d4d0704	\N	auth-cookie	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f23e1bd5-f288-4b7b-94bf-c046d61f9d46	2	10	f	\N	\N
dc39b587-c662-4a1e-a690-c9490239c763	\N	auth-spnego	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f23e1bd5-f288-4b7b-94bf-c046d61f9d46	3	20	f	\N	\N
2d3ba9c7-8223-4af9-a16f-7cc7fe41fb5b	\N	identity-provider-redirector	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f23e1bd5-f288-4b7b-94bf-c046d61f9d46	2	25	f	\N	\N
a3d596d9-0341-4f72-a008-c72baedc8abf	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f23e1bd5-f288-4b7b-94bf-c046d61f9d46	2	30	t	b7b37672-f6f6-406a-8282-469ce69e98d1	\N
5115dc83-5d7d-44c0-b772-03de7eb6018c	\N	auth-username-password-form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	b7b37672-f6f6-406a-8282-469ce69e98d1	0	10	f	\N	\N
f7799444-a913-423f-ac2d-19ccf7e102e8	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	b7b37672-f6f6-406a-8282-469ce69e98d1	1	20	t	9b020945-c02d-4fe7-ad1d-61c4c4298c6c	\N
2ecacfab-ca33-4942-bb25-36e3b9eab786	\N	conditional-user-configured	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	9b020945-c02d-4fe7-ad1d-61c4c4298c6c	0	10	f	\N	\N
bcc4db0e-2df1-4e91-9e66-f5ca1f31c261	\N	auth-otp-form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	9b020945-c02d-4fe7-ad1d-61c4c4298c6c	0	20	f	\N	\N
662df89d-30c0-49e3-89e5-a1b58ef4c34e	\N	direct-grant-validate-username	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	4156543f-c584-4577-ae84-dbfd47840f42	0	10	f	\N	\N
522fb39f-fc19-4807-b5fd-ef63e4aa69e1	\N	direct-grant-validate-password	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	4156543f-c584-4577-ae84-dbfd47840f42	0	20	f	\N	\N
392510c0-9843-4b6a-a3e1-13f70de72860	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	4156543f-c584-4577-ae84-dbfd47840f42	1	30	t	117d17b9-f0db-4c70-9433-a5002cf14465	\N
8a2222c7-bdd0-4dbf-b58f-8dac0037dd99	\N	conditional-user-configured	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	117d17b9-f0db-4c70-9433-a5002cf14465	0	10	f	\N	\N
c4777012-9ac3-4568-a767-42ab11fe3099	\N	direct-grant-validate-otp	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	117d17b9-f0db-4c70-9433-a5002cf14465	0	20	f	\N	\N
299fadaf-4408-4b83-afe8-0a9f914f7444	\N	registration-page-form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	44ea3da9-29af-4e1d-8525-b21a5ac82e79	0	10	t	ee8151fb-9a28-4017-85c8-05e0a4ff218c	\N
9cce316f-24f4-4a53-9ec0-78c1abc5c9ab	\N	registration-user-creation	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ee8151fb-9a28-4017-85c8-05e0a4ff218c	0	20	f	\N	\N
253870ef-dea5-4afe-956b-13f04ba7370e	\N	registration-password-action	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ee8151fb-9a28-4017-85c8-05e0a4ff218c	0	50	f	\N	\N
3abc68ec-05d6-4f0a-a389-70ec040f7fe5	\N	registration-recaptcha-action	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ee8151fb-9a28-4017-85c8-05e0a4ff218c	3	60	f	\N	\N
98a0a800-0496-4b8a-a9a0-fffa48e5f517	\N	registration-terms-and-conditions	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ee8151fb-9a28-4017-85c8-05e0a4ff218c	3	70	f	\N	\N
f73ef96d-6abf-4290-87e4-da0f2528061c	\N	reset-credentials-choose-user	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5e436c93-99eb-45d3-99ff-263e301da456	0	10	f	\N	\N
3fc3cf77-96c8-42cc-a1b4-a769f00b81d7	\N	reset-credential-email	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5e436c93-99eb-45d3-99ff-263e301da456	0	20	f	\N	\N
ffeecfd4-c619-45f8-b307-645e47a71580	\N	reset-password	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5e436c93-99eb-45d3-99ff-263e301da456	0	30	f	\N	\N
3c0fc4b6-24c7-4879-92a5-532197d07248	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5e436c93-99eb-45d3-99ff-263e301da456	1	40	t	ab8887cb-bc8e-420b-bf1d-3d4a3ac1afdb	\N
4fd057bc-7828-46a9-b656-f0ba57318423	\N	conditional-user-configured	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ab8887cb-bc8e-420b-bf1d-3d4a3ac1afdb	0	10	f	\N	\N
2746e999-8f9d-43c2-aed9-fb2390981850	\N	reset-otp	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ab8887cb-bc8e-420b-bf1d-3d4a3ac1afdb	0	20	f	\N	\N
23a562e7-9e3f-4012-a027-7936a6c6f6d6	\N	client-secret	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	2	10	f	\N	\N
1fbb9576-128f-4456-ae59-df724ad94cff	\N	client-jwt	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	2	20	f	\N	\N
93a1160e-f8fa-4e67-94c2-3bd38dc1854d	\N	client-secret-jwt	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	2	30	f	\N	\N
56e4c0a3-5f3e-4ac0-ad2c-4d717d701263	\N	client-x509	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	2	40	f	\N	\N
ababe41f-f843-43f2-9cbc-bfb585d29a2f	\N	idp-review-profile	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a9bde9fb-f4c9-4abc-b325-71f6dbc0ab79	0	10	f	\N	aac9cebd-5be6-4f5d-ad01-30c5a3d7b1d2
286180e2-3ac7-439a-9483-ba7569f49cc1	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a9bde9fb-f4c9-4abc-b325-71f6dbc0ab79	0	20	t	e65dd54c-796f-49b3-b72b-1baf4e36b484	\N
68e20f25-245f-47c2-a920-8ca4bcda433c	\N	idp-create-user-if-unique	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	e65dd54c-796f-49b3-b72b-1baf4e36b484	2	10	f	\N	072307f8-ee2e-4366-ba79-fe448affceb9
3667a44e-ebcb-478f-8003-c8e67c392a83	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	e65dd54c-796f-49b3-b72b-1baf4e36b484	2	20	t	8ae4d8fd-0645-4509-85b3-9fc41ef1be9a	\N
0859f651-8652-4c4d-8301-06f6e41fc24e	\N	idp-confirm-link	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	8ae4d8fd-0645-4509-85b3-9fc41ef1be9a	0	10	f	\N	\N
cef5eec8-fbda-42e0-ba4f-7612a3434c96	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	8ae4d8fd-0645-4509-85b3-9fc41ef1be9a	0	20	t	5ed4f841-a031-4715-a3fa-eeec9a8bae05	\N
231d4365-8bf1-4489-9c42-862985bbbfcd	\N	idp-email-verification	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5ed4f841-a031-4715-a3fa-eeec9a8bae05	2	10	f	\N	\N
aee228ab-064c-4140-9765-a6500cffc2e3	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5ed4f841-a031-4715-a3fa-eeec9a8bae05	2	20	t	e1a88640-c40f-442c-bad7-1ae8c8c18245	\N
811a2567-5f80-46cc-954f-1a25eae9a8de	\N	idp-username-password-form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	e1a88640-c40f-442c-bad7-1ae8c8c18245	0	10	f	\N	\N
70bf6eb9-1aa0-49de-984c-dc6892032df6	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	e1a88640-c40f-442c-bad7-1ae8c8c18245	1	20	t	565c3400-fe55-4c0a-99ca-198b0020630c	\N
b762266a-7af3-43fe-b331-7515b7b0cf65	\N	conditional-user-configured	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	565c3400-fe55-4c0a-99ca-198b0020630c	0	10	f	\N	\N
f77d670c-e2ea-423e-a958-fbd1ff1b5802	\N	auth-otp-form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	565c3400-fe55-4c0a-99ca-198b0020630c	0	20	f	\N	\N
681558cf-2036-4765-bb08-661dc297dbb5	\N	http-basic-authenticator	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	50bf79e8-0a52-4030-812b-0bf1490a77f2	0	10	f	\N	\N
4572c989-7865-4f50-89b0-239a87a90918	\N	docker-http-basic-authenticator	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	d0899066-0005-41c1-9f3c-c6bdf3ff6ecc	0	10	f	\N	\N
52132449-5863-4800-bfa4-c4fee2b576f0	\N	auth-cookie	d3c7eec2-b715-4576-ae52-eafaa022dbfb	a7ba2cda-ac20-454e-b27f-6aca07958bde	2	10	f	\N	\N
415475b9-b2e1-49da-82b9-41606f868abd	\N	auth-spnego	d3c7eec2-b715-4576-ae52-eafaa022dbfb	a7ba2cda-ac20-454e-b27f-6aca07958bde	3	20	f	\N	\N
54d0cc92-d7e7-4db2-bff0-2c75c5f7ef5b	\N	identity-provider-redirector	d3c7eec2-b715-4576-ae52-eafaa022dbfb	a7ba2cda-ac20-454e-b27f-6aca07958bde	2	25	f	\N	\N
e475ce83-2df7-49c1-ba3c-de0538f3a4f1	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	a7ba2cda-ac20-454e-b27f-6aca07958bde	2	30	t	53161801-6d18-4fe4-9d99-28a60997a1fd	\N
dc1f9cb8-84f7-4b9c-aaf4-b8f8c4000966	\N	auth-username-password-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	53161801-6d18-4fe4-9d99-28a60997a1fd	0	10	f	\N	\N
355875d3-1c91-4e55-9cf5-4acbdfda1433	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	53161801-6d18-4fe4-9d99-28a60997a1fd	1	20	t	c5ebbb52-6508-45cb-bb6d-22d34b08bd00	\N
6fd25bc9-27a9-4c0d-8456-496e81640790	\N	conditional-user-configured	d3c7eec2-b715-4576-ae52-eafaa022dbfb	c5ebbb52-6508-45cb-bb6d-22d34b08bd00	0	10	f	\N	\N
30b7f56a-a517-4dc4-a854-fd5b0debcaca	\N	auth-otp-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	c5ebbb52-6508-45cb-bb6d-22d34b08bd00	0	20	f	\N	\N
5bc4f219-850d-44f0-b543-548c8c92e264	\N	direct-grant-validate-username	d3c7eec2-b715-4576-ae52-eafaa022dbfb	6722bd08-ceee-4fef-880a-ea3f86f2bc50	0	10	f	\N	\N
88ab1b39-3117-4cfe-8a52-9c62acb09ffa	\N	direct-grant-validate-password	d3c7eec2-b715-4576-ae52-eafaa022dbfb	6722bd08-ceee-4fef-880a-ea3f86f2bc50	0	20	f	\N	\N
d8c745c7-153e-4204-8323-1ded116c7d1c	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	6722bd08-ceee-4fef-880a-ea3f86f2bc50	1	30	t	e74ee7a2-f618-4238-83b9-f8c9d20c948f	\N
3a8bab57-fa64-4d6c-99aa-2a92c81abb3f	\N	conditional-user-configured	d3c7eec2-b715-4576-ae52-eafaa022dbfb	e74ee7a2-f618-4238-83b9-f8c9d20c948f	0	10	f	\N	\N
ef87e3eb-6ce4-4485-a898-4cfbefd3ea10	\N	direct-grant-validate-otp	d3c7eec2-b715-4576-ae52-eafaa022dbfb	e74ee7a2-f618-4238-83b9-f8c9d20c948f	0	20	f	\N	\N
3f75c4bd-0509-404e-a31e-a7883fb050f4	\N	registration-page-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	47b19025-2cef-4f55-9ef1-5dd08b96f5e1	0	10	t	0a79f87e-39ba-45e3-956a-2d25f604faaa	\N
8998ac3e-c583-4b3d-bee7-a1abe5b32615	\N	registration-user-creation	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0a79f87e-39ba-45e3-956a-2d25f604faaa	0	20	f	\N	\N
f37f12f3-1f6b-4476-a6aa-9655835724ac	\N	registration-password-action	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0a79f87e-39ba-45e3-956a-2d25f604faaa	0	50	f	\N	\N
86c1598b-339d-4aaf-90c8-fad0aa4684f7	\N	registration-recaptcha-action	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0a79f87e-39ba-45e3-956a-2d25f604faaa	3	60	f	\N	\N
6be5ef76-ec0f-4f8e-acb5-26335f060ccd	\N	registration-terms-and-conditions	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0a79f87e-39ba-45e3-956a-2d25f604faaa	3	70	f	\N	\N
926efd9a-3982-48a6-aaf2-1219cd2c5998	\N	reset-credentials-choose-user	d3c7eec2-b715-4576-ae52-eafaa022dbfb	fde96a26-1965-4880-9ac7-35f197db7446	0	10	f	\N	\N
a82e5fd0-81a9-49d1-b058-f4c218a52d88	\N	reset-credential-email	d3c7eec2-b715-4576-ae52-eafaa022dbfb	fde96a26-1965-4880-9ac7-35f197db7446	0	20	f	\N	\N
313587b8-479a-45f0-95fd-2eb4b6976f67	\N	reset-password	d3c7eec2-b715-4576-ae52-eafaa022dbfb	fde96a26-1965-4880-9ac7-35f197db7446	0	30	f	\N	\N
50bb70c7-99b9-4ddc-a23f-6d9daa42dd23	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	fde96a26-1965-4880-9ac7-35f197db7446	1	40	t	cd8cc0ba-4412-454f-9d29-8e6cdd2ce577	\N
c507878f-d095-43e2-96ee-a4125caa3365	\N	conditional-user-configured	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cd8cc0ba-4412-454f-9d29-8e6cdd2ce577	0	10	f	\N	\N
f980d3d4-2f31-4a5e-aae0-034787f82167	\N	reset-otp	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cd8cc0ba-4412-454f-9d29-8e6cdd2ce577	0	20	f	\N	\N
7220f311-fad3-450f-b2f2-5ee2d2644c65	\N	client-secret	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cae671f0-9b5d-4fb8-9c26-580b1e0fb817	2	10	f	\N	\N
abb2fab8-6e2d-4806-ac44-9609674fd339	\N	client-jwt	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cae671f0-9b5d-4fb8-9c26-580b1e0fb817	2	20	f	\N	\N
735bec58-44d6-4d04-b4ab-8f9c1eb01624	\N	client-secret-jwt	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cae671f0-9b5d-4fb8-9c26-580b1e0fb817	2	30	f	\N	\N
57c1c91e-1b8e-4940-b0cb-fb65237db3aa	\N	client-x509	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cae671f0-9b5d-4fb8-9c26-580b1e0fb817	2	40	f	\N	\N
73bd4371-336e-403a-a5a5-ba9c9b3d6ce1	\N	idp-review-profile	d3c7eec2-b715-4576-ae52-eafaa022dbfb	08e12670-f999-4670-939e-d66f7946f10e	0	10	f	\N	830029f4-fc5e-4173-8162-e2e732c52aa7
3c8078ab-faac-4175-826c-3093c95e6df9	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	08e12670-f999-4670-939e-d66f7946f10e	0	20	t	86b497dd-9118-4518-9be7-3bd22c651793	\N
bfa786ed-0638-486b-a9a1-f02a52ca2860	\N	idp-create-user-if-unique	d3c7eec2-b715-4576-ae52-eafaa022dbfb	86b497dd-9118-4518-9be7-3bd22c651793	2	10	f	\N	063ee565-6a22-4258-b689-41ddcccb510f
8aedceba-b05d-4122-a590-a78fa0323482	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	86b497dd-9118-4518-9be7-3bd22c651793	2	20	t	e47e1157-c1a0-4e73-818e-1835d3806602	\N
3a9434e1-81ad-4552-bb86-69d1405c9532	\N	idp-confirm-link	d3c7eec2-b715-4576-ae52-eafaa022dbfb	e47e1157-c1a0-4e73-818e-1835d3806602	0	10	f	\N	\N
48399ad6-5f17-4b26-bd8d-11028f123402	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	e47e1157-c1a0-4e73-818e-1835d3806602	0	20	t	cba903d9-1411-4f96-b00b-9cd305e2e62c	\N
4f28715e-96cb-4e1e-afa8-d6bc2841570e	\N	idp-email-verification	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cba903d9-1411-4f96-b00b-9cd305e2e62c	2	10	f	\N	\N
32790aa1-16f0-4346-a946-ee7d3bf511a1	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	cba903d9-1411-4f96-b00b-9cd305e2e62c	2	20	t	688284c6-1c5c-428b-a6f0-b133dbeabed4	\N
c6b25c29-8c89-4407-ac22-d89a05a7138c	\N	idp-username-password-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	688284c6-1c5c-428b-a6f0-b133dbeabed4	0	10	f	\N	\N
3cf74234-c969-460c-a022-cb623642ccbe	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	688284c6-1c5c-428b-a6f0-b133dbeabed4	1	20	t	212fb2bb-988d-4e4f-b690-cf682f780166	\N
914aa519-37a5-48d5-a65e-3984d0feddab	\N	conditional-user-configured	d3c7eec2-b715-4576-ae52-eafaa022dbfb	212fb2bb-988d-4e4f-b690-cf682f780166	0	10	f	\N	\N
090b7a98-ecdc-4913-a88a-151fa78b9724	\N	auth-otp-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	212fb2bb-988d-4e4f-b690-cf682f780166	0	20	f	\N	\N
cdbb786b-eaed-4158-9af9-5d019ce100e0	\N	http-basic-authenticator	d3c7eec2-b715-4576-ae52-eafaa022dbfb	ab2b9b19-1a26-4295-b6f0-64ef47e3706a	0	10	f	\N	\N
05035f52-1409-4e31-abd2-1ac56e57b218	\N	docker-http-basic-authenticator	d3c7eec2-b715-4576-ae52-eafaa022dbfb	8ee040d9-8d9e-4758-b0fb-ab6810b4f228	0	10	f	\N	\N
cd135a5d-1037-40bc-ab45-7a97e0dc04f0	\N	registration-user-creation	d3c7eec2-b715-4576-ae52-eafaa022dbfb	271526b4-ed9b-4f73-a2a1-f754bfbd9986	0	20	f	\N	\N
2363cb6e-68f7-4212-9a6b-0717be8fd51e	\N	registration-password-action	d3c7eec2-b715-4576-ae52-eafaa022dbfb	271526b4-ed9b-4f73-a2a1-f754bfbd9986	0	50	f	\N	\N
31af507c-fa54-45ea-a799-1c3e91949a74	\N	registration-recaptcha-action	d3c7eec2-b715-4576-ae52-eafaa022dbfb	271526b4-ed9b-4f73-a2a1-f754bfbd9986	3	60	f	\N	\N
b96522f4-3d72-4031-b541-0e7885926217	\N	registration-terms-and-conditions	d3c7eec2-b715-4576-ae52-eafaa022dbfb	271526b4-ed9b-4f73-a2a1-f754bfbd9986	3	70	f	\N	\N
258dd205-6a2b-44e3-8885-e6f44ea9e4a0	\N	registration-page-form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	1c32d8ca-b424-4c43-970b-6feaae090fbe	0	10	t	271526b4-ed9b-4f73-a2a1-f754bfbd9986	\N
672384d4-4bd0-4481-b585-da472d6bba08	\N	auth-cookie	535ccb56-a180-4def-9f05-660bd334f36f	215e2f1b-d49d-4fda-b59a-0dc477594b43	2	10	f	\N	\N
07757a5d-4b32-405d-b97d-2bb0f7a3a010	\N	auth-spnego	535ccb56-a180-4def-9f05-660bd334f36f	215e2f1b-d49d-4fda-b59a-0dc477594b43	3	20	f	\N	\N
5d06036b-98b9-4bd9-a062-5beaac628481	\N	identity-provider-redirector	535ccb56-a180-4def-9f05-660bd334f36f	215e2f1b-d49d-4fda-b59a-0dc477594b43	2	25	f	\N	\N
8298c309-3353-48cf-b353-ae58700b8d24	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	215e2f1b-d49d-4fda-b59a-0dc477594b43	2	30	t	6ed2c10b-51d9-4c75-8182-3d65ecd349ba	\N
5eba1e6e-150e-4e2b-9e7f-65ab68ab7b6a	\N	auth-username-password-form	535ccb56-a180-4def-9f05-660bd334f36f	6ed2c10b-51d9-4c75-8182-3d65ecd349ba	0	10	f	\N	\N
1db1d6f8-cc45-424c-92ec-ecfd5c134b2d	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	6ed2c10b-51d9-4c75-8182-3d65ecd349ba	1	20	t	258c4f7b-6e8b-4be0-9114-8a4d80fd17b6	\N
58716f2f-1da7-496e-9571-d012969bb3b9	\N	conditional-user-configured	535ccb56-a180-4def-9f05-660bd334f36f	258c4f7b-6e8b-4be0-9114-8a4d80fd17b6	0	10	f	\N	\N
f0a8cc3f-db42-4701-8319-b4174db8c84f	\N	auth-otp-form	535ccb56-a180-4def-9f05-660bd334f36f	258c4f7b-6e8b-4be0-9114-8a4d80fd17b6	0	20	f	\N	\N
b40b6259-a095-4e23-92a9-275dcdb8db2b	\N	direct-grant-validate-username	535ccb56-a180-4def-9f05-660bd334f36f	b0712a5b-444b-414b-a471-8fddf38e313e	0	10	f	\N	\N
f02c13a7-4ee3-4323-9595-d9ba7d2bb456	\N	direct-grant-validate-password	535ccb56-a180-4def-9f05-660bd334f36f	b0712a5b-444b-414b-a471-8fddf38e313e	0	20	f	\N	\N
90aa6323-210a-48b7-aa08-b205093c0725	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	b0712a5b-444b-414b-a471-8fddf38e313e	1	30	t	a86bdfda-3c04-4c3a-9bef-dacef54767e6	\N
ef35a6d0-7a0e-432d-9610-35ab0ffd0963	\N	conditional-user-configured	535ccb56-a180-4def-9f05-660bd334f36f	a86bdfda-3c04-4c3a-9bef-dacef54767e6	0	10	f	\N	\N
c6adca4d-180d-4d41-a4a3-739ed277c54a	\N	direct-grant-validate-otp	535ccb56-a180-4def-9f05-660bd334f36f	a86bdfda-3c04-4c3a-9bef-dacef54767e6	0	20	f	\N	\N
05577a9c-063a-48dd-94c8-dce16a92d8cc	\N	registration-page-form	535ccb56-a180-4def-9f05-660bd334f36f	c1b49ace-86f1-4d34-805d-7ee87855e12d	0	10	t	93ebc307-044c-4da3-8e5f-0261083ae5d9	\N
0964358b-3708-4616-ada9-230bd59a7430	\N	registration-user-creation	535ccb56-a180-4def-9f05-660bd334f36f	93ebc307-044c-4da3-8e5f-0261083ae5d9	0	20	f	\N	\N
a2c38a9c-cccd-492a-91e8-92918f6b2803	\N	registration-password-action	535ccb56-a180-4def-9f05-660bd334f36f	93ebc307-044c-4da3-8e5f-0261083ae5d9	0	50	f	\N	\N
15905aa4-1d88-4c59-844d-7c1f4f164831	\N	registration-recaptcha-action	535ccb56-a180-4def-9f05-660bd334f36f	93ebc307-044c-4da3-8e5f-0261083ae5d9	3	60	f	\N	\N
d06eaa0f-ce7c-423d-a23a-ea89f5c31b53	\N	registration-terms-and-conditions	535ccb56-a180-4def-9f05-660bd334f36f	93ebc307-044c-4da3-8e5f-0261083ae5d9	3	70	f	\N	\N
c264a075-be96-4338-aba6-06bb7322d483	\N	reset-credentials-choose-user	535ccb56-a180-4def-9f05-660bd334f36f	5a748cfb-cfc7-484a-b209-1c1b86046581	0	10	f	\N	\N
f05d5db6-4625-4a93-be91-854f05971450	\N	reset-credential-email	535ccb56-a180-4def-9f05-660bd334f36f	5a748cfb-cfc7-484a-b209-1c1b86046581	0	20	f	\N	\N
335c2dc7-2a03-4a36-9653-4a16fc827e35	\N	reset-password	535ccb56-a180-4def-9f05-660bd334f36f	5a748cfb-cfc7-484a-b209-1c1b86046581	0	30	f	\N	\N
b3d47f45-2b94-44e5-8733-b96f5929c757	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	5a748cfb-cfc7-484a-b209-1c1b86046581	1	40	t	255b046f-e38f-4f5e-9c41-e5ee884b874f	\N
c0079f92-b839-4107-8e90-21c70de077f4	\N	conditional-user-configured	535ccb56-a180-4def-9f05-660bd334f36f	255b046f-e38f-4f5e-9c41-e5ee884b874f	0	10	f	\N	\N
3baa9232-5ac9-44e6-8047-a7de15ba41c5	\N	reset-otp	535ccb56-a180-4def-9f05-660bd334f36f	255b046f-e38f-4f5e-9c41-e5ee884b874f	0	20	f	\N	\N
ac5d8a39-2076-43b9-b053-1c455a1ffdc8	\N	client-secret	535ccb56-a180-4def-9f05-660bd334f36f	c96c079b-b5d4-49eb-b28f-fc539598c6db	2	10	f	\N	\N
d87d5372-1056-4506-9e30-dde9861fbd05	\N	client-jwt	535ccb56-a180-4def-9f05-660bd334f36f	c96c079b-b5d4-49eb-b28f-fc539598c6db	2	20	f	\N	\N
574318be-76ff-4814-b049-b08f9155430d	\N	client-secret-jwt	535ccb56-a180-4def-9f05-660bd334f36f	c96c079b-b5d4-49eb-b28f-fc539598c6db	2	30	f	\N	\N
9a841992-b223-4105-bd84-ffea6db247cb	\N	client-x509	535ccb56-a180-4def-9f05-660bd334f36f	c96c079b-b5d4-49eb-b28f-fc539598c6db	2	40	f	\N	\N
9b271d02-6d36-4858-95e3-dd794c5c7e15	\N	idp-review-profile	535ccb56-a180-4def-9f05-660bd334f36f	94e3f91d-6870-4aae-9488-33bfbc559ac9	0	10	f	\N	ab69c874-3a5c-4ce6-9e67-fdd868be7752
d7b8da9f-5904-4baf-a5a2-7e3fe435b1e6	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	94e3f91d-6870-4aae-9488-33bfbc559ac9	0	20	t	e37a8f45-6e6f-4feb-802f-b24126aaf992	\N
043a81e5-dd69-409f-a7fb-5ecb9ce0ad9c	\N	idp-create-user-if-unique	535ccb56-a180-4def-9f05-660bd334f36f	e37a8f45-6e6f-4feb-802f-b24126aaf992	2	10	f	\N	df500a95-e72c-4035-8876-28d8bfec9b8c
4170b125-0717-4b51-a649-d6d0dc3b8d68	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	e37a8f45-6e6f-4feb-802f-b24126aaf992	2	20	t	bea33aad-a9b0-4e20-b392-d998d71e8ade	\N
1cd28201-e2e9-4082-80f8-8a5d2f95f64e	\N	idp-confirm-link	535ccb56-a180-4def-9f05-660bd334f36f	bea33aad-a9b0-4e20-b392-d998d71e8ade	0	10	f	\N	\N
a8c5e714-f79a-408e-91b2-a482d979b983	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	bea33aad-a9b0-4e20-b392-d998d71e8ade	0	20	t	9e9efa63-c849-4b5f-b244-aeb208f6bf39	\N
7a01edae-f3fc-4247-b47e-9a04d48aad7a	\N	idp-email-verification	535ccb56-a180-4def-9f05-660bd334f36f	9e9efa63-c849-4b5f-b244-aeb208f6bf39	2	10	f	\N	\N
94e408b5-1030-43bf-9506-aaa386e58b2c	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	9e9efa63-c849-4b5f-b244-aeb208f6bf39	2	20	t	841824c2-1a17-47ca-a6dc-13a0e1fb9c11	\N
960c9fb3-44ac-4ff7-8c9d-61d78ab157f9	\N	idp-username-password-form	535ccb56-a180-4def-9f05-660bd334f36f	841824c2-1a17-47ca-a6dc-13a0e1fb9c11	0	10	f	\N	\N
3dd0dd70-b068-4fbe-99e4-a2beca8c9d7f	\N	\N	535ccb56-a180-4def-9f05-660bd334f36f	841824c2-1a17-47ca-a6dc-13a0e1fb9c11	1	20	t	b6af0594-04a6-42f6-ab08-c70ac27782ac	\N
3eba72dd-eda5-45a1-a7ed-6a72a940fa6d	\N	conditional-user-configured	535ccb56-a180-4def-9f05-660bd334f36f	b6af0594-04a6-42f6-ab08-c70ac27782ac	0	10	f	\N	\N
f830e92d-ad5b-49ac-98f9-70ac868bd34b	\N	auth-otp-form	535ccb56-a180-4def-9f05-660bd334f36f	b6af0594-04a6-42f6-ab08-c70ac27782ac	0	20	f	\N	\N
82313374-86fd-4c20-b9fa-1e409bec86a9	\N	http-basic-authenticator	535ccb56-a180-4def-9f05-660bd334f36f	d639d858-c9aa-41cd-ae2f-eb64328371af	0	10	f	\N	\N
c0ece3f0-11a7-406c-b308-ca2909fb0c09	\N	docker-http-basic-authenticator	535ccb56-a180-4def-9f05-660bd334f36f	c0295371-9168-4b45-b95d-8ea7e3d53df3	0	10	f	\N	\N
\.


--
-- TOC entry 5797 (class 0 OID 60900)
-- Dependencies: 244
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f23e1bd5-f288-4b7b-94bf-c046d61f9d46	browser	browser based authentication	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
b7b37672-f6f6-406a-8282-469ce69e98d1	forms	Username, password, otp and other auth forms.	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
9b020945-c02d-4fe7-ad1d-61c4c4298c6c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
4156543f-c584-4577-ae84-dbfd47840f42	direct grant	OpenID Connect Resource Owner Grant	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
117d17b9-f0db-4c70-9433-a5002cf14465	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
44ea3da9-29af-4e1d-8525-b21a5ac82e79	registration	registration flow	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
ee8151fb-9a28-4017-85c8-05e0a4ff218c	registration form	registration form	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	form-flow	f	t
5e436c93-99eb-45d3-99ff-263e301da456	reset credentials	Reset credentials for a user if they forgot their password or something	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
ab8887cb-bc8e-420b-bf1d-3d4a3ac1afdb	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	clients	Base authentication for clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	client-flow	t	t
a9bde9fb-f4c9-4abc-b325-71f6dbc0ab79	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
e65dd54c-796f-49b3-b72b-1baf4e36b484	User creation or linking	Flow for the existing/non-existing user alternatives	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
8ae4d8fd-0645-4509-85b3-9fc41ef1be9a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
5ed4f841-a031-4715-a3fa-eeec9a8bae05	Account verification options	Method with which to verity the existing account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
e1a88640-c40f-442c-bad7-1ae8c8c18245	Verify Existing Account by Re-authentication	Reauthentication of existing account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
565c3400-fe55-4c0a-99ca-198b0020630c	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	f	t
50bf79e8-0a52-4030-812b-0bf1490a77f2	saml ecp	SAML ECP Profile Authentication Flow	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
d0899066-0005-41c1-9f3c-c6bdf3ff6ecc	docker auth	Used by Docker clients to authenticate against the IDP	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	basic-flow	t	t
a7ba2cda-ac20-454e-b27f-6aca07958bde	browser	browser based authentication	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
53161801-6d18-4fe4-9d99-28a60997a1fd	forms	Username, password, otp and other auth forms.	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
c5ebbb52-6508-45cb-bb6d-22d34b08bd00	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
6722bd08-ceee-4fef-880a-ea3f86f2bc50	direct grant	OpenID Connect Resource Owner Grant	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
e74ee7a2-f618-4238-83b9-f8c9d20c948f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
47b19025-2cef-4f55-9ef1-5dd08b96f5e1	registration	registration flow	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
0a79f87e-39ba-45e3-956a-2d25f604faaa	registration form	registration form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	form-flow	f	t
fde96a26-1965-4880-9ac7-35f197db7446	reset credentials	Reset credentials for a user if they forgot their password or something	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
cd8cc0ba-4412-454f-9d29-8e6cdd2ce577	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
cae671f0-9b5d-4fb8-9c26-580b1e0fb817	clients	Base authentication for clients	d3c7eec2-b715-4576-ae52-eafaa022dbfb	client-flow	t	t
08e12670-f999-4670-939e-d66f7946f10e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
86b497dd-9118-4518-9be7-3bd22c651793	User creation or linking	Flow for the existing/non-existing user alternatives	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
e47e1157-c1a0-4e73-818e-1835d3806602	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
cba903d9-1411-4f96-b00b-9cd305e2e62c	Account verification options	Method with which to verity the existing account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
688284c6-1c5c-428b-a6f0-b133dbeabed4	Verify Existing Account by Re-authentication	Reauthentication of existing account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
212fb2bb-988d-4e4f-b690-cf682f780166	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	f	t
ab2b9b19-1a26-4295-b6f0-64ef47e3706a	saml ecp	SAML ECP Profile Authentication Flow	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
8ee040d9-8d9e-4758-b0fb-ab6810b4f228	docker auth	Used by Docker clients to authenticate against the IDP	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	t
271526b4-ed9b-4f73-a2a1-f754bfbd9986	Custom Registration registration form	registration form	d3c7eec2-b715-4576-ae52-eafaa022dbfb	form-flow	f	f
1c32d8ca-b424-4c43-970b-6feaae090fbe	Custom Registration	Custom registration with additional attributes such as phone and adress	d3c7eec2-b715-4576-ae52-eafaa022dbfb	basic-flow	t	f
215e2f1b-d49d-4fda-b59a-0dc477594b43	browser	browser based authentication	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
6ed2c10b-51d9-4c75-8182-3d65ecd349ba	forms	Username, password, otp and other auth forms.	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
258c4f7b-6e8b-4be0-9114-8a4d80fd17b6	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
b0712a5b-444b-414b-a471-8fddf38e313e	direct grant	OpenID Connect Resource Owner Grant	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
a86bdfda-3c04-4c3a-9bef-dacef54767e6	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
c1b49ace-86f1-4d34-805d-7ee87855e12d	registration	registration flow	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
93ebc307-044c-4da3-8e5f-0261083ae5d9	registration form	registration form	535ccb56-a180-4def-9f05-660bd334f36f	form-flow	f	t
5a748cfb-cfc7-484a-b209-1c1b86046581	reset credentials	Reset credentials for a user if they forgot their password or something	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
255b046f-e38f-4f5e-9c41-e5ee884b874f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
c96c079b-b5d4-49eb-b28f-fc539598c6db	clients	Base authentication for clients	535ccb56-a180-4def-9f05-660bd334f36f	client-flow	t	t
94e3f91d-6870-4aae-9488-33bfbc559ac9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
e37a8f45-6e6f-4feb-802f-b24126aaf992	User creation or linking	Flow for the existing/non-existing user alternatives	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
bea33aad-a9b0-4e20-b392-d998d71e8ade	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
9e9efa63-c849-4b5f-b244-aeb208f6bf39	Account verification options	Method with which to verity the existing account	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
841824c2-1a17-47ca-a6dc-13a0e1fb9c11	Verify Existing Account by Re-authentication	Reauthentication of existing account	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
b6af0594-04a6-42f6-ab08-c70ac27782ac	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	f	t
d639d858-c9aa-41cd-ae2f-eb64328371af	saml ecp	SAML ECP Profile Authentication Flow	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
c0295371-9168-4b45-b95d-8ea7e3d53df3	docker auth	Used by Docker clients to authenticate against the IDP	535ccb56-a180-4def-9f05-660bd334f36f	basic-flow	t	t
\.


--
-- TOC entry 5798 (class 0 OID 60908)
-- Dependencies: 245
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.authenticator_config (id, alias, realm_id) FROM stdin;
aac9cebd-5be6-4f5d-ad01-30c5a3d7b1d2	review profile config	86792e35-17a3-4746-b4fe-09bd6bc4cd5d
072307f8-ee2e-4366-ba79-fe448affceb9	create unique user config	86792e35-17a3-4746-b4fe-09bd6bc4cd5d
830029f4-fc5e-4173-8162-e2e732c52aa7	review profile config	d3c7eec2-b715-4576-ae52-eafaa022dbfb
063ee565-6a22-4258-b689-41ddcccb510f	create unique user config	d3c7eec2-b715-4576-ae52-eafaa022dbfb
ab69c874-3a5c-4ce6-9e67-fdd868be7752	review profile config	535ccb56-a180-4def-9f05-660bd334f36f
df500a95-e72c-4035-8876-28d8bfec9b8c	create unique user config	535ccb56-a180-4def-9f05-660bd334f36f
\.


--
-- TOC entry 5799 (class 0 OID 60911)
-- Dependencies: 246
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
072307f8-ee2e-4366-ba79-fe448affceb9	false	require.password.update.after.registration
aac9cebd-5be6-4f5d-ad01-30c5a3d7b1d2	missing	update.profile.on.first.login
063ee565-6a22-4258-b689-41ddcccb510f	false	require.password.update.after.registration
830029f4-fc5e-4173-8162-e2e732c52aa7	missing	update.profile.on.first.login
ab69c874-3a5c-4ce6-9e67-fdd868be7752	missing	update.profile.on.first.login
df500a95-e72c-4035-8876-28d8bfec9b8c	false	require.password.update.after.registration
\.


--
-- TOC entry 5800 (class 0 OID 60916)
-- Dependencies: 247
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 5801 (class 0 OID 60921)
-- Dependencies: 248
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	f	master-realm	0	f	\N	\N	t	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
87776386-5f22-4d8f-8fcb-791558de1118	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
93555091-c257-4da0-a8d8-0af76f37af12	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
dac8a065-0be3-4a04-a4fa-a94138096ead	t	f	broker	0	f	\N	\N	t	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d5f29a80-4c71-4007-9730-716982ad6d8a	t	f	admin-cli	0	t	\N	\N	f	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	f	Golfshop-realm	0	f	\N	\N	t	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	0	f	f	Golfshop Realm	f	client-secret	\N	\N	\N	t	f	f	f
9106d96e-381a-4552-9cad-0619fc3fbef4	t	f	realm-management	0	f	\N	\N	t	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	f	account	0	t	\N	/realms/Golfshop/account/	f	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
28cc48d5-69de-4f31-88e0-71f449cc1a0e	t	f	account-console	0	t	\N	/realms/Golfshop/account/	f	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	t	f	broker	0	f	\N	\N	t	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
83d156ce-eb02-4415-a71e-9515f5e2fcee	t	f	security-admin-console	0	t	\N	/admin/Golfshop/console/	f	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	t	f	admin-cli	0	t	\N	\N	f	\N	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
212c93d9-721d-4a39-bac3-8f8a90aa993e	t	t	golfstore-backend	0	f	yR5aJsfdW5ETFqEcYjmo8alSbivYxfz6		f	http://host.docker.internal:8080/*	f	d3c7eec2-b715-4576-ae52-eafaa022dbfb	openid-connect	-1	t	f	golfstore-backend	t	client-secret	http://host.docker.internal:8080/		\N	t	f	t	f
7286d85d-38fd-4102-a563-09cfaed39e3e	t	f	innloggingbruker-realm	0	f	\N	\N	t	\N	f	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	0	f	f	innloggingbruker Realm	f	client-secret	\N	\N	\N	t	f	f	f
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	f	realm-management	0	f	\N	\N	t	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	f	account	0	t	\N	/realms/innloggingbruker/account/	f	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	t	f	account-console	0	t	\N	/realms/innloggingbruker/account/	f	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a259c734-1af0-4b39-85fb-c8bcb2957d43	t	f	broker	0	f	\N	\N	t	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	t	f	security-admin-console	0	t	\N	/admin/innloggingbruker/console/	f	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ba9f6fe5-a118-4569-8515-f6f07e709aa9	t	f	admin-cli	0	t	\N	\N	f	\N	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
a394b610-97f4-4bd1-b512-9cf01093fa82	t	t	nextjs	0	t	\N		f	http://localhost:3000	f	535ccb56-a180-4def-9f05-660bd334f36f	openid-connect	-1	t	f		f	client-secret	http://localhost:3000		\N	t	f	t	f
\.


--
-- TOC entry 5802 (class 0 OID 60939)
-- Dependencies: 249
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_attributes (client_id, name, value) FROM stdin;
87776386-5f22-4d8f-8fcb-791558de1118	post.logout.redirect.uris	+
93555091-c257-4da0-a8d8-0af76f37af12	post.logout.redirect.uris	+
93555091-c257-4da0-a8d8-0af76f37af12	pkce.code.challenge.method	S256
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	post.logout.redirect.uris	+
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	pkce.code.challenge.method	S256
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	post.logout.redirect.uris	+
28cc48d5-69de-4f31-88e0-71f449cc1a0e	post.logout.redirect.uris	+
28cc48d5-69de-4f31-88e0-71f449cc1a0e	pkce.code.challenge.method	S256
83d156ce-eb02-4415-a71e-9515f5e2fcee	post.logout.redirect.uris	+
83d156ce-eb02-4415-a71e-9515f5e2fcee	pkce.code.challenge.method	S256
212c93d9-721d-4a39-bac3-8f8a90aa993e	client.secret.creation.time	1743241979
212c93d9-721d-4a39-bac3-8f8a90aa993e	oauth2.device.authorization.grant.enabled	false
212c93d9-721d-4a39-bac3-8f8a90aa993e	oidc.ciba.grant.enabled	false
212c93d9-721d-4a39-bac3-8f8a90aa993e	post.logout.redirect.uris	http://localhost:8080
212c93d9-721d-4a39-bac3-8f8a90aa993e	backchannel.logout.session.required	true
212c93d9-721d-4a39-bac3-8f8a90aa993e	backchannel.logout.revoke.offline.tokens	false
212c93d9-721d-4a39-bac3-8f8a90aa993e	display.on.consent.screen	false
342f8d7f-3d22-4696-8ec4-5420ee87df9e	post.logout.redirect.uris	+
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	post.logout.redirect.uris	+
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	pkce.code.challenge.method	S256
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	post.logout.redirect.uris	+
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	pkce.code.challenge.method	S256
a394b610-97f4-4bd1-b512-9cf01093fa82	oauth2.device.authorization.grant.enabled	false
a394b610-97f4-4bd1-b512-9cf01093fa82	oidc.ciba.grant.enabled	false
a394b610-97f4-4bd1-b512-9cf01093fa82	post.logout.redirect.uris	http://localhost:3000
a394b610-97f4-4bd1-b512-9cf01093fa82	backchannel.logout.session.required	true
a394b610-97f4-4bd1-b512-9cf01093fa82	backchannel.logout.revoke.offline.tokens	false
a394b610-97f4-4bd1-b512-9cf01093fa82	display.on.consent.screen	false
a394b610-97f4-4bd1-b512-9cf01093fa82	use.refresh.tokens	true
a394b610-97f4-4bd1-b512-9cf01093fa82	client_credentials.use_refresh_token	false
a394b610-97f4-4bd1-b512-9cf01093fa82	token.response.type.bearer.lower-case	false
a394b610-97f4-4bd1-b512-9cf01093fa82	tls.client.certificate.bound.access.tokens	false
a394b610-97f4-4bd1-b512-9cf01093fa82	require.pushed.authorization.requests	false
a394b610-97f4-4bd1-b512-9cf01093fa82	client.use.lightweight.access.token.enabled	false
a394b610-97f4-4bd1-b512-9cf01093fa82	acr.loa.map	{}
\.


--
-- TOC entry 5803 (class 0 OID 60944)
-- Dependencies: 250
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 5804 (class 0 OID 60947)
-- Dependencies: 251
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 5805 (class 0 OID 60950)
-- Dependencies: 252
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 5806 (class 0 OID 60953)
-- Dependencies: 253
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_scope (id, name, realm_id, description, protocol) FROM stdin;
1c19ab5c-b6b7-48ee-a016-79c1789fd89b	offline_access	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect built-in scope: offline_access	openid-connect
f5296789-81a7-4006-9119-cc32b2baab41	role_list	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	SAML role list	saml
b4395185-aeb1-4446-bf2b-988d8f51e6a9	profile	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect built-in scope: profile	openid-connect
488627d1-bec8-4871-91ef-820441ddcac0	email	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect built-in scope: email	openid-connect
74700042-bde8-4c4d-b178-12554cc5652e	address	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect built-in scope: address	openid-connect
7df18228-19ad-4ece-a63f-dd5d5c3308e8	phone	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect built-in scope: phone	openid-connect
df95f2e8-cf06-4a18-b996-e993aa273c00	roles	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect scope for add user roles to the access token	openid-connect
eee8ee08-4889-4755-900f-f6fb8c3a0f2a	web-origins	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
000e417f-1ead-409b-bfa6-55016cef6dd6	microprofile-jwt	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	Microprofile - JWT built-in scope	openid-connect
ee6c1968-7989-4b51-8e5b-45334e3e36d5	acr	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
e852bf42-ddbb-458b-8216-2e1622c99b1b	offline_access	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect built-in scope: offline_access	openid-connect
10ac70c6-5f2b-496c-8805-5c913c6cf836	role_list	d3c7eec2-b715-4576-ae52-eafaa022dbfb	SAML role list	saml
8b704fa0-732c-4f41-b813-5a23d92400ce	profile	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect built-in scope: profile	openid-connect
2e7cf264-4d58-445a-81df-2f0cd3a949dc	email	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect built-in scope: email	openid-connect
b5c169c4-f4c7-4c51-a9b2-688946b65720	address	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect built-in scope: address	openid-connect
9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	phone	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect built-in scope: phone	openid-connect
3385adea-c1f4-4835-a0b1-d07d8a5d4921	roles	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect scope for add user roles to the access token	openid-connect
291b1b9b-6dd0-429b-99d3-f2953145d453	web-origins	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect scope for add allowed web origins to the access token	openid-connect
60603b1d-d04a-4b93-9e84-da5a10b90eb0	microprofile-jwt	d3c7eec2-b715-4576-ae52-eafaa022dbfb	Microprofile - JWT built-in scope	openid-connect
b05d1158-dc57-46a9-808e-148d356b1a41	acr	d3c7eec2-b715-4576-ae52-eafaa022dbfb	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ce5420b2-511a-40c1-a616-9a3540e17893	offline_access	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect built-in scope: offline_access	openid-connect
8081554b-1ecf-4294-86c1-c2a4b6bb526a	role_list	535ccb56-a180-4def-9f05-660bd334f36f	SAML role list	saml
6c9dbb09-744f-4c8e-96d1-6a6859430cfd	profile	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect built-in scope: profile	openid-connect
82aead9b-99b2-4918-8d7b-f2e3182aabfc	email	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect built-in scope: email	openid-connect
d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	address	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect built-in scope: address	openid-connect
d56be853-823a-49f3-9393-c9a12877f40b	phone	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect built-in scope: phone	openid-connect
ceb3a9ae-ce56-429b-913f-9790b0e25615	roles	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect scope for add user roles to the access token	openid-connect
f957de7a-83b6-4697-9af2-df4ed8eca247	web-origins	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a375e2da-75bb-493a-9915-bd36cb00d742	microprofile-jwt	535ccb56-a180-4def-9f05-660bd334f36f	Microprofile - JWT built-in scope	openid-connect
8f628aa6-3f38-4ac6-823c-8d15397804be	acr	535ccb56-a180-4def-9f05-660bd334f36f	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- TOC entry 5807 (class 0 OID 60958)
-- Dependencies: 254
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_scope_attributes (scope_id, value, name) FROM stdin;
1c19ab5c-b6b7-48ee-a016-79c1789fd89b	true	display.on.consent.screen
1c19ab5c-b6b7-48ee-a016-79c1789fd89b	${offlineAccessScopeConsentText}	consent.screen.text
f5296789-81a7-4006-9119-cc32b2baab41	true	display.on.consent.screen
f5296789-81a7-4006-9119-cc32b2baab41	${samlRoleListScopeConsentText}	consent.screen.text
b4395185-aeb1-4446-bf2b-988d8f51e6a9	true	display.on.consent.screen
b4395185-aeb1-4446-bf2b-988d8f51e6a9	${profileScopeConsentText}	consent.screen.text
b4395185-aeb1-4446-bf2b-988d8f51e6a9	true	include.in.token.scope
488627d1-bec8-4871-91ef-820441ddcac0	true	display.on.consent.screen
488627d1-bec8-4871-91ef-820441ddcac0	${emailScopeConsentText}	consent.screen.text
488627d1-bec8-4871-91ef-820441ddcac0	true	include.in.token.scope
74700042-bde8-4c4d-b178-12554cc5652e	true	display.on.consent.screen
74700042-bde8-4c4d-b178-12554cc5652e	${addressScopeConsentText}	consent.screen.text
74700042-bde8-4c4d-b178-12554cc5652e	true	include.in.token.scope
7df18228-19ad-4ece-a63f-dd5d5c3308e8	true	display.on.consent.screen
7df18228-19ad-4ece-a63f-dd5d5c3308e8	${phoneScopeConsentText}	consent.screen.text
7df18228-19ad-4ece-a63f-dd5d5c3308e8	true	include.in.token.scope
df95f2e8-cf06-4a18-b996-e993aa273c00	true	display.on.consent.screen
df95f2e8-cf06-4a18-b996-e993aa273c00	${rolesScopeConsentText}	consent.screen.text
df95f2e8-cf06-4a18-b996-e993aa273c00	false	include.in.token.scope
eee8ee08-4889-4755-900f-f6fb8c3a0f2a	false	display.on.consent.screen
eee8ee08-4889-4755-900f-f6fb8c3a0f2a		consent.screen.text
eee8ee08-4889-4755-900f-f6fb8c3a0f2a	false	include.in.token.scope
000e417f-1ead-409b-bfa6-55016cef6dd6	false	display.on.consent.screen
000e417f-1ead-409b-bfa6-55016cef6dd6	true	include.in.token.scope
ee6c1968-7989-4b51-8e5b-45334e3e36d5	false	display.on.consent.screen
ee6c1968-7989-4b51-8e5b-45334e3e36d5	false	include.in.token.scope
e852bf42-ddbb-458b-8216-2e1622c99b1b	true	display.on.consent.screen
e852bf42-ddbb-458b-8216-2e1622c99b1b	${offlineAccessScopeConsentText}	consent.screen.text
10ac70c6-5f2b-496c-8805-5c913c6cf836	true	display.on.consent.screen
10ac70c6-5f2b-496c-8805-5c913c6cf836	${samlRoleListScopeConsentText}	consent.screen.text
8b704fa0-732c-4f41-b813-5a23d92400ce	true	display.on.consent.screen
8b704fa0-732c-4f41-b813-5a23d92400ce	${profileScopeConsentText}	consent.screen.text
8b704fa0-732c-4f41-b813-5a23d92400ce	true	include.in.token.scope
2e7cf264-4d58-445a-81df-2f0cd3a949dc	true	display.on.consent.screen
2e7cf264-4d58-445a-81df-2f0cd3a949dc	${emailScopeConsentText}	consent.screen.text
2e7cf264-4d58-445a-81df-2f0cd3a949dc	true	include.in.token.scope
b5c169c4-f4c7-4c51-a9b2-688946b65720	true	display.on.consent.screen
b5c169c4-f4c7-4c51-a9b2-688946b65720	${addressScopeConsentText}	consent.screen.text
b5c169c4-f4c7-4c51-a9b2-688946b65720	true	include.in.token.scope
9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	true	display.on.consent.screen
9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	${phoneScopeConsentText}	consent.screen.text
9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	true	include.in.token.scope
3385adea-c1f4-4835-a0b1-d07d8a5d4921	true	display.on.consent.screen
3385adea-c1f4-4835-a0b1-d07d8a5d4921	${rolesScopeConsentText}	consent.screen.text
3385adea-c1f4-4835-a0b1-d07d8a5d4921	false	include.in.token.scope
291b1b9b-6dd0-429b-99d3-f2953145d453	false	display.on.consent.screen
291b1b9b-6dd0-429b-99d3-f2953145d453		consent.screen.text
291b1b9b-6dd0-429b-99d3-f2953145d453	false	include.in.token.scope
60603b1d-d04a-4b93-9e84-da5a10b90eb0	false	display.on.consent.screen
60603b1d-d04a-4b93-9e84-da5a10b90eb0	true	include.in.token.scope
b05d1158-dc57-46a9-808e-148d356b1a41	false	display.on.consent.screen
b05d1158-dc57-46a9-808e-148d356b1a41	false	include.in.token.scope
ce5420b2-511a-40c1-a616-9a3540e17893	true	display.on.consent.screen
ce5420b2-511a-40c1-a616-9a3540e17893	${offlineAccessScopeConsentText}	consent.screen.text
8081554b-1ecf-4294-86c1-c2a4b6bb526a	true	display.on.consent.screen
8081554b-1ecf-4294-86c1-c2a4b6bb526a	${samlRoleListScopeConsentText}	consent.screen.text
6c9dbb09-744f-4c8e-96d1-6a6859430cfd	true	display.on.consent.screen
6c9dbb09-744f-4c8e-96d1-6a6859430cfd	${profileScopeConsentText}	consent.screen.text
6c9dbb09-744f-4c8e-96d1-6a6859430cfd	true	include.in.token.scope
82aead9b-99b2-4918-8d7b-f2e3182aabfc	true	display.on.consent.screen
82aead9b-99b2-4918-8d7b-f2e3182aabfc	${emailScopeConsentText}	consent.screen.text
82aead9b-99b2-4918-8d7b-f2e3182aabfc	true	include.in.token.scope
d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	true	display.on.consent.screen
d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	${addressScopeConsentText}	consent.screen.text
d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	true	include.in.token.scope
d56be853-823a-49f3-9393-c9a12877f40b	true	display.on.consent.screen
d56be853-823a-49f3-9393-c9a12877f40b	${phoneScopeConsentText}	consent.screen.text
d56be853-823a-49f3-9393-c9a12877f40b	true	include.in.token.scope
ceb3a9ae-ce56-429b-913f-9790b0e25615	true	display.on.consent.screen
ceb3a9ae-ce56-429b-913f-9790b0e25615	${rolesScopeConsentText}	consent.screen.text
ceb3a9ae-ce56-429b-913f-9790b0e25615	false	include.in.token.scope
f957de7a-83b6-4697-9af2-df4ed8eca247	false	display.on.consent.screen
f957de7a-83b6-4697-9af2-df4ed8eca247		consent.screen.text
f957de7a-83b6-4697-9af2-df4ed8eca247	false	include.in.token.scope
a375e2da-75bb-493a-9915-bd36cb00d742	false	display.on.consent.screen
a375e2da-75bb-493a-9915-bd36cb00d742	true	include.in.token.scope
8f628aa6-3f38-4ac6-823c-8d15397804be	false	display.on.consent.screen
8f628aa6-3f38-4ac6-823c-8d15397804be	false	include.in.token.scope
\.


--
-- TOC entry 5808 (class 0 OID 60963)
-- Dependencies: 255
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
87776386-5f22-4d8f-8fcb-791558de1118	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
87776386-5f22-4d8f-8fcb-791558de1118	488627d1-bec8-4871-91ef-820441ddcac0	t
87776386-5f22-4d8f-8fcb-791558de1118	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
87776386-5f22-4d8f-8fcb-791558de1118	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
87776386-5f22-4d8f-8fcb-791558de1118	df95f2e8-cf06-4a18-b996-e993aa273c00	t
87776386-5f22-4d8f-8fcb-791558de1118	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
87776386-5f22-4d8f-8fcb-791558de1118	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
87776386-5f22-4d8f-8fcb-791558de1118	74700042-bde8-4c4d-b178-12554cc5652e	f
87776386-5f22-4d8f-8fcb-791558de1118	000e417f-1ead-409b-bfa6-55016cef6dd6	f
93555091-c257-4da0-a8d8-0af76f37af12	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
93555091-c257-4da0-a8d8-0af76f37af12	488627d1-bec8-4871-91ef-820441ddcac0	t
93555091-c257-4da0-a8d8-0af76f37af12	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
93555091-c257-4da0-a8d8-0af76f37af12	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
93555091-c257-4da0-a8d8-0af76f37af12	df95f2e8-cf06-4a18-b996-e993aa273c00	t
93555091-c257-4da0-a8d8-0af76f37af12	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
93555091-c257-4da0-a8d8-0af76f37af12	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
93555091-c257-4da0-a8d8-0af76f37af12	74700042-bde8-4c4d-b178-12554cc5652e	f
93555091-c257-4da0-a8d8-0af76f37af12	000e417f-1ead-409b-bfa6-55016cef6dd6	f
d5f29a80-4c71-4007-9730-716982ad6d8a	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
d5f29a80-4c71-4007-9730-716982ad6d8a	488627d1-bec8-4871-91ef-820441ddcac0	t
d5f29a80-4c71-4007-9730-716982ad6d8a	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
d5f29a80-4c71-4007-9730-716982ad6d8a	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
d5f29a80-4c71-4007-9730-716982ad6d8a	df95f2e8-cf06-4a18-b996-e993aa273c00	t
d5f29a80-4c71-4007-9730-716982ad6d8a	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
d5f29a80-4c71-4007-9730-716982ad6d8a	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
d5f29a80-4c71-4007-9730-716982ad6d8a	74700042-bde8-4c4d-b178-12554cc5652e	f
d5f29a80-4c71-4007-9730-716982ad6d8a	000e417f-1ead-409b-bfa6-55016cef6dd6	f
dac8a065-0be3-4a04-a4fa-a94138096ead	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
dac8a065-0be3-4a04-a4fa-a94138096ead	488627d1-bec8-4871-91ef-820441ddcac0	t
dac8a065-0be3-4a04-a4fa-a94138096ead	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
dac8a065-0be3-4a04-a4fa-a94138096ead	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
dac8a065-0be3-4a04-a4fa-a94138096ead	df95f2e8-cf06-4a18-b996-e993aa273c00	t
dac8a065-0be3-4a04-a4fa-a94138096ead	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
dac8a065-0be3-4a04-a4fa-a94138096ead	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
dac8a065-0be3-4a04-a4fa-a94138096ead	74700042-bde8-4c4d-b178-12554cc5652e	f
dac8a065-0be3-4a04-a4fa-a94138096ead	000e417f-1ead-409b-bfa6-55016cef6dd6	f
abb73e2b-8831-4aa5-b8d7-506d914c1baa	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
abb73e2b-8831-4aa5-b8d7-506d914c1baa	488627d1-bec8-4871-91ef-820441ddcac0	t
abb73e2b-8831-4aa5-b8d7-506d914c1baa	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
abb73e2b-8831-4aa5-b8d7-506d914c1baa	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
abb73e2b-8831-4aa5-b8d7-506d914c1baa	df95f2e8-cf06-4a18-b996-e993aa273c00	t
abb73e2b-8831-4aa5-b8d7-506d914c1baa	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
abb73e2b-8831-4aa5-b8d7-506d914c1baa	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
abb73e2b-8831-4aa5-b8d7-506d914c1baa	74700042-bde8-4c4d-b178-12554cc5652e	f
abb73e2b-8831-4aa5-b8d7-506d914c1baa	000e417f-1ead-409b-bfa6-55016cef6dd6	f
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	488627d1-bec8-4871-91ef-820441ddcac0	t
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	df95f2e8-cf06-4a18-b996-e993aa273c00	t
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	74700042-bde8-4c4d-b178-12554cc5652e	f
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	000e417f-1ead-409b-bfa6-55016cef6dd6	f
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	b05d1158-dc57-46a9-808e-148d356b1a41	t
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	8b704fa0-732c-4f41-b813-5a23d92400ce	t
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	291b1b9b-6dd0-429b-99d3-f2953145d453	t
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
28cc48d5-69de-4f31-88e0-71f449cc1a0e	b05d1158-dc57-46a9-808e-148d356b1a41	t
28cc48d5-69de-4f31-88e0-71f449cc1a0e	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
28cc48d5-69de-4f31-88e0-71f449cc1a0e	8b704fa0-732c-4f41-b813-5a23d92400ce	t
28cc48d5-69de-4f31-88e0-71f449cc1a0e	291b1b9b-6dd0-429b-99d3-f2953145d453	t
28cc48d5-69de-4f31-88e0-71f449cc1a0e	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
28cc48d5-69de-4f31-88e0-71f449cc1a0e	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
28cc48d5-69de-4f31-88e0-71f449cc1a0e	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
28cc48d5-69de-4f31-88e0-71f449cc1a0e	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
28cc48d5-69de-4f31-88e0-71f449cc1a0e	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	b05d1158-dc57-46a9-808e-148d356b1a41	t
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	8b704fa0-732c-4f41-b813-5a23d92400ce	t
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	291b1b9b-6dd0-429b-99d3-f2953145d453	t
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
b38fc0f2-4ed1-4118-9e91-4af881b33f8d	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	b05d1158-dc57-46a9-808e-148d356b1a41	t
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	8b704fa0-732c-4f41-b813-5a23d92400ce	t
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	291b1b9b-6dd0-429b-99d3-f2953145d453	t
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
f69c19d3-aa6e-4dc2-8156-b963cd44ef37	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
9106d96e-381a-4552-9cad-0619fc3fbef4	b05d1158-dc57-46a9-808e-148d356b1a41	t
9106d96e-381a-4552-9cad-0619fc3fbef4	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
9106d96e-381a-4552-9cad-0619fc3fbef4	8b704fa0-732c-4f41-b813-5a23d92400ce	t
9106d96e-381a-4552-9cad-0619fc3fbef4	291b1b9b-6dd0-429b-99d3-f2953145d453	t
9106d96e-381a-4552-9cad-0619fc3fbef4	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
9106d96e-381a-4552-9cad-0619fc3fbef4	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
9106d96e-381a-4552-9cad-0619fc3fbef4	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
9106d96e-381a-4552-9cad-0619fc3fbef4	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
9106d96e-381a-4552-9cad-0619fc3fbef4	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
83d156ce-eb02-4415-a71e-9515f5e2fcee	b05d1158-dc57-46a9-808e-148d356b1a41	t
83d156ce-eb02-4415-a71e-9515f5e2fcee	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
83d156ce-eb02-4415-a71e-9515f5e2fcee	8b704fa0-732c-4f41-b813-5a23d92400ce	t
83d156ce-eb02-4415-a71e-9515f5e2fcee	291b1b9b-6dd0-429b-99d3-f2953145d453	t
83d156ce-eb02-4415-a71e-9515f5e2fcee	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
83d156ce-eb02-4415-a71e-9515f5e2fcee	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
83d156ce-eb02-4415-a71e-9515f5e2fcee	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
83d156ce-eb02-4415-a71e-9515f5e2fcee	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
83d156ce-eb02-4415-a71e-9515f5e2fcee	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
212c93d9-721d-4a39-bac3-8f8a90aa993e	b05d1158-dc57-46a9-808e-148d356b1a41	t
212c93d9-721d-4a39-bac3-8f8a90aa993e	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
212c93d9-721d-4a39-bac3-8f8a90aa993e	8b704fa0-732c-4f41-b813-5a23d92400ce	t
212c93d9-721d-4a39-bac3-8f8a90aa993e	291b1b9b-6dd0-429b-99d3-f2953145d453	t
212c93d9-721d-4a39-bac3-8f8a90aa993e	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
212c93d9-721d-4a39-bac3-8f8a90aa993e	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
212c93d9-721d-4a39-bac3-8f8a90aa993e	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
212c93d9-721d-4a39-bac3-8f8a90aa993e	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
212c93d9-721d-4a39-bac3-8f8a90aa993e	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
342f8d7f-3d22-4696-8ec4-5420ee87df9e	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
342f8d7f-3d22-4696-8ec4-5420ee87df9e	8f628aa6-3f38-4ac6-823c-8d15397804be	t
342f8d7f-3d22-4696-8ec4-5420ee87df9e	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
342f8d7f-3d22-4696-8ec4-5420ee87df9e	f957de7a-83b6-4697-9af2-df4ed8eca247	t
342f8d7f-3d22-4696-8ec4-5420ee87df9e	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
342f8d7f-3d22-4696-8ec4-5420ee87df9e	ce5420b2-511a-40c1-a616-9a3540e17893	f
342f8d7f-3d22-4696-8ec4-5420ee87df9e	a375e2da-75bb-493a-9915-bd36cb00d742	f
342f8d7f-3d22-4696-8ec4-5420ee87df9e	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
342f8d7f-3d22-4696-8ec4-5420ee87df9e	d56be853-823a-49f3-9393-c9a12877f40b	f
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	8f628aa6-3f38-4ac6-823c-8d15397804be	t
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	f957de7a-83b6-4697-9af2-df4ed8eca247	t
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	ce5420b2-511a-40c1-a616-9a3540e17893	f
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	a375e2da-75bb-493a-9915-bd36cb00d742	f
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	d56be853-823a-49f3-9393-c9a12877f40b	f
ba9f6fe5-a118-4569-8515-f6f07e709aa9	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
ba9f6fe5-a118-4569-8515-f6f07e709aa9	8f628aa6-3f38-4ac6-823c-8d15397804be	t
ba9f6fe5-a118-4569-8515-f6f07e709aa9	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
ba9f6fe5-a118-4569-8515-f6f07e709aa9	f957de7a-83b6-4697-9af2-df4ed8eca247	t
ba9f6fe5-a118-4569-8515-f6f07e709aa9	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
ba9f6fe5-a118-4569-8515-f6f07e709aa9	ce5420b2-511a-40c1-a616-9a3540e17893	f
ba9f6fe5-a118-4569-8515-f6f07e709aa9	a375e2da-75bb-493a-9915-bd36cb00d742	f
ba9f6fe5-a118-4569-8515-f6f07e709aa9	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
ba9f6fe5-a118-4569-8515-f6f07e709aa9	d56be853-823a-49f3-9393-c9a12877f40b	f
a259c734-1af0-4b39-85fb-c8bcb2957d43	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
a259c734-1af0-4b39-85fb-c8bcb2957d43	8f628aa6-3f38-4ac6-823c-8d15397804be	t
a259c734-1af0-4b39-85fb-c8bcb2957d43	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
a259c734-1af0-4b39-85fb-c8bcb2957d43	f957de7a-83b6-4697-9af2-df4ed8eca247	t
a259c734-1af0-4b39-85fb-c8bcb2957d43	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
a259c734-1af0-4b39-85fb-c8bcb2957d43	ce5420b2-511a-40c1-a616-9a3540e17893	f
a259c734-1af0-4b39-85fb-c8bcb2957d43	a375e2da-75bb-493a-9915-bd36cb00d742	f
a259c734-1af0-4b39-85fb-c8bcb2957d43	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
a259c734-1af0-4b39-85fb-c8bcb2957d43	d56be853-823a-49f3-9393-c9a12877f40b	f
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	8f628aa6-3f38-4ac6-823c-8d15397804be	t
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	f957de7a-83b6-4697-9af2-df4ed8eca247	t
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	ce5420b2-511a-40c1-a616-9a3540e17893	f
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	a375e2da-75bb-493a-9915-bd36cb00d742	f
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
6017e07b-f65d-4b79-9a6d-11854ed2d1c1	d56be853-823a-49f3-9393-c9a12877f40b	f
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	8f628aa6-3f38-4ac6-823c-8d15397804be	t
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	f957de7a-83b6-4697-9af2-df4ed8eca247	t
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	ce5420b2-511a-40c1-a616-9a3540e17893	f
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	a375e2da-75bb-493a-9915-bd36cb00d742	f
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	d56be853-823a-49f3-9393-c9a12877f40b	f
a394b610-97f4-4bd1-b512-9cf01093fa82	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
a394b610-97f4-4bd1-b512-9cf01093fa82	8f628aa6-3f38-4ac6-823c-8d15397804be	t
a394b610-97f4-4bd1-b512-9cf01093fa82	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
a394b610-97f4-4bd1-b512-9cf01093fa82	f957de7a-83b6-4697-9af2-df4ed8eca247	t
a394b610-97f4-4bd1-b512-9cf01093fa82	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
a394b610-97f4-4bd1-b512-9cf01093fa82	ce5420b2-511a-40c1-a616-9a3540e17893	f
a394b610-97f4-4bd1-b512-9cf01093fa82	a375e2da-75bb-493a-9915-bd36cb00d742	f
a394b610-97f4-4bd1-b512-9cf01093fa82	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
a394b610-97f4-4bd1-b512-9cf01093fa82	d56be853-823a-49f3-9393-c9a12877f40b	f
\.


--
-- TOC entry 5809 (class 0 OID 60969)
-- Dependencies: 256
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_scope_role_mapping (scope_id, role_id) FROM stdin;
1c19ab5c-b6b7-48ee-a016-79c1789fd89b	213f051a-7bf2-46c9-a888-918f1a33ec9d
e852bf42-ddbb-458b-8216-2e1622c99b1b	d86f3892-6e8b-490f-b8d5-212bc2bfbf4e
ce5420b2-511a-40c1-a616-9a3540e17893	5071f0ba-2044-498c-ad2f-982338250bdf
\.


--
-- TOC entry 5810 (class 0 OID 60972)
-- Dependencies: 257
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 5811 (class 0 OID 60977)
-- Dependencies: 258
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 5812 (class 0 OID 60980)
-- Dependencies: 259
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 5813 (class 0 OID 60985)
-- Dependencies: 260
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 5814 (class 0 OID 60988)
-- Dependencies: 261
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 5815 (class 0 OID 60991)
-- Dependencies: 262
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 5816 (class 0 OID 60996)
-- Dependencies: 263
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
8c932681-79fb-413d-9643-4726a1c354d3	Trusted Hosts	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
7f4c9efe-845d-4487-9090-fece1f5c8d7a	Consent Required	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
892e0a6a-8711-44fd-b9bd-053305981040	Full Scope Disabled	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
222eadd2-0826-4ae6-b360-97aca4c36b27	Max Clients Limit	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
fda07426-b05b-47d1-b1a5-0056277b334f	Allowed Protocol Mapper Types	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
c8a91d52-1a3b-41ac-93c8-f275d9fc893b	Allowed Client Scopes	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	anonymous
295c9bf9-742b-4b52-b1c6-4a0b674931f5	Allowed Protocol Mapper Types	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	authenticated
f0f7785c-2fcd-4df8-9cbe-9593db227eff	Allowed Client Scopes	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	authenticated
31e35f10-da09-4dee-86c0-ef831a42d5fd	rsa-generated	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	rsa-generated	org.keycloak.keys.KeyProvider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N
91d842ee-550e-4c41-93ce-232e0bbb19f7	rsa-enc-generated	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	rsa-enc-generated	org.keycloak.keys.KeyProvider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N
404434c3-d948-4659-87ef-8b1c4e70a6d2	hmac-generated-hs512	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	hmac-generated	org.keycloak.keys.KeyProvider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N
71c31ec9-0088-410c-afaa-70285d59741a	aes-generated	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	aes-generated	org.keycloak.keys.KeyProvider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N
4878c1d7-769e-4237-88bf-4fb28b3ed99e	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N
c317f658-650e-4ff9-8d72-5e76203c1338	rsa-generated	d3c7eec2-b715-4576-ae52-eafaa022dbfb	rsa-generated	org.keycloak.keys.KeyProvider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N
87398590-7a1e-4606-bbe5-d7d343ecb486	rsa-enc-generated	d3c7eec2-b715-4576-ae52-eafaa022dbfb	rsa-enc-generated	org.keycloak.keys.KeyProvider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N
8aabbc69-cdd7-46ed-a330-1deb69d3cb32	hmac-generated-hs512	d3c7eec2-b715-4576-ae52-eafaa022dbfb	hmac-generated	org.keycloak.keys.KeyProvider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N
7e796f4d-49fc-42df-80b4-9cf8f14126a3	aes-generated	d3c7eec2-b715-4576-ae52-eafaa022dbfb	aes-generated	org.keycloak.keys.KeyProvider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N
b7e4033d-a24c-42ce-8e06-a805af9fde35	Trusted Hosts	d3c7eec2-b715-4576-ae52-eafaa022dbfb	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
9001f902-0655-4f64-ad0a-a56ca7847f44	Consent Required	d3c7eec2-b715-4576-ae52-eafaa022dbfb	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
7ec0216e-bb70-4025-b46a-4ad50037232f	Full Scope Disabled	d3c7eec2-b715-4576-ae52-eafaa022dbfb	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
7d640a57-c6fb-46e3-943d-92ad16d3a6f8	Max Clients Limit	d3c7eec2-b715-4576-ae52-eafaa022dbfb	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
52a44465-1105-4e91-a011-4fb4594d3ab8	Allowed Protocol Mapper Types	d3c7eec2-b715-4576-ae52-eafaa022dbfb	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
dce47b7a-0d37-4949-a190-843dcc25f6c0	Allowed Client Scopes	d3c7eec2-b715-4576-ae52-eafaa022dbfb	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	anonymous
e6e30e7d-32cf-4cf1-bbed-276fc610cb15	Allowed Protocol Mapper Types	d3c7eec2-b715-4576-ae52-eafaa022dbfb	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	authenticated
aa94c343-19ab-4d06-b97b-c2e282cbe723	Allowed Client Scopes	d3c7eec2-b715-4576-ae52-eafaa022dbfb	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	authenticated
bda55068-0248-43c9-a220-d0544913beee	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N
4ed64ceb-b7e1-42e7-84d0-e02455696e6b	rsa-generated	535ccb56-a180-4def-9f05-660bd334f36f	rsa-generated	org.keycloak.keys.KeyProvider	535ccb56-a180-4def-9f05-660bd334f36f	\N
ca8c67e5-4122-43ba-ad67-64df5822018b	rsa-enc-generated	535ccb56-a180-4def-9f05-660bd334f36f	rsa-enc-generated	org.keycloak.keys.KeyProvider	535ccb56-a180-4def-9f05-660bd334f36f	\N
0b3680b9-2bd9-4ccd-9701-df38cf8b8042	hmac-generated-hs512	535ccb56-a180-4def-9f05-660bd334f36f	hmac-generated	org.keycloak.keys.KeyProvider	535ccb56-a180-4def-9f05-660bd334f36f	\N
62d4906c-232a-44c5-886a-7dec08a681fa	aes-generated	535ccb56-a180-4def-9f05-660bd334f36f	aes-generated	org.keycloak.keys.KeyProvider	535ccb56-a180-4def-9f05-660bd334f36f	\N
c4f2e7fa-e5ee-4e99-b75d-2eebadd3b37a	Trusted Hosts	535ccb56-a180-4def-9f05-660bd334f36f	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
1803e61a-8370-44a4-b82d-e01c1dc9119e	Consent Required	535ccb56-a180-4def-9f05-660bd334f36f	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
2273b834-3419-46a9-81c5-57242e4d11cb	Full Scope Disabled	535ccb56-a180-4def-9f05-660bd334f36f	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
d82cb46a-0c62-4833-beeb-93af9639c123	Max Clients Limit	535ccb56-a180-4def-9f05-660bd334f36f	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
c55853b6-4a91-403d-861f-fb9c166db8df	Allowed Protocol Mapper Types	535ccb56-a180-4def-9f05-660bd334f36f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
93eeeb35-c219-4f3c-b5bd-bae0e2884537	Allowed Client Scopes	535ccb56-a180-4def-9f05-660bd334f36f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	anonymous
cd3478e2-96fd-40c4-b81a-31222652a920	Allowed Protocol Mapper Types	535ccb56-a180-4def-9f05-660bd334f36f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	authenticated
2698fc9e-7171-40fe-bf15-29c00ebf5435	Allowed Client Scopes	535ccb56-a180-4def-9f05-660bd334f36f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	535ccb56-a180-4def-9f05-660bd334f36f	authenticated
\.


--
-- TOC entry 5817 (class 0 OID 61001)
-- Dependencies: 264
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.component_config (id, component_id, name, value) FROM stdin;
06035de9-3b98-456f-a16c-6fb37b9d26a5	222eadd2-0826-4ae6-b360-97aca4c36b27	max-clients	200
eff076e0-e6d4-4ee0-bfca-54c7bd8bbe1b	c8a91d52-1a3b-41ac-93c8-f275d9fc893b	allow-default-scopes	true
581d011e-96ce-4df8-83a9-e7b6743620ac	f0f7785c-2fcd-4df8-9cbe-9593db227eff	allow-default-scopes	true
60ccae12-7e61-4654-b99b-cbd87373c6fd	8c932681-79fb-413d-9643-4726a1c354d3	client-uris-must-match	true
15aa164c-53d8-4929-aa67-b181f7929686	8c932681-79fb-413d-9643-4726a1c354d3	host-sending-registration-request-must-match	true
c5a4c38b-a820-4692-ac9b-81cd1ddca264	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
95c545b3-c93a-4acf-9f51-c34164fedd5d	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	saml-user-property-mapper
75046156-e507-4b9c-b22d-7122e3bb7693	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	saml-role-list-mapper
3f4221dc-fe45-43da-b13e-c63abddf6df4	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	saml-user-attribute-mapper
4af8193f-08a9-4503-bc1b-e0955b6c16db	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	oidc-full-name-mapper
b9f35632-3a50-465d-9ecb-5ff085d5a16a	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	oidc-address-mapper
059fd860-2c0b-46ba-8185-5319fe167ad5	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
cec27f93-b8ff-488d-b150-5d08b77ac878	fda07426-b05b-47d1-b1a5-0056277b334f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f6875336-81f6-4508-86ab-44b126ef5b34	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	oidc-full-name-mapper
95272836-c1e4-42f9-8cb6-ef19adfd50db	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
889a0dd0-905c-4ace-ba08-fbb21690acc9	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	saml-user-property-mapper
55193f56-fdb5-4cd8-b3e0-ecfed6aac4d0	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	oidc-address-mapper
278a8656-392a-4d6f-80e8-9a5c490d4f92	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0c7f8c1b-a3cc-48f1-95e8-6a63b8543413	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
65de9008-eb08-45f2-81e9-75c61abc2dff	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	saml-role-list-mapper
9001076a-55b6-47d5-ad3a-adf67aef3702	295c9bf9-742b-4b52-b1c6-4a0b674931f5	allowed-protocol-mapper-types	saml-user-attribute-mapper
4de38172-f8df-4253-8e00-4eeda9b3d776	404434c3-d948-4659-87ef-8b1c4e70a6d2	algorithm	HS512
5c755985-afe0-46e5-a308-259218e37be7	404434c3-d948-4659-87ef-8b1c4e70a6d2	kid	ca1c8e30-0d5c-4c6d-8927-18119ed64d57
95ddacab-184b-4b4a-8c83-60273c195b4a	404434c3-d948-4659-87ef-8b1c4e70a6d2	secret	kVflAc_r-pz8txygcNwJ7JihK466jN-NfxRSj9eRhiwPyiZf_LBS6E2L0f8jfAOEPhIE31Q045SWFfRCVQwwsn-6eN7nzekTaUGS2b5lUBHBtSWaUVmsJ_h3FfQKaCzczBqESH0_lKCzTAvQVZAyXF1qPreydKUVnEEU3sFspBA
8a99bbdf-404d-494e-9cbe-e41d0e72ead1	404434c3-d948-4659-87ef-8b1c4e70a6d2	priority	100
29feee80-eb94-4f31-b47b-22efdf63c421	31e35f10-da09-4dee-86c0-ef831a42d5fd	certificate	MIICmzCCAYMCBgGV4UqCQDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzI5MDk0MzMxWhcNMzUwMzI5MDk0NTExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCG53jBHx0IWJVYaa5S5L0SRw72aUZpWBhf/CYdTe9cIHTFLw27e2vRrp1P4dfKwtOyifaT4ExJgFcs/usi7THLemOXnoGYPrnBDfcpk7OjXpi0Un1VfP14rcs9ugjEfBWy1o3X0h4PCkVRPcTgAxW5/Nerh4LdKvKdAQ81QgegVM19ZAf6mdX8T1qoJtUEE95hbk1saC1u++8kfwKX12kCC9GVxgdmlbcXv0n/tqurAWi//b6CLHYTrWmwTboKwXqbYuBukQMoLxAHjM8R40e5MJpuD7dxdXvvr7y/IYUxc4EbzK+n0bWijc1hYIRPZSzm4p7aOSGbeCZGJQB/esjvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFe4riXEuimbLE0tOCB8Gde5/tOzYeDG78QYv/MkgxLPtapJEPB1wJbXdGgL86pyv5VJPkzi/zVbb9ngpelyjUzSTI0pXwaluT0YUU6Bn4BwQT3RB2YD2D7LQjEhy6g+rYmFXykVfiG/VCIduw4LUoFm/BMt7SS+JoVns4jp1LEsMyzAA+ehRZf7jFYFceipw85IsE2aTDzDBXsYnOGFDJBSFSAAEBYS2D8sIpHMLIFCPB0yulQJFrNMSP6yTEdg5ODch2tfWB6x7lZnx2XL+AZ/WqkFZl4ExkgSB3oBhG4oekSWUDGLpeIEMeGrLKGnGUTqVomvevXVjmTgUGDlfO0=
10691bfe-f3b3-493c-b8aa-7a0b6240dfd6	31e35f10-da09-4dee-86c0-ef831a42d5fd	privateKey	MIIEpAIBAAKCAQEAhud4wR8dCFiVWGmuUuS9EkcO9mlGaVgYX/wmHU3vXCB0xS8Nu3tr0a6dT+HXysLTson2k+BMSYBXLP7rIu0xy3pjl56BmD65wQ33KZOzo16YtFJ9VXz9eK3LPboIxHwVstaN19IeDwpFUT3E4AMVufzXq4eC3SrynQEPNUIHoFTNfWQH+pnV/E9aqCbVBBPeYW5NbGgtbvvvJH8Cl9dpAgvRlcYHZpW3F79J/7arqwFov/2+gix2E61psE26CsF6m2LgbpEDKC8QB4zPEeNHuTCabg+3cXV776+8vyGFMXOBG8yvp9G1oo3NYWCET2Us5uKe2jkhm3gmRiUAf3rI7wIDAQABAoIBAAXXsTTOpSeUYTtysEMUzFTQplw+U6ICV7k90WTELaapcoU2XtDiLS7n8hY1625I9nmCsh7WFa0P6uFJqmNZLyaR3A2tUWLc7Jc+L0MqC3CliyrcG7jVG0vbswlZrOwy4jmxmHO4EjyH2a1auykR2SIJ9PPlKuIV7GtSUsH1ZHZ+xaKRYFCn/XtaEheJ/WZBtOWSmmj2/vWRS8szZ6aw1bK0cukuJ6vLWRKhyBsuTzeqVpp6IEyqJn3yBgXTqs/NYdwtm2HBFpt8kcUEbAgk5nLgjbNDjPkl/fvOTCEfnNgL3UsnrII6LV26DdrPoxUr1mrvxa68wjpdg4vzhgXHMQECgYEAu1OlR+1qEY1CS9OUeymxSu1FHgslSWzwRSyqm1vtsUQvyv+vbDsgC0Yc0h9nYZhklHcpKu5LoSnV/zsusiFU8dFePhXHv1b6Li6NBudYwkPoCypdpQ+G4McUuvlkgViwzHdD1lS8vGjI99RtmUUCXBoYrIVdgOkWvCcKhTKODG8CgYEAuFwKy0rxGaqHcOBKHH/CxNMesbBTGjGVsB3X7yW92TcJXiNEBF7O6jRo8sDqNNG+RFJinyvf00+2xMFF0Rd+2BQ8SxjL4MM9m5+9J4KTjB9bzxuoMHG4FkqVTO0OV7pFdLlAg4dz5OFuZ/oweE0i9ycV9EUQdE9uYVxeZmDeS4ECgYEAm4NyeEcRwmZ5/kc1QhY3uFNICQwJtW45/cN6EyX7KynHX4hqkrh2/sUDEjG9+piwD0zpoVlY8f+wR4ZTWtAvG93LllEwlZlYctR0gaG33vbPAc33FhvQxnSfsiVuma8Of4AXkiygzu1SwePZ5N8UeW+0wiyplmZrWGI06qUwpgMCgYEAhHyYwTmNBE3ZYZO9jrd9x6aUo0s8nVFO6i64NENiKIx1rfIX+jAL8KFTXkimxuiIHF88QnjsM9ZQWRsvyjBhVnVMUwdx1IdaadEkxRUAZa1PdAnDF3VRvqtAmfSt3vuc2GIc66jW73/VsOFKHdoJK6YqD83mIj/G6i7QJDCu74ECgYBkNQMzo+ze136s8e/Czf9xp1h7Ju4JowHM31FISXf1j70VxpshGXPvY3JziH3B9Gri9ViJeggvq8xMEQsuSZFQ0g/wSY9Pz6vpQGk+oNmKYFoPHO3NSiTGjCxpvicNqQJNm026f5lNPd6xgn3GvAaRz+GU5RW9ctTbxcm+NCXV0g==
f9b7f5f0-4240-4a34-9471-455aeea757a4	31e35f10-da09-4dee-86c0-ef831a42d5fd	priority	100
70a2ab91-9c7d-4962-87e9-64d7a4645ec0	31e35f10-da09-4dee-86c0-ef831a42d5fd	keyUse	SIG
d85a2320-2af9-4ea3-bd97-978ff6a3f51e	91d842ee-550e-4c41-93ce-232e0bbb19f7	certificate	MIICmzCCAYMCBgGV4UqDDjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzI5MDk0MzMxWhcNMzUwMzI5MDk0NTExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfiZTKDD/44wXa9ycx+bl+Ph0AGZLDk+U+crS5phLYAhAeDzBqSk7Y6mwpsDKA16GAwPEnocwzbKXx66pGsmjkMPfcLzU/9XBaEGMh7Ho8jIFDXZfwd7rFbwxpOM4aVGHYtcPd7gfdR4lOTuzB/YjH8UzrBifUHYEq8h/UqXyXi/DyG/ZC7UQrBi+9j7zsvUypHKxBn8KNAIRbX92pFSUT0yLQdTqValW9DHUNSnpRQVbS0M1dNHtlIyEhmqE9wQCA0z76CM13Y5YCiobcjaouULDkZHjNkpnqMY+Fltiby0T0kVHqGyQw/PynPKZ5n+siPc9EhkyTXbsij+H+U0wxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFwFrCs3kT5G+ssRkZdMT8YSc45HLubl3SXKuuLmef3d11lvg0of2o3DGzLAiI/eaMn2qT4+89SM8w8iqgxYwZYGYL4/i9WmNdmZgekPll8XUJIoacUfn1RkaNUvvcj85P8AS2MNvZyWRtRZOifFbszzYDBYTxKo3E/elNd3o/rZF6ngpYl2Oa9wh/VSh6HlTLqCGVtGzdbp0W/J2dQySUzHdQKOmJZWM4uKajq54bt5XZ6bGOUexNO8cPL6RFZUO+By0PJF06LsVoGuT7VkL2JtmXHrzlQdIzXMjwBnbFabCLtMdH9uS4yLgbBPkFLvLD7cxoLCsjqLvGuXLVLD+AI=
66d03558-74d5-4547-a8ce-b127cc3dd648	91d842ee-550e-4c41-93ce-232e0bbb19f7	keyUse	ENC
a912a8eb-a2b7-46d7-a8de-06ea249a54d2	91d842ee-550e-4c41-93ce-232e0bbb19f7	privateKey	MIIEowIBAAKCAQEAn4mUygw/+OMF2vcnMfm5fj4dABmSw5PlPnK0uaYS2AIQHg8wakpO2OpsKbAygNehgMDxJ6HMM2yl8euqRrJo5DD33C81P/VwWhBjIex6PIyBQ12X8He6xW8MaTjOGlRh2LXD3e4H3UeJTk7swf2Ix/FM6wYn1B2BKvIf1Kl8l4vw8hv2Qu1EKwYvvY+87L1MqRysQZ/CjQCEW1/dqRUlE9Mi0HU6lWpVvQx1DUp6UUFW0tDNXTR7ZSMhIZqhPcEAgNM++gjNd2OWAoqG3I2qLlCw5GR4zZKZ6jGPhZbYm8tE9JFR6hskMPz8pzymeZ/rIj3PRIZMk127Io/h/lNMMQIDAQABAoIBADiomPIE1bdjkRHJ0t65zLnb/1qoumnBHZpHDI4eP/T9DpJOXKhzCXuaDZ3kmJsPeakLXNnxaV8eB/VZ99gxxnS8O1q0XVoApc0mor5KiML2N3YgSDS7oNY7cRHxfaj2LOXU7+HihmJ85HOuLgFbNHel5+ZUAlMfw17oLIvPQZNkLOis62YxIhzui8mfMjBnW9kcJyl2aj4S6me3olwitou5ltQtrnLyb1V6iJWhEyGctk6PeprI6RTTJ6kZ/9QdpDhrZqHG9O9lbpUEZPHLp6u/RwppQA1bcKNt5ev0hzQ17Hi74OvCDbGxpHMausKC1qktsn5LztLXU/2thSXglc0CgYEA2ByP2rgCQVA6UDK2YJZPWk4MMm8mQRM2/FcTfBB+NoQbDWICuwsXB+AD1gbSieji5aV2LT+YibJSTiRTkUWd4Ucref5VvbzxRloptrpzDc3oHqaSKwvyMSOgqXlMXo9cqRP9Kb61jrpGUoyEnVcbrhPM5m03/Y5muGqozffk2+8CgYEAvPvY8fzLh2QZh1nknVtOlgO7nbzmPpBa9C8r92/cGLzKi3l2avzIEM8v/yShnd079htwaZoiIeuzFrfKRPMpFzeivg1KkFW5rvVe9GIy9+Tsklra/7C3QQyJB9D60h6tiYjp16OubLzLhFCZxKRRvZQj2sukyrppmWoidp14ud8CgYEA2BC+VquQPaKrmpEJPEorbhsIIMh106wVVnbsmSaYOYMc1OV/22e8D/iNfUd26cD4USd7nsOti0XI+i1hi6WxspEIS8DYEoo8I91zRSjmbQ/HmhVpoDYiX7TCJY6LpyLoPncorrroJJniQxgQYoq7tvA+9MaPqybbVlf1C3Bj1OsCgYBjSTE2GSjYrbdXy9t27GSCHd3wxjB0yCRwy2Oe8K7CdFU5J4wWM03svt0pf5ZFONjquIm7gVXTWmBRXCexR8rbvsgKbzMwV0lhaNoFLJ44bJX5YjBSSwZL74kCiUFtKN7lNgAc4Yqe6CVIE4xlqiqjnfOkXH7sXzlhd0g55wtpIwKBgE1y4sJx8QjeHnh+4UUfDUH7z1pQxKd5jkRN10BjBgXjWXN/9GrA/04x/paimr0tpNmJaG9d23rWa33luo7QsDxsnyR/pbrytxse+Ce6l8Jdcdx1HJo153yeOtrdHwgVep937f5Fj4cX8oOzpmQyeMdQxz+51kkO0oX7RhHtCxGr
847e0c88-aa87-4577-80f3-e7722829260e	91d842ee-550e-4c41-93ce-232e0bbb19f7	algorithm	RSA-OAEP
994ba97d-c06f-47ab-b9ae-1fef7444bf07	91d842ee-550e-4c41-93ce-232e0bbb19f7	priority	100
be1d68b0-ee92-405e-a5ca-d73de074811d	71c31ec9-0088-410c-afaa-70285d59741a	kid	4ea73a3e-2fb6-4103-aafc-13935630dbbe
1d20e69f-0843-4cea-b7f4-46050b7de2d5	71c31ec9-0088-410c-afaa-70285d59741a	priority	100
938e8db4-4b04-4857-a7cb-fd01f8ae5618	71c31ec9-0088-410c-afaa-70285d59741a	secret	v2_QhYVHdlOyLzSk_3eADA
aa4d8939-3bce-4b86-82ea-e1ac05a519a6	4878c1d7-769e-4237-88bf-4fb28b3ed99e	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
c20859e6-0640-4dba-af87-6050d30ca66d	7e796f4d-49fc-42df-80b4-9cf8f14126a3	priority	100
82c51290-350b-416e-8428-c283dfc62f31	7e796f4d-49fc-42df-80b4-9cf8f14126a3	kid	e5acbdd3-cc7e-4862-9290-4211aef809f8
c91903f2-f89c-48b6-8ad0-a11091d598e6	7e796f4d-49fc-42df-80b4-9cf8f14126a3	secret	8rvD1u8Int4tNp38jxeB-g
04a5391a-b0bd-46c9-9afa-3df2288effd0	c317f658-650e-4ff9-8d72-5e76203c1338	privateKey	MIIEogIBAAKCAQEAwJ/3RSq3j9qv4ucyf0C25eXU92rvU8taq56jaXwVjdEDP0m6OuJlN/WYZyVqqfYW1BAmhx873xmGKhE6oBubKxUqY/DLEKUGALcvD0fFGBeUEuHHgQTCf9xO1TE1tVm4Y4U5qjftST2XnhAi6dk6Q5e4Dh3uX4BoJNn5KtRlxhmG6OCJ60zlNLXopNSHZstUPgXX6UqWrprPT2twxqWI3Lh7ro9G0BtYEMvRZ2tXV7/u+2+Aqcn0RlgJ+r4/OItBVP4Nkphpz1a91hUVZmJTDjKkEyN+6wKAncX2bwD8WAmHiTwCzPAYYg742jUD3A/LZYRorOy/5adFaH04RyIlywIDAQABAoH/bvu7/J4gJUJbFOEgtzESMGO70NJMEnuYQkmk3aIgyRUkSdKw+jx3FUbsCIIGcubXQFgN2sykMmcCZjqHDLjbLneDdRHH7k8mpkLlWmh/puHu7vIngK69Ye4NfchcqaCIHM8l6m1OymQyd1/UvefrKgbAhWG5dk0FtDXi2kqGWRxbJsuLFoaqZjK5Ny7BjdTX2Tb+GqHMIVmbsUwcYfIA95wvzL0mIinbNq5e0hd3lfXYEtgUTBJCFVysQUN0R2oCYNN166o/zUbVpLWQYnFvUo9pK9rt+EV0IINm13LpR5Tg4SSSfkYh7cPyOLOK9VvkwQrnJps5m8hQehbuwPItAoGBAPNhzKMc+fFd56vjl4WlbeTUoVZh4ltmvwdEOuMRpRniJBBFeEtpg6OH4dV2UPSJQ7U2+MI++oDNM6A0ndmaiVcy4MX5n0CVxt+huP1XJ0B5zswq8E6R9VsVFUYgWtCLbjOxf3zQ3rlGqAB3s2VA3palQ6YAvHj7OQ8k3FlWgmy9AoGBAMqcgqQwQ8KBIVUz80sbdsedXBqTVwv25cf4Qx5RG4hL9HpRydZOnqpVpiZ18RmaixmZnYeAPm7dmR7wwk/ZPwchiExgWTEXrES+Q2+LUDaQ7WsH2MNPKC5jbq+w+CxFPjLvIUWIDNBvwXAp1/DFBFZmHOiFHyL2kQ7DXHjP27knAoGBAI7LO5gb4R1W/hzgfD8CT1ap1jrrVTZRMxUdV/tvl9F217fgOnLsZjqk98AZGehPPLVumkbFUo4NVxPQqyhHvfq2NCCTk3b+KV998B5bawEuNkGdk75VboHQ/dlWFFI07CRSKL1fgr1rkhgsIsnuZGo4bldQKURGCTU0aD/WPNF1AoGBAIw258oMhLgUeSbnvtUZeogGBHl3wePLx5Ut3/UZGD6oodYMx+uBmRg0EbnIIUQgyWa8AmKFg69ht9fLsg1kQNQEhrikbNUmltcz/KMy/B3nCgbp9T6khyAjO7RmejjY6oSBLLtbvdJ5pJqkuoYrMidAn3zis3uUuypGVLZe0qY9AoGALSAIrp9KNmPsddx+6xc9PL2vK5e0COStJbxQoEJx2BW3IQtiolmjjelfg04HN/Rx4EmBg/d3mssll9KU1ruuRn+wZj3Q0BZ+eYq2mFDvzGXXko3IGmET6YP5CvuRRPOqoN+3DEprBZ/hG5DZiOEp52PLTFml3+UGpCDUEdJDuik=
ae176965-6488-4959-aa3c-2e8b09483fd5	c317f658-650e-4ff9-8d72-5e76203c1338	keyUse	SIG
cc436161-55d0-4f40-a565-a7565f7eb040	c317f658-650e-4ff9-8d72-5e76203c1338	priority	100
61d42f3f-5b52-466f-8031-c71afd8232a8	c317f658-650e-4ff9-8d72-5e76203c1338	certificate	MIICnzCCAYcCBgGV4U0PwTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhHb2xmc2hvcDAeFw0yNTAzMjkwOTQ2MThaFw0zNTAzMjkwOTQ3NThaMBMxETAPBgNVBAMMCEdvbGZzaG9wMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwJ/3RSq3j9qv4ucyf0C25eXU92rvU8taq56jaXwVjdEDP0m6OuJlN/WYZyVqqfYW1BAmhx873xmGKhE6oBubKxUqY/DLEKUGALcvD0fFGBeUEuHHgQTCf9xO1TE1tVm4Y4U5qjftST2XnhAi6dk6Q5e4Dh3uX4BoJNn5KtRlxhmG6OCJ60zlNLXopNSHZstUPgXX6UqWrprPT2twxqWI3Lh7ro9G0BtYEMvRZ2tXV7/u+2+Aqcn0RlgJ+r4/OItBVP4Nkphpz1a91hUVZmJTDjKkEyN+6wKAncX2bwD8WAmHiTwCzPAYYg742jUD3A/LZYRorOy/5adFaH04RyIlywIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCW7NFxx6E+iXRPq+USBqhAKuC//eHEWy4zSwxAsodzEyWM3pAIQPU+fFDyXVusdXY1DK2yaK5dU0LH1CEMiyutxUP0lTEmUAUtKpPKWm641JTfT5hft2rMs03eaPGFIk3WmcKo7PJ+iAoiY54ggcqW4KyWzEx53Q/APg2Q/AojSqQ5URfvkNto2oFXJqgwJH9jXou5Pt3yBDivjt5O6FgR48DG3zVhEdeEE0Mm7ux4uO7gSnLNSakIwbl4MpOmJZQ5HvRNk/pbS3OqKJcHdjVvzZEqHLFZf6rtV60YGpVr1ICbEoixJydnEN1i/GrJJpIHGeXh38bZ7vGSXYA7F9eX
4e17a5bb-3611-4ae7-abbb-e65da184bbda	87398590-7a1e-4606-bbe5-d7d343ecb486	keyUse	ENC
4736dc21-f95f-4580-9b4f-99e9bc406c19	87398590-7a1e-4606-bbe5-d7d343ecb486	certificate	MIICnzCCAYcCBgGV4U0QkDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhHb2xmc2hvcDAeFw0yNTAzMjkwOTQ2MThaFw0zNTAzMjkwOTQ3NThaMBMxETAPBgNVBAMMCEdvbGZzaG9wMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAm8FsAAvxhlwNhEMr2v90Rhy7Pm/43KuSAd1E3NVcglILlue3VoqITfPOKD+8qUh9mtYysUdEh7/aHL218U8Yr4Cn/lK0/5XJ8jvM0I02ikYXcP8HIGN876SLHOP8M7CdXC/y1T8QXw/wOUw0qD3SGk+oDMyk1QLG2eBw2vam3hMmb1KAfy3egbtLSPWStXeDE7l7crJHHGDp3x8qR4+QUy/7WWz5B9JXsVUCFaoWoLnLD1r9gR40WXDlIvuP1vGQypGhJoquwFhusmNiasnWifSL7ede2Zj460GlzWinjN+3ariduO4ip3+W0+EjhxgLGTNlrGgjaEWWbh87YBY6kwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCbfGAhPye9FHKJyfUFJtEbBr3lQIk5DSqCNvSmKqYpblGRVaU7FMXHH1/Yzmz7WyzV7HchWmXWR5Rqw+CN0VF4zm5rQMK5uZ01uXfrAzGdSSDlws/f596uM3VMjLqdSjXlfp41YbkMUDdTgUzJmRR5ZijgJ1VZez7+HkFGZ/eSUt5quKLPNZY2z5un0bNNifleh4idIkt4XR8AiDFf+Qe7Ghhi6CU0HMnkJwZWZgaWfLsYY52462f8AhJ0Fe7ajTE/CdibvOmwInl2dElaPgop2sopE1MSjZDv18lwbe5h04mA8VkdHCP2abGtS/rMjWL9vi9wJQfS+88xWmRFSnRN
f080971e-ab3a-417e-91bf-3ae0246bfdc2	87398590-7a1e-4606-bbe5-d7d343ecb486	priority	100
d04eda99-7481-4f59-8a4b-72861032a49c	87398590-7a1e-4606-bbe5-d7d343ecb486	privateKey	MIIEowIBAAKCAQEAm8FsAAvxhlwNhEMr2v90Rhy7Pm/43KuSAd1E3NVcglILlue3VoqITfPOKD+8qUh9mtYysUdEh7/aHL218U8Yr4Cn/lK0/5XJ8jvM0I02ikYXcP8HIGN876SLHOP8M7CdXC/y1T8QXw/wOUw0qD3SGk+oDMyk1QLG2eBw2vam3hMmb1KAfy3egbtLSPWStXeDE7l7crJHHGDp3x8qR4+QUy/7WWz5B9JXsVUCFaoWoLnLD1r9gR40WXDlIvuP1vGQypGhJoquwFhusmNiasnWifSL7ede2Zj460GlzWinjN+3ariduO4ip3+W0+EjhxgLGTNlrGgjaEWWbh87YBY6kwIDAQABAoIBABb4skwDdu4BBOv9LX+mw2hVHnc5SR6KngXGXjyk/yLSpOuZuzF5TFxq2SdDLI5ZpvoUyJ8wH/cBdagILB2t3mSBThrf6dqe0Iz4WDRopKLvbs+h3VQ1OBzuoKcfJ3gcKT6KbSnERk7Zk+1vbtNiuBUHVdqlZ/4T4xiz1bva5YYaWRsMJ8qm+P19ig19RxmhrySJX/8HASZ251o9NXZD4p5y/W6GuQc+rYV+633cp2G8tcAmLhVFXm2C5qiZ00dSMGcx97UK319PYSBuaBeBq4A1mBgLvfPD3sL0v0rT8kX5OTV6BIksUZf3K2sRsf+rxpR3KZ/7G25GUMy/BgdqmbECgYEA25TfsMmv6cWsS+A/zjWz+OXn2AdDDd0UEuPv+PnexNq5wKLrlB51QeCgy3lUtVlvfqJUxJVKfeC5E7iF60sxMrMz0YS0tMp7gkp/Vmc4C/sHWJvTgPJA4OlfY7+KbW1/tQyD0dQbePxdb0DCy1A7eljMp19A45h1ZHYSanDODgkCgYEAtZaV8bivcv8SDj16GQjL81IQV4cus0MqZVQAeKSSTeKXO8I3fmi9eyBjGzH0f5gRjb4rO+241EMYBsnbN8QeKzhZRprRyh9s4NPtvpKY9bTVaJDlj7bBuwDzwiP1oPNBM6gYQy3xw07I5aniXKm58TbVakARV/uggq+wAhJAqrsCgYEA1dhx1UlGocOaXbbCTQAuCttUZCYGXq0MzKzh2zb1hf+B4aKJDRJwnby2vBKotYipNcnABkdiaZ7+f7835QOwoTC26Xh1SJDdofENfEc/5SMPb3MqkyzalG+TL6Ctno6CTf8nLaWFL9mO4TdPvhOgKTHr9aCloEGtKi53FuRPOIkCgYADzHmoi9+HvVRIXfre6TMzDOVwn1BXybDqW76Cx5aT8IiPZHm6uEA2gi/wkrP1s12ypGbNIyT5s8md4r0mRoEHEG+1rWl0HAIwFd7kXLa8dSL9xAI5Zm5ZFiUDS7NIwa38gai4Rw7GsjA7tbkZjSdpp2cBiQOT3py1/yzkbjNSHwKBgBlQcEDWysR+BhqGZWSef9wVdXf7x0XugDFVyQiW62HoAWjLvIHEhKOjRjnkDWB7bWNimNzZ9plKd0ej9n8PaSNEli54w0lBRHH9P6SuikKnfxFzQFGR4OABzFhAD31IUrA9f0EZLrhkjZYYg+5wAqaap3grqdcKo/stwe6a2tml
151276df-0030-40b2-82e8-9bb56efa4213	87398590-7a1e-4606-bbe5-d7d343ecb486	algorithm	RSA-OAEP
ebb9060d-2dd1-4ae0-85a5-69a7713d7a75	8aabbc69-cdd7-46ed-a330-1deb69d3cb32	secret	cXvVqGzXXTJ17_yZ9RPPOkHNHNoOKvEPGDl70mQWmm1-fOMurtaAYOVgjYDbPce3Xi1m_HXXSY3LS0hgwiO1-2ZjouzrWnz6yIpP-L6MuVa9T-TrNLf_yTtnu4KnWoaGkB2A-ToF65RGvfBo8Q36e4VjzSRt_3h4Itp4iwpU2X0
cb1cd6f4-75ab-4421-ac43-aa5c3a3720ff	8aabbc69-cdd7-46ed-a330-1deb69d3cb32	priority	100
c597000e-358f-44cf-96d7-73ae800c0878	8aabbc69-cdd7-46ed-a330-1deb69d3cb32	kid	13058bbd-8048-462c-b441-5e9e27d0167b
1b388f09-93a2-4716-9995-14a589720c06	8aabbc69-cdd7-46ed-a330-1deb69d3cb32	algorithm	HS512
ad08b47d-ee5d-4a47-b83d-b5164f3333c6	dce47b7a-0d37-4949-a190-843dcc25f6c0	allow-default-scopes	true
cf05293e-2386-4f78-8ba9-a9d5ab435c59	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f72f5c3f-7941-4f3e-befb-2dc3384a4763	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	saml-role-list-mapper
4bc1935c-cc71-41a0-9a10-c21ccc773696	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	oidc-full-name-mapper
d2eb0320-8e95-4996-bfa8-744e1c6c817f	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	saml-user-attribute-mapper
bdad9d8e-fae0-4bb1-80e9-8016fb140926	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5fe8ab0f-d355-4e3b-a6ff-2e21e55df36f	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	saml-user-property-mapper
708446cd-a6bb-4fef-adfc-396c1897e280	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e6e08edb-3981-4e57-9e08-f623c8336447	52a44465-1105-4e91-a011-4fb4594d3ab8	allowed-protocol-mapper-types	oidc-address-mapper
ed346233-5d3f-4261-b85e-24d0fc715458	7d640a57-c6fb-46e3-943d-92ad16d3a6f8	max-clients	200
658696cf-2edd-48ab-926c-0b2a9a3a53c1	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	saml-user-attribute-mapper
437c5538-1017-4b4f-b7a0-bd1c30df2a02	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
43b7d2d0-3707-4779-9c56-01c6dac21c89	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	saml-user-property-mapper
6836d416-9517-415d-9867-fe446870bbf8	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	oidc-full-name-mapper
ff1b479b-c8f5-479e-a95b-fa6b7664c3ed	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	oidc-address-mapper
1ad63a5d-5f9d-4f88-8c8f-5ab56c22ad57	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bde820b3-2ae8-4fa4-974b-2b7d1c9e4749	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	saml-role-list-mapper
4348b10b-5361-4145-8610-de069a9a7f56	e6e30e7d-32cf-4cf1-bbed-276fc610cb15	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1c0f4297-03f6-41ae-8e96-0cd13643cbb8	b7e4033d-a24c-42ce-8e06-a805af9fde35	host-sending-registration-request-must-match	true
9b386023-9a98-45c2-bb7d-0aaaa3b9dbb0	b7e4033d-a24c-42ce-8e06-a805af9fde35	client-uris-must-match	true
81fa8f9d-c916-4063-976e-5d4b18c44204	aa94c343-19ab-4d06-b97b-c2e282cbe723	allow-default-scopes	true
1478585e-d47f-4343-ad83-a7f5eae0c02c	bda55068-0248-43c9-a220-d0544913beee	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"phone","displayName":"phone","validations":{},"annotations":{},"required":{"roles":["admin","user"]},"permissions":{"view":[],"edit":["admin"]},"multivalued":false},{"name":"adress","displayName":"adress","validations":{},"annotations":{},"required":{"roles":["admin","user"]},"permissions":{"view":[],"edit":["admin"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
65e6efab-a05a-4359-a50d-ba1766a96458	ca8c67e5-4122-43ba-ad67-64df5822018b	keyUse	ENC
c79378d1-bdad-43d3-bb1b-95a8113fa08c	ca8c67e5-4122-43ba-ad67-64df5822018b	priority	100
4777aea3-6248-4aff-96a9-d13f05b995b5	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
41384d30-13f6-4b0a-bd03-33aaf96ff43e	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	oidc-address-mapper
fe830790-0da7-4d1b-b042-4d4fcca26c69	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	oidc-full-name-mapper
5f6908ec-0c9b-42b2-9c78-ef9fe34a25e2	ca8c67e5-4122-43ba-ad67-64df5822018b	privateKey	MIIEowIBAAKCAQEA7C1ZtvccyriyUG42TTEMi/2oqFbQETgIFw9k0VzvXTkU+1S4qedBPqE10d0uNx5gp5CwjYZohnCXOiYK/Qu+GyCRNKEH1pD28FFiH1f3Rk76XYJifw2nfAyDlHvOnfaPLa1+hYatEkDputTKuhfNpTPi+x06/am/L8ioOKaEsdz5++u6Aln73AEMS+i5EhFPoLKpy2ij6HsqnmB1eVMDXY0FidVMEicQjr+VqRFHveYHkZV96k7/5xmBHgfwoKg07zVpUqOQrhBZz+Hs06ngWxj5XWwlLZs4u/BXbbdo22Lg3HE8GyePnsQTQ27L+gnbaS0PlrXWEpOQWPDYdYjTQwIDAQABAoIBAHEvir9UzkeZHFvPddaomwq8FggXEsAtyjLC/d4YW96hbJzGjXlfirUpLVHWXj+sH0Yu4W3x7EYBz3feo4WCCymVAgHm6oq6Dp49YnkC/06CqxoFUo7xTEL2/Fg8vViWwSdy7h+v22HUGi+fq0hj//ocU7tk1tCaeTW9RGFh7FYQVTX1Qx0/+Ad6gFZcV5rzfHSEi5OrIVLE0pfSLfiieednwHn7XjzAg++7vyXeupD71Y67MxwZilx9w34ysurSGJxTuGNbUqv3OZbrsFHnGP8PeIMas96lCwNodXL3x3mE8/wRpCGYjbfzh0E37drIy/g29tMqvJSw3Ub6gcbTmIECgYEA/QR3gQocem+9FhgknvqsdjyzU0ouIOzUcnGJDHX5sK6x1hUXzCLAjYHiUp80Wy5/OosQd2uS77k4RSgR+QInK+2RZMTSLqYkKd8+txRyWftwJEWSwbj6ZvGhxtTicy7qamxrOgIgPPDXIQekjElYQ5rOQj6f81xttvwi6VJXTQUCgYEA7vYQg2oyHdt8oKT9wskvtfvKIPf61GCrwwbaO2kykdpFJYfQeRZna1Ao6Qpm5aaQFp9baKLi353Wil8nQQ/KsLrbRjlpIlSGSisE9d1IIP4sGKA8DdQl5F7Rjq2XDxf1rdrJGpbF/eg1uRL6P4mlaNludZ/MueWjjQHX55ALUacCgYAPjQK7T5/Idq2sefdmPgnzim+LIvgK1gOItSmzNl0OWu5bNhisV0Z2bBE4+sgBAq6XLozoihgR29R1i6zvHQ7DSGqzQtWYQGXgnPQB1KPim+2cjRokBfZ99UP4MIVqhuupdthwTEkm9baDNTEL3kYqgY1DzQ2Pq5KiuIR8yq7K8QKBgC4B/kfvCFsrSSF84sbACYmWQuJ6HDcLrcZM6XOK24utZKbHMWI+6AaHVnkX4ZvRp+hTIjxRMDExqH7Xty0Vp0bDkzhAEXfkoj5hbgEQa7S+eyr6ntVixTDk+J/p2C21xT2F5DZUVSZ/sOhDOR9GlyxKwLOw4q/gAM9DTZht6V/9AoGBANsE6AjJubXkvQDgDFr5i9SRsIfg5XwWnS1h/X4YAo3JoeZ2C8+CW4JSsHMySNIilDsSl8qne77Z7YwvErguoDewnDxZvuQbmHpCJIf/glD6Yzu4DpJarz5g84MvDDTny/9QoFzQxj3mkbI4jL1CDq9dOuruzntlSNJ+fS2Sezk0
6e57e741-a7fa-40bc-a2bb-e6a6f878ee2b	ca8c67e5-4122-43ba-ad67-64df5822018b	certificate	MIICrzCCAZcCBgGXIFh5njANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBpbm5sb2dnaW5nYnJ1a2VyMB4XDTI1MDUzMDA4MzczOFoXDTM1MDUzMDA4MzkxOFowGzEZMBcGA1UEAwwQaW5ubG9nZ2luZ2JydWtlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOwtWbb3HMq4slBuNk0xDIv9qKhW0BE4CBcPZNFc7105FPtUuKnnQT6hNdHdLjceYKeQsI2GaIZwlzomCv0LvhsgkTShB9aQ9vBRYh9X90ZO+l2CYn8Np3wMg5R7zp32jy2tfoWGrRJA6brUyroXzaUz4vsdOv2pvy/IqDimhLHc+fvrugJZ+9wBDEvouRIRT6Cyqctoo+h7Kp5gdXlTA12NBYnVTBInEI6/lakRR73mB5GVfepO/+cZgR4H8KCoNO81aVKjkK4QWc/h7NOp4FsY+V1sJS2bOLvwV223aNti4NxxPBsnj57EE0Nuy/oJ22ktD5a11hKTkFjw2HWI00MCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAXRWJ3dmD+o6x8twGUrL82pOXHE4kRJbinqvxwMqNKSMM22B2n5Qz4nyieLZV/ZIdQ3NJd8G1EDRnqP7okNyJfUgXkG0QHX6eCAAZvRXUv6GG4OsXBq7oPMDKQByZkyAZv47NATZaCp7WU8FVpNCksH2g0eXpVSRgmHY6eOFnysCquBlaoaj3IRsJ2CxbzB5SpuqMO7nTqienoYz6lWW7Xxe4NJw/qcDl293ZpU6VQSLCRdH4fqvcJLEwhuGMfWz3t5stKa7MrsOJJiGYZ6fuP+iegGAihg+OKwnQxDXTKySy+TI/wiho3lUaXKj9o2ehXVr/DQxSrzIJPlKLhxFTxQ==
1d9a5301-26d9-4c4a-b240-46877bfc12ae	ca8c67e5-4122-43ba-ad67-64df5822018b	algorithm	RSA-OAEP
8a2b16c5-9137-4095-b7b1-40e282739d66	4ed64ceb-b7e1-42e7-84d0-e02455696e6b	priority	100
b94efd23-054e-4b5a-aca9-2a379c61f82c	4ed64ceb-b7e1-42e7-84d0-e02455696e6b	keyUse	SIG
502d769b-cf3b-4d10-b6ee-e211382e0d8e	4ed64ceb-b7e1-42e7-84d0-e02455696e6b	privateKey	MIIEowIBAAKCAQEAwrrcR2TZcSbHastccgGmB8eDd3PnLiQUw/uk7w2JebGB9X5GSOggj1QkEOHwGQfHOCTVffZqsx72KVV/6r3SPHJiY6u0zCoiaOExXtjzNZHbkZu+tGMAbNP9y69aO6/T17fAOaUXb0RvDLjCXfCgEchsImluuL7GbFwOJX5eWBEdivmrDobUG9OrcuSJvokfYKWyMknFHl7tXLp1lIvjttE+FGWxKDfDfzWJ+8bFRwRR7lu7sg4UaRyFsycrXiFgALPjxlIjpeC93qHgHbZ6qtf6Yb0ViDK10RiRgEcrz1Qm8L0XREm7zsyEBNBbv+t1p15fUeboWbkALbd26l6iZQIDAQABAoIBABQl+3bTo4AGsCmHoygUrZYueZbZgjkO+KsSlY06jFfwGu9IwoL2qa/K1/R7PDmKyX0wqnpfDck80eGS/CpQu7kPaMjBUnKxhV/utQoITpnjXqGhSMknWTrpcGAr4507YyL120jboSIdJZReZZYMuLM+Vpn06MTq0GMT307X1XEtHdu2tEPV82HdBJ4xGl6IT6UfYSRtNVaT4jys4dmMXQT+B0LedrAhRMeiv0FaGnTHN/xZnH9KkQE/VPBPlylyZ7ZenMl4OihYwLj2yRD6eiEpSrQ+QQHs/1JnliDKsGOL2tO6QYIt4YezvdAJyvGhUYz6XdDMJTCSkHGmwv3A9OECgYEA7+J7NyzPEwAl4pj69P91OzdJnbVx3XENn0/Ko2i6bp4ULj948t5OrkI2mASzRanhJvVHQa64RIY1NzHtdXQaREHq8QsrwugOMMCkVDEK42kUD5f7pfsOuqjU7hBYQHyT62n+pvdFK+C4CMGK+kOJWHW1ec2UmCtpkfZ3V2IdRt0CgYEAz8/PlWxf7wWxFrBlKWRVKKDYdvQg0GRLuXkhjxs8nY3OrsYZMd1V9vbemGmQ63CGsUZpk5zo/3/UAhHCi7SWJZHFi2Y0xpOBV8iTMk8SFb3XjbU4RXNRUAKD34ZnJ33uPSCyFa2mThr1IKCSjDSuZ7TQsg3RWdswPw4EVi2wXSkCgYBYQNuSBgM8+0302tFhN2a63XFQ+0Mj9AbN+L4Vdl84eSH1jdaCi7UouSV6sif+ViyGd7C6gnw6gaGsZ8rz7j4HpLS576Eu+M7XstgCPXTDC5Kc1g54FzBpDdogp5TATNTixEEyzj/9j5RFbGckAZrTF6MnZ7HmdfpGAAYR+P/KZQKBgBGSuzUhkwM9cfo/NG7Jo0HqSCPXBSdaM+UdTy8w2HFiWoYBDoRe+TQHME+nLbAbNeir0aW/8RwaDS2XnuH9hWzr5M6i9/eK5bcsqPXqJddc1GuRVY7Z75hafhha30JBrfHRX/3hT1zvfqchrQLaOZ1fdv53mKqGlI/geZFoD6/xAoGBANxzDUaofhTQydo7CwmprFaUDYmtmDnOI2Q5BAdW+VCkevoCBqpADwudSfIajRamLtZK1hqFWLsCWKIGEwADI1bdXm8SxHuSXNL/ZAsMb90YFhlBUwrqzo1IOfAeW/P9qQHZPsGgvxbdSoVHChu7kotV6ttRlcabTOw/TuTQ4yXf
4c3ce668-3fce-4139-b7c9-b1e379cb0f18	4ed64ceb-b7e1-42e7-84d0-e02455696e6b	certificate	MIICrzCCAZcCBgGXIFh34DANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBpbm5sb2dnaW5nYnJ1a2VyMB4XDTI1MDUzMDA4MzczOFoXDTM1MDUzMDA4MzkxOFowGzEZMBcGA1UEAwwQaW5ubG9nZ2luZ2JydWtlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMK63Edk2XEmx2rLXHIBpgfHg3dz5y4kFMP7pO8NiXmxgfV+RkjoII9UJBDh8BkHxzgk1X32arMe9ilVf+q90jxyYmOrtMwqImjhMV7Y8zWR25GbvrRjAGzT/cuvWjuv09e3wDmlF29Ebwy4wl3woBHIbCJpbri+xmxcDiV+XlgRHYr5qw6G1BvTq3Lkib6JH2ClsjJJxR5e7Vy6dZSL47bRPhRlsSg3w381ifvGxUcEUe5bu7IOFGkchbMnK14hYACz48ZSI6Xgvd6h4B22eqrX+mG9FYgytdEYkYBHK89UJvC9F0RJu87MhATQW7/rdadeX1Hm6Fm5AC23dupeomUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEADcx1xdz8oZN0pctMMewaRvl1YCmkdS3pXnj6oio0uf93JaH/lzbdxUVf2fsXViMf83/hm1CO0dsmrJz68CtNErFzzCcNYo7E3ELhowlD+2JxdZtxo0rMf6nmrw5i/EtoFVcErbGbfY+LFYCbjzWa7IvisRcXroZVmInWX5oMLyyYVawQNhUAMA8gf3lqRLlEYJPeg3x+RRKd6RDpyjPZW2kUX//npl+lbNMwOGYsqwBlekVwcmfWNEVtCjeVTnLlTUcQ08ykwTcF7UgcojcPS5Eh4K8CUzsG4WBdzqn3YBOmbWgPVf7T45QYNsI2PYw9qevlD+ZpeV8ye4YTP1p1mQ==
b6dc7f26-ab72-4ba2-a941-91f20d408288	0b3680b9-2bd9-4ccd-9701-df38cf8b8042	algorithm	HS512
8995761f-67e2-4aac-8571-97470be7e0a1	0b3680b9-2bd9-4ccd-9701-df38cf8b8042	priority	100
a934ab88-e5ea-49c8-8dd6-f82cef3e4c79	0b3680b9-2bd9-4ccd-9701-df38cf8b8042	secret	MyiUXGuSX4v2d-E_sWxNRx_gRTkMpKbYRA1iJZlJh7sfgumNOodfFsYZGD6qVM9xjwKStWMG7SGtbnid_pRjuxR-Niex3sKSXv5itzdF7AAetlRkxVJoWFuSETTWzyj8nlw6Ilg7wZarmtBUNE4DzPG9UWW-nD_YyRo-mSv8NAA
e4d70998-f932-47db-8b9c-fac4765252b2	0b3680b9-2bd9-4ccd-9701-df38cf8b8042	kid	388a366a-1d21-4b12-95d1-a1bcf98563ae
9d75120e-b55b-4ce5-8bda-dcd7869623e1	62d4906c-232a-44c5-886a-7dec08a681fa	secret	REwCZuhuG_11vaZ5uXRHSw
201450ee-1d6d-4b19-b369-6fd1438019c5	62d4906c-232a-44c5-886a-7dec08a681fa	priority	100
4b1d39ee-e3aa-4f00-a359-3f730352bf2d	62d4906c-232a-44c5-886a-7dec08a681fa	kid	b29bd650-9462-45c4-8ce3-81b8e42be952
202421ac-ce8d-45af-8caa-4a0076d654b4	d82cb46a-0c62-4833-beeb-93af9639c123	max-clients	200
25fd23c4-1046-4a62-9cfd-700534741575	93eeeb35-c219-4f3c-b5bd-bae0e2884537	allow-default-scopes	true
9b05e0bc-2f93-4fe2-80ac-5bdb91d28f81	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	saml-user-attribute-mapper
86d9e8f1-52f2-4ce2-be71-9070eeb3dafd	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c89444e8-62dc-4a16-936d-38044493cb41	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	saml-user-property-mapper
cb17dac0-5489-4fc8-a70f-95a681cbc9c3	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a0181894-425b-4fea-967f-4ad81a3f8f1f	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	oidc-full-name-mapper
81415434-4418-48ed-997a-2036b1ad5cae	cd3478e2-96fd-40c4-b81a-31222652a920	allowed-protocol-mapper-types	saml-role-list-mapper
39de4a18-b57b-4355-8dda-1e979c89066e	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	saml-user-property-mapper
e5ebd0a9-d146-4071-bf06-ca736fd57043	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	oidc-address-mapper
3a852958-3996-4356-9c5e-57b732e0e437	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	saml-user-attribute-mapper
6a36efee-013b-458a-acc6-890f175ad068	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
30099c44-1ca0-41da-80d5-80ecd89db89f	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	saml-role-list-mapper
16ad67ac-ec7b-45f8-ace0-bddfe9c11b59	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2520ab2a-6641-41cb-9905-d0a70f373351	c55853b6-4a91-403d-861f-fb9c166db8df	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4b9125cb-ed1b-47f0-8511-b8754c8a8a93	c4f2e7fa-e5ee-4e99-b75d-2eebadd3b37a	client-uris-must-match	true
ff7ca183-43b0-460d-92c2-8e54caf4abd1	c4f2e7fa-e5ee-4e99-b75d-2eebadd3b37a	host-sending-registration-request-must-match	true
98e8b6e6-8d50-4e2f-8b5b-ee4d9e6ed564	2698fc9e-7171-40fe-bf15-29c00ebf5435	allow-default-scopes	true
\.


--
-- TOC entry 5818 (class 0 OID 61006)
-- Dependencies: 265
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.composite_role (composite, child_role) FROM stdin;
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	c3c63302-7563-4e1a-8346-dd355f4271c2
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	2f55c677-8571-44bd-ad70-a6b48e9c4826
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	a61f38d5-9791-4140-abcc-005be8856cec
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	e1c96c73-7511-4862-8973-b7adde5d7e99
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	0c113da7-1011-420d-a06d-54e017d40381
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	8d163aef-1548-481a-affb-6214280f00b7
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	bef2cb35-1f1f-4ee8-95f6-b7c122dd8898
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	ddac3388-923c-4897-9d5d-67f432de6a30
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	d9690da8-0265-4bd6-a891-b50be2f2fd42
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	5a54c20a-9e80-4498-aff8-e7dde681c968
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	3009a6b7-378a-4d22-9f30-d402aeb3503e
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	c4bc91de-cbef-429b-b86a-ae0e5bcd99ea
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	1bee03c6-d8b6-455e-b82d-6802097cd1cf
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	6c308bdc-1f11-4d27-b12f-064a7211301f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	98f58f7f-7e00-4355-bb32-a837d82adf4f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	d6ed4825-2651-43e4-9b14-eca1d9a436ac
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	065e978f-1d42-4258-a1e3-9d74d4d45a39
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	5020db19-41ce-49a4-b8d3-01a3ae9dbb47
0c113da7-1011-420d-a06d-54e017d40381	d6ed4825-2651-43e4-9b14-eca1d9a436ac
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	df54a484-a1e4-4d9f-b5c0-0c8c20d44804
e1c96c73-7511-4862-8973-b7adde5d7e99	5020db19-41ce-49a4-b8d3-01a3ae9dbb47
e1c96c73-7511-4862-8973-b7adde5d7e99	98f58f7f-7e00-4355-bb32-a837d82adf4f
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	99a902d0-7d9f-46d4-8b66-5bfa470fc2b9
99a902d0-7d9f-46d4-8b66-5bfa470fc2b9	cf7685f8-188d-4298-af54-a245d4643dd8
c0dbd5b0-91cd-4a52-839f-90b16c1c09f5	a2a7f387-e63b-4167-8251-29b87c9684d1
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	596b95de-8fd9-473d-9c05-dbe33ff79c32
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	213f051a-7bf2-46c9-a888-918f1a33ec9d
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	718b9d47-19f1-421f-bec9-f90649486c95
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	b4e751fe-0acc-43bd-82d3-1835d0533cdf
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	2de02dae-50dc-4ff8-b091-17d313257557
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	177f36d3-2ae7-496c-94dc-ee5d9c56f871
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	ba5df043-db47-41a4-9754-a0a99e6b0f3c
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	ac6a366a-f503-4286-a631-2fb5e31d6171
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	8cc5334e-8e32-4bf0-8d78-df7c3b96c8c0
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	26ec6132-ce03-46e3-99ef-18fbe54372f0
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	24e8912c-b3d8-40ea-bb77-96fce85ad8d5
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	ee105db7-892b-46f6-87b7-9b87f8d91f75
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	f893c3ec-afaf-4f82-9aa6-be0035776cbd
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	6783fb11-9146-4298-8e65-5f33239fc11a
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	30e1693b-d49c-489b-ba13-ab28b456cbd3
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	fc9df704-c0d4-45c9-81e2-5b6e6f947b61
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	f5599c3b-42eb-4937-b877-1b25aaa2760a
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	f86caa13-b891-44eb-932f-413aaa5cbd89
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	07c1e640-4e70-4e10-a81a-8c28c2d877f7
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	f44f9ad6-b76f-4b25-a18f-62c1368931fa
177f36d3-2ae7-496c-94dc-ee5d9c56f871	f5599c3b-42eb-4937-b877-1b25aaa2760a
177f36d3-2ae7-496c-94dc-ee5d9c56f871	f44f9ad6-b76f-4b25-a18f-62c1368931fa
ba5df043-db47-41a4-9754-a0a99e6b0f3c	f86caa13-b891-44eb-932f-413aaa5cbd89
08aead87-160e-4289-a06d-057a53ad565a	19ffaa95-f7c1-4681-9f6b-feeffad74a2f
08aead87-160e-4289-a06d-057a53ad565a	20ada318-bab1-46b8-9f2c-806e6e01fba0
08aead87-160e-4289-a06d-057a53ad565a	057d31df-eca8-44b5-b629-bb66504ae031
08aead87-160e-4289-a06d-057a53ad565a	e125d87a-6064-4157-8433-559f428216f9
08aead87-160e-4289-a06d-057a53ad565a	d49a8a68-183e-4026-acc6-2996e06b0449
08aead87-160e-4289-a06d-057a53ad565a	555bd265-352f-4e3c-a918-81a684db3bde
08aead87-160e-4289-a06d-057a53ad565a	a3aa2e53-e459-4030-bc39-f1c5ff40d3c5
08aead87-160e-4289-a06d-057a53ad565a	4a01a00c-2b94-4820-ac21-4e17877853c9
08aead87-160e-4289-a06d-057a53ad565a	2888906e-11da-4c60-8755-4502a5a2febd
08aead87-160e-4289-a06d-057a53ad565a	8baeaa9f-90d0-4f87-a960-44eadf50e7ed
08aead87-160e-4289-a06d-057a53ad565a	8cde7a77-e76a-40d6-9562-ac10d7b13e54
08aead87-160e-4289-a06d-057a53ad565a	1d81cbc7-a848-47e9-87b4-31878afe0a00
08aead87-160e-4289-a06d-057a53ad565a	eed3a0d2-c7f6-40d1-9b6d-78726921b12d
08aead87-160e-4289-a06d-057a53ad565a	af985581-8c07-48ea-adaf-9366b0f051d2
08aead87-160e-4289-a06d-057a53ad565a	7da2e140-ffee-42c5-81bb-870fcb2c43a6
08aead87-160e-4289-a06d-057a53ad565a	2f36d904-3025-4ff8-9009-abae750646d0
08aead87-160e-4289-a06d-057a53ad565a	9a3bbaf9-0da5-4e10-937d-fb4a61954f75
057d31df-eca8-44b5-b629-bb66504ae031	9a3bbaf9-0da5-4e10-937d-fb4a61954f75
057d31df-eca8-44b5-b629-bb66504ae031	af985581-8c07-48ea-adaf-9366b0f051d2
dc009e10-c242-43f6-9ce2-db07b2020ddd	2f5054e0-136f-4181-aa04-3a2d33fccbde
e125d87a-6064-4157-8433-559f428216f9	7da2e140-ffee-42c5-81bb-870fcb2c43a6
dc009e10-c242-43f6-9ce2-db07b2020ddd	812dfaf7-1f2c-47f9-b621-d064b40d852a
812dfaf7-1f2c-47f9-b621-d064b40d852a	a0ab7693-4738-4b99-99a7-0fd7658e8cbb
1f7bca78-d81d-476f-876f-6f5820c7250e	4076408c-8ec8-44de-b0af-9007eeb5e6de
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	87102fc4-5b66-4957-8470-531633f2170b
08aead87-160e-4289-a06d-057a53ad565a	3410c1c4-bff0-4cb1-be9e-fc4657cad827
dc009e10-c242-43f6-9ce2-db07b2020ddd	d86f3892-6e8b-490f-b8d5-212bc2bfbf4e
dc009e10-c242-43f6-9ce2-db07b2020ddd	cfb934e0-dac7-4aca-8572-629a92f56107
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	1fffcb6f-fb3a-4492-889b-c7041048812f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	93caffc2-84d7-44af-8e60-d0e16787a920
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	e7e491dc-4070-4170-b52a-1d13f695a45f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	608743cf-30e7-4f2b-a7cd-2897ee92bf58
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	4a35fc4a-c6f9-4521-8794-28e51bc4e526
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	972c9c10-3fa1-4fd1-84c8-b9604ed3a3d4
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	49f44b86-382e-4b23-afd8-b1de0e1e3f8f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	af3a1bdd-29f9-488a-9c59-3d9c367d6a68
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	4046ac8c-685d-46b9-a42b-cfcbc3c501fd
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	6bb18e31-de28-4b9b-bae9-d654f2f4ff75
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	123690bc-d9a4-4d65-9119-3c2eab3d9780
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	53fa1836-e6e9-42ea-9b5f-36585f09c134
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	2a218cbc-a6bd-4c70-86c9-c6f31b7bb1bd
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	54700490-dba0-402a-a45c-d7e0f5673e6f
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	1baeb684-fd79-4ee7-b2bd-a3d98ff15a50
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	1aef2cee-73a5-49e4-adf0-d8ee6214e120
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	7efed64f-b833-4096-a7e4-5f097426c06d
608743cf-30e7-4f2b-a7cd-2897ee92bf58	1baeb684-fd79-4ee7-b2bd-a3d98ff15a50
e7e491dc-4070-4170-b52a-1d13f695a45f	7efed64f-b833-4096-a7e4-5f097426c06d
e7e491dc-4070-4170-b52a-1d13f695a45f	54700490-dba0-402a-a45c-d7e0f5673e6f
f617e918-0737-4703-a328-011d8b1fdf09	2a841380-35c3-4532-915e-d15c5e9eb7a1
f617e918-0737-4703-a328-011d8b1fdf09	129ffd9c-3b4c-4a5e-a915-eb36be7383e4
f617e918-0737-4703-a328-011d8b1fdf09	0663162a-92a2-4652-9e60-d866877d741e
f617e918-0737-4703-a328-011d8b1fdf09	603d7ada-1e8f-4c41-8db2-9c8c85fab18d
f617e918-0737-4703-a328-011d8b1fdf09	8ab0ce0b-e9bc-4ea2-a25f-ae659556513d
f617e918-0737-4703-a328-011d8b1fdf09	765809ce-8f97-4f6c-aa54-ccdaadd42187
f617e918-0737-4703-a328-011d8b1fdf09	cb9cb36a-b396-45ec-83ac-a945b7ce5649
f617e918-0737-4703-a328-011d8b1fdf09	a34b6381-362a-4226-a2af-4e59e1b01532
f617e918-0737-4703-a328-011d8b1fdf09	2582e778-9a35-46d2-9900-2031fa95f4c9
f617e918-0737-4703-a328-011d8b1fdf09	fa687379-076d-4ad5-8deb-1c16265d06c4
f617e918-0737-4703-a328-011d8b1fdf09	55dc2353-023f-4921-a850-42409b86d08d
f617e918-0737-4703-a328-011d8b1fdf09	ec7024b4-7e85-491b-8c51-64a371584d12
f617e918-0737-4703-a328-011d8b1fdf09	fbcdb94c-7744-44f6-a867-f4455ec18b51
f617e918-0737-4703-a328-011d8b1fdf09	d9ad7e91-2c66-409b-9e9d-12cb04c96bdd
f617e918-0737-4703-a328-011d8b1fdf09	99fcb45e-25dc-43b6-9939-3388c21ac899
f617e918-0737-4703-a328-011d8b1fdf09	f7d7e1d8-49d8-44fc-a750-9d86e97c3c66
f617e918-0737-4703-a328-011d8b1fdf09	66fccf28-9d25-4a67-a6a5-8dcaa9eefaea
0663162a-92a2-4652-9e60-d866877d741e	d9ad7e91-2c66-409b-9e9d-12cb04c96bdd
0663162a-92a2-4652-9e60-d866877d741e	66fccf28-9d25-4a67-a6a5-8dcaa9eefaea
603d7ada-1e8f-4c41-8db2-9c8c85fab18d	99fcb45e-25dc-43b6-9939-3388c21ac899
a118805b-7c50-45cf-bbab-9521167264fe	a1810dd8-fd8d-4402-8866-92ec04157282
a118805b-7c50-45cf-bbab-9521167264fe	f1c84ec4-cfc4-477b-bdd7-31ce86e1e4f3
f1c84ec4-cfc4-477b-bdd7-31ce86e1e4f3	50661d19-612b-45e9-b8b6-3e5e795ff8c4
1d1b10e8-9a41-4bb6-aa4d-d31cb3533366	e556ee53-07dd-4c7d-b1af-312e00676362
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	8cf35bf4-b67e-436a-98a5-ed1848207241
f617e918-0737-4703-a328-011d8b1fdf09	d9b02dd6-55f8-4343-85b9-d2d5b1cf8be0
a118805b-7c50-45cf-bbab-9521167264fe	5071f0ba-2044-498c-ad2f-982338250bdf
a118805b-7c50-45cf-bbab-9521167264fe	71eebf99-43a7-4d18-a4f2-a639e0908561
\.


--
-- TOC entry 5819 (class 0 OID 61009)
-- Dependencies: 266
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
50665180-762a-4062-b370-fc59b9a41da6	\N	password	0fe5fe58-662e-4891-b442-205b990c162a	1743241513028	\N	{"value":"APa26AKlB+x6QTip1x/I0KPy1JKPFpiNVfRbxMPPyNT+tO0XxtNWb22YFwxdwWi+G25F7hTb+lOJugDkeWz7XQ==","salt":"9D0ZChfSt2vUoZ4AmJRihQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
15e74967-9f43-48cd-92ab-820159162354	\N	password	e6f4f152-a362-4dbe-a552-8d390bfe7b55	1743242133649	My password	{"value":"sTk51Kk6TNgVlG0hyaLVdCnnB7yH1JEs2P5kJBU2Bn2b2sDebItvaUEklw2V0fLVZHndi+a5W3NUT0rfSFG5KA==","salt":"OtSP3sQP2whND74v3c6UQw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
885ba3fb-7895-4898-9ca1-12d68066bb93	\N	password	bd234904-c74b-4f53-beff-f57f554665ef	1743242964535	My password	{"value":"7y5Cwr5SKsLgJn6PBWT743Yo2RBhK5Hh4w7DHyxpnyohYMLhaJG9z2daWCtLKCx6m8Ibh8znB3guEWXLEbqlMg==","salt":"1l3+7m9zaZ6AsKDAUymV2Q==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
5001c461-ddd6-46f3-ab36-e329b8535175	\N	password	8cc39632-d297-44d8-85c1-0adf483603ea	1748594569371	\N	{"value":"yGz9SDMbvUzNprJvna90DcaJRANcF/ZBoF9MLSKmi4CNfPRIcYzTFjD25RzD8UY0vpQyITOp/NasYltUMu3cSw==","salt":"19NFibceCotrJTSIioYlfg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
33c63b6f-357e-4ce5-bd2f-46bb147213b6	\N	password	a3d27beb-6e26-4df6-8a96-c68dcf625df1	1749046913932	\N	{"value":"V1h992Y5DCqAAEldUbhjG4voMFgUwOyFCI1TWrPo35w2u5uEcO/FbEmkhJNwpj/zZHq3uI3pwf6u7Unplgc9Hw==","salt":"KuMFaAEvuawAnmU+lTj2LQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
c446cf94-61de-433d-9317-5bbe672a8e04	\N	password	9152d26a-a4cd-4e04-a979-7d1756896ee0	1749047017747	\N	{"value":"dR8HglkJ11IBmKM7E7Qz05jsv3pwN2tNJpLZpO796A4h09rTU6zr0yl8ROyt5i12tMqKi8JW10j3Gd7AFigj4w==","salt":"DNklJk7+sy9J+N8LH0ztyQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- TOC entry 5820 (class 0 OID 61014)
-- Dependencies: 267
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-03-29 09:45:06.692527	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3241506032
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-03-29 09:45:06.70807	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	3241506032
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-03-29 09:45:06.772802	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	3241506032
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-03-29 09:45:06.779691	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3241506032
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-03-29 09:45:06.926003	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3241506032
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-03-29 09:45:06.934963	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	3241506032
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-03-29 09:45:07.086936	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3241506032
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-03-29 09:45:07.092554	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	3241506032
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-03-29 09:45:07.103447	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	3241506032
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-03-29 09:45:07.229566	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	3241506032
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-03-29 09:45:07.310343	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3241506032
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-03-29 09:45:07.314538	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3241506032
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-03-29 09:45:07.348702	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	3241506032
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-29 09:45:07.372672	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	3241506032
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-29 09:45:07.375367	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3241506032
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-29 09:45:07.379337	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	3241506032
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-29 09:45:07.385199	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	3241506032
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-03-29 09:45:07.442465	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	3241506032
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-03-29 09:45:07.496842	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3241506032
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-03-29 09:45:07.505087	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3241506032
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-29 09:45:09.13531	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	3241506032
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-29 09:45:07.508611	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	3241506032
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-29 09:45:07.513496	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	3241506032
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-03-29 09:45:07.56788	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	3241506032
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-03-29 09:45:07.578864	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3241506032
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-03-29 09:45:07.582363	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	3241506032
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-03-29 09:45:07.62727	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	3241506032
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-03-29 09:45:07.714691	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	3241506032
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-03-29 09:45:07.72228	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3241506032
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-03-29 09:45:07.788791	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	3241506032
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-03-29 09:45:07.806528	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	3241506032
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-03-29 09:45:07.838327	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	3241506032
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-03-29 09:45:07.851446	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	3241506032
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-29 09:45:07.864633	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3241506032
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-29 09:45:07.868186	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3241506032
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-29 09:45:07.914202	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	3241506032
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-03-29 09:45:07.920997	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	3241506032
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-29 09:45:07.927058	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3241506032
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-03-29 09:45:07.932893	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	3241506032
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-03-29 09:45:07.937794	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	3241506032
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-29 09:45:07.939876	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3241506032
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-29 09:45:07.943081	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	3241506032
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-03-29 09:45:07.954252	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	3241506032
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-29 09:45:08.066773	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	3241506032
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-03-29 09:45:08.072585	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	3241506032
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-29 09:45:08.080153	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3241506032
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-29 09:45:08.091711	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	3241506032
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-29 09:45:08.093936	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	3241506032
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-29 09:45:08.150227	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	3241506032
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-29 09:45:08.156647	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	3241506032
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-03-29 09:45:08.198856	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	3241506032
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-03-29 09:45:08.227479	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	3241506032
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-03-29 09:45:08.232468	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-03-29 09:45:08.237622	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	3241506032
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-03-29 09:45:08.242411	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	3241506032
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-29 09:45:08.250715	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	3241506032
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-29 09:45:08.258456	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	3241506032
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-29 09:45:08.288321	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	3241506032
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-29 09:45:08.42609	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	3241506032
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-03-29 09:45:08.461601	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	3241506032
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-03-29 09:45:08.472496	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	3241506032
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-29 09:45:08.491679	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	3241506032
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-29 09:45:08.498594	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	3241506032
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-03-29 09:45:08.504486	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3241506032
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-03-29 09:45:08.510981	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	3241506032
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-29 09:45:08.517045	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	3241506032
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-03-29 09:45:08.533971	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	3241506032
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-29 09:45:08.541277	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	3241506032
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-03-29 09:45:08.549481	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	3241506032
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-03-29 09:45:08.571867	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	3241506032
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-03-29 09:45:08.583555	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	3241506032
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-03-29 09:45:08.590983	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3241506032
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-29 09:45:08.604949	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3241506032
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-29 09:45:08.619649	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3241506032
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-29 09:45:08.622303	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	3241506032
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-29 09:45:08.663463	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	3241506032
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-29 09:45:08.67301	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	3241506032
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-29 09:45:08.679774	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	3241506032
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-29 09:45:08.683107	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	3241506032
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-29 09:45:08.709459	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	3241506032
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-29 09:45:08.712241	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	3241506032
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-29 09:45:08.72156	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	3241506032
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-29 09:45:08.724223	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3241506032
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-29 09:45:08.733951	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3241506032
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-29 09:45:08.736654	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	3241506032
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-29 09:45:08.746347	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3241506032
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-03-29 09:45:08.754592	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	3241506032
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-29 09:45:08.767442	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	3241506032
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-29 09:45:08.780028	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	3241506032
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.795955	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	3241506032
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.80965	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	3241506032
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.818592	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3241506032
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.83183	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	3241506032
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.834829	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3241506032
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.847309	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	3241506032
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.851052	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	3241506032
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-29 09:45:08.864829	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	3241506032
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.878195	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	3241506032
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.881134	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.907643	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.918643	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.921371	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.931347	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	3241506032
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-29 09:45:08.944642	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	3241506032
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-03-29 09:45:08.957378	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	3241506032
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-03-29 09:45:08.966062	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	3241506032
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-03-29 09:45:08.973978	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	3241506032
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-03-29 09:45:08.98693	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	3241506032
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-29 09:45:08.995939	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3241506032
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-29 09:45:08.998576	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	3241506032
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-29 09:45:09.013837	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-03-29 09:45:09.025992	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	3241506032
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-29 09:45:09.061278	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	3241506032
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-29 09:45:09.064792	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	3241506032
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-29 09:45:09.077902	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	3241506032
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-29 09:45:09.080758	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	3241506032
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-29 09:45:09.093665	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	3241506032
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-29 09:45:09.09971	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	3241506032
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-29 09:45:09.123795	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	3241506032
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-29 09:45:09.145392	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-29 09:45:09.155043	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3241506032
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-30 08:35:15.959772	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	8594115743
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-30 08:35:15.990255	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8594115743
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-30 08:35:16.006169	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	8594115743
\.


--
-- TOC entry 5821 (class 0 OID 61019)
-- Dependencies: 268
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 5822 (class 0 OID 61022)
-- Dependencies: 269
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	1c19ab5c-b6b7-48ee-a016-79c1789fd89b	f
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f5296789-81a7-4006-9119-cc32b2baab41	t
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	b4395185-aeb1-4446-bf2b-988d8f51e6a9	t
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	488627d1-bec8-4871-91ef-820441ddcac0	t
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	74700042-bde8-4c4d-b178-12554cc5652e	f
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7df18228-19ad-4ece-a63f-dd5d5c3308e8	f
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	df95f2e8-cf06-4a18-b996-e993aa273c00	t
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	eee8ee08-4889-4755-900f-f6fb8c3a0f2a	t
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	000e417f-1ead-409b-bfa6-55016cef6dd6	f
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	ee6c1968-7989-4b51-8e5b-45334e3e36d5	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	e852bf42-ddbb-458b-8216-2e1622c99b1b	f
d3c7eec2-b715-4576-ae52-eafaa022dbfb	10ac70c6-5f2b-496c-8805-5c913c6cf836	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	8b704fa0-732c-4f41-b813-5a23d92400ce	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	2e7cf264-4d58-445a-81df-2f0cd3a949dc	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	b5c169c4-f4c7-4c51-a9b2-688946b65720	f
d3c7eec2-b715-4576-ae52-eafaa022dbfb	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03	f
d3c7eec2-b715-4576-ae52-eafaa022dbfb	3385adea-c1f4-4835-a0b1-d07d8a5d4921	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	291b1b9b-6dd0-429b-99d3-f2953145d453	t
d3c7eec2-b715-4576-ae52-eafaa022dbfb	60603b1d-d04a-4b93-9e84-da5a10b90eb0	f
d3c7eec2-b715-4576-ae52-eafaa022dbfb	b05d1158-dc57-46a9-808e-148d356b1a41	t
535ccb56-a180-4def-9f05-660bd334f36f	ce5420b2-511a-40c1-a616-9a3540e17893	f
535ccb56-a180-4def-9f05-660bd334f36f	8081554b-1ecf-4294-86c1-c2a4b6bb526a	t
535ccb56-a180-4def-9f05-660bd334f36f	6c9dbb09-744f-4c8e-96d1-6a6859430cfd	t
535ccb56-a180-4def-9f05-660bd334f36f	82aead9b-99b2-4918-8d7b-f2e3182aabfc	t
535ccb56-a180-4def-9f05-660bd334f36f	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab	f
535ccb56-a180-4def-9f05-660bd334f36f	d56be853-823a-49f3-9393-c9a12877f40b	f
535ccb56-a180-4def-9f05-660bd334f36f	ceb3a9ae-ce56-429b-913f-9790b0e25615	t
535ccb56-a180-4def-9f05-660bd334f36f	f957de7a-83b6-4697-9af2-df4ed8eca247	t
535ccb56-a180-4def-9f05-660bd334f36f	a375e2da-75bb-493a-9915-bd36cb00d742	f
535ccb56-a180-4def-9f05-660bd334f36f	8f628aa6-3f38-4ac6-823c-8d15397804be	t
\.


--
-- TOC entry 5823 (class 0 OID 61026)
-- Dependencies: 270
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- TOC entry 5824 (class 0 OID 61031)
-- Dependencies: 271
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- TOC entry 5825 (class 0 OID 61036)
-- Dependencies: 272
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 5826 (class 0 OID 61041)
-- Dependencies: 273
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 5827 (class 0 OID 61044)
-- Dependencies: 274
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 5828 (class 0 OID 61049)
-- Dependencies: 275
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 5829 (class 0 OID 61052)
-- Dependencies: 276
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 5830 (class 0 OID 61058)
-- Dependencies: 277
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 5831 (class 0 OID 61061)
-- Dependencies: 278
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 5832 (class 0 OID 61066)
-- Dependencies: 279
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 5833 (class 0 OID 61071)
-- Dependencies: 280
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 5834 (class 0 OID 61077)
-- Dependencies: 281
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 5835 (class 0 OID 61080)
-- Dependencies: 282
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 5836 (class 0 OID 61091)
-- Dependencies: 283
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 5837 (class 0 OID 61096)
-- Dependencies: 284
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 5838 (class 0 OID 61101)
-- Dependencies: 285
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 5839 (class 0 OID 61106)
-- Dependencies: 286
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- TOC entry 5840 (class 0 OID 61109)
-- Dependencies: 287
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	${role_default-roles}	default-roles-master	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	\N
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	${role_admin}	admin	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	\N
c3c63302-7563-4e1a-8346-dd355f4271c2	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	${role_create-realm}	create-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	\N
2f55c677-8571-44bd-ad70-a6b48e9c4826	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_create-client}	create-client	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
a61f38d5-9791-4140-abcc-005be8856cec	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-realm}	view-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
e1c96c73-7511-4862-8973-b7adde5d7e99	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-users}	view-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
0c113da7-1011-420d-a06d-54e017d40381	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-clients}	view-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
8d163aef-1548-481a-affb-6214280f00b7	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-events}	view-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
bef2cb35-1f1f-4ee8-95f6-b7c122dd8898	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-identity-providers}	view-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
ddac3388-923c-4897-9d5d-67f432de6a30	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_view-authorization}	view-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
d9690da8-0265-4bd6-a891-b50be2f2fd42	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-realm}	manage-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
5a54c20a-9e80-4498-aff8-e7dde681c968	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-users}	manage-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
3009a6b7-378a-4d22-9f30-d402aeb3503e	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-clients}	manage-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
c4bc91de-cbef-429b-b86a-ae0e5bcd99ea	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-events}	manage-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
1bee03c6-d8b6-455e-b82d-6802097cd1cf	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-identity-providers}	manage-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
6c308bdc-1f11-4d27-b12f-064a7211301f	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_manage-authorization}	manage-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
98f58f7f-7e00-4355-bb32-a837d82adf4f	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_query-users}	query-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
d6ed4825-2651-43e4-9b14-eca1d9a436ac	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_query-clients}	query-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
065e978f-1d42-4258-a1e3-9d74d4d45a39	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_query-realms}	query-realms	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
5020db19-41ce-49a4-b8d3-01a3ae9dbb47	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_query-groups}	query-groups	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
df54a484-a1e4-4d9f-b5c0-0c8c20d44804	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_view-profile}	view-profile	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
99a902d0-7d9f-46d4-8b66-5bfa470fc2b9	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_manage-account}	manage-account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
cf7685f8-188d-4298-af54-a245d4643dd8	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_manage-account-links}	manage-account-links	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
3c6cb347-f578-4c0c-8500-de59586bd04f	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_view-applications}	view-applications	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
a2a7f387-e63b-4167-8251-29b87c9684d1	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_view-consent}	view-consent	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
c0dbd5b0-91cd-4a52-839f-90b16c1c09f5	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_manage-consent}	manage-consent	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
3f4e49e4-9fb3-4b1d-8323-33922d4f3452	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_view-groups}	view-groups	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
1bc439aa-6e3a-45ca-b107-413499df7adb	87776386-5f22-4d8f-8fcb-791558de1118	t	${role_delete-account}	delete-account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	87776386-5f22-4d8f-8fcb-791558de1118	\N
26cb5da2-be51-4383-9991-4fc6a46ecc5a	dac8a065-0be3-4a04-a4fa-a94138096ead	t	${role_read-token}	read-token	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	dac8a065-0be3-4a04-a4fa-a94138096ead	\N
596b95de-8fd9-473d-9c05-dbe33ff79c32	abb73e2b-8831-4aa5-b8d7-506d914c1baa	t	${role_impersonation}	impersonation	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	abb73e2b-8831-4aa5-b8d7-506d914c1baa	\N
213f051a-7bf2-46c9-a888-918f1a33ec9d	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	${role_offline-access}	offline_access	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	\N
718b9d47-19f1-421f-bec9-f90649486c95	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	${role_uma_authorization}	uma_authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	\N	\N
dc009e10-c242-43f6-9ce2-db07b2020ddd	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	${role_default-roles}	default-roles-golfshop	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N	\N
b4e751fe-0acc-43bd-82d3-1835d0533cdf	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_create-client}	create-client	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
2de02dae-50dc-4ff8-b091-17d313257557	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-realm}	view-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
177f36d3-2ae7-496c-94dc-ee5d9c56f871	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-users}	view-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
ba5df043-db47-41a4-9754-a0a99e6b0f3c	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-clients}	view-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
ac6a366a-f503-4286-a631-2fb5e31d6171	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-events}	view-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
8cc5334e-8e32-4bf0-8d78-df7c3b96c8c0	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-identity-providers}	view-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
26ec6132-ce03-46e3-99ef-18fbe54372f0	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_view-authorization}	view-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
24e8912c-b3d8-40ea-bb77-96fce85ad8d5	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-realm}	manage-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
ee105db7-892b-46f6-87b7-9b87f8d91f75	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-users}	manage-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
f893c3ec-afaf-4f82-9aa6-be0035776cbd	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-clients}	manage-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
6783fb11-9146-4298-8e65-5f33239fc11a	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-events}	manage-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
30e1693b-d49c-489b-ba13-ab28b456cbd3	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-identity-providers}	manage-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
fc9df704-c0d4-45c9-81e2-5b6e6f947b61	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_manage-authorization}	manage-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
f5599c3b-42eb-4937-b877-1b25aaa2760a	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_query-users}	query-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
f86caa13-b891-44eb-932f-413aaa5cbd89	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_query-clients}	query-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
07c1e640-4e70-4e10-a81a-8c28c2d877f7	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_query-realms}	query-realms	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
f44f9ad6-b76f-4b25-a18f-62c1368931fa	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_query-groups}	query-groups	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
08aead87-160e-4289-a06d-057a53ad565a	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_realm-admin}	realm-admin	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
19ffaa95-f7c1-4681-9f6b-feeffad74a2f	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_create-client}	create-client	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
20ada318-bab1-46b8-9f2c-806e6e01fba0	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-realm}	view-realm	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
057d31df-eca8-44b5-b629-bb66504ae031	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-users}	view-users	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
e125d87a-6064-4157-8433-559f428216f9	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-clients}	view-clients	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
d49a8a68-183e-4026-acc6-2996e06b0449	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-events}	view-events	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
555bd265-352f-4e3c-a918-81a684db3bde	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-identity-providers}	view-identity-providers	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
a3aa2e53-e459-4030-bc39-f1c5ff40d3c5	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_view-authorization}	view-authorization	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
4a01a00c-2b94-4820-ac21-4e17877853c9	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-realm}	manage-realm	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
2888906e-11da-4c60-8755-4502a5a2febd	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-users}	manage-users	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
8baeaa9f-90d0-4f87-a960-44eadf50e7ed	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-clients}	manage-clients	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
8cde7a77-e76a-40d6-9562-ac10d7b13e54	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-events}	manage-events	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
1d81cbc7-a848-47e9-87b4-31878afe0a00	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-identity-providers}	manage-identity-providers	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
eed3a0d2-c7f6-40d1-9b6d-78726921b12d	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_manage-authorization}	manage-authorization	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
af985581-8c07-48ea-adaf-9366b0f051d2	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_query-users}	query-users	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
7da2e140-ffee-42c5-81bb-870fcb2c43a6	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_query-clients}	query-clients	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
2f36d904-3025-4ff8-9009-abae750646d0	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_query-realms}	query-realms	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
9a3bbaf9-0da5-4e10-937d-fb4a61954f75	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_query-groups}	query-groups	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
2f5054e0-136f-4181-aa04-3a2d33fccbde	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_view-profile}	view-profile	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
812dfaf7-1f2c-47f9-b621-d064b40d852a	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_manage-account}	manage-account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
a0ab7693-4738-4b99-99a7-0fd7658e8cbb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_manage-account-links}	manage-account-links	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
7100e4f5-2c85-4e21-8f58-d1405b9704cf	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_view-applications}	view-applications	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
4076408c-8ec8-44de-b0af-9007eeb5e6de	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_view-consent}	view-consent	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
1f7bca78-d81d-476f-876f-6f5820c7250e	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_manage-consent}	manage-consent	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
02201b68-3c79-4bc3-a9e8-2ba035682a4d	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_view-groups}	view-groups	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
dc2a7bab-dd37-4a63-a1cd-8633b7f5d33a	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	t	${role_delete-account}	delete-account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0d0ec982-e518-4f82-a9de-d0d2d4b4108c	\N
87102fc4-5b66-4957-8470-531633f2170b	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	t	${role_impersonation}	impersonation	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	\N
3410c1c4-bff0-4cb1-be9e-fc4657cad827	9106d96e-381a-4552-9cad-0619fc3fbef4	t	${role_impersonation}	impersonation	d3c7eec2-b715-4576-ae52-eafaa022dbfb	9106d96e-381a-4552-9cad-0619fc3fbef4	\N
c1f071c8-e417-4922-b30a-29a77caea904	f69c19d3-aa6e-4dc2-8156-b963cd44ef37	t	${role_read-token}	read-token	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f69c19d3-aa6e-4dc2-8156-b963cd44ef37	\N
d86f3892-6e8b-490f-b8d5-212bc2bfbf4e	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	${role_offline-access}	offline_access	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N	\N
cfb934e0-dac7-4aca-8572-629a92f56107	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	${role_uma_authorization}	uma_authorization	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N	\N
d66b2629-c44f-4011-bfc5-ce39099fb288	212c93d9-721d-4a39-bac3-8f8a90aa993e	t	\N	uma_protection	d3c7eec2-b715-4576-ae52-eafaa022dbfb	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
db0638b4-e439-47c1-bf4c-7812952a3987	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	USER	USER	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N	\N
fd449160-613b-454d-92da-08f92d951256	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	ADMIN	ADMIN	d3c7eec2-b715-4576-ae52-eafaa022dbfb	\N	\N
a118805b-7c50-45cf-bbab-9521167264fe	535ccb56-a180-4def-9f05-660bd334f36f	f	${role_default-roles}	default-roles-innloggingbruker	535ccb56-a180-4def-9f05-660bd334f36f	\N	\N
1fffcb6f-fb3a-4492-889b-c7041048812f	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_create-client}	create-client	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
93caffc2-84d7-44af-8e60-d0e16787a920	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-realm}	view-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
e7e491dc-4070-4170-b52a-1d13f695a45f	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-users}	view-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
608743cf-30e7-4f2b-a7cd-2897ee92bf58	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-clients}	view-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
4a35fc4a-c6f9-4521-8794-28e51bc4e526	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-events}	view-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
972c9c10-3fa1-4fd1-84c8-b9604ed3a3d4	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-identity-providers}	view-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
49f44b86-382e-4b23-afd8-b1de0e1e3f8f	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_view-authorization}	view-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
af3a1bdd-29f9-488a-9c59-3d9c367d6a68	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-realm}	manage-realm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
4046ac8c-685d-46b9-a42b-cfcbc3c501fd	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-users}	manage-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
6bb18e31-de28-4b9b-bae9-d654f2f4ff75	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-clients}	manage-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
123690bc-d9a4-4d65-9119-3c2eab3d9780	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-events}	manage-events	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
53fa1836-e6e9-42ea-9b5f-36585f09c134	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-identity-providers}	manage-identity-providers	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
2a218cbc-a6bd-4c70-86c9-c6f31b7bb1bd	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_manage-authorization}	manage-authorization	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
54700490-dba0-402a-a45c-d7e0f5673e6f	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_query-users}	query-users	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
1baeb684-fd79-4ee7-b2bd-a3d98ff15a50	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_query-clients}	query-clients	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
1aef2cee-73a5-49e4-adf0-d8ee6214e120	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_query-realms}	query-realms	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
7efed64f-b833-4096-a7e4-5f097426c06d	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_query-groups}	query-groups	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
f617e918-0737-4703-a328-011d8b1fdf09	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_realm-admin}	realm-admin	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
2a841380-35c3-4532-915e-d15c5e9eb7a1	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_create-client}	create-client	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
129ffd9c-3b4c-4a5e-a915-eb36be7383e4	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-realm}	view-realm	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
0663162a-92a2-4652-9e60-d866877d741e	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-users}	view-users	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
603d7ada-1e8f-4c41-8db2-9c8c85fab18d	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-clients}	view-clients	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
8ab0ce0b-e9bc-4ea2-a25f-ae659556513d	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-events}	view-events	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
765809ce-8f97-4f6c-aa54-ccdaadd42187	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-identity-providers}	view-identity-providers	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
cb9cb36a-b396-45ec-83ac-a945b7ce5649	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_view-authorization}	view-authorization	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
a34b6381-362a-4226-a2af-4e59e1b01532	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-realm}	manage-realm	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
2582e778-9a35-46d2-9900-2031fa95f4c9	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-users}	manage-users	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
fa687379-076d-4ad5-8deb-1c16265d06c4	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-clients}	manage-clients	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
55dc2353-023f-4921-a850-42409b86d08d	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-events}	manage-events	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
ec7024b4-7e85-491b-8c51-64a371584d12	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-identity-providers}	manage-identity-providers	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
fbcdb94c-7744-44f6-a867-f4455ec18b51	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_manage-authorization}	manage-authorization	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
d9ad7e91-2c66-409b-9e9d-12cb04c96bdd	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_query-users}	query-users	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
99fcb45e-25dc-43b6-9939-3388c21ac899	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_query-clients}	query-clients	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
f7d7e1d8-49d8-44fc-a750-9d86e97c3c66	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_query-realms}	query-realms	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
66fccf28-9d25-4a67-a6a5-8dcaa9eefaea	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_query-groups}	query-groups	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
a1810dd8-fd8d-4402-8866-92ec04157282	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_view-profile}	view-profile	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
f1c84ec4-cfc4-477b-bdd7-31ce86e1e4f3	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_manage-account}	manage-account	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
50661d19-612b-45e9-b8b6-3e5e795ff8c4	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_manage-account-links}	manage-account-links	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
270ee551-b455-48a3-9069-037bf9507a9a	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_view-applications}	view-applications	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
e556ee53-07dd-4c7d-b1af-312e00676362	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_view-consent}	view-consent	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
1d1b10e8-9a41-4bb6-aa4d-d31cb3533366	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_manage-consent}	manage-consent	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
1a3e59f2-538c-4097-9fec-cb28e6b6153a	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_view-groups}	view-groups	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
2a198cc4-9a08-430a-847d-bd7a082ac559	342f8d7f-3d22-4696-8ec4-5420ee87df9e	t	${role_delete-account}	delete-account	535ccb56-a180-4def-9f05-660bd334f36f	342f8d7f-3d22-4696-8ec4-5420ee87df9e	\N
8cf35bf4-b67e-436a-98a5-ed1848207241	7286d85d-38fd-4102-a563-09cfaed39e3e	t	${role_impersonation}	impersonation	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	7286d85d-38fd-4102-a563-09cfaed39e3e	\N
d9b02dd6-55f8-4343-85b9-d2d5b1cf8be0	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	t	${role_impersonation}	impersonation	535ccb56-a180-4def-9f05-660bd334f36f	6017e07b-f65d-4b79-9a6d-11854ed2d1c1	\N
42c812a1-12f6-4404-8594-5b9414a6490c	a259c734-1af0-4b39-85fb-c8bcb2957d43	t	${role_read-token}	read-token	535ccb56-a180-4def-9f05-660bd334f36f	a259c734-1af0-4b39-85fb-c8bcb2957d43	\N
5071f0ba-2044-498c-ad2f-982338250bdf	535ccb56-a180-4def-9f05-660bd334f36f	f	${role_offline-access}	offline_access	535ccb56-a180-4def-9f05-660bd334f36f	\N	\N
71eebf99-43a7-4d18-a4f2-a639e0908561	535ccb56-a180-4def-9f05-660bd334f36f	f	${role_uma_authorization}	uma_authorization	535ccb56-a180-4def-9f05-660bd334f36f	\N	\N
187838d6-3e0a-4a45-a2a6-2f4cbf92d13f	a394b610-97f4-4bd1-b512-9cf01093fa82	t		USER	535ccb56-a180-4def-9f05-660bd334f36f	a394b610-97f4-4bd1-b512-9cf01093fa82	\N
3a9c3b6c-956d-47ed-999c-1ec2977b293c	535ccb56-a180-4def-9f05-660bd334f36f	f		USER	535ccb56-a180-4def-9f05-660bd334f36f	\N	\N
\.


--
-- TOC entry 5841 (class 0 OID 61115)
-- Dependencies: 288
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.migration_model (id, version, update_time) FROM stdin;
lo2p9	24.0.1	1743241509
nf5gg	24.0.3	1748594119
\.


--
-- TOC entry 5842 (class 0 OID 61119)
-- Dependencies: 289
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 5843 (class 0 OID 61126)
-- Dependencies: 290
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 5844 (class 0 OID 61132)
-- Dependencies: 291
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.policy_config (policy_id, name, value) FROM stdin;
d9e1d0e4-e798-4958-bcbd-082729c1a5c3	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
28fb5e66-76ce-449b-bc7f-4b795ca3433c	defaultResourceType	urn:golfstore-backend:resources:default
\.


--
-- TOC entry 5845 (class 0 OID 61137)
-- Dependencies: 292
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
d2b617de-8a58-4cbf-968e-8608653ce56a	audience resolve	openid-connect	oidc-audience-resolve-mapper	93555091-c257-4da0-a8d8-0af76f37af12	\N
724dfebe-394e-4801-8d26-f2a36ffe611c	locale	openid-connect	oidc-usermodel-attribute-mapper	9ac44be8-ce0e-46aa-8116-57a9e4dfc028	\N
9dc00e0e-19cd-4572-af8b-aaa5a5cf13dc	role list	saml	saml-role-list-mapper	\N	f5296789-81a7-4006-9119-cc32b2baab41
c951413c-995b-4062-be9a-c0172f539943	full name	openid-connect	oidc-full-name-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
f13216c0-c27a-4470-88be-3a7e3d66fad3	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
1860fdfa-606f-49ba-9456-ce5eb6c113cc	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
c941f55f-0bc3-4444-b9ab-c360160dfe96	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
514155f5-1b1d-4129-98f7-c733861714de	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
88f2a81c-44bd-4bd4-ab58-38184442af32	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
db77d59d-bcfe-422c-bc57-631c7a37d39a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
2558c2cf-b18f-4179-b731-6a59cc18a407	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
f5f24165-2cc9-4c39-b055-2585cccd5578	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
c13894db-630c-490d-a448-8961c76bd55c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b4395185-aeb1-4446-bf2b-988d8f51e6a9
24b60cde-fecf-45db-814c-465d397cd201	email	openid-connect	oidc-usermodel-attribute-mapper	\N	488627d1-bec8-4871-91ef-820441ddcac0
7700c5ea-e055-4f39-a2b0-427db37c0df7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	488627d1-bec8-4871-91ef-820441ddcac0
81f3999e-5a85-4052-99c0-e2c02f45d9cb	address	openid-connect	oidc-address-mapper	\N	74700042-bde8-4c4d-b178-12554cc5652e
ffdc74ea-6392-4b57-b43f-d93b778f7663	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	7df18228-19ad-4ece-a63f-dd5d5c3308e8
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	7df18228-19ad-4ece-a63f-dd5d5c3308e8
313b205c-8ef8-4224-9988-653d227412d9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	df95f2e8-cf06-4a18-b996-e993aa273c00
fb604e81-899f-4c40-9368-9c46a88b0ff1	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	df95f2e8-cf06-4a18-b996-e993aa273c00
e3ddaaf1-0215-4419-8cd9-2ec3c92e3e99	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	df95f2e8-cf06-4a18-b996-e993aa273c00
da9d5e7a-8ab9-4348-a90b-5705f1d08d39	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	eee8ee08-4889-4755-900f-f6fb8c3a0f2a
9ba331dd-973c-4159-97c4-f483d96e5077	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	000e417f-1ead-409b-bfa6-55016cef6dd6
c1e8e8c9-87fd-4173-a64c-815d70c22f80	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	000e417f-1ead-409b-bfa6-55016cef6dd6
523be5b8-9f84-47b7-9ba2-ae4d96a8680a	acr loa level	openid-connect	oidc-acr-mapper	\N	ee6c1968-7989-4b51-8e5b-45334e3e36d5
a30fb426-e1ae-4ffd-b4ea-30c52ded0fc9	audience resolve	openid-connect	oidc-audience-resolve-mapper	28cc48d5-69de-4f31-88e0-71f449cc1a0e	\N
fd23eb21-a355-465b-b517-30bf48f143f2	role list	saml	saml-role-list-mapper	\N	10ac70c6-5f2b-496c-8805-5c913c6cf836
3f258160-c031-4b9d-83ba-a464c1189bbd	full name	openid-connect	oidc-full-name-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
e75449a1-cada-42ce-aa61-1ed433401b9c	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
c1864d96-3100-4e49-8143-967199f25765	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
4643cdf7-344e-4c7d-b4a4-977c0eecffce	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	username	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
a6e13358-b9fd-4a7c-84c5-85430f243430	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
934f164e-30db-47a8-9aaf-48da0dca180a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
5106f062-476e-4225-85a6-055ab31d27a8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
5b936f7f-62fb-4ed0-9532-c4c43f848bed	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
4244660c-01bc-414b-b080-d2e84c30781e	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
2d8e7126-885a-45ef-9414-75e9b0e72f6c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8b704fa0-732c-4f41-b813-5a23d92400ce
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	email	openid-connect	oidc-usermodel-attribute-mapper	\N	2e7cf264-4d58-445a-81df-2f0cd3a949dc
5490a671-b91d-4e68-b884-d5317b2382d7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2e7cf264-4d58-445a-81df-2f0cd3a949dc
7eb984a2-1347-474e-9723-61c83c125911	address	openid-connect	oidc-address-mapper	\N	b5c169c4-f4c7-4c51-a9b2-688946b65720
64062a2d-5476-4cad-8a86-24b51aeb54f0	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03
6d0a92f6-f6ca-40db-8efa-432fac658905	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9e4418ef-64a1-41fb-8d7a-a0f809b9ac03
62944f38-6780-4d59-8d6f-bcc702b0dfe1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	3385adea-c1f4-4835-a0b1-d07d8a5d4921
11d40849-22dd-474d-8d64-236513efa71d	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	3385adea-c1f4-4835-a0b1-d07d8a5d4921
7db7503c-c285-4570-b268-75e747c04119	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	3385adea-c1f4-4835-a0b1-d07d8a5d4921
7a157299-bcb2-405e-9fcb-7897337217ef	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	291b1b9b-6dd0-429b-99d3-f2953145d453
bda6c9bf-f473-40c1-98c0-109008779110	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	60603b1d-d04a-4b93-9e84-da5a10b90eb0
4b677ca1-dd56-48f6-801b-5643b1889b45	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	60603b1d-d04a-4b93-9e84-da5a10b90eb0
9cd524e4-eb9d-4c85-aa5d-9767ae6502ab	acr loa level	openid-connect	oidc-acr-mapper	\N	b05d1158-dc57-46a9-808e-148d356b1a41
a21c8cac-e154-4587-8e80-a93d1fdaa493	locale	openid-connect	oidc-usermodel-attribute-mapper	83d156ce-eb02-4415-a71e-9515f5e2fcee	\N
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
21542434-54a0-4fc8-a0d8-5b42b8a70e94	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
33c50a08-0e44-4f4a-ada1-6926dc83beb1	adress	openid-connect	oidc-usermodel-attribute-mapper	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	phone	openid-connect	oidc-usermodel-attribute-mapper	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
2c72184d-3edd-4ee5-873c-89600d229736	audience resolve	openid-connect	oidc-audience-resolve-mapper	1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	\N
b0dc7527-60a0-4a26-ace6-98d059318f3e	role list	saml	saml-role-list-mapper	\N	8081554b-1ecf-4294-86c1-c2a4b6bb526a
797711a8-3ce8-45ab-8976-1b9737c9ce4a	full name	openid-connect	oidc-full-name-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
f3fe4d57-231e-4d32-9cec-0fbe3655d301	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
c16a244b-66b7-42f4-875b-5d4633b47890	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
487dec09-2fac-4d31-9268-147f1e340d47	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
421253ad-26cd-4ecd-98fa-b9c3849250d1	username	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
b8cb780e-deda-4a9a-8876-254d3a2046be	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
14a8d61b-bbae-4279-b81a-340b91fe1ca0	website	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
bc529540-bef0-44d5-9068-1aca321aee2e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
5f066e27-503f-474d-af81-db7c203f7c29	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
72d24de4-7e46-4406-ac9a-94f402f5862a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9dbb09-744f-4c8e-96d1-6a6859430cfd
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	email	openid-connect	oidc-usermodel-attribute-mapper	\N	82aead9b-99b2-4918-8d7b-f2e3182aabfc
d4eaa563-982d-4b10-bc30-b736ae4295fa	email verified	openid-connect	oidc-usermodel-property-mapper	\N	82aead9b-99b2-4918-8d7b-f2e3182aabfc
a55e50f2-0d34-4099-9712-16f15346babb	address	openid-connect	oidc-address-mapper	\N	d4716eee-91da-4cdb-9d73-a9aa7cbd63ab
12b2a73a-877b-4707-b292-501c014af2a5	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d56be853-823a-49f3-9393-c9a12877f40b
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d56be853-823a-49f3-9393-c9a12877f40b
7684363b-02a2-46ff-bdb0-25d25925005c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	ceb3a9ae-ce56-429b-913f-9790b0e25615
1c3c0118-cc50-4506-9203-a7fb64471c24	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	ceb3a9ae-ce56-429b-913f-9790b0e25615
7e0b5d27-9c42-4b12-bae7-8f50fedcadcb	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	ceb3a9ae-ce56-429b-913f-9790b0e25615
3244eb77-1ad1-49b4-9ab1-077a6fad4147	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	f957de7a-83b6-4697-9af2-df4ed8eca247
1cf6abe2-423e-4a10-acbf-f26a5130fae6	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a375e2da-75bb-493a-9915-bd36cb00d742
ace1562c-a5d7-4a69-a7a7-4385b3713635	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a375e2da-75bb-493a-9915-bd36cb00d742
e549df7a-25b1-4cb0-89fb-1a4b4e09dbb4	acr loa level	openid-connect	oidc-acr-mapper	\N	8f628aa6-3f38-4ac6-823c-8d15397804be
e4a8d9e9-14ca-4563-809b-6821dbc804e7	locale	openid-connect	oidc-usermodel-attribute-mapper	2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	\N
\.


--
-- TOC entry 5846 (class 0 OID 61142)
-- Dependencies: 293
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
724dfebe-394e-4801-8d26-f2a36ffe611c	true	introspection.token.claim
724dfebe-394e-4801-8d26-f2a36ffe611c	true	userinfo.token.claim
724dfebe-394e-4801-8d26-f2a36ffe611c	locale	user.attribute
724dfebe-394e-4801-8d26-f2a36ffe611c	true	id.token.claim
724dfebe-394e-4801-8d26-f2a36ffe611c	true	access.token.claim
724dfebe-394e-4801-8d26-f2a36ffe611c	locale	claim.name
724dfebe-394e-4801-8d26-f2a36ffe611c	String	jsonType.label
9dc00e0e-19cd-4572-af8b-aaa5a5cf13dc	false	single
9dc00e0e-19cd-4572-af8b-aaa5a5cf13dc	Basic	attribute.nameformat
9dc00e0e-19cd-4572-af8b-aaa5a5cf13dc	Role	attribute.name
1860fdfa-606f-49ba-9456-ce5eb6c113cc	true	introspection.token.claim
1860fdfa-606f-49ba-9456-ce5eb6c113cc	true	userinfo.token.claim
1860fdfa-606f-49ba-9456-ce5eb6c113cc	middleName	user.attribute
1860fdfa-606f-49ba-9456-ce5eb6c113cc	true	id.token.claim
1860fdfa-606f-49ba-9456-ce5eb6c113cc	true	access.token.claim
1860fdfa-606f-49ba-9456-ce5eb6c113cc	middle_name	claim.name
1860fdfa-606f-49ba-9456-ce5eb6c113cc	String	jsonType.label
2558c2cf-b18f-4179-b731-6a59cc18a407	true	introspection.token.claim
2558c2cf-b18f-4179-b731-6a59cc18a407	true	userinfo.token.claim
2558c2cf-b18f-4179-b731-6a59cc18a407	birthdate	user.attribute
2558c2cf-b18f-4179-b731-6a59cc18a407	true	id.token.claim
2558c2cf-b18f-4179-b731-6a59cc18a407	true	access.token.claim
2558c2cf-b18f-4179-b731-6a59cc18a407	birthdate	claim.name
2558c2cf-b18f-4179-b731-6a59cc18a407	String	jsonType.label
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	true	introspection.token.claim
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	true	userinfo.token.claim
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	username	user.attribute
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	true	id.token.claim
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	true	access.token.claim
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	preferred_username	claim.name
390f85b7-a07e-40b3-8f85-f6b03d5b95dd	String	jsonType.label
514155f5-1b1d-4129-98f7-c733861714de	true	introspection.token.claim
514155f5-1b1d-4129-98f7-c733861714de	true	userinfo.token.claim
514155f5-1b1d-4129-98f7-c733861714de	picture	user.attribute
514155f5-1b1d-4129-98f7-c733861714de	true	id.token.claim
514155f5-1b1d-4129-98f7-c733861714de	true	access.token.claim
514155f5-1b1d-4129-98f7-c733861714de	picture	claim.name
514155f5-1b1d-4129-98f7-c733861714de	String	jsonType.label
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	true	introspection.token.claim
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	true	userinfo.token.claim
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	lastName	user.attribute
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	true	id.token.claim
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	true	access.token.claim
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	family_name	claim.name
7b8f8ec4-59e8-4df0-adbb-d1fb105e7fbe	String	jsonType.label
88f2a81c-44bd-4bd4-ab58-38184442af32	true	introspection.token.claim
88f2a81c-44bd-4bd4-ab58-38184442af32	true	userinfo.token.claim
88f2a81c-44bd-4bd4-ab58-38184442af32	website	user.attribute
88f2a81c-44bd-4bd4-ab58-38184442af32	true	id.token.claim
88f2a81c-44bd-4bd4-ab58-38184442af32	true	access.token.claim
88f2a81c-44bd-4bd4-ab58-38184442af32	website	claim.name
88f2a81c-44bd-4bd4-ab58-38184442af32	String	jsonType.label
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	true	introspection.token.claim
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	true	userinfo.token.claim
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	locale	user.attribute
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	true	id.token.claim
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	true	access.token.claim
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	locale	claim.name
ab6caba8-acd9-4fc3-83d4-f0f4ed73c403	String	jsonType.label
c13894db-630c-490d-a448-8961c76bd55c	true	introspection.token.claim
c13894db-630c-490d-a448-8961c76bd55c	true	userinfo.token.claim
c13894db-630c-490d-a448-8961c76bd55c	updatedAt	user.attribute
c13894db-630c-490d-a448-8961c76bd55c	true	id.token.claim
c13894db-630c-490d-a448-8961c76bd55c	true	access.token.claim
c13894db-630c-490d-a448-8961c76bd55c	updated_at	claim.name
c13894db-630c-490d-a448-8961c76bd55c	long	jsonType.label
c941f55f-0bc3-4444-b9ab-c360160dfe96	true	introspection.token.claim
c941f55f-0bc3-4444-b9ab-c360160dfe96	true	userinfo.token.claim
c941f55f-0bc3-4444-b9ab-c360160dfe96	nickname	user.attribute
c941f55f-0bc3-4444-b9ab-c360160dfe96	true	id.token.claim
c941f55f-0bc3-4444-b9ab-c360160dfe96	true	access.token.claim
c941f55f-0bc3-4444-b9ab-c360160dfe96	nickname	claim.name
c941f55f-0bc3-4444-b9ab-c360160dfe96	String	jsonType.label
c951413c-995b-4062-be9a-c0172f539943	true	introspection.token.claim
c951413c-995b-4062-be9a-c0172f539943	true	userinfo.token.claim
c951413c-995b-4062-be9a-c0172f539943	true	id.token.claim
c951413c-995b-4062-be9a-c0172f539943	true	access.token.claim
db77d59d-bcfe-422c-bc57-631c7a37d39a	true	introspection.token.claim
db77d59d-bcfe-422c-bc57-631c7a37d39a	true	userinfo.token.claim
db77d59d-bcfe-422c-bc57-631c7a37d39a	gender	user.attribute
db77d59d-bcfe-422c-bc57-631c7a37d39a	true	id.token.claim
db77d59d-bcfe-422c-bc57-631c7a37d39a	true	access.token.claim
db77d59d-bcfe-422c-bc57-631c7a37d39a	gender	claim.name
db77d59d-bcfe-422c-bc57-631c7a37d39a	String	jsonType.label
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	true	introspection.token.claim
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	true	userinfo.token.claim
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	profile	user.attribute
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	true	id.token.claim
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	true	access.token.claim
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	profile	claim.name
eb228b8a-74bc-426a-a6ac-c8e993aebdd2	String	jsonType.label
f13216c0-c27a-4470-88be-3a7e3d66fad3	true	introspection.token.claim
f13216c0-c27a-4470-88be-3a7e3d66fad3	true	userinfo.token.claim
f13216c0-c27a-4470-88be-3a7e3d66fad3	firstName	user.attribute
f13216c0-c27a-4470-88be-3a7e3d66fad3	true	id.token.claim
f13216c0-c27a-4470-88be-3a7e3d66fad3	true	access.token.claim
f13216c0-c27a-4470-88be-3a7e3d66fad3	given_name	claim.name
f13216c0-c27a-4470-88be-3a7e3d66fad3	String	jsonType.label
f5f24165-2cc9-4c39-b055-2585cccd5578	true	introspection.token.claim
f5f24165-2cc9-4c39-b055-2585cccd5578	true	userinfo.token.claim
f5f24165-2cc9-4c39-b055-2585cccd5578	zoneinfo	user.attribute
f5f24165-2cc9-4c39-b055-2585cccd5578	true	id.token.claim
f5f24165-2cc9-4c39-b055-2585cccd5578	true	access.token.claim
f5f24165-2cc9-4c39-b055-2585cccd5578	zoneinfo	claim.name
f5f24165-2cc9-4c39-b055-2585cccd5578	String	jsonType.label
24b60cde-fecf-45db-814c-465d397cd201	true	introspection.token.claim
24b60cde-fecf-45db-814c-465d397cd201	true	userinfo.token.claim
24b60cde-fecf-45db-814c-465d397cd201	email	user.attribute
24b60cde-fecf-45db-814c-465d397cd201	true	id.token.claim
24b60cde-fecf-45db-814c-465d397cd201	true	access.token.claim
24b60cde-fecf-45db-814c-465d397cd201	email	claim.name
24b60cde-fecf-45db-814c-465d397cd201	String	jsonType.label
7700c5ea-e055-4f39-a2b0-427db37c0df7	true	introspection.token.claim
7700c5ea-e055-4f39-a2b0-427db37c0df7	true	userinfo.token.claim
7700c5ea-e055-4f39-a2b0-427db37c0df7	emailVerified	user.attribute
7700c5ea-e055-4f39-a2b0-427db37c0df7	true	id.token.claim
7700c5ea-e055-4f39-a2b0-427db37c0df7	true	access.token.claim
7700c5ea-e055-4f39-a2b0-427db37c0df7	email_verified	claim.name
7700c5ea-e055-4f39-a2b0-427db37c0df7	boolean	jsonType.label
81f3999e-5a85-4052-99c0-e2c02f45d9cb	formatted	user.attribute.formatted
81f3999e-5a85-4052-99c0-e2c02f45d9cb	country	user.attribute.country
81f3999e-5a85-4052-99c0-e2c02f45d9cb	true	introspection.token.claim
81f3999e-5a85-4052-99c0-e2c02f45d9cb	postal_code	user.attribute.postal_code
81f3999e-5a85-4052-99c0-e2c02f45d9cb	true	userinfo.token.claim
81f3999e-5a85-4052-99c0-e2c02f45d9cb	street	user.attribute.street
81f3999e-5a85-4052-99c0-e2c02f45d9cb	true	id.token.claim
81f3999e-5a85-4052-99c0-e2c02f45d9cb	region	user.attribute.region
81f3999e-5a85-4052-99c0-e2c02f45d9cb	true	access.token.claim
81f3999e-5a85-4052-99c0-e2c02f45d9cb	locality	user.attribute.locality
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	true	introspection.token.claim
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	true	userinfo.token.claim
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	phoneNumberVerified	user.attribute
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	true	id.token.claim
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	true	access.token.claim
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	phone_number_verified	claim.name
fcf39d67-cb55-4dcb-b4bf-618e94dc9a88	boolean	jsonType.label
ffdc74ea-6392-4b57-b43f-d93b778f7663	true	introspection.token.claim
ffdc74ea-6392-4b57-b43f-d93b778f7663	true	userinfo.token.claim
ffdc74ea-6392-4b57-b43f-d93b778f7663	phoneNumber	user.attribute
ffdc74ea-6392-4b57-b43f-d93b778f7663	true	id.token.claim
ffdc74ea-6392-4b57-b43f-d93b778f7663	true	access.token.claim
ffdc74ea-6392-4b57-b43f-d93b778f7663	phone_number	claim.name
ffdc74ea-6392-4b57-b43f-d93b778f7663	String	jsonType.label
313b205c-8ef8-4224-9988-653d227412d9	true	introspection.token.claim
313b205c-8ef8-4224-9988-653d227412d9	true	multivalued
313b205c-8ef8-4224-9988-653d227412d9	foo	user.attribute
313b205c-8ef8-4224-9988-653d227412d9	true	access.token.claim
313b205c-8ef8-4224-9988-653d227412d9	realm_access.roles	claim.name
313b205c-8ef8-4224-9988-653d227412d9	String	jsonType.label
e3ddaaf1-0215-4419-8cd9-2ec3c92e3e99	true	introspection.token.claim
e3ddaaf1-0215-4419-8cd9-2ec3c92e3e99	true	access.token.claim
fb604e81-899f-4c40-9368-9c46a88b0ff1	true	introspection.token.claim
fb604e81-899f-4c40-9368-9c46a88b0ff1	true	multivalued
fb604e81-899f-4c40-9368-9c46a88b0ff1	foo	user.attribute
fb604e81-899f-4c40-9368-9c46a88b0ff1	true	access.token.claim
fb604e81-899f-4c40-9368-9c46a88b0ff1	resource_access.${client_id}.roles	claim.name
fb604e81-899f-4c40-9368-9c46a88b0ff1	String	jsonType.label
da9d5e7a-8ab9-4348-a90b-5705f1d08d39	true	introspection.token.claim
da9d5e7a-8ab9-4348-a90b-5705f1d08d39	true	access.token.claim
9ba331dd-973c-4159-97c4-f483d96e5077	true	introspection.token.claim
9ba331dd-973c-4159-97c4-f483d96e5077	true	userinfo.token.claim
9ba331dd-973c-4159-97c4-f483d96e5077	username	user.attribute
9ba331dd-973c-4159-97c4-f483d96e5077	true	id.token.claim
9ba331dd-973c-4159-97c4-f483d96e5077	true	access.token.claim
9ba331dd-973c-4159-97c4-f483d96e5077	upn	claim.name
9ba331dd-973c-4159-97c4-f483d96e5077	String	jsonType.label
c1e8e8c9-87fd-4173-a64c-815d70c22f80	true	introspection.token.claim
c1e8e8c9-87fd-4173-a64c-815d70c22f80	true	multivalued
c1e8e8c9-87fd-4173-a64c-815d70c22f80	foo	user.attribute
c1e8e8c9-87fd-4173-a64c-815d70c22f80	true	id.token.claim
c1e8e8c9-87fd-4173-a64c-815d70c22f80	true	access.token.claim
c1e8e8c9-87fd-4173-a64c-815d70c22f80	groups	claim.name
c1e8e8c9-87fd-4173-a64c-815d70c22f80	String	jsonType.label
523be5b8-9f84-47b7-9ba2-ae4d96a8680a	true	introspection.token.claim
523be5b8-9f84-47b7-9ba2-ae4d96a8680a	true	id.token.claim
523be5b8-9f84-47b7-9ba2-ae4d96a8680a	true	access.token.claim
fd23eb21-a355-465b-b517-30bf48f143f2	false	single
fd23eb21-a355-465b-b517-30bf48f143f2	Basic	attribute.nameformat
fd23eb21-a355-465b-b517-30bf48f143f2	Role	attribute.name
2d8e7126-885a-45ef-9414-75e9b0e72f6c	true	introspection.token.claim
2d8e7126-885a-45ef-9414-75e9b0e72f6c	true	userinfo.token.claim
2d8e7126-885a-45ef-9414-75e9b0e72f6c	updatedAt	user.attribute
2d8e7126-885a-45ef-9414-75e9b0e72f6c	true	id.token.claim
2d8e7126-885a-45ef-9414-75e9b0e72f6c	true	access.token.claim
2d8e7126-885a-45ef-9414-75e9b0e72f6c	updated_at	claim.name
2d8e7126-885a-45ef-9414-75e9b0e72f6c	long	jsonType.label
3f258160-c031-4b9d-83ba-a464c1189bbd	true	introspection.token.claim
3f258160-c031-4b9d-83ba-a464c1189bbd	true	userinfo.token.claim
3f258160-c031-4b9d-83ba-a464c1189bbd	true	id.token.claim
3f258160-c031-4b9d-83ba-a464c1189bbd	true	access.token.claim
4244660c-01bc-414b-b080-d2e84c30781e	true	introspection.token.claim
4244660c-01bc-414b-b080-d2e84c30781e	true	userinfo.token.claim
4244660c-01bc-414b-b080-d2e84c30781e	locale	user.attribute
4244660c-01bc-414b-b080-d2e84c30781e	true	id.token.claim
4244660c-01bc-414b-b080-d2e84c30781e	true	access.token.claim
4244660c-01bc-414b-b080-d2e84c30781e	locale	claim.name
4244660c-01bc-414b-b080-d2e84c30781e	String	jsonType.label
4643cdf7-344e-4c7d-b4a4-977c0eecffce	true	introspection.token.claim
4643cdf7-344e-4c7d-b4a4-977c0eecffce	true	userinfo.token.claim
4643cdf7-344e-4c7d-b4a4-977c0eecffce	nickname	user.attribute
4643cdf7-344e-4c7d-b4a4-977c0eecffce	true	id.token.claim
4643cdf7-344e-4c7d-b4a4-977c0eecffce	true	access.token.claim
4643cdf7-344e-4c7d-b4a4-977c0eecffce	nickname	claim.name
4643cdf7-344e-4c7d-b4a4-977c0eecffce	String	jsonType.label
5106f062-476e-4225-85a6-055ab31d27a8	true	introspection.token.claim
5106f062-476e-4225-85a6-055ab31d27a8	true	userinfo.token.claim
5106f062-476e-4225-85a6-055ab31d27a8	birthdate	user.attribute
5106f062-476e-4225-85a6-055ab31d27a8	true	id.token.claim
5106f062-476e-4225-85a6-055ab31d27a8	true	access.token.claim
5106f062-476e-4225-85a6-055ab31d27a8	birthdate	claim.name
5106f062-476e-4225-85a6-055ab31d27a8	String	jsonType.label
5b936f7f-62fb-4ed0-9532-c4c43f848bed	true	introspection.token.claim
5b936f7f-62fb-4ed0-9532-c4c43f848bed	true	userinfo.token.claim
5b936f7f-62fb-4ed0-9532-c4c43f848bed	zoneinfo	user.attribute
5b936f7f-62fb-4ed0-9532-c4c43f848bed	true	id.token.claim
5b936f7f-62fb-4ed0-9532-c4c43f848bed	true	access.token.claim
5b936f7f-62fb-4ed0-9532-c4c43f848bed	zoneinfo	claim.name
5b936f7f-62fb-4ed0-9532-c4c43f848bed	String	jsonType.label
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	true	introspection.token.claim
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	true	userinfo.token.claim
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	website	user.attribute
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	true	id.token.claim
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	true	access.token.claim
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	website	claim.name
724ad9fa-5050-4450-b9f5-c46fcd0d7a04	String	jsonType.label
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	true	introspection.token.claim
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	true	userinfo.token.claim
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	picture	user.attribute
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	true	id.token.claim
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	true	access.token.claim
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	picture	claim.name
866dda2f-59ee-4ecb-8bb2-9ba8e59f2c5f	String	jsonType.label
934f164e-30db-47a8-9aaf-48da0dca180a	true	introspection.token.claim
934f164e-30db-47a8-9aaf-48da0dca180a	true	userinfo.token.claim
934f164e-30db-47a8-9aaf-48da0dca180a	gender	user.attribute
934f164e-30db-47a8-9aaf-48da0dca180a	true	id.token.claim
934f164e-30db-47a8-9aaf-48da0dca180a	true	access.token.claim
934f164e-30db-47a8-9aaf-48da0dca180a	gender	claim.name
934f164e-30db-47a8-9aaf-48da0dca180a	String	jsonType.label
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	true	introspection.token.claim
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	true	userinfo.token.claim
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	middleName	user.attribute
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	true	id.token.claim
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	true	access.token.claim
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	middle_name	claim.name
a0fcea4e-fa1e-4dfa-8baf-50ec7e7443f3	String	jsonType.label
a6e13358-b9fd-4a7c-84c5-85430f243430	true	introspection.token.claim
a6e13358-b9fd-4a7c-84c5-85430f243430	true	userinfo.token.claim
a6e13358-b9fd-4a7c-84c5-85430f243430	profile	user.attribute
a6e13358-b9fd-4a7c-84c5-85430f243430	true	id.token.claim
a6e13358-b9fd-4a7c-84c5-85430f243430	true	access.token.claim
a6e13358-b9fd-4a7c-84c5-85430f243430	profile	claim.name
a6e13358-b9fd-4a7c-84c5-85430f243430	String	jsonType.label
c1864d96-3100-4e49-8143-967199f25765	true	introspection.token.claim
c1864d96-3100-4e49-8143-967199f25765	true	userinfo.token.claim
c1864d96-3100-4e49-8143-967199f25765	firstName	user.attribute
c1864d96-3100-4e49-8143-967199f25765	true	id.token.claim
c1864d96-3100-4e49-8143-967199f25765	true	access.token.claim
c1864d96-3100-4e49-8143-967199f25765	given_name	claim.name
c1864d96-3100-4e49-8143-967199f25765	String	jsonType.label
e75449a1-cada-42ce-aa61-1ed433401b9c	true	introspection.token.claim
e75449a1-cada-42ce-aa61-1ed433401b9c	true	userinfo.token.claim
e75449a1-cada-42ce-aa61-1ed433401b9c	lastName	user.attribute
e75449a1-cada-42ce-aa61-1ed433401b9c	true	id.token.claim
e75449a1-cada-42ce-aa61-1ed433401b9c	true	access.token.claim
e75449a1-cada-42ce-aa61-1ed433401b9c	family_name	claim.name
e75449a1-cada-42ce-aa61-1ed433401b9c	String	jsonType.label
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	true	introspection.token.claim
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	true	userinfo.token.claim
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	username	user.attribute
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	true	id.token.claim
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	true	access.token.claim
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	preferred_username	claim.name
fd90f548-d62c-4a7a-91d8-df1b3efb8c08	String	jsonType.label
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	true	introspection.token.claim
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	true	userinfo.token.claim
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	email	user.attribute
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	true	id.token.claim
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	true	access.token.claim
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	email	claim.name
1bc34c4b-bc12-42e4-8d25-8fd5bc466de6	String	jsonType.label
5490a671-b91d-4e68-b884-d5317b2382d7	true	introspection.token.claim
5490a671-b91d-4e68-b884-d5317b2382d7	true	userinfo.token.claim
5490a671-b91d-4e68-b884-d5317b2382d7	emailVerified	user.attribute
5490a671-b91d-4e68-b884-d5317b2382d7	true	id.token.claim
5490a671-b91d-4e68-b884-d5317b2382d7	true	access.token.claim
5490a671-b91d-4e68-b884-d5317b2382d7	email_verified	claim.name
5490a671-b91d-4e68-b884-d5317b2382d7	boolean	jsonType.label
7eb984a2-1347-474e-9723-61c83c125911	formatted	user.attribute.formatted
7eb984a2-1347-474e-9723-61c83c125911	country	user.attribute.country
7eb984a2-1347-474e-9723-61c83c125911	true	introspection.token.claim
7eb984a2-1347-474e-9723-61c83c125911	postal_code	user.attribute.postal_code
7eb984a2-1347-474e-9723-61c83c125911	true	userinfo.token.claim
7eb984a2-1347-474e-9723-61c83c125911	street	user.attribute.street
7eb984a2-1347-474e-9723-61c83c125911	true	id.token.claim
7eb984a2-1347-474e-9723-61c83c125911	region	user.attribute.region
7eb984a2-1347-474e-9723-61c83c125911	true	access.token.claim
7eb984a2-1347-474e-9723-61c83c125911	locality	user.attribute.locality
64062a2d-5476-4cad-8a86-24b51aeb54f0	true	introspection.token.claim
64062a2d-5476-4cad-8a86-24b51aeb54f0	true	userinfo.token.claim
64062a2d-5476-4cad-8a86-24b51aeb54f0	phoneNumber	user.attribute
64062a2d-5476-4cad-8a86-24b51aeb54f0	true	id.token.claim
64062a2d-5476-4cad-8a86-24b51aeb54f0	true	access.token.claim
64062a2d-5476-4cad-8a86-24b51aeb54f0	phone_number	claim.name
64062a2d-5476-4cad-8a86-24b51aeb54f0	String	jsonType.label
6d0a92f6-f6ca-40db-8efa-432fac658905	true	introspection.token.claim
6d0a92f6-f6ca-40db-8efa-432fac658905	true	userinfo.token.claim
6d0a92f6-f6ca-40db-8efa-432fac658905	phoneNumberVerified	user.attribute
6d0a92f6-f6ca-40db-8efa-432fac658905	true	id.token.claim
6d0a92f6-f6ca-40db-8efa-432fac658905	true	access.token.claim
6d0a92f6-f6ca-40db-8efa-432fac658905	phone_number_verified	claim.name
6d0a92f6-f6ca-40db-8efa-432fac658905	boolean	jsonType.label
11d40849-22dd-474d-8d64-236513efa71d	true	introspection.token.claim
11d40849-22dd-474d-8d64-236513efa71d	true	multivalued
11d40849-22dd-474d-8d64-236513efa71d	foo	user.attribute
11d40849-22dd-474d-8d64-236513efa71d	true	access.token.claim
11d40849-22dd-474d-8d64-236513efa71d	resource_access.${client_id}.roles	claim.name
11d40849-22dd-474d-8d64-236513efa71d	String	jsonType.label
62944f38-6780-4d59-8d6f-bcc702b0dfe1	true	introspection.token.claim
62944f38-6780-4d59-8d6f-bcc702b0dfe1	true	multivalued
62944f38-6780-4d59-8d6f-bcc702b0dfe1	foo	user.attribute
62944f38-6780-4d59-8d6f-bcc702b0dfe1	true	access.token.claim
62944f38-6780-4d59-8d6f-bcc702b0dfe1	realm_access.roles	claim.name
62944f38-6780-4d59-8d6f-bcc702b0dfe1	String	jsonType.label
7db7503c-c285-4570-b268-75e747c04119	true	introspection.token.claim
7db7503c-c285-4570-b268-75e747c04119	true	access.token.claim
7a157299-bcb2-405e-9fcb-7897337217ef	true	introspection.token.claim
7a157299-bcb2-405e-9fcb-7897337217ef	true	access.token.claim
4b677ca1-dd56-48f6-801b-5643b1889b45	true	introspection.token.claim
4b677ca1-dd56-48f6-801b-5643b1889b45	true	multivalued
4b677ca1-dd56-48f6-801b-5643b1889b45	foo	user.attribute
4b677ca1-dd56-48f6-801b-5643b1889b45	true	id.token.claim
4b677ca1-dd56-48f6-801b-5643b1889b45	true	access.token.claim
4b677ca1-dd56-48f6-801b-5643b1889b45	groups	claim.name
4b677ca1-dd56-48f6-801b-5643b1889b45	String	jsonType.label
bda6c9bf-f473-40c1-98c0-109008779110	true	introspection.token.claim
bda6c9bf-f473-40c1-98c0-109008779110	true	userinfo.token.claim
bda6c9bf-f473-40c1-98c0-109008779110	username	user.attribute
bda6c9bf-f473-40c1-98c0-109008779110	true	id.token.claim
bda6c9bf-f473-40c1-98c0-109008779110	true	access.token.claim
bda6c9bf-f473-40c1-98c0-109008779110	upn	claim.name
bda6c9bf-f473-40c1-98c0-109008779110	String	jsonType.label
9cd524e4-eb9d-4c85-aa5d-9767ae6502ab	true	introspection.token.claim
9cd524e4-eb9d-4c85-aa5d-9767ae6502ab	true	id.token.claim
9cd524e4-eb9d-4c85-aa5d-9767ae6502ab	true	access.token.claim
a21c8cac-e154-4587-8e80-a93d1fdaa493	true	introspection.token.claim
a21c8cac-e154-4587-8e80-a93d1fdaa493	true	userinfo.token.claim
a21c8cac-e154-4587-8e80-a93d1fdaa493	locale	user.attribute
a21c8cac-e154-4587-8e80-a93d1fdaa493	true	id.token.claim
a21c8cac-e154-4587-8e80-a93d1fdaa493	true	access.token.claim
a21c8cac-e154-4587-8e80-a93d1fdaa493	locale	claim.name
a21c8cac-e154-4587-8e80-a93d1fdaa493	String	jsonType.label
21542434-54a0-4fc8-a0d8-5b42b8a70e94	clientHost	user.session.note
21542434-54a0-4fc8-a0d8-5b42b8a70e94	true	introspection.token.claim
21542434-54a0-4fc8-a0d8-5b42b8a70e94	true	id.token.claim
21542434-54a0-4fc8-a0d8-5b42b8a70e94	true	access.token.claim
21542434-54a0-4fc8-a0d8-5b42b8a70e94	clientHost	claim.name
21542434-54a0-4fc8-a0d8-5b42b8a70e94	String	jsonType.label
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	clientAddress	user.session.note
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	true	introspection.token.claim
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	true	id.token.claim
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	true	access.token.claim
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	clientAddress	claim.name
98adc3b0-98f3-4826-bcfe-8c0ed6523dd0	String	jsonType.label
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	client_id	user.session.note
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	true	introspection.token.claim
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	true	id.token.claim
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	true	access.token.claim
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	client_id	claim.name
9c1dadb0-0399-4f75-a900-d0a2cae1ff77	String	jsonType.label
33c50a08-0e44-4f4a-ada1-6926dc83beb1	true	introspection.token.claim
33c50a08-0e44-4f4a-ada1-6926dc83beb1	true	userinfo.token.claim
33c50a08-0e44-4f4a-ada1-6926dc83beb1	adress	user.attribute
33c50a08-0e44-4f4a-ada1-6926dc83beb1	true	id.token.claim
33c50a08-0e44-4f4a-ada1-6926dc83beb1	false	lightweight.claim
33c50a08-0e44-4f4a-ada1-6926dc83beb1	true	access.token.claim
33c50a08-0e44-4f4a-ada1-6926dc83beb1	String	jsonType.label
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	true	introspection.token.claim
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	true	userinfo.token.claim
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	phone	user.attribute
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	true	id.token.claim
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	false	lightweight.claim
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	true	access.token.claim
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	String	jsonType.label
33c50a08-0e44-4f4a-ada1-6926dc83beb1	false	aggregate.attrs
33c50a08-0e44-4f4a-ada1-6926dc83beb1	false	multivalued
33c50a08-0e44-4f4a-ada1-6926dc83beb1	adress	claim.name
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	false	aggregate.attrs
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	false	multivalued
9ebc7edf-a75b-4eb2-a748-8f40b43f6a7e	phone	claim.name
b0dc7527-60a0-4a26-ace6-98d059318f3e	false	single
b0dc7527-60a0-4a26-ace6-98d059318f3e	Basic	attribute.nameformat
b0dc7527-60a0-4a26-ace6-98d059318f3e	Role	attribute.name
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	true	introspection.token.claim
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	true	userinfo.token.claim
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	gender	user.attribute
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	true	id.token.claim
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	true	access.token.claim
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	gender	claim.name
0c67abc1-c6b0-4f87-b18b-6f4f6e040134	String	jsonType.label
14a8d61b-bbae-4279-b81a-340b91fe1ca0	true	introspection.token.claim
14a8d61b-bbae-4279-b81a-340b91fe1ca0	true	userinfo.token.claim
14a8d61b-bbae-4279-b81a-340b91fe1ca0	website	user.attribute
14a8d61b-bbae-4279-b81a-340b91fe1ca0	true	id.token.claim
14a8d61b-bbae-4279-b81a-340b91fe1ca0	true	access.token.claim
14a8d61b-bbae-4279-b81a-340b91fe1ca0	website	claim.name
14a8d61b-bbae-4279-b81a-340b91fe1ca0	String	jsonType.label
421253ad-26cd-4ecd-98fa-b9c3849250d1	true	introspection.token.claim
421253ad-26cd-4ecd-98fa-b9c3849250d1	true	userinfo.token.claim
421253ad-26cd-4ecd-98fa-b9c3849250d1	username	user.attribute
421253ad-26cd-4ecd-98fa-b9c3849250d1	true	id.token.claim
421253ad-26cd-4ecd-98fa-b9c3849250d1	true	access.token.claim
421253ad-26cd-4ecd-98fa-b9c3849250d1	preferred_username	claim.name
421253ad-26cd-4ecd-98fa-b9c3849250d1	String	jsonType.label
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	true	introspection.token.claim
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	true	userinfo.token.claim
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	picture	user.attribute
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	true	id.token.claim
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	true	access.token.claim
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	picture	claim.name
47cfdbc3-da49-4258-9a26-eb89f3ec1f67	String	jsonType.label
487dec09-2fac-4d31-9268-147f1e340d47	true	introspection.token.claim
487dec09-2fac-4d31-9268-147f1e340d47	true	userinfo.token.claim
487dec09-2fac-4d31-9268-147f1e340d47	middleName	user.attribute
487dec09-2fac-4d31-9268-147f1e340d47	true	id.token.claim
487dec09-2fac-4d31-9268-147f1e340d47	true	access.token.claim
487dec09-2fac-4d31-9268-147f1e340d47	middle_name	claim.name
487dec09-2fac-4d31-9268-147f1e340d47	String	jsonType.label
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	true	introspection.token.claim
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	true	userinfo.token.claim
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	nickname	user.attribute
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	true	id.token.claim
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	true	access.token.claim
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	nickname	claim.name
5c5e2f6b-27a8-41ad-8f48-12e932b06ea4	String	jsonType.label
5f066e27-503f-474d-af81-db7c203f7c29	true	introspection.token.claim
5f066e27-503f-474d-af81-db7c203f7c29	true	userinfo.token.claim
5f066e27-503f-474d-af81-db7c203f7c29	locale	user.attribute
5f066e27-503f-474d-af81-db7c203f7c29	true	id.token.claim
5f066e27-503f-474d-af81-db7c203f7c29	true	access.token.claim
5f066e27-503f-474d-af81-db7c203f7c29	locale	claim.name
5f066e27-503f-474d-af81-db7c203f7c29	String	jsonType.label
72d24de4-7e46-4406-ac9a-94f402f5862a	true	introspection.token.claim
72d24de4-7e46-4406-ac9a-94f402f5862a	true	userinfo.token.claim
72d24de4-7e46-4406-ac9a-94f402f5862a	updatedAt	user.attribute
72d24de4-7e46-4406-ac9a-94f402f5862a	true	id.token.claim
72d24de4-7e46-4406-ac9a-94f402f5862a	true	access.token.claim
72d24de4-7e46-4406-ac9a-94f402f5862a	updated_at	claim.name
72d24de4-7e46-4406-ac9a-94f402f5862a	long	jsonType.label
797711a8-3ce8-45ab-8976-1b9737c9ce4a	true	introspection.token.claim
797711a8-3ce8-45ab-8976-1b9737c9ce4a	true	userinfo.token.claim
797711a8-3ce8-45ab-8976-1b9737c9ce4a	true	id.token.claim
797711a8-3ce8-45ab-8976-1b9737c9ce4a	true	access.token.claim
b8cb780e-deda-4a9a-8876-254d3a2046be	true	introspection.token.claim
b8cb780e-deda-4a9a-8876-254d3a2046be	true	userinfo.token.claim
b8cb780e-deda-4a9a-8876-254d3a2046be	profile	user.attribute
b8cb780e-deda-4a9a-8876-254d3a2046be	true	id.token.claim
b8cb780e-deda-4a9a-8876-254d3a2046be	true	access.token.claim
b8cb780e-deda-4a9a-8876-254d3a2046be	profile	claim.name
b8cb780e-deda-4a9a-8876-254d3a2046be	String	jsonType.label
bc529540-bef0-44d5-9068-1aca321aee2e	true	introspection.token.claim
bc529540-bef0-44d5-9068-1aca321aee2e	true	userinfo.token.claim
bc529540-bef0-44d5-9068-1aca321aee2e	birthdate	user.attribute
bc529540-bef0-44d5-9068-1aca321aee2e	true	id.token.claim
bc529540-bef0-44d5-9068-1aca321aee2e	true	access.token.claim
bc529540-bef0-44d5-9068-1aca321aee2e	birthdate	claim.name
bc529540-bef0-44d5-9068-1aca321aee2e	String	jsonType.label
c16a244b-66b7-42f4-875b-5d4633b47890	true	introspection.token.claim
c16a244b-66b7-42f4-875b-5d4633b47890	true	userinfo.token.claim
c16a244b-66b7-42f4-875b-5d4633b47890	firstName	user.attribute
c16a244b-66b7-42f4-875b-5d4633b47890	true	id.token.claim
c16a244b-66b7-42f4-875b-5d4633b47890	true	access.token.claim
c16a244b-66b7-42f4-875b-5d4633b47890	given_name	claim.name
c16a244b-66b7-42f4-875b-5d4633b47890	String	jsonType.label
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	true	introspection.token.claim
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	true	userinfo.token.claim
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	zoneinfo	user.attribute
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	true	id.token.claim
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	true	access.token.claim
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	zoneinfo	claim.name
cd5d0258-e53e-42b8-9cf6-2463eb9a9923	String	jsonType.label
f3fe4d57-231e-4d32-9cec-0fbe3655d301	true	introspection.token.claim
f3fe4d57-231e-4d32-9cec-0fbe3655d301	true	userinfo.token.claim
f3fe4d57-231e-4d32-9cec-0fbe3655d301	lastName	user.attribute
f3fe4d57-231e-4d32-9cec-0fbe3655d301	true	id.token.claim
f3fe4d57-231e-4d32-9cec-0fbe3655d301	true	access.token.claim
f3fe4d57-231e-4d32-9cec-0fbe3655d301	family_name	claim.name
f3fe4d57-231e-4d32-9cec-0fbe3655d301	String	jsonType.label
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	true	introspection.token.claim
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	true	userinfo.token.claim
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	email	user.attribute
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	true	id.token.claim
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	true	access.token.claim
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	email	claim.name
04cd6ed1-6fd5-4b6f-ac1c-eacadbe0005c	String	jsonType.label
d4eaa563-982d-4b10-bc30-b736ae4295fa	true	introspection.token.claim
d4eaa563-982d-4b10-bc30-b736ae4295fa	true	userinfo.token.claim
d4eaa563-982d-4b10-bc30-b736ae4295fa	emailVerified	user.attribute
d4eaa563-982d-4b10-bc30-b736ae4295fa	true	id.token.claim
d4eaa563-982d-4b10-bc30-b736ae4295fa	true	access.token.claim
d4eaa563-982d-4b10-bc30-b736ae4295fa	email_verified	claim.name
d4eaa563-982d-4b10-bc30-b736ae4295fa	boolean	jsonType.label
a55e50f2-0d34-4099-9712-16f15346babb	formatted	user.attribute.formatted
a55e50f2-0d34-4099-9712-16f15346babb	country	user.attribute.country
a55e50f2-0d34-4099-9712-16f15346babb	true	introspection.token.claim
a55e50f2-0d34-4099-9712-16f15346babb	postal_code	user.attribute.postal_code
a55e50f2-0d34-4099-9712-16f15346babb	true	userinfo.token.claim
a55e50f2-0d34-4099-9712-16f15346babb	street	user.attribute.street
a55e50f2-0d34-4099-9712-16f15346babb	true	id.token.claim
a55e50f2-0d34-4099-9712-16f15346babb	region	user.attribute.region
a55e50f2-0d34-4099-9712-16f15346babb	true	access.token.claim
a55e50f2-0d34-4099-9712-16f15346babb	locality	user.attribute.locality
12b2a73a-877b-4707-b292-501c014af2a5	true	introspection.token.claim
12b2a73a-877b-4707-b292-501c014af2a5	true	userinfo.token.claim
12b2a73a-877b-4707-b292-501c014af2a5	phoneNumber	user.attribute
12b2a73a-877b-4707-b292-501c014af2a5	true	id.token.claim
12b2a73a-877b-4707-b292-501c014af2a5	true	access.token.claim
12b2a73a-877b-4707-b292-501c014af2a5	phone_number	claim.name
12b2a73a-877b-4707-b292-501c014af2a5	String	jsonType.label
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	true	introspection.token.claim
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	true	userinfo.token.claim
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	phoneNumberVerified	user.attribute
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	true	id.token.claim
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	true	access.token.claim
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	phone_number_verified	claim.name
ed2dbd16-3a81-456c-9aa9-0171a4d56d85	boolean	jsonType.label
1c3c0118-cc50-4506-9203-a7fb64471c24	true	introspection.token.claim
1c3c0118-cc50-4506-9203-a7fb64471c24	true	multivalued
1c3c0118-cc50-4506-9203-a7fb64471c24	foo	user.attribute
1c3c0118-cc50-4506-9203-a7fb64471c24	true	access.token.claim
1c3c0118-cc50-4506-9203-a7fb64471c24	resource_access.${client_id}.roles	claim.name
1c3c0118-cc50-4506-9203-a7fb64471c24	String	jsonType.label
7684363b-02a2-46ff-bdb0-25d25925005c	true	introspection.token.claim
7684363b-02a2-46ff-bdb0-25d25925005c	true	multivalued
7684363b-02a2-46ff-bdb0-25d25925005c	foo	user.attribute
7684363b-02a2-46ff-bdb0-25d25925005c	true	access.token.claim
7684363b-02a2-46ff-bdb0-25d25925005c	realm_access.roles	claim.name
7684363b-02a2-46ff-bdb0-25d25925005c	String	jsonType.label
7e0b5d27-9c42-4b12-bae7-8f50fedcadcb	true	introspection.token.claim
7e0b5d27-9c42-4b12-bae7-8f50fedcadcb	true	access.token.claim
3244eb77-1ad1-49b4-9ab1-077a6fad4147	true	introspection.token.claim
3244eb77-1ad1-49b4-9ab1-077a6fad4147	true	access.token.claim
1cf6abe2-423e-4a10-acbf-f26a5130fae6	true	introspection.token.claim
1cf6abe2-423e-4a10-acbf-f26a5130fae6	true	userinfo.token.claim
1cf6abe2-423e-4a10-acbf-f26a5130fae6	username	user.attribute
1cf6abe2-423e-4a10-acbf-f26a5130fae6	true	id.token.claim
1cf6abe2-423e-4a10-acbf-f26a5130fae6	true	access.token.claim
1cf6abe2-423e-4a10-acbf-f26a5130fae6	upn	claim.name
1cf6abe2-423e-4a10-acbf-f26a5130fae6	String	jsonType.label
ace1562c-a5d7-4a69-a7a7-4385b3713635	true	introspection.token.claim
ace1562c-a5d7-4a69-a7a7-4385b3713635	true	multivalued
ace1562c-a5d7-4a69-a7a7-4385b3713635	foo	user.attribute
ace1562c-a5d7-4a69-a7a7-4385b3713635	true	id.token.claim
ace1562c-a5d7-4a69-a7a7-4385b3713635	true	access.token.claim
ace1562c-a5d7-4a69-a7a7-4385b3713635	groups	claim.name
ace1562c-a5d7-4a69-a7a7-4385b3713635	String	jsonType.label
e549df7a-25b1-4cb0-89fb-1a4b4e09dbb4	true	introspection.token.claim
e549df7a-25b1-4cb0-89fb-1a4b4e09dbb4	true	id.token.claim
e549df7a-25b1-4cb0-89fb-1a4b4e09dbb4	true	access.token.claim
e4a8d9e9-14ca-4563-809b-6821dbc804e7	true	introspection.token.claim
e4a8d9e9-14ca-4563-809b-6821dbc804e7	true	userinfo.token.claim
e4a8d9e9-14ca-4563-809b-6821dbc804e7	locale	user.attribute
e4a8d9e9-14ca-4563-809b-6821dbc804e7	true	id.token.claim
e4a8d9e9-14ca-4563-809b-6821dbc804e7	true	access.token.claim
e4a8d9e9-14ca-4563-809b-6821dbc804e7	locale	claim.name
e4a8d9e9-14ca-4563-809b-6821dbc804e7	String	jsonType.label
\.


--
-- TOC entry 5847 (class 0 OID 61147)
-- Dependencies: 294
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d3c7eec2-b715-4576-ae52-eafaa022dbfb	60	300	300	\N	\N	\N	t	f	0	\N	Golfshop	0	\N	t	f	f	f	EXTERNAL	1800	36000	f	f	76ab9b81-61cd-49e0-a8dd-f96eccd9121f	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a7ba2cda-ac20-454e-b27f-6aca07958bde	47b19025-2cef-4f55-9ef1-5dd08b96f5e1	6722bd08-ceee-4fef-880a-ea3f86f2bc50	fde96a26-1965-4880-9ac7-35f197db7446	cae671f0-9b5d-4fb8-9c26-580b1e0fb817	2592000	f	900	t	f	8ee040d9-8d9e-4758-b0fb-ab6810b4f228	0	f	0	0	dc009e10-c242-43f6-9ce2-db07b2020ddd
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	abb73e2b-8831-4aa5-b8d7-506d914c1baa	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f23e1bd5-f288-4b7b-94bf-c046d61f9d46	44ea3da9-29af-4e1d-8525-b21a5ac82e79	4156543f-c584-4577-ae84-dbfd47840f42	5e436c93-99eb-45d3-99ff-263e301da456	a278b8a2-29ce-4be0-a7cc-bd82ff9c057b	2592000	f	900	t	f	d0899066-0005-41c1-9f3c-c6bdf3ff6ecc	0	f	0	0	a5c8b6e2-1975-4e5b-a6bb-63558e5f1965
535ccb56-a180-4def-9f05-660bd334f36f	60	300	300	\N	\N	\N	t	f	0	\N	innloggingbruker	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	7286d85d-38fd-4102-a563-09cfaed39e3e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	215e2f1b-d49d-4fda-b59a-0dc477594b43	c1b49ace-86f1-4d34-805d-7ee87855e12d	b0712a5b-444b-414b-a471-8fddf38e313e	5a748cfb-cfc7-484a-b209-1c1b86046581	c96c079b-b5d4-49eb-b28f-fc539598c6db	2592000	f	900	t	f	c0295371-9168-4b45-b95d-8ea7e3d53df3	0	f	0	0	a118805b-7c50-45cf-bbab-9521167264fe
\.


--
-- TOC entry 5848 (class 0 OID 61180)
-- Dependencies: 295
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	
_browser_header.xContentTypeOptions	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	nosniff
_browser_header.referrerPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	no-referrer
_browser_header.xRobotsTag	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	none
_browser_header.xFrameOptions	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	SAMEORIGIN
_browser_header.contentSecurityPolicy	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	1; mode=block
_browser_header.strictTransportSecurity	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	max-age=31536000; includeSubDomains
bruteForceProtected	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	false
permanentLockout	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	false
maxTemporaryLockouts	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	0
maxFailureWaitSeconds	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	900
minimumQuickLoginWaitSeconds	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	60
waitIncrementSeconds	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	60
quickLoginCheckMilliSeconds	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	1000
maxDeltaTimeSeconds	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	43200
failureFactor	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	30
realmReusableOtpCode	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	false
firstBrokerLoginFlowId	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	a9bde9fb-f4c9-4abc-b325-71f6dbc0ab79
displayName	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	Keycloak
displayNameHtml	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	RS256
offlineSessionMaxLifespanEnabled	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	false
offlineSessionMaxLifespan	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	5184000
bruteForceProtected	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
permanentLockout	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
maxTemporaryLockouts	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
maxFailureWaitSeconds	d3c7eec2-b715-4576-ae52-eafaa022dbfb	900
minimumQuickLoginWaitSeconds	d3c7eec2-b715-4576-ae52-eafaa022dbfb	60
waitIncrementSeconds	d3c7eec2-b715-4576-ae52-eafaa022dbfb	60
quickLoginCheckMilliSeconds	d3c7eec2-b715-4576-ae52-eafaa022dbfb	1000
maxDeltaTimeSeconds	d3c7eec2-b715-4576-ae52-eafaa022dbfb	43200
failureFactor	d3c7eec2-b715-4576-ae52-eafaa022dbfb	30
realmReusableOtpCode	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
defaultSignatureAlgorithm	d3c7eec2-b715-4576-ae52-eafaa022dbfb	RS256
offlineSessionMaxLifespanEnabled	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
offlineSessionMaxLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	5184000
actionTokenGeneratedByAdminLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	43200
actionTokenGeneratedByUserLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	300
oauth2DeviceCodeLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	600
oauth2DevicePollingInterval	d3c7eec2-b715-4576-ae52-eafaa022dbfb	5
webAuthnPolicyRpEntityName	d3c7eec2-b715-4576-ae52-eafaa022dbfb	keycloak
webAuthnPolicySignatureAlgorithms	d3c7eec2-b715-4576-ae52-eafaa022dbfb	ES256
webAuthnPolicyRpId	d3c7eec2-b715-4576-ae52-eafaa022dbfb	
webAuthnPolicyAttestationConveyancePreference	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyAuthenticatorAttachment	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyRequireResidentKey	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyUserVerificationRequirement	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyCreateTimeout	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
webAuthnPolicyRpEntityNamePasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	ES256
webAuthnPolicyRpIdPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	not specified
webAuthnPolicyCreateTimeoutPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	false
cibaBackchannelTokenDeliveryMode	d3c7eec2-b715-4576-ae52-eafaa022dbfb	poll
cibaExpiresIn	d3c7eec2-b715-4576-ae52-eafaa022dbfb	120
cibaInterval	d3c7eec2-b715-4576-ae52-eafaa022dbfb	5
cibaAuthRequestedUserHint	d3c7eec2-b715-4576-ae52-eafaa022dbfb	login_hint
parRequestUriLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	60
firstBrokerLoginFlowId	d3c7eec2-b715-4576-ae52-eafaa022dbfb	08e12670-f999-4670-939e-d66f7946f10e
clientSessionIdleTimeout	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
clientSessionMaxLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
clientOfflineSessionIdleTimeout	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
clientOfflineSessionMaxLifespan	d3c7eec2-b715-4576-ae52-eafaa022dbfb	0
client-policies.profiles	d3c7eec2-b715-4576-ae52-eafaa022dbfb	{"profiles":[]}
client-policies.policies	d3c7eec2-b715-4576-ae52-eafaa022dbfb	{"policies":[]}
acr.loa.map	d3c7eec2-b715-4576-ae52-eafaa022dbfb	{}
displayName	d3c7eec2-b715-4576-ae52-eafaa022dbfb	
displayNameHtml	d3c7eec2-b715-4576-ae52-eafaa022dbfb	
_browser_header.xRobotsTag	d3c7eec2-b715-4576-ae52-eafaa022dbfb	none
_browser_header.xFrameOptions	d3c7eec2-b715-4576-ae52-eafaa022dbfb	SAMEORIGIN
frontendUrl	d3c7eec2-b715-4576-ae52-eafaa022dbfb	http://host.docker.internal:8180
_browser_header.contentSecurityPolicyReportOnly	d3c7eec2-b715-4576-ae52-eafaa022dbfb	
_browser_header.xContentTypeOptions	d3c7eec2-b715-4576-ae52-eafaa022dbfb	nosniff
_browser_header.referrerPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	no-referrer
_browser_header.contentSecurityPolicy	d3c7eec2-b715-4576-ae52-eafaa022dbfb	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d3c7eec2-b715-4576-ae52-eafaa022dbfb	1; mode=block
_browser_header.strictTransportSecurity	d3c7eec2-b715-4576-ae52-eafaa022dbfb	max-age=31536000; includeSubDomains
bruteForceProtected	535ccb56-a180-4def-9f05-660bd334f36f	false
permanentLockout	535ccb56-a180-4def-9f05-660bd334f36f	false
maxTemporaryLockouts	535ccb56-a180-4def-9f05-660bd334f36f	0
maxFailureWaitSeconds	535ccb56-a180-4def-9f05-660bd334f36f	900
minimumQuickLoginWaitSeconds	535ccb56-a180-4def-9f05-660bd334f36f	60
waitIncrementSeconds	535ccb56-a180-4def-9f05-660bd334f36f	60
quickLoginCheckMilliSeconds	535ccb56-a180-4def-9f05-660bd334f36f	1000
maxDeltaTimeSeconds	535ccb56-a180-4def-9f05-660bd334f36f	43200
failureFactor	535ccb56-a180-4def-9f05-660bd334f36f	30
realmReusableOtpCode	535ccb56-a180-4def-9f05-660bd334f36f	false
defaultSignatureAlgorithm	535ccb56-a180-4def-9f05-660bd334f36f	RS256
offlineSessionMaxLifespanEnabled	535ccb56-a180-4def-9f05-660bd334f36f	false
offlineSessionMaxLifespan	535ccb56-a180-4def-9f05-660bd334f36f	5184000
actionTokenGeneratedByAdminLifespan	535ccb56-a180-4def-9f05-660bd334f36f	43200
actionTokenGeneratedByUserLifespan	535ccb56-a180-4def-9f05-660bd334f36f	300
oauth2DeviceCodeLifespan	535ccb56-a180-4def-9f05-660bd334f36f	600
oauth2DevicePollingInterval	535ccb56-a180-4def-9f05-660bd334f36f	5
webAuthnPolicyRpEntityName	535ccb56-a180-4def-9f05-660bd334f36f	keycloak
webAuthnPolicySignatureAlgorithms	535ccb56-a180-4def-9f05-660bd334f36f	ES256
webAuthnPolicyRpId	535ccb56-a180-4def-9f05-660bd334f36f	
webAuthnPolicyAttestationConveyancePreference	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyAuthenticatorAttachment	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyRequireResidentKey	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyUserVerificationRequirement	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyCreateTimeout	535ccb56-a180-4def-9f05-660bd334f36f	0
webAuthnPolicyAvoidSameAuthenticatorRegister	535ccb56-a180-4def-9f05-660bd334f36f	false
webAuthnPolicyRpEntityNamePasswordless	535ccb56-a180-4def-9f05-660bd334f36f	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	ES256
webAuthnPolicyRpIdPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	
webAuthnPolicyAttestationConveyancePreferencePasswordless	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyRequireResidentKeyPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	not specified
webAuthnPolicyCreateTimeoutPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	535ccb56-a180-4def-9f05-660bd334f36f	false
cibaBackchannelTokenDeliveryMode	535ccb56-a180-4def-9f05-660bd334f36f	poll
cibaExpiresIn	535ccb56-a180-4def-9f05-660bd334f36f	120
cibaInterval	535ccb56-a180-4def-9f05-660bd334f36f	5
cibaAuthRequestedUserHint	535ccb56-a180-4def-9f05-660bd334f36f	login_hint
parRequestUriLifespan	535ccb56-a180-4def-9f05-660bd334f36f	60
firstBrokerLoginFlowId	535ccb56-a180-4def-9f05-660bd334f36f	94e3f91d-6870-4aae-9488-33bfbc559ac9
clientSessionIdleTimeout	535ccb56-a180-4def-9f05-660bd334f36f	0
clientSessionMaxLifespan	535ccb56-a180-4def-9f05-660bd334f36f	0
clientOfflineSessionIdleTimeout	535ccb56-a180-4def-9f05-660bd334f36f	0
clientOfflineSessionMaxLifespan	535ccb56-a180-4def-9f05-660bd334f36f	0
client-policies.profiles	535ccb56-a180-4def-9f05-660bd334f36f	{"profiles":[]}
client-policies.policies	535ccb56-a180-4def-9f05-660bd334f36f	{"policies":[]}
frontendUrl	535ccb56-a180-4def-9f05-660bd334f36f	
acr.loa.map	535ccb56-a180-4def-9f05-660bd334f36f	{}
displayName	535ccb56-a180-4def-9f05-660bd334f36f	Logg inn
displayNameHtml	535ccb56-a180-4def-9f05-660bd334f36f	
_browser_header.contentSecurityPolicyReportOnly	535ccb56-a180-4def-9f05-660bd334f36f	
_browser_header.xContentTypeOptions	535ccb56-a180-4def-9f05-660bd334f36f	nosniff
_browser_header.referrerPolicy	535ccb56-a180-4def-9f05-660bd334f36f	no-referrer
_browser_header.xRobotsTag	535ccb56-a180-4def-9f05-660bd334f36f	none
_browser_header.xFrameOptions	535ccb56-a180-4def-9f05-660bd334f36f	SAMEORIGIN
_browser_header.contentSecurityPolicy	535ccb56-a180-4def-9f05-660bd334f36f	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	535ccb56-a180-4def-9f05-660bd334f36f	1; mode=block
_browser_header.strictTransportSecurity	535ccb56-a180-4def-9f05-660bd334f36f	max-age=31536000; includeSubDomains
\.


--
-- TOC entry 5849 (class 0 OID 61185)
-- Dependencies: 296
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 5850 (class 0 OID 61188)
-- Dependencies: 297
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 5851 (class 0 OID 61191)
-- Dependencies: 298
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_events_listeners (realm_id, value) FROM stdin;
86792e35-17a3-4746-b4fe-09bd6bc4cd5d	jboss-logging
d3c7eec2-b715-4576-ae52-eafaa022dbfb	jboss-logging
535ccb56-a180-4def-9f05-660bd334f36f	jboss-logging
\.


--
-- TOC entry 5852 (class 0 OID 61194)
-- Dependencies: 299
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 5853 (class 0 OID 61199)
-- Dependencies: 300
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	86792e35-17a3-4746-b4fe-09bd6bc4cd5d
password	password	t	t	d3c7eec2-b715-4576-ae52-eafaa022dbfb
password	password	t	t	535ccb56-a180-4def-9f05-660bd334f36f
\.


--
-- TOC entry 5854 (class 0 OID 61206)
-- Dependencies: 301
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 5855 (class 0 OID 61211)
-- Dependencies: 302
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 5856 (class 0 OID 61214)
-- Dependencies: 303
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.redirect_uris (client_id, value) FROM stdin;
87776386-5f22-4d8f-8fcb-791558de1118	/realms/master/account/*
93555091-c257-4da0-a8d8-0af76f37af12	/realms/master/account/*
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	/admin/master/console/*
0d0ec982-e518-4f82-a9de-d0d2d4b4108c	/realms/Golfshop/account/*
28cc48d5-69de-4f31-88e0-71f449cc1a0e	/realms/Golfshop/account/*
83d156ce-eb02-4415-a71e-9515f5e2fcee	/admin/Golfshop/console/*
212c93d9-721d-4a39-bac3-8f8a90aa993e	http://host.docker.internal:8080/*
342f8d7f-3d22-4696-8ec4-5420ee87df9e	/realms/innloggingbruker/account/*
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	/realms/innloggingbruker/account/*
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	/admin/innloggingbruker/console/*
a394b610-97f4-4bd1-b512-9cf01093fa82	http://localhost:3000/*
\.


--
-- TOC entry 5857 (class 0 OID 61217)
-- Dependencies: 304
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 5858 (class 0 OID 61222)
-- Dependencies: 305
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
3f02a9dc-79c2-44c0-ad5f-b8819925c89d	VERIFY_EMAIL	Verify Email	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	VERIFY_EMAIL	50
756ff62b-ce01-43d8-a9c2-23a7a2629047	UPDATE_PROFILE	Update Profile	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	UPDATE_PROFILE	40
96e74b7e-7e38-4a8d-91ed-f1527a42c26a	CONFIGURE_TOTP	Configure OTP	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	CONFIGURE_TOTP	10
b57f3fb3-3ee3-42a0-9e6a-ecf72f3c774b	UPDATE_PASSWORD	Update Password	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	UPDATE_PASSWORD	30
4631a935-8b00-4fa6-9884-9321d435549d	TERMS_AND_CONDITIONS	Terms and Conditions	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	f	TERMS_AND_CONDITIONS	20
09348b2b-d7ee-4c9c-a02c-515fc6319f28	delete_account	Delete Account	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	f	f	delete_account	60
0971e608-d3ea-40ab-a63f-7b6d0f6b42db	update_user_locale	Update User Locale	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	update_user_locale	1000
d52b408b-55fd-4c69-a168-d4acf0b64ba5	webauthn-register	Webauthn Register	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	webauthn-register	70
9dcb3167-a981-471f-a52c-50f3e0be85ec	webauthn-register-passwordless	Webauthn Register Passwordless	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	webauthn-register-passwordless	80
a77d68d0-cd10-4958-bdb9-72cc740f2390	VERIFY_PROFILE	Verify Profile	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	VERIFY_PROFILE	90
b4f5d22d-2978-4828-9440-991fb3970e26	VERIFY_EMAIL	Verify Email	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	VERIFY_EMAIL	50
ec803c87-21ae-44b1-960a-c3f30831dfd4	UPDATE_PROFILE	Update Profile	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	UPDATE_PROFILE	40
5ba5bcad-fb65-4b62-8a06-871bd836e1ae	CONFIGURE_TOTP	Configure OTP	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	CONFIGURE_TOTP	10
ca07d412-32d0-430a-8cb1-b63f2ad1130b	UPDATE_PASSWORD	Update Password	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	UPDATE_PASSWORD	30
fe242840-2c3c-475c-839d-9406d329f70c	TERMS_AND_CONDITIONS	Terms and Conditions	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	f	TERMS_AND_CONDITIONS	20
150b68d6-9ea1-44ed-8009-00c251b37def	delete_account	Delete Account	d3c7eec2-b715-4576-ae52-eafaa022dbfb	f	f	delete_account	60
a83ba428-871b-4aab-9b45-9d200a504983	update_user_locale	Update User Locale	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	update_user_locale	1000
180b8753-453b-44c2-8262-dfb45859b126	webauthn-register	Webauthn Register	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	webauthn-register	70
359a2270-2a42-4733-9063-6f36e6df63a8	webauthn-register-passwordless	Webauthn Register Passwordless	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	webauthn-register-passwordless	80
e6cdc877-216c-44df-b7c3-409213abb5e7	VERIFY_PROFILE	Verify Profile	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	VERIFY_PROFILE	90
92ab8a0e-5e81-4f23-a8fc-2001136a2631	delete_credential	Delete Credential	d3c7eec2-b715-4576-ae52-eafaa022dbfb	t	f	delete_credential	100
cc79fd84-e05a-4792-9266-fbffc36fa081	delete_credential	Delete Credential	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	t	f	delete_credential	100
eb05f350-777c-4154-b5c7-15d4d3c900d4	VERIFY_EMAIL	Verify Email	535ccb56-a180-4def-9f05-660bd334f36f	t	f	VERIFY_EMAIL	50
efb1000c-76be-4c4a-a026-10e35fc69626	UPDATE_PROFILE	Update Profile	535ccb56-a180-4def-9f05-660bd334f36f	t	f	UPDATE_PROFILE	40
6194fa9b-53e7-4818-b37c-842e131db5af	CONFIGURE_TOTP	Configure OTP	535ccb56-a180-4def-9f05-660bd334f36f	t	f	CONFIGURE_TOTP	10
b626e1e7-e94b-4207-b3d8-290b60c0017d	UPDATE_PASSWORD	Update Password	535ccb56-a180-4def-9f05-660bd334f36f	t	f	UPDATE_PASSWORD	30
6e5cc90b-8fb9-413f-9a6b-45daa5a1887e	TERMS_AND_CONDITIONS	Terms and Conditions	535ccb56-a180-4def-9f05-660bd334f36f	f	f	TERMS_AND_CONDITIONS	20
d80eb30b-9bd9-405c-8a6f-f9ce0976787d	delete_account	Delete Account	535ccb56-a180-4def-9f05-660bd334f36f	f	f	delete_account	60
9b63eb21-522f-439f-a3d8-e06c49c5a5b4	delete_credential	Delete Credential	535ccb56-a180-4def-9f05-660bd334f36f	t	f	delete_credential	100
2bf8d3a6-271a-4218-af88-9f60b0507e60	update_user_locale	Update User Locale	535ccb56-a180-4def-9f05-660bd334f36f	t	f	update_user_locale	1000
8ea5db73-8e80-4dcd-935d-873226c6697d	webauthn-register	Webauthn Register	535ccb56-a180-4def-9f05-660bd334f36f	t	f	webauthn-register	70
b0a451f8-1e70-428a-9f64-a6301180c8a7	webauthn-register-passwordless	Webauthn Register Passwordless	535ccb56-a180-4def-9f05-660bd334f36f	t	f	webauthn-register-passwordless	80
7723008e-8c1e-440e-8ce2-73e372cc1f7e	VERIFY_PROFILE	Verify Profile	535ccb56-a180-4def-9f05-660bd334f36f	t	f	VERIFY_PROFILE	90
\.


--
-- TOC entry 5859 (class 0 OID 61229)
-- Dependencies: 306
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 5860 (class 0 OID 61235)
-- Dependencies: 307
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 5861 (class 0 OID 61238)
-- Dependencies: 308
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 5862 (class 0 OID 61241)
-- Dependencies: 309
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
212c93d9-721d-4a39-bac3-8f8a90aa993e	t	0	1
\.


--
-- TOC entry 5863 (class 0 OID 61246)
-- Dependencies: 310
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 5864 (class 0 OID 61251)
-- Dependencies: 311
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
d9e1d0e4-e798-4958-bcbd-082729c1a5c3	Default Policy	A policy that grants access only for users within this realm	js	0	0	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
28fb5e66-76ce-449b-bc7f-4b795ca3433c	Default Permission	A permission that applies to the default resource type	resource	1	0	212c93d9-721d-4a39-bac3-8f8a90aa993e	\N
\.


--
-- TOC entry 5865 (class 0 OID 61256)
-- Dependencies: 312
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
5eda6157-46af-440c-899a-31df0217da4f	Default Resource	urn:golfstore-backend:resources:default	\N	212c93d9-721d-4a39-bac3-8f8a90aa993e	212c93d9-721d-4a39-bac3-8f8a90aa993e	f	\N
\.


--
-- TOC entry 5866 (class 0 OID 61262)
-- Dependencies: 313
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 5867 (class 0 OID 61267)
-- Dependencies: 314
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.resource_uris (resource_id, value) FROM stdin;
5eda6157-46af-440c-899a-31df0217da4f	/*
\.


--
-- TOC entry 5868 (class 0 OID 61270)
-- Dependencies: 315
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 5869 (class 0 OID 61275)
-- Dependencies: 316
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.scope_mapping (client_id, role_id) FROM stdin;
93555091-c257-4da0-a8d8-0af76f37af12	99a902d0-7d9f-46d4-8b66-5bfa470fc2b9
93555091-c257-4da0-a8d8-0af76f37af12	3f4e49e4-9fb3-4b1d-8323-33922d4f3452
28cc48d5-69de-4f31-88e0-71f449cc1a0e	02201b68-3c79-4bc3-a9e8-2ba035682a4d
28cc48d5-69de-4f31-88e0-71f449cc1a0e	812dfaf7-1f2c-47f9-b621-d064b40d852a
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	f1c84ec4-cfc4-477b-bdd7-31ce86e1e4f3
1f5e4abc-eba6-4633-bd19-ae9dbcb9ea5d	1a3e59f2-538c-4097-9fec-cb28e6b6153a
\.


--
-- TOC entry 5870 (class 0 OID 61278)
-- Dependencies: 317
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 5871 (class 0 OID 61281)
-- Dependencies: 318
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
phone	40043234	bd234904-c74b-4f53-beff-f57f554665ef	f991e090-63e1-486b-8b5b-19685b8fc4d8	\N	\N	\N
adress	Hvelven	bd234904-c74b-4f53-beff-f57f554665ef	05e59821-63e0-40a5-86dc-08752e0e19e6	\N	\N	\N
\.


--
-- TOC entry 5872 (class 0 OID 61287)
-- Dependencies: 319
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 5873 (class 0 OID 61292)
-- Dependencies: 320
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 5874 (class 0 OID 61295)
-- Dependencies: 321
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
0fe5fe58-662e-4891-b442-205b990c162a	\N	008c964e-4759-4c26-84cb-a3a875e74a66	f	t	\N	\N	\N	86792e35-17a3-4746-b4fe-09bd6bc4cd5d	admin	1743241512632	\N	0
5af769b6-7874-4cb8-9077-0fe79d6dfd9e	\N	893a2e2b-a9df-4b60-b6cc-6f7bd66c4fae	f	t	\N	\N	\N	d3c7eec2-b715-4576-ae52-eafaa022dbfb	service-account-golfstore-backend	1743241979153	212c93d9-721d-4a39-bac3-8f8a90aa993e	0
e6f4f152-a362-4dbe-a552-8d390bfe7b55	testuser@hotmail.com	testuser@hotmail.com	t	t	\N	Test	User	d3c7eec2-b715-4576-ae52-eafaa022dbfb	testuser1	1743242117529	\N	0
bd234904-c74b-4f53-beff-f57f554665ef	testuser2@hotmail.com	testuser2@hotmail.com	t	t	\N	Test	User2	d3c7eec2-b715-4576-ae52-eafaa022dbfb	testuser2	1743242950122	\N	0
a3d27beb-6e26-4df6-8a96-c68dcf625df1	toni@toni.com	toni@toni.com	f	t	\N	don	toni	535ccb56-a180-4def-9f05-660bd334f36f	toni	1749046913481	\N	0
9152d26a-a4cd-4e04-a979-7d1756896ee0	andre@andre.com	andre@andre.com	f	t	\N	andre	dantoni	535ccb56-a180-4def-9f05-660bd334f36f	andre	1749047017515	\N	0
8cc39632-d297-44d8-85c1-0adf483603ea	sindremagnussen@live.no	sindremagnussen@live.no	t	t	\N	Sindre	Magnussen	535ccb56-a180-4def-9f05-660bd334f36f	sindre	1748594568554	\N	0
\.


--
-- TOC entry 5875 (class 0 OID 61303)
-- Dependencies: 322
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 5876 (class 0 OID 61308)
-- Dependencies: 323
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 5877 (class 0 OID 61313)
-- Dependencies: 324
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 5878 (class 0 OID 61318)
-- Dependencies: 325
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 5879 (class 0 OID 61323)
-- Dependencies: 326
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- TOC entry 5880 (class 0 OID 61326)
-- Dependencies: 327
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 5881 (class 0 OID 61330)
-- Dependencies: 328
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_role_mapping (role_id, user_id) FROM stdin;
a5c8b6e2-1975-4e5b-a6bb-63558e5f1965	0fe5fe58-662e-4891-b442-205b990c162a
acc09f73-a0d4-4dc3-bf6c-8f59787a48b7	0fe5fe58-662e-4891-b442-205b990c162a
b4e751fe-0acc-43bd-82d3-1835d0533cdf	0fe5fe58-662e-4891-b442-205b990c162a
2de02dae-50dc-4ff8-b091-17d313257557	0fe5fe58-662e-4891-b442-205b990c162a
177f36d3-2ae7-496c-94dc-ee5d9c56f871	0fe5fe58-662e-4891-b442-205b990c162a
ba5df043-db47-41a4-9754-a0a99e6b0f3c	0fe5fe58-662e-4891-b442-205b990c162a
ac6a366a-f503-4286-a631-2fb5e31d6171	0fe5fe58-662e-4891-b442-205b990c162a
8cc5334e-8e32-4bf0-8d78-df7c3b96c8c0	0fe5fe58-662e-4891-b442-205b990c162a
26ec6132-ce03-46e3-99ef-18fbe54372f0	0fe5fe58-662e-4891-b442-205b990c162a
24e8912c-b3d8-40ea-bb77-96fce85ad8d5	0fe5fe58-662e-4891-b442-205b990c162a
ee105db7-892b-46f6-87b7-9b87f8d91f75	0fe5fe58-662e-4891-b442-205b990c162a
f893c3ec-afaf-4f82-9aa6-be0035776cbd	0fe5fe58-662e-4891-b442-205b990c162a
6783fb11-9146-4298-8e65-5f33239fc11a	0fe5fe58-662e-4891-b442-205b990c162a
30e1693b-d49c-489b-ba13-ab28b456cbd3	0fe5fe58-662e-4891-b442-205b990c162a
fc9df704-c0d4-45c9-81e2-5b6e6f947b61	0fe5fe58-662e-4891-b442-205b990c162a
f5599c3b-42eb-4937-b877-1b25aaa2760a	0fe5fe58-662e-4891-b442-205b990c162a
f86caa13-b891-44eb-932f-413aaa5cbd89	0fe5fe58-662e-4891-b442-205b990c162a
07c1e640-4e70-4e10-a81a-8c28c2d877f7	0fe5fe58-662e-4891-b442-205b990c162a
f44f9ad6-b76f-4b25-a18f-62c1368931fa	0fe5fe58-662e-4891-b442-205b990c162a
dc009e10-c242-43f6-9ce2-db07b2020ddd	5af769b6-7874-4cb8-9077-0fe79d6dfd9e
d66b2629-c44f-4011-bfc5-ce39099fb288	5af769b6-7874-4cb8-9077-0fe79d6dfd9e
dc009e10-c242-43f6-9ce2-db07b2020ddd	e6f4f152-a362-4dbe-a552-8d390bfe7b55
db0638b4-e439-47c1-bf4c-7812952a3987	e6f4f152-a362-4dbe-a552-8d390bfe7b55
dc009e10-c242-43f6-9ce2-db07b2020ddd	bd234904-c74b-4f53-beff-f57f554665ef
db0638b4-e439-47c1-bf4c-7812952a3987	bd234904-c74b-4f53-beff-f57f554665ef
1fffcb6f-fb3a-4492-889b-c7041048812f	0fe5fe58-662e-4891-b442-205b990c162a
93caffc2-84d7-44af-8e60-d0e16787a920	0fe5fe58-662e-4891-b442-205b990c162a
e7e491dc-4070-4170-b52a-1d13f695a45f	0fe5fe58-662e-4891-b442-205b990c162a
608743cf-30e7-4f2b-a7cd-2897ee92bf58	0fe5fe58-662e-4891-b442-205b990c162a
4a35fc4a-c6f9-4521-8794-28e51bc4e526	0fe5fe58-662e-4891-b442-205b990c162a
972c9c10-3fa1-4fd1-84c8-b9604ed3a3d4	0fe5fe58-662e-4891-b442-205b990c162a
49f44b86-382e-4b23-afd8-b1de0e1e3f8f	0fe5fe58-662e-4891-b442-205b990c162a
af3a1bdd-29f9-488a-9c59-3d9c367d6a68	0fe5fe58-662e-4891-b442-205b990c162a
4046ac8c-685d-46b9-a42b-cfcbc3c501fd	0fe5fe58-662e-4891-b442-205b990c162a
6bb18e31-de28-4b9b-bae9-d654f2f4ff75	0fe5fe58-662e-4891-b442-205b990c162a
123690bc-d9a4-4d65-9119-3c2eab3d9780	0fe5fe58-662e-4891-b442-205b990c162a
53fa1836-e6e9-42ea-9b5f-36585f09c134	0fe5fe58-662e-4891-b442-205b990c162a
2a218cbc-a6bd-4c70-86c9-c6f31b7bb1bd	0fe5fe58-662e-4891-b442-205b990c162a
54700490-dba0-402a-a45c-d7e0f5673e6f	0fe5fe58-662e-4891-b442-205b990c162a
1baeb684-fd79-4ee7-b2bd-a3d98ff15a50	0fe5fe58-662e-4891-b442-205b990c162a
1aef2cee-73a5-49e4-adf0-d8ee6214e120	0fe5fe58-662e-4891-b442-205b990c162a
7efed64f-b833-4096-a7e4-5f097426c06d	0fe5fe58-662e-4891-b442-205b990c162a
a118805b-7c50-45cf-bbab-9521167264fe	8cc39632-d297-44d8-85c1-0adf483603ea
a118805b-7c50-45cf-bbab-9521167264fe	a3d27beb-6e26-4df6-8a96-c68dcf625df1
a118805b-7c50-45cf-bbab-9521167264fe	9152d26a-a4cd-4e04-a979-7d1756896ee0
3a9c3b6c-956d-47ed-999c-1ec2977b293c	8cc39632-d297-44d8-85c1-0adf483603ea
\.


--
-- TOC entry 5882 (class 0 OID 61333)
-- Dependencies: 329
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 5883 (class 0 OID 61339)
-- Dependencies: 330
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 5884 (class 0 OID 61344)
-- Dependencies: 331
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 5885 (class 0 OID 61349)
-- Dependencies: 332
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: postgres
--

COPY keycloak.web_origins (client_id, value) FROM stdin;
9ac44be8-ce0e-46aa-8116-57a9e4dfc028	+
83d156ce-eb02-4415-a71e-9515f5e2fcee	+
212c93d9-721d-4a39-bac3-8f8a90aa993e	+
2570305d-a5ed-4c91-b1aa-0fdd4a8628a3	+
a394b610-97f4-4bd1-b512-9cf01093fa82	http://localhost:3000
\.


--
-- TOC entry 5771 (class 0 OID 54272)
-- Dependencies: 218
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brand (brandid, brand_name) FROM stdin;
8	Nike
9	Adidas
10	Callaway
11	Cleveland
12	Cobra
13	Ping
\.


--
-- TOC entry 5772 (class 0 OID 54275)
-- Dependencies: 219
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (categoryid, category, parent_categoryid) FROM stdin;
1	Golfkøller	\N
2	Klær og sko	\N
3	Tilbehør	\N
4	bagger og traller	\N
5	Driver	1
6	Wooder	1
7	Hybrid	1
8	Jern	1
9	Putter	1
10	Tshirts	2
11	Jakke	2
12	Bukse	2
13	Sko	2
14	Ball	3
15	Hanske	3
16	Trolleybag	4
17	Carrybag	4
\.


--
-- TOC entry 5773 (class 0 OID 54278)
-- Dependencies: 220
-- Data for Name: category_filter_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_filter_options (category_filter_optionsid, filter_optionid, categoryid) FROM stdin;
26	11	5
27	14	5
28	12	6
29	15	6
30	13	7
31	16	7
36	1	11
37	2	11
38	3	11
39	4	11
40	1	12
41	2	12
42	3	12
43	4	12
46	1	10
47	4	10
\.


--
-- TOC entry 5775 (class 0 OID 54282)
-- Dependencies: 222
-- Data for Name: filter_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filter_options (filter_optionid, filter_name, is_main_attribute) FROM stdin;
1	Size	f
2	Price	f
3	Brand	f
14	Driver Loft	f
15	Wooder Loft	f
16	Hybrid Loft	f
17	Flex	f
4	Color	t
11	Driver Flex	t
12	Wooder Flex	t
13	Hybrid Flex	t
\.


--
-- TOC entry 5777 (class 0 OID 54286)
-- Dependencies: 224
-- Data for Name: filter_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filter_values (filter_valueid, filter_optionid, filter_value) FROM stdin;
1	1	Small
2	1	Medium
3	1	Large
4	1	XL
5	1	XXL
6	4	Blue
7	4	Red
8	4	White
9	4	Black
10	3	Adidas
11	3	Nike
12	3	Puma
13	11	Extra Stiff
14	11	Stiff
15	11	Regular
16	12	Stiff
17	12	Regular
18	12	Senior
19	13	Regular
20	13	Senior
21	13	Ladies
22	14	8.5°
23	14	9°
24	14	9.5°
25	14	10.5°
26	14	12°
27	15	13°
28	15	15°
29	15	17°
30	15	19°
31	15	21°
32	16	18°
33	16	22°
34	16	24°
35	16	27°
42	3	Callaway
43	3	Cobra
44	3	Titleist
45	3	PING
\.


--
-- TOC entry 5779 (class 0 OID 54290)
-- Dependencies: 226
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (imageid, imageurl, productid) FROM stdin;
37	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-ls-driver-_1__1.jpg	82
38	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-ls-driver-_1__1.jpg	83
39	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/i/sim_2_max_driver.jpg	84
40	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-x-driver-_1__1.jpg	85
41	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-max-driver-_1__1.jpg	86
42	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/m/e/media-catalog-product-c-o-cobra_aerojet_max_driver.jpg	87
43	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/d/r/drivers-2024-rogue-st-max___1_1.png	88
44	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/co-king-rad-s-dr-25-h_1_.jpg	89
45	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-ls-driver-_1__1.jpg	90
46	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-max-driver-_1__1.jpg	91
47	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra_aerojet_ls_wood.jpg	92
48	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/i/sim_2_max_wood.jpg	93
49	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-max-wood-_1__1.jpg	94
50	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/m/a/mavrik_wood_1.jpg	95
51	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-x-wood-_1__1.jpg	96
52	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/f/w/fwoods-2024-rogue-st-max___1_1.png	97
53	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra_aerojet_max_wood.jpg	98
54	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/w/cw-pdy-ai-smk-max-fw-h_1__1.jpg	99
55	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/a/taylormade-qi10-fairway-wood_1_.jpg	100
56	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/m/tm-qi35-max-wood-h_1_.jpg	101
57	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra_tec_hybrid_23.png	102
58	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra-darkspeed-hybrid-_1__1.jpg	103
59	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra_aerojet_hybrid.jpg	104
60	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/i/sim_2_max_hybrid.jpg	105
61	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/co-fmax-airspeed-hy-ldy-h_1_.jpg	106
62	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/w/cw-pdy-ai-smk-hy-h_1_.jpg	107
63	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/co-ds-adapt-hybrid-h_1_.jpg	108
64	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/a/callaway_rogue_st_max_os_lite_hybrid_1.jpg	109
65	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/a/taylormade-qi10-tour-hybrid_1_.jpg	110
66	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/p/i/pi-g440-hyb-h_1__1_1.jpg	111
67	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/cobra_tec_hybrid_23.png	112
68	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/p/sport-45-hero-min.jpg	122
76	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/m/g/mg-mgzpt01.jpg	130
80	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/c/scotty_cameron_ss_newport.jpg	123
81	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/3/d/3d_agera_hero-min_3.jpg	124
82	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/o/d/od-ai-one-s2s-jailbird-cs-h_1_.jpg	125
83	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/u/supernova_35_fang_hero-min_2.jpg	126
84	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/m/tm-spider-red-25-db-pt-h_1_.jpg	127
85	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/m/a/mallet_2_1.jpg	128
86	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/c/sc-ss-25-newport-2-plus-pt-h_1_.jpg	129
88	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/m/tm-spider-tr-s-blk-25-cb-db-h_1_.jpg	131
90	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-fz7501-540-h_1_.jpg	133
91	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/g/r/gr_1_1_.jpg	134
92	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-dh0822-100-h_1_.jpg	136
93	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-dh0822-657-h_1_.jpg	137
94	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-fz7450-451-h_1_.jpg	139
99	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/ad-iu4442-h_1_.jpg	140
100	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/ad-iu4435-h_1_.jpg	135
101	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/adi_polo_1_.jpg	138
104	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/h/i/hielands_jakke_navy_1_.jpg	142
105	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/b/ab-0123-300-lores.jpg	143
106	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/h/ah_light_svart_1_.jpg	144
107	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/j/a/jakke_navy.jpg	145
108	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/z/a/zane_pro_navy_1_.jpg	146
109	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/b/ab-0202-300-h_1_.jpg	147
110	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/b/ab-0202-336-h_1_.jpg	148
111	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/j/a/jakke_gr_1_.jpg	149
112	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/w/cw-cgrfe0g4-410-h_1_.jpg	150
113	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/ad-ih8520-h_1_.jpg	162
114	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/ad-if0286-h_1_.jpg	168
115	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/d/ad-ih8520-h_1__1.jpg	169
116	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/i/n/inifinity_hvit_1_.jpg	163
117	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-fz4155-100-h_1_.jpg	164
118	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/n/i/ni-fd0217-100-h_1_.jpg	165
119	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/i/air_max_hvit_2.jpg	166
120	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/s/a/saddle_1_.jpg	167
121	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/i/n/inifinity_sort_1_.jpg	170
122	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/a/i/air_max_svart_1_.jpg	171
143	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/w/e/webimage-4b0c734c-de84-4348-91c5a58276a2e272.png	408
144	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/w/e/webimage-08dd39a8-f296-4c6c-a5f1bc3987d2d387.png	409
145	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/o/co-909590-001.jpg	410
146	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/h/chase_dry_sort_1_.jpg	411
147	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/l/i/lite_3_tralle.jpg	412
148	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/w/e/webimage-cd8194f4-4aa0-4b8e-b3346ec6865b7b2f.png	413
149	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/f/l/flare_bl_1_.jpg	414
150	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/p/r/pro_navy_1_.jpg	415
151	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/f/e/feather_1_.jpg	416
152	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/u/l/ul_pro_sort_1_.jpg	417
153	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/i/ti-t2029s-4dlrd.jpg	172
154	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/w/s/ws-wg2008101.jpg	173
155	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/m/tm-n7638601.jpg	174
156	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/t/m/tm-v9948501_1_.jpg	175
157	https://www.golfshopen.no/media/catalog/product/cache/46aafc3e6118b9c39efa06563f5f1493/c/v/cv-3695950004-3dz_1__1.jpg	176
158	https://img01.ztat.net/article/spp-media-p1/a94a8450256b43d8be5c55be690d9a70/9e32009872044583822d780901ddb6ee.jpg?imwidth=1800&filter=packshot	132
159	https://img01.ztat.net/article/spp-media-p1/d13ca4dd322247e7a230b790108093ef/064adab04ad74f888a7ad4ca8cf63212.jpg?imwidth=1800&filter=packshot	132
160	https://img01.ztat.net/article/spp-media-p1/a94a8450256b43d8be5c55be690d9a70/9e32009872044583822d780901ddb6ee.jpg?imwidth=1800&filter=packshot	132
161	https://img01.ztat.net/article/spp-media-p1/a078919943df49968d3997bf29d2cecd/d0a4a1cd35114119a89d163f7bf00de1.jpg?imwidth=1800&filter=packshot	132
166	https://www.xxl.no/filespin/23a0f6957d2045f9b8bfc362e17031ec?quality=75&bgcolor=efefef&resize=1080%2C1080	177
167	https://www.xxl.no/filespin/20f4bdd63eb84e6abbb7d3a26ce82700?quality=75&bgcolor=efefef&resize=1080%2C1080	178
168	https://www.xxl.no/filespin/4d08e41a9f9e4ff1b7673f68115dd143?quality=75&bgcolor=efefef&resize=1080%2C1080	179
169	https://www.xxl.no/filespin/c6fa576c4aef470fb855e6423f7a6621?quality=75&bgcolor=efefef&resize=1080%2C1080	180
170	https://www.xxl.no/filespin/e1a38829e64141198bd1bf940f12dada?quality=75&bgcolor=efefef&resize=1080%2C1080	181
171	https://www.xxl.no/filespin/23a0f6957d2045f9b8bfc362e17031ec?quality=75&bgcolor=efefef&resize=1080%2C1080	177
172	https://www.xxl.no/filespin/5e13be7a199d44c8b4030d336282c71d?quality=75&bgcolor=efefef&resize=1080%2C1080	177
173	https://www.xxl.no/filespin/6ad471fc224744d1ad92e722adfb43bf?quality=75&bgcolor=efefef&resize=1080%2C1080	177
174	https://www.xxl.no/filespin/d8a6f8bd79594fc4b48bc3a5252c7fbf?quality=75&bgcolor=efefef&resize=1080%2C1080	177
175	https://williamsandkent.com/cdn/shop/files/53390_PG13_WK_SP23.jpg?v=1707318122&width=900	151
176	https://img01.ztat.net/article/spp-media-p1/a94a8450256b43d8be5c55be690d9a70/9e32009872044583822d780901ddb6ee.jpg?imwidth=1800&filter=packshot	141
177	https://img01.ztat.net/article/spp-media-p1/d13ca4dd322247e7a230b790108093ef/064adab04ad74f888a7ad4ca8cf63212.jpg?imwidth=1800&filter=packshot	141
178	https://img01.ztat.net/article/spp-media-p1/a94a8450256b43d8be5c55be690d9a70/9e32009872044583822d780901ddb6ee.jpg?imwidth=1800&filter=packshot	141
179	https://img01.ztat.net/article/spp-media-p1/a078919943df49968d3997bf29d2cecd/d0a4a1cd35114119a89d163f7bf00de1.jpg?imwidth=1800&filter=packshot	141
\.


--
-- TOC entry 5782 (class 0 OID 54297)
-- Dependencies: 229
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_variants (variantid, productid) FROM stdin;
1	132
2	132
3	132
4	132
5	132
6	132
7	132
8	132
9	132
10	132
11	133
12	133
13	133
14	133
15	133
16	133
17	133
18	133
19	133
20	133
21	134
22	134
23	134
24	134
25	134
26	134
27	134
28	134
29	134
30	134
31	135
32	135
33	135
34	135
35	135
36	135
37	135
38	135
39	135
40	135
41	136
42	136
43	136
44	136
45	136
46	136
47	136
48	136
49	136
50	136
51	137
52	137
53	137
54	137
55	137
56	137
57	137
58	137
59	137
60	137
61	138
62	138
63	138
64	138
65	138
66	138
67	138
68	138
69	138
70	138
71	139
72	139
73	139
74	139
75	139
76	139
77	139
78	139
79	139
80	139
81	140
82	140
83	140
84	140
85	140
86	140
87	140
88	140
89	140
90	140
91	141
92	141
93	141
94	141
95	141
96	141
97	141
98	141
99	141
100	141
101	142
102	142
103	142
104	142
105	142
106	142
107	142
108	142
109	142
110	142
111	143
112	143
113	143
114	143
115	143
116	143
117	143
118	143
119	143
120	143
121	144
122	144
123	144
124	144
125	144
126	144
127	144
128	144
129	144
130	144
131	145
132	145
133	145
134	145
135	145
136	145
137	145
138	145
139	145
140	145
141	146
142	146
143	146
144	146
145	146
146	146
147	146
148	146
149	146
150	146
151	147
152	147
153	147
154	147
155	147
156	147
157	147
158	147
159	147
160	147
161	148
162	148
163	148
164	148
165	148
166	148
167	148
168	148
169	148
170	148
171	149
172	149
173	149
174	149
175	149
176	149
177	149
178	149
179	149
180	149
181	150
182	150
183	150
184	150
185	150
186	150
187	150
188	150
189	150
190	150
191	151
192	151
193	151
194	151
195	151
196	151
197	151
198	151
199	151
200	151
501	82
502	82
503	82
504	82
505	82
506	82
507	82
508	82
509	82
510	82
511	82
512	82
513	82
514	82
515	82
516	82
517	82
518	82
519	82
520	82
521	83
522	83
523	83
524	83
525	83
526	83
527	83
528	83
529	83
530	83
531	83
532	83
533	83
534	83
535	83
536	83
537	83
538	83
539	83
540	83
541	84
542	84
543	84
544	84
545	84
546	84
547	84
548	84
549	84
550	84
551	84
552	84
553	84
554	84
555	84
556	84
557	84
558	84
559	84
560	84
561	85
562	85
563	85
564	85
565	85
566	85
567	85
568	85
569	85
570	85
571	85
572	85
573	85
574	85
575	85
576	85
577	85
578	85
579	85
580	85
581	86
582	86
583	86
584	86
585	86
586	86
587	86
588	86
589	86
590	86
591	86
592	86
593	86
594	86
595	86
596	86
597	86
598	86
599	86
600	86
601	87
602	87
603	87
604	87
605	87
606	87
607	87
608	87
609	87
610	87
611	87
612	87
613	87
614	87
615	87
616	87
617	87
618	87
619	87
620	87
621	88
622	88
623	88
624	88
625	88
626	88
627	88
628	88
629	88
630	88
631	88
632	88
633	88
634	88
635	88
636	88
637	88
638	88
639	88
640	88
641	89
642	89
643	89
644	89
645	89
646	89
647	89
648	89
649	89
650	89
651	89
652	89
653	89
654	89
655	89
656	89
657	89
658	89
659	89
660	89
661	90
662	90
663	90
664	90
665	90
666	90
667	90
668	90
669	90
670	90
671	90
672	90
673	90
674	90
675	90
676	90
677	90
678	90
679	90
680	90
681	91
682	91
683	91
684	91
685	91
686	91
687	91
688	91
689	91
690	91
691	91
692	91
693	91
694	91
695	91
696	91
697	91
698	91
699	91
700	91
701	92
702	92
703	92
704	92
705	92
706	92
707	92
708	92
709	92
710	92
711	92
712	92
713	92
714	92
715	92
716	92
717	92
718	92
719	92
720	92
721	93
722	93
723	93
724	93
725	93
726	93
727	93
728	93
729	93
730	93
731	93
732	93
733	93
734	93
735	93
736	93
737	93
738	93
739	93
740	93
741	94
742	94
743	94
744	94
745	94
746	94
747	94
748	94
749	94
750	94
751	94
752	94
753	94
754	94
755	94
756	94
757	94
758	94
759	94
760	94
761	95
762	95
763	95
764	95
765	95
766	95
767	95
768	95
769	95
770	95
771	95
772	95
773	95
774	95
775	95
776	95
777	95
778	95
779	95
780	95
781	96
782	96
783	96
784	96
785	96
786	96
787	96
788	96
789	96
790	96
791	96
792	96
793	96
794	96
795	96
796	96
797	96
798	96
799	96
800	96
801	97
802	97
803	97
804	97
805	97
806	97
807	97
808	97
809	97
810	97
811	97
812	97
813	97
814	97
815	97
816	97
817	97
818	97
819	97
820	97
821	98
822	98
823	98
824	98
825	98
826	98
827	98
828	98
829	98
830	98
831	98
832	98
833	98
834	98
835	98
836	98
837	98
838	98
839	98
840	98
841	99
842	99
843	99
844	99
845	99
846	99
847	99
848	99
849	99
850	99
851	99
852	99
853	99
854	99
855	99
856	99
857	99
858	99
859	99
860	99
861	100
862	100
863	100
864	100
865	100
866	100
867	100
868	100
869	100
870	100
871	100
872	100
873	100
874	100
875	100
876	100
877	100
878	100
879	100
880	100
881	101
882	101
883	101
884	101
885	101
886	101
887	101
888	101
889	101
890	101
891	101
892	101
893	101
894	101
895	101
896	101
897	101
898	101
899	101
900	101
901	102
902	102
903	102
904	102
905	102
906	102
907	102
908	102
909	102
910	102
911	102
912	102
913	102
914	102
915	102
916	102
917	102
918	102
919	102
920	102
921	103
922	103
923	103
924	103
925	103
926	103
927	103
928	103
929	103
930	103
931	103
932	103
933	103
934	103
935	103
936	103
937	103
938	103
939	103
940	103
941	104
942	104
943	104
944	104
945	104
946	104
947	104
948	104
949	104
950	104
951	104
952	104
953	104
954	104
955	104
956	104
957	104
958	104
959	104
960	104
961	105
962	105
963	105
964	105
965	105
966	105
967	105
968	105
969	105
970	105
971	105
972	105
973	105
974	105
975	105
976	105
977	105
978	105
979	105
980	105
981	106
982	106
983	106
984	106
985	106
986	106
987	106
988	106
989	106
990	106
991	106
992	106
993	106
994	106
995	106
996	106
997	106
998	106
999	106
1000	106
1001	107
1002	107
1003	107
1004	107
1005	107
1006	107
1007	107
1008	107
1009	107
1010	107
1011	107
1012	107
1013	107
1014	107
1015	107
1016	107
1017	107
1018	107
1019	107
1020	107
1021	108
1022	108
1023	108
1024	108
1025	108
1026	108
1027	108
1028	108
1029	108
1030	108
1031	108
1032	108
1033	108
1034	108
1035	108
1036	108
1037	108
1038	108
1039	108
1040	108
1041	109
1042	109
1043	109
1044	109
1045	109
1046	109
1047	109
1048	109
1049	109
1050	109
1051	109
1052	109
1053	109
1054	109
1055	109
1056	109
1057	109
1058	109
1059	109
1060	109
1061	110
1062	110
1063	110
1064	110
1065	110
1066	110
1067	110
1068	110
1069	110
1070	110
1071	110
1072	110
1073	110
1074	110
1075	110
1076	110
1077	110
1078	110
1079	110
1080	110
1081	111
1082	111
1083	111
1084	111
1085	111
1086	111
1087	111
1088	111
1089	111
1090	111
1091	111
1092	111
1093	111
1094	111
1095	111
1096	111
1097	111
1098	111
1099	111
1100	111
1111	172
1112	173
1113	174
1114	175
1115	176
1116	408
1117	409
1118	410
1119	411
1120	412
1121	413
1122	414
1123	415
1124	416
1125	417
\.


--
-- TOC entry 5784 (class 0 OID 54301)
-- Dependencies: 231
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (productid, productname, price, categoryid, description, brandid, has_variants) FROM stdin;
82	Titan V1 Driver	299.99	5	High launch with titanium face for maximum distance.	10	t
83	Falcon XR	279.99	5	Speed-optimized head with low spin control.	13	t
84	BlackHawk Stealth	319.99	5	Matte black aerodynamic driver for better airflow.	12	t
85	Eagle Pro Max	289.99	5	Forgiveness-focused driver for consistent swings.	11	t
86	Inferno Drive X	309.99	5	Hot face technology for explosive energy transfer.	10	t
87	Stormbreaker Z7	339.99	5	Tour-level precision with adjustable loft.	13	t
88	Quantum Boost	249.99	5	Entry-level power driver with light graphite shaft.	9	t
89	Velocity Nova	269.99	5	Balanced feel with smart weight distribution.	8	t
90	Phantom Impact	299.49	5	Deep sound and high ball speed at impact.	11	t
91	Raptor Elite Drive	324.95	5	Elite control driver with carbon crown.	12	t
92	Silverstrike 3W	219.99	6	3-wood with high MOI and low CG for optimal trajectory.	10	t
93	Vortex FW5	229.50	6	Powerful fairway wood for long-range control shots.	13	t
94	Predator Launch W7	249.95	6	Lightweight composite head for fast swing speeds.	11	t
95	Tornado Glide 3+	239.99	6	Wide sole wood with turf interaction technology.	12	t
96	Phoenix Ember 4W	224.75	6	Mid-launch 4-wood with responsive face insert.	10	t
97	Skyline Horizon 5W	212.00	6	Forgiving 5-wood with smooth launch for amateurs.	8	t
98	Tempest Steel 7W	218.90	6	Compact head design for tight fairway control.	11	t
99	NovaSpin Flex W3	245.00	6	Advanced flex shaft with neutral flight bias.	13	t
100	Ignite Max Fairway	259.99	6	Explosive ball speed with carbon crown.	12	t
101	Eclipse Tour W5+	232.99	6	Tour-profiled wood with controlled spin rate.	9	t
102	Fusion H2	199.99	7	Forgiving hybrid with high launch and soft landing.	10	t
103	Viper Strike H3	209.50	7	Low-profile hybrid with fast face for long approaches.	13	t
104	Orion Forge H4	219.99	7	Precision hybrid for gap filling between irons.	12	t
105	Thunderflash H5	205.00	7	Mid-launch hybrid ideal for rough and tight lies.	11	t
106	Blaze Aero H3	199.95	7	Aero-optimized head for easy swings and high carry.	8	t
107	Hawk Glide H2+	214.90	7	Versatile hybrid with neutral ball flight.	13	t
108	Equinox Hybrid 19°	223.00	7	Designed for better turf interaction and distance.	10	t
109	StealthPath H4+	217.75	7	Matte black finish with explosive energy transfer.	12	t
110	Firefly Rescue H3	208.99	7	Lightweight rescue club with high forgiveness.	11	t
111	Galaxy Core H5	229.49	7	Compact profile hybrid with strong ball flight.	9	t
112	Fusion H2	199.99	7	Forgiving hybrid with high launch and soft landing.	10	t
113	Viper Strike H3	209.50	7	Low-profile hybrid with fast face for long approaches.	13	t
114	Orion Forge H4	219.99	7	Precision hybrid for gap filling between irons.	12	t
115	Thunderflash H5	205.00	7	Mid-launch hybrid ideal for rough and tight lies.	11	t
116	Blaze Aero H3	199.95	7	Aero-optimized head for easy swings and high carry.	8	t
117	Hawk Glide H2+	214.90	7	Versatile hybrid with neutral ball flight.	13	t
118	Equinox Hybrid 19°	223.00	7	Designed for better turf interaction and distance.	10	t
119	StealthPath H4+	217.75	7	Matte black finish with explosive energy transfer.	12	t
120	Firefly Rescue H3	208.99	7	Lightweight rescue club with high forgiveness.	11	t
121	Galaxy Core H5	229.49	7	Compact profile hybrid with strong ball flight.	9	t
122	RollMaster P1	119.99	9	Face-balanced putter for square impact.	10	t
123	Phantom Glide Putter	134.50	9	Smooth rolling mallet with high MOI.	11	t
124	ZenBlade Classic	128.00	9	Blade-style putter with soft insert.	13	t
125	Storm Align Putter	149.99	9	Alignment lines for visual aid and control.	12	t
126	Orbit Tour P2	138.25	9	High toe-hang design for arc putting strokes.	9	t
127	Gravity Lock Putter	129.75	9	Heavy headweight for improved tempo.	10	t
128	Raptor SmoothRoll	142.99	9	Precision-milled face for consistent roll.	11	t
129	NovaLine Putter X	137.49	9	Stable mallet with oversized grip support.	13	t
130	Eclipse SoftTouch	144.00	9	Soft polymer insert for quiet feedback.	12	t
131	Tundra Ice Putter	151.95	9	Minimalist look with balanced performance.	8	t
408	TerrainRoller 5-Wheel	109.99	16	High-quality trolley bag for all terrains.	10	f
409	FairwayCruise Pro	113.99	16	High-quality trolley bag for all terrains.	10	f
410	EZGlide TerrainMaster	117.99	16	High-quality trolley bag for all terrains.	10	f
411	TourTrack StableCart	121.99	16	High-quality trolley bag for all terrains.	11	f
412	AllRoad Compact Trolley	125.99	16	High-quality trolley bag for all terrains.	11	f
413	SwiftCarry Lite	89.99	17	Lightweight and durable carry bag for walkers.	11	f
414	ProWalker Flex	93.49	17	Lightweight and durable carry bag for walkers.	12	f
415	AirStride CarryPack	96.99	17	Lightweight and durable carry bag for walkers.	12	f
416	SpeedCarry Tour	100.49	17	Lightweight and durable carry bag for walkers.	12	f
417	FieldRunner Compact	103.99	17	Lightweight and durable carry bag for walkers.	10	f
172	VeloSpin Tour Ball	44.99	14	3-piece urethane ball for high spin control.	10	t
173	AeroDrive Distance Ball	29.95	14	Maximized distance with low driver spin.	9	t
174	SoftCore Control Ball	34.50	14	Soft feel for greenside control.	13	t
175	Phantom Velocity Ball	39.00	14	Balanced performance for all swing speeds.	11	t
176	StormFlight Range Ball	24.99	14	Durable two-piece construction for practice.	12	t
177	GripMaster Leather Glove	21.99	15	Cabretta leather for premium feel and grip.	10	t
178	AllWeather Flex Glove	18.50	15	Stretch zones and water-resistant fabric.	9	t
179	TourFit Pro Glove	19.75	15	Tour-proven fit with moisture-wicking interior.	11	t
180	Phantom Grip Control	22.00	15	Enhanced palm texture for grip consistency.	13	t
181	LiteSwing Mesh Glove	17.95	15	Lightweight and breathable mesh back.	12	t
151	Phantom WarmCore	107.50	11	Lined for insulation with active stretch.	9	t
152	TourFit Trousers	59.99	12	Slim-cut stretch trousers for full mobility.	9	t
153	DrySwing Pants	64.50	12	Quick-drying fabric with elastic waistband.	9	t
154	Clubhouse Chinos	62.00	12	Cotton-blend pants for on/off course wear.	8	t
155	FlexTech Slacks	68.95	12	Soft feel with performance flex zones.	9	t
156	StormLine Rain Pants	74.25	12	Waterproof pants with zippered legs.	9	t
157	PowerStride Pants	66.00	12	Athletic fit with hidden ball pocket.	8	t
158	ProMotion Golf Pants	63.75	12	Classic fit with modern tapered leg.	8	t
159	EagleCore Stretch	67.90	12	Smooth finish with active cooling.	8	t
160	BunkerGuard Trousers	71.10	12	Durable build for rough terrain.	8	t
161	Fairway Flow Pants	69.95	12	Wrinkle-free travel-friendly fabric.	8	t
132	ProDry Tee V1	39.99	10	Moisture-wicking performance golf t-shirt.	8	t
133	ClimaSwing Tee	42.50	10	Breathable Adidas golf shirt with stretch fabric.	8	t
134	CoolFlex Polo Tee	44.99	10	Lightweight polo tee for summer rounds.	8	t
135	StrikeFit Tee	41.25	10	Modern athletic fit with vented side panels.	9	t
136	TourCore Cotton Tee	36.95	10	Classic cotton tee with embroidered chest logo.	8	t
137	SwingEase Tee	38.90	10	4-way stretch for unrestrictive movement.	8	t
138	EagleLine DryFit	43.00	10	Quick-dry tee ideal for warm climates.	9	t
139	Titan Classic Tee	39.49	10	Traditional fit shirt for clubhouse comfort.	8	t
140	ZeroResistance Tee	45.00	10	Seamless design with antimicrobial finish.	9	t
141	SkyDrive Performance Tee	47.25	10	UV-protective shirt for high sun exposure.	8	t
142	StormShell Jacket	89.99	11	Water-resistant shell with wind protection.	9	t
143	ThermoFlex Golf Jacket	94.50	11	Light insulation with flexible stretch zones.	8	t
144	AeroZip Hybrid Jacket	102.00	11	Hybrid jacket with breathable back panel.	8	t
145	ColdPlay Tour Jacket	109.99	11	Thermal-lined jacket for cold-weather rounds.	8	t
146	DrizzleGuard Pro	95.75	11	Rain-resistant finish with adjustable cuffs.	9	t
147	SkyLine Softshell	98.45	11	Lightweight shell for early mornings.	8	t
148	WindRush Elite	99.99	11	Windbreaker with ventilation flaps.	9	t
149	Nimbus DryLayer	103.25	11	3-layer construction for foul weather.	9	t
150	Equinox Ultralight	92.90	11	Compact and packable golf jacket.	8	t
162	GripMax Spike	109.99	13	Traditional spiked golf shoe with max grip.	9	t
163	CloudWalk Pro	124.50	13	Cushioned sole for all-day comfort.	8	t
164	StormTread Waterproof	132.00	13	100% waterproof with premium leather.	8	t
165	ZeroDrop LightStep	118.75	13	Low-profile shoe with balanced stance.	8	t
166	Fairway Runner Hybrid	115.00	13	Sneaker-like comfort with golf performance.	8	t
167	Velocity SpikeLite	129.95	13	Lightweight spiked shoe for fast tempo swings.	8	t
168	EagleWalk Classic	111.25	13	Classic look with modern insole cushioning.	9	t
169	NovaDrive BOA	139.99	13	Dial-based BOA lacing for precision fit.	9	t
170	Phantom Tour S	128.49	13	Molded footbed with stability frame.	8	t
171	AirGrip SoftFlex	119.00	13	Flexible outsole with breathable mesh.	8	t
\.


--
-- TOC entry 5786 (class 0 OID 54308)
-- Dependencies: 233
-- Data for Name: productstock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productstock (stockid, productid, variantid, stockcount) FROM stdin;
16	132	1	100
17	132	2	100
18	132	3	100
19	132	4	100
20	132	5	100
21	132	6	100
22	132	7	100
23	132	8	100
24	132	9	100
25	132	10	100
26	133	11	100
27	133	12	100
28	133	13	100
29	133	14	100
30	133	15	100
31	133	16	100
32	133	17	100
33	133	18	100
34	133	19	100
35	133	20	100
36	134	21	100
37	134	22	100
38	134	23	100
39	134	24	100
40	134	25	100
41	134	26	100
42	134	27	100
43	134	28	100
44	134	29	100
45	134	30	100
46	135	31	100
47	135	32	100
48	135	33	100
49	135	34	100
50	135	35	100
51	135	36	100
52	135	37	100
53	135	38	100
54	135	39	100
55	135	40	100
56	136	41	100
57	136	42	100
58	136	43	100
59	136	44	100
60	136	45	100
61	136	46	100
62	136	47	100
63	136	48	100
64	136	49	100
65	136	50	100
66	137	51	100
67	137	52	100
68	137	53	100
69	137	54	100
70	137	55	100
71	137	56	100
72	137	57	100
73	137	58	100
74	137	59	100
75	137	60	100
76	138	61	100
77	138	62	100
78	138	63	100
79	138	64	100
80	138	65	100
81	138	66	100
82	138	67	100
83	138	68	100
84	138	69	100
85	138	70	100
86	139	71	100
87	139	72	100
88	139	73	100
89	139	74	100
90	139	75	100
91	139	76	100
92	139	77	100
93	139	78	100
94	139	79	100
95	139	80	100
96	140	81	100
97	140	82	100
98	140	83	100
99	140	84	100
100	140	85	100
101	140	86	100
102	140	87	100
103	140	88	100
104	140	89	100
105	140	90	100
106	141	91	100
107	141	92	100
108	141	93	100
109	141	94	100
110	141	95	100
111	141	96	100
112	141	97	100
113	141	98	100
114	141	99	100
115	141	100	100
116	142	101	100
117	142	102	100
118	142	103	100
119	142	104	100
120	142	105	100
121	142	106	100
122	142	107	100
123	142	108	100
124	142	109	100
125	142	110	100
126	143	111	100
127	143	112	100
128	143	113	100
129	143	114	100
130	143	115	100
131	143	116	100
132	143	117	100
133	143	118	100
134	143	119	100
135	143	120	100
136	144	121	100
137	144	122	100
138	144	123	100
139	144	124	100
140	144	125	100
141	144	126	100
142	144	127	100
143	144	128	100
144	144	129	100
145	144	130	100
146	145	131	100
147	145	132	100
148	145	133	100
149	145	134	100
150	145	135	100
151	145	136	100
152	145	137	100
153	145	138	100
154	145	139	100
155	145	140	100
156	146	141	100
157	146	142	100
158	146	143	100
159	146	144	100
160	146	145	100
161	146	146	100
162	146	147	100
163	146	148	100
164	146	149	100
165	146	150	100
166	147	151	100
167	147	152	100
168	147	153	100
169	147	154	100
170	147	155	100
171	147	156	100
172	147	157	100
173	147	158	100
174	147	159	100
175	147	160	100
176	148	161	100
177	148	162	100
178	148	163	100
179	148	164	100
180	148	165	100
181	148	166	100
182	148	167	100
183	148	168	100
184	148	169	100
185	148	170	100
186	149	171	100
187	149	172	100
188	149	173	100
189	149	174	100
190	149	175	100
191	149	176	100
192	149	177	100
193	149	178	100
194	149	179	100
195	149	180	100
196	150	181	100
197	150	182	100
198	150	183	100
199	150	184	100
200	150	185	100
201	150	186	100
202	150	187	100
203	150	188	100
204	150	189	100
205	150	190	100
206	151	191	100
207	151	192	100
208	151	193	100
209	151	194	100
210	151	195	100
211	151	196	100
212	151	197	100
213	151	198	100
214	151	199	100
215	151	200	100
216	82	501	100
217	82	502	100
218	82	503	100
219	82	504	100
220	82	505	100
221	82	506	100
222	82	507	100
223	82	508	100
224	82	509	100
225	82	510	100
226	82	511	100
227	82	512	100
228	82	513	100
229	82	514	100
230	82	515	100
231	82	516	100
232	82	517	100
233	82	518	100
234	82	519	100
235	82	520	100
236	83	521	100
237	83	522	100
238	83	523	100
239	83	524	100
240	83	525	100
241	83	526	100
242	83	527	100
243	83	528	100
244	83	529	100
245	83	530	100
246	83	531	100
247	83	532	100
248	83	533	100
249	83	534	100
250	83	535	100
251	83	536	100
252	83	537	100
253	83	538	100
254	83	539	100
255	83	540	100
256	84	541	100
257	84	542	100
258	84	543	100
259	84	544	100
260	84	545	100
261	84	546	100
262	84	547	100
263	84	548	100
264	84	549	100
265	84	550	100
266	84	551	100
267	84	552	100
268	84	553	100
269	84	554	100
270	84	555	100
271	84	556	100
272	84	557	100
273	84	558	100
274	84	559	100
275	84	560	100
276	85	561	100
277	85	562	100
278	85	563	100
279	85	564	100
280	85	565	100
281	85	566	100
282	85	567	100
283	85	568	100
284	85	569	100
285	85	570	100
286	85	571	100
287	85	572	100
288	85	573	100
289	85	574	100
290	85	575	100
291	85	576	100
292	85	577	100
293	85	578	100
294	85	579	100
295	85	580	100
296	86	581	100
297	86	582	100
298	86	583	100
299	86	584	100
300	86	585	100
301	86	586	100
302	86	587	100
303	86	588	100
304	86	589	100
305	86	590	100
306	86	591	100
307	86	592	100
308	86	593	100
309	86	594	100
310	86	595	100
311	86	596	100
312	86	597	100
313	86	598	100
314	86	599	100
315	86	600	100
316	87	601	100
317	87	602	100
318	87	603	100
319	87	604	100
320	87	605	100
321	87	606	100
322	87	607	100
323	87	608	100
324	87	609	100
325	87	610	100
326	87	611	100
327	87	612	100
328	87	613	100
329	87	614	100
330	87	615	100
331	87	616	100
332	87	617	100
333	87	618	100
334	87	619	100
335	87	620	100
336	88	621	100
337	88	622	100
338	88	623	100
339	88	624	100
340	88	625	100
341	88	626	100
342	88	627	100
343	88	628	100
344	88	629	100
345	88	630	100
346	88	631	100
347	88	632	100
348	88	633	100
349	88	634	100
350	88	635	100
351	88	636	100
352	88	637	100
353	88	638	100
354	88	639	100
355	88	640	100
356	89	641	100
357	89	642	100
358	89	643	100
359	89	644	100
360	89	645	100
361	89	646	100
362	89	647	100
363	89	648	100
364	89	649	100
365	89	650	100
366	89	651	100
367	89	652	100
368	89	653	100
369	89	654	100
370	89	655	100
371	89	656	100
372	89	657	100
373	89	658	100
374	89	659	100
375	89	660	100
376	90	661	100
377	90	662	100
378	90	663	100
379	90	664	100
380	90	665	100
381	90	666	100
382	90	667	100
383	90	668	100
384	90	669	100
385	90	670	100
386	90	671	100
387	90	672	100
388	90	673	100
389	90	674	100
390	90	675	100
391	90	676	100
392	90	677	100
393	90	678	100
394	90	679	100
395	90	680	100
396	91	681	100
397	91	682	100
398	91	683	100
399	91	684	100
400	91	685	100
401	91	686	100
402	91	687	100
403	91	688	100
404	91	689	100
405	91	690	100
406	91	691	100
407	91	692	100
408	91	693	100
409	91	694	100
410	91	695	100
411	91	696	100
412	91	697	100
413	91	698	100
414	91	699	100
415	91	700	100
416	92	701	100
417	92	702	100
418	92	703	100
419	92	704	100
420	92	705	100
421	92	706	100
422	92	707	100
423	92	708	100
424	92	709	100
425	92	710	100
426	92	711	100
427	92	712	100
428	92	713	100
429	92	714	100
430	92	715	100
431	92	716	100
432	92	717	100
433	92	718	100
434	92	719	100
435	92	720	100
436	93	721	100
437	93	722	100
438	93	723	100
439	93	724	100
440	93	725	100
441	93	726	100
442	93	727	100
443	93	728	100
444	93	729	100
445	93	730	100
446	93	731	100
447	93	732	100
448	93	733	100
449	93	734	100
450	93	735	100
451	93	736	100
452	93	737	100
453	93	738	100
454	93	739	100
455	93	740	100
456	94	741	100
457	94	742	100
458	94	743	100
459	94	744	100
460	94	745	100
461	94	746	100
462	94	747	100
463	94	748	100
464	94	749	100
465	94	750	100
466	94	751	100
467	94	752	100
468	94	753	100
469	94	754	100
470	94	755	100
471	94	756	100
472	94	757	100
473	94	758	100
474	94	759	100
475	94	760	100
476	95	761	100
477	95	762	100
478	95	763	100
479	95	764	100
480	95	765	100
481	95	766	100
482	95	767	100
483	95	768	100
484	95	769	100
485	95	770	100
486	95	771	100
487	95	772	100
488	95	773	100
489	95	774	100
490	95	775	100
491	95	776	100
492	95	777	100
493	95	778	100
494	95	779	100
495	95	780	100
496	96	781	100
497	96	782	100
498	96	783	100
499	96	784	100
500	96	785	100
501	96	786	100
502	96	787	100
503	96	788	100
504	96	789	100
505	96	790	100
506	96	791	100
507	96	792	100
508	96	793	100
509	96	794	100
510	96	795	100
511	96	796	100
512	96	797	100
513	96	798	100
514	96	799	100
515	96	800	100
516	97	801	100
517	97	802	100
518	97	803	100
519	97	804	100
520	97	805	100
521	97	806	100
522	97	807	100
523	97	808	100
524	97	809	100
525	97	810	100
526	97	811	100
527	97	812	100
528	97	813	100
529	97	814	100
530	97	815	100
531	97	816	100
532	97	817	100
533	97	818	100
534	97	819	100
535	97	820	100
536	98	821	100
537	98	822	100
538	98	823	100
539	98	824	100
540	98	825	100
541	98	826	100
542	98	827	100
543	98	828	100
544	98	829	100
545	98	830	100
546	98	831	100
547	98	832	100
548	98	833	100
549	98	834	100
550	98	835	100
551	98	836	100
552	98	837	100
553	98	838	100
554	98	839	100
555	98	840	100
556	99	841	100
557	99	842	100
558	99	843	100
559	99	844	100
560	99	845	100
561	99	846	100
562	99	847	100
563	99	848	100
564	99	849	100
565	99	850	100
566	99	851	100
567	99	852	100
568	99	853	100
569	99	854	100
570	99	855	100
571	99	856	100
572	99	857	100
573	99	858	100
574	99	859	100
575	99	860	100
576	100	861	100
577	100	862	100
578	100	863	100
579	100	864	100
580	100	865	100
581	100	866	100
582	100	867	100
583	100	868	100
584	100	869	100
585	100	870	100
586	100	871	100
587	100	872	100
588	100	873	100
589	100	874	100
590	100	875	100
591	100	876	100
592	100	877	100
593	100	878	100
594	100	879	100
595	100	880	100
596	101	881	100
597	101	882	100
598	101	883	100
599	101	884	100
600	101	885	100
601	101	886	100
602	101	887	100
603	101	888	100
604	101	889	100
605	101	890	100
606	101	891	100
607	101	892	100
608	101	893	100
609	101	894	100
610	101	895	100
611	101	896	100
612	101	897	100
613	101	898	100
614	101	899	100
615	101	900	100
616	102	901	100
617	102	902	100
618	102	903	100
619	102	904	100
620	102	905	100
621	102	906	100
622	102	907	100
623	102	908	100
624	102	909	100
625	102	910	100
626	102	911	100
627	102	912	100
628	102	913	100
629	102	914	100
630	102	915	100
631	102	916	100
632	102	917	100
633	102	918	100
634	102	919	100
635	102	920	100
636	103	921	100
637	103	922	100
638	103	923	100
639	103	924	100
640	103	925	100
641	103	926	100
642	103	927	100
643	103	928	100
644	103	929	100
645	103	930	100
646	103	931	100
647	103	932	100
648	103	933	100
649	103	934	100
650	103	935	100
651	103	936	100
652	103	937	100
653	103	938	100
654	103	939	100
655	103	940	100
656	104	941	100
657	104	942	100
658	104	943	100
659	104	944	100
660	104	945	100
661	104	946	100
662	104	947	100
663	104	948	100
664	104	949	100
665	104	950	100
666	104	951	100
667	104	952	100
668	104	953	100
669	104	954	100
670	104	955	100
671	104	956	100
672	104	957	100
673	104	958	100
674	104	959	100
675	104	960	100
676	105	961	100
677	105	962	100
678	105	963	100
679	105	964	100
680	105	965	100
681	105	966	100
682	105	967	100
683	105	968	100
684	105	969	100
685	105	970	100
686	105	971	100
687	105	972	100
688	105	973	100
689	105	974	100
690	105	975	100
691	105	976	100
692	105	977	100
693	105	978	100
694	105	979	100
695	105	980	100
696	106	981	100
697	106	982	100
698	106	983	100
699	106	984	100
700	106	985	100
701	106	986	100
702	106	987	100
703	106	988	100
704	106	989	100
705	106	990	100
706	106	991	100
707	106	992	100
708	106	993	100
709	106	994	100
710	106	995	100
711	106	996	100
712	106	997	100
713	106	998	100
714	106	999	100
715	106	1000	100
716	107	1001	100
717	107	1002	100
718	107	1003	100
719	107	1004	100
720	107	1005	100
721	107	1006	100
722	107	1007	100
723	107	1008	100
724	107	1009	100
725	107	1010	100
726	107	1011	100
727	107	1012	100
728	107	1013	100
729	107	1014	100
730	107	1015	100
731	107	1016	100
732	107	1017	100
733	107	1018	100
734	107	1019	100
735	107	1020	100
736	108	1021	100
737	108	1022	100
738	108	1023	100
739	108	1024	100
740	108	1025	100
741	108	1026	100
742	108	1027	100
743	108	1028	100
744	108	1029	100
745	108	1030	100
746	108	1031	100
747	108	1032	100
748	108	1033	100
749	108	1034	100
750	108	1035	100
751	108	1036	100
752	108	1037	100
753	108	1038	100
754	108	1039	100
755	108	1040	100
756	109	1041	100
757	109	1042	100
758	109	1043	100
759	109	1044	100
760	109	1045	100
761	109	1046	100
762	109	1047	100
763	109	1048	100
764	109	1049	100
765	109	1050	100
766	109	1051	100
767	109	1052	100
768	109	1053	100
769	109	1054	100
770	109	1055	100
771	109	1056	100
772	109	1057	100
773	109	1058	100
774	109	1059	100
775	109	1060	100
776	110	1061	100
777	110	1062	100
778	110	1063	100
779	110	1064	100
780	110	1065	100
781	110	1066	100
782	110	1067	100
783	110	1068	100
784	110	1069	100
785	110	1070	100
786	110	1071	100
787	110	1072	100
788	110	1073	100
789	110	1074	100
790	110	1075	100
791	110	1076	100
792	110	1077	100
793	110	1078	100
794	110	1079	100
795	110	1080	100
796	111	1081	100
797	111	1082	100
798	111	1083	100
799	111	1084	100
800	111	1085	100
801	111	1086	100
802	111	1087	100
803	111	1088	100
804	111	1089	100
805	111	1090	100
806	111	1091	100
807	111	1092	100
808	111	1093	100
809	111	1094	100
810	111	1095	100
811	111	1096	100
812	111	1097	100
813	111	1098	100
814	111	1099	100
815	111	1100	100
816	172	1111	100
817	173	1112	100
818	174	1113	100
819	175	1114	100
820	176	1115	100
821	408	1116	100
822	409	1117	100
823	410	1118	100
824	411	1119	100
825	412	1120	100
826	413	1121	100
827	414	1122	100
828	415	1123	100
829	416	1124	100
830	417	1125	100
\.


--
-- TOC entry 5788 (class 0 OID 54312)
-- Dependencies: 235
-- Data for Name: shoppingcart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shoppingcart (shoppingcartid, keycloakid) FROM stdin;
1	37ddaf2c-7bcc-4735-9a2f-e0d81dab171f
2	717014ef-5807-4a1e-9e90-9415ce50a254
3	bd234904-c74b-4f53-beff-f57f554665ef
4	e6f4f152-a362-4dbe-a552-8d390bfe7b55
5	3083191e-bc6a-4d98-bf71-d7b676ff01cf
6	c2a33db1-ee44-4d68-ba1d-88739bfbb83a
7	e3c85e09-1775-4050-a727-753fd49a7721
8	826cd9c0-5268-47dc-bfb4-1aeb6fcb3b69
9	2e446419-fd5b-4963-b1ec-2e85f213921e
10	5d397029-3eb4-4199-b527-eab5fdc3fd41
\.


--
-- TOC entry 5790 (class 0 OID 54316)
-- Dependencies: 237
-- Data for Name: shoppingcartitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shoppingcartitems (shoppingcartid, variantid, amount) FROM stdin;
7	1	1
\.


--
-- TOC entry 5791 (class 0 OID 54319)
-- Dependencies: 238
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (keycloakid, email, firstname, lastname, adress, phone) FROM stdin;
73362bba-2200-4a15-9978-d6bd4f090050	be.ostby@hotmail.com	Bjørn-Erik	Østby	\N	\N
6889de79-eb43-4664-aed8-8b61216085ea	bee.ostby@hotmail.com	qwer	qwer	qwerqwer	\N
37ddaf2c-7bcc-4735-9a2f-e0d81dab171f	alferino@pepperino.no	Alf	erino	Veiginveien 99	\N
717014ef-5807-4a1e-9e90-9415ce50a254	elise@hotmail.com	Elise	Strømsodd	VEiginff	\N
bd234904-c74b-4f53-beff-f57f554665ef	testuser2@hotmail.com	Test	User2	Hvelven	\N
e6f4f152-a362-4dbe-a552-8d390bfe7b55	testuser@hotmail.com	Test	User	\N	\N
3083191e-bc6a-4d98-bf71-d7b676ff01cf	fårn@gho	fårnm	user	\N	\N
c2a33db1-ee44-4d68-ba1d-88739bfbb83a	testuser3@hotmail.com	test3	user3	\N	\N
e3c85e09-1775-4050-a727-753fd49a7721	igjen@f.f	igjen	igjeeen	\N	\N
826cd9c0-5268-47dc-bfb4-1aeb6fcb3b69	pepsi@ho.c	pepsi	max	\N	\N
2e446419-fd5b-4963-b1ec-2e85f213921e	lars@hotmail.com	Lars	Nordås	\N	\N
5d397029-3eb4-4199-b527-eab5fdc3fd41	sprud@go.c	sprudle	vann	\N	\N
\.


--
-- TOC entry 5792 (class 0 OID 54322)
-- Dependencies: 239
-- Data for Name: variant_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variant_attributes (variant_attributeid, variantid, filter_optionid, filter_valueid) FROM stdin;
1256	901	13	19
1257	901	16	32
1258	902	13	19
1259	902	16	33
1260	903	13	19
1261	903	16	34
1262	904	13	20
1263	904	16	32
1264	905	13	20
1265	905	16	33
1266	906	13	20
1267	906	16	34
1268	907	13	21
1269	907	16	32
1270	908	13	21
1271	908	16	33
1272	909	13	21
1273	909	16	34
1274	910	13	19
1275	910	16	32
1276	911	13	19
1277	911	16	33
1278	912	13	19
1279	912	16	34
1280	913	13	20
1281	913	16	32
1282	914	13	20
1283	914	16	33
1284	915	13	20
1285	915	16	34
1286	916	13	21
1287	916	16	32
1288	917	13	21
1289	917	16	33
1290	918	13	21
1291	918	16	34
1292	919	13	19
1293	919	16	32
1294	920	13	19
1295	920	16	33
1296	921	13	19
1297	921	16	32
50	1	1	1
51	1	4	6
52	2	1	2
53	2	4	8
54	3	1	3
55	3	4	6
56	4	1	1
57	4	4	8
58	5	1	2
59	5	4	6
60	6	1	3
61	6	4	8
62	7	1	1
63	7	4	6
64	8	1	2
65	8	4	8
66	9	1	3
67	9	4	6
68	10	1	1
69	10	4	8
70	11	1	1
71	11	4	6
72	12	1	2
73	12	4	8
74	13	1	3
75	13	4	6
76	14	1	1
77	14	4	8
78	15	1	2
79	15	4	6
80	16	1	3
81	16	4	8
82	17	1	1
83	17	4	6
84	18	1	2
85	18	4	8
86	19	1	3
87	19	4	6
88	20	1	1
89	20	4	8
90	21	1	1
91	21	4	6
92	22	1	2
93	22	4	8
94	23	1	3
95	23	4	6
96	24	1	1
97	24	4	8
98	25	1	2
99	25	4	6
100	26	1	3
101	26	4	8
102	27	1	1
103	27	4	6
104	28	1	2
105	28	4	8
106	29	1	3
107	29	4	6
108	30	1	1
109	30	4	8
110	31	1	1
111	31	4	6
112	32	1	2
113	32	4	8
114	33	1	3
115	33	4	6
116	34	1	1
117	34	4	8
118	35	1	2
119	35	4	6
120	36	1	3
121	36	4	8
122	37	1	1
123	37	4	6
124	38	1	2
125	38	4	8
126	39	1	3
127	39	4	6
128	40	1	1
129	40	4	8
130	41	1	1
131	41	4	6
132	42	1	2
133	42	4	8
134	43	1	3
135	43	4	6
136	44	1	1
137	44	4	8
138	45	1	2
139	45	4	6
140	46	1	3
141	46	4	8
142	47	1	1
143	47	4	6
144	48	1	2
145	48	4	8
146	49	1	3
147	49	4	6
148	50	1	1
149	50	4	8
150	51	1	1
151	51	4	6
152	52	1	2
153	52	4	8
154	53	1	3
155	53	4	6
156	54	1	1
157	54	4	8
158	55	1	2
159	55	4	6
160	56	1	3
161	56	4	8
162	57	1	1
163	57	4	6
164	58	1	2
165	58	4	8
166	59	1	3
167	59	4	6
168	60	1	1
169	60	4	8
170	61	1	1
171	61	4	6
172	62	1	2
173	62	4	8
174	63	1	3
175	63	4	6
176	64	1	1
177	64	4	8
178	65	1	2
179	65	4	6
180	66	1	3
181	66	4	8
182	67	1	1
183	67	4	6
184	68	1	2
185	68	4	8
186	69	1	3
187	69	4	6
188	70	1	1
189	70	4	8
190	71	1	1
191	71	4	6
192	72	1	2
193	72	4	8
194	73	1	3
195	73	4	6
196	74	1	1
197	74	4	8
198	75	1	2
199	75	4	6
200	76	1	3
201	76	4	8
202	77	1	1
203	77	4	6
204	78	1	2
205	78	4	8
206	79	1	3
207	79	4	6
208	80	1	1
209	80	4	8
210	81	1	1
211	81	4	6
212	82	1	2
213	82	4	8
214	83	1	3
215	83	4	6
216	84	1	1
217	84	4	8
218	85	1	2
219	85	4	6
220	86	1	3
221	86	4	8
222	87	1	1
223	87	4	6
224	88	1	2
225	88	4	8
226	89	1	3
227	89	4	6
228	90	1	1
229	90	4	8
230	91	1	1
231	91	4	6
232	92	1	2
233	92	4	8
234	93	1	3
235	93	4	6
236	94	1	1
237	94	4	8
238	95	1	2
239	95	4	6
240	96	1	3
241	96	4	8
242	97	1	1
243	97	4	6
244	98	1	2
245	98	4	8
246	99	1	3
247	99	4	6
248	100	1	1
249	100	4	8
250	101	1	1
251	101	4	6
252	102	1	2
253	102	4	8
254	103	1	3
255	103	4	6
256	104	1	1
257	104	4	8
258	105	1	2
259	105	4	6
260	106	1	3
261	106	4	8
262	107	1	1
263	107	4	6
264	108	1	2
265	108	4	8
266	109	1	3
267	109	4	6
268	110	1	1
269	110	4	8
270	111	1	1
271	111	4	6
272	112	1	2
273	112	4	8
274	113	1	3
275	113	4	6
276	114	1	1
277	114	4	8
278	115	1	2
279	115	4	6
280	116	1	3
281	116	4	8
282	117	1	1
283	117	4	6
284	118	1	2
285	118	4	8
286	119	1	3
287	119	4	6
288	120	1	1
289	120	4	8
290	121	1	1
291	121	4	6
292	122	1	2
293	122	4	8
294	123	1	3
295	123	4	6
296	124	1	1
297	124	4	8
298	125	1	2
299	125	4	6
300	126	1	3
301	126	4	8
302	127	1	1
303	127	4	6
304	128	1	2
305	128	4	8
306	129	1	3
307	129	4	6
308	130	1	1
309	130	4	8
310	131	1	1
311	131	4	6
312	132	1	2
313	132	4	8
314	133	1	3
315	133	4	6
316	134	1	1
317	134	4	8
318	135	1	2
319	135	4	6
320	136	1	3
321	136	4	8
322	137	1	1
323	137	4	6
324	138	1	2
325	138	4	8
326	139	1	3
327	139	4	6
328	140	1	1
329	140	4	8
330	141	1	1
331	141	4	6
332	142	1	2
333	142	4	8
334	143	1	3
335	143	4	6
336	144	1	1
337	144	4	8
338	145	1	2
339	145	4	6
340	146	1	3
341	146	4	8
342	147	1	1
343	147	4	6
344	148	1	2
345	148	4	8
346	149	1	3
347	149	4	6
348	150	1	1
349	150	4	8
350	151	1	1
351	151	4	6
352	152	1	2
353	152	4	8
354	153	1	3
355	153	4	6
356	154	1	1
357	154	4	8
358	155	1	2
359	155	4	6
360	156	1	3
361	156	4	8
362	157	1	1
363	157	4	6
364	158	1	2
365	158	4	8
366	159	1	3
367	159	4	6
368	160	1	1
369	160	4	8
370	161	1	1
371	161	4	6
372	162	1	2
373	162	4	8
374	163	1	3
375	163	4	6
376	164	1	1
377	164	4	8
378	165	1	2
379	165	4	6
380	166	1	3
381	166	4	8
382	167	1	1
383	167	4	6
384	168	1	2
385	168	4	8
386	169	1	3
387	169	4	6
388	170	1	1
389	170	4	8
390	171	1	1
391	171	4	6
392	172	1	2
393	172	4	8
394	173	1	3
395	173	4	6
396	174	1	1
397	174	4	8
398	175	1	2
399	175	4	6
400	176	1	3
401	176	4	8
402	177	1	1
403	177	4	6
404	178	1	2
405	178	4	8
406	179	1	3
407	179	4	6
408	180	1	1
409	180	4	8
410	181	1	1
411	181	4	6
412	182	1	2
413	182	4	8
414	183	1	3
415	183	4	6
416	184	1	1
417	184	4	8
418	185	1	2
419	185	4	6
420	186	1	3
421	186	4	8
422	187	1	1
423	187	4	6
424	188	1	2
425	188	4	8
426	189	1	3
427	189	4	6
428	190	1	1
429	190	4	8
430	191	1	1
431	191	4	6
432	192	1	2
433	192	4	8
434	193	1	3
435	193	4	6
436	194	1	1
437	194	4	8
438	195	1	2
439	195	4	6
440	196	1	3
441	196	4	8
442	197	1	1
443	197	4	6
444	198	1	2
445	198	4	8
446	199	1	3
447	199	4	6
448	200	1	1
449	200	4	8
1298	922	13	19
1299	922	16	33
1300	923	13	19
1301	923	16	34
1302	924	13	20
1303	924	16	32
456	501	11	15
457	501	14	22
458	502	11	15
459	502	14	23
460	503	11	15
461	503	14	24
462	504	11	14
463	504	14	26
464	505	11	14
465	505	14	22
466	506	11	14
467	506	14	23
468	507	11	13
469	507	14	25
470	508	11	13
471	508	14	26
472	509	11	13
473	509	14	22
474	510	11	12
475	510	14	24
476	511	11	12
477	511	14	25
478	512	11	12
479	512	14	26
480	513	11	15
481	513	14	23
482	514	11	15
483	514	14	24
484	515	11	15
485	515	14	25
486	516	11	14
487	516	14	22
488	517	11	14
489	517	14	23
490	518	11	14
491	518	14	24
492	519	11	13
493	519	14	26
494	520	11	13
495	520	14	22
496	521	11	15
497	521	14	22
498	522	11	15
499	522	14	23
500	523	11	15
501	523	14	24
502	524	11	14
503	524	14	26
504	525	11	14
505	525	14	22
506	526	11	14
507	526	14	23
508	527	11	13
509	527	14	25
510	528	11	13
511	528	14	26
512	529	11	13
513	529	14	22
514	530	11	12
515	530	14	24
516	531	11	12
517	531	14	25
518	532	11	12
519	532	14	26
520	533	11	15
521	533	14	23
522	534	11	15
523	534	14	24
524	535	11	15
525	535	14	25
526	536	11	14
527	536	14	22
528	537	11	14
529	537	14	23
530	538	11	14
531	538	14	24
532	539	11	13
533	539	14	26
534	540	11	13
535	540	14	22
536	541	11	15
537	541	14	22
538	542	11	15
539	542	14	23
540	543	11	15
541	543	14	24
542	544	11	14
543	544	14	26
544	545	11	14
545	545	14	22
546	546	11	14
547	546	14	23
548	547	11	13
549	547	14	25
550	548	11	13
551	548	14	26
552	549	11	13
553	549	14	22
554	550	11	12
555	550	14	24
556	551	11	12
557	551	14	25
558	552	11	12
559	552	14	26
560	553	11	15
561	553	14	23
562	554	11	15
563	554	14	24
564	555	11	15
565	555	14	25
566	556	11	14
567	556	14	22
568	557	11	14
569	557	14	23
570	558	11	14
571	558	14	24
572	559	11	13
573	559	14	26
574	560	11	13
575	560	14	22
576	561	11	15
577	561	14	22
578	562	11	15
579	562	14	23
580	563	11	15
581	563	14	24
582	564	11	14
583	564	14	26
584	565	11	14
585	565	14	22
586	566	11	14
587	566	14	23
588	567	11	13
589	567	14	25
590	568	11	13
591	568	14	26
592	569	11	13
593	569	14	22
594	570	11	12
595	570	14	24
596	571	11	12
597	571	14	25
598	572	11	12
599	572	14	26
600	573	11	15
601	573	14	23
602	574	11	15
603	574	14	24
604	575	11	15
605	575	14	25
606	576	11	14
607	576	14	22
608	577	11	14
609	577	14	23
610	578	11	14
611	578	14	24
612	579	11	13
613	579	14	26
614	580	11	13
615	580	14	22
616	581	11	15
617	581	14	22
618	582	11	15
619	582	14	23
620	583	11	15
621	583	14	24
622	584	11	14
623	584	14	26
624	585	11	14
625	585	14	22
626	586	11	14
627	586	14	23
628	587	11	13
629	587	14	25
630	588	11	13
631	588	14	26
632	589	11	13
633	589	14	22
634	590	11	12
635	590	14	24
636	591	11	12
637	591	14	25
638	592	11	12
639	592	14	26
640	593	11	15
641	593	14	23
642	594	11	15
643	594	14	24
644	595	11	15
645	595	14	25
646	596	11	14
647	596	14	22
648	597	11	14
649	597	14	23
650	598	11	14
651	598	14	24
652	599	11	13
653	599	14	26
654	600	11	13
655	600	14	22
656	601	11	15
657	601	14	22
658	602	11	15
659	602	14	23
660	603	11	15
661	603	14	24
662	604	11	14
663	604	14	26
664	605	11	14
665	605	14	22
666	606	11	14
667	606	14	23
668	607	11	13
669	607	14	25
670	608	11	13
671	608	14	26
672	609	11	13
673	609	14	22
674	610	11	12
675	610	14	24
676	611	11	12
677	611	14	25
678	612	11	12
679	612	14	26
680	613	11	15
681	613	14	23
682	614	11	15
683	614	14	24
684	615	11	15
685	615	14	25
686	616	11	14
687	616	14	22
688	617	11	14
689	617	14	23
690	618	11	14
691	618	14	24
692	619	11	13
693	619	14	26
694	620	11	13
695	620	14	22
696	621	11	15
697	621	14	22
698	622	11	15
699	622	14	23
700	623	11	15
701	623	14	24
702	624	11	14
703	624	14	26
704	625	11	14
705	625	14	22
706	626	11	14
707	626	14	23
708	627	11	13
709	627	14	25
710	628	11	13
711	628	14	26
712	629	11	13
713	629	14	22
714	630	11	12
715	630	14	24
716	631	11	12
717	631	14	25
718	632	11	12
719	632	14	26
720	633	11	15
721	633	14	23
722	634	11	15
723	634	14	24
724	635	11	15
725	635	14	25
726	636	11	14
727	636	14	22
728	637	11	14
729	637	14	23
730	638	11	14
731	638	14	24
732	639	11	13
733	639	14	26
734	640	11	13
735	640	14	22
736	641	11	15
737	641	14	22
738	642	11	15
739	642	14	23
740	643	11	15
741	643	14	24
742	644	11	14
743	644	14	26
744	645	11	14
745	645	14	22
746	646	11	14
747	646	14	23
748	647	11	13
749	647	14	25
750	648	11	13
751	648	14	26
752	649	11	13
753	649	14	22
754	650	11	12
755	650	14	24
756	651	11	12
757	651	14	25
758	652	11	12
759	652	14	26
760	653	11	15
761	653	14	23
762	654	11	15
763	654	14	24
764	655	11	15
765	655	14	25
766	656	11	14
767	656	14	22
768	657	11	14
769	657	14	23
770	658	11	14
771	658	14	24
772	659	11	13
773	659	14	26
774	660	11	13
775	660	14	22
776	661	11	15
777	661	14	22
778	662	11	15
779	662	14	23
780	663	11	15
781	663	14	24
782	664	11	14
783	664	14	26
784	665	11	14
785	665	14	22
786	666	11	14
787	666	14	23
788	667	11	13
789	667	14	25
790	668	11	13
791	668	14	26
792	669	11	13
793	669	14	22
794	670	11	12
795	670	14	24
796	671	11	12
797	671	14	25
798	672	11	12
799	672	14	26
800	673	11	15
801	673	14	23
802	674	11	15
803	674	14	24
804	675	11	15
805	675	14	25
806	676	11	14
807	676	14	22
808	677	11	14
809	677	14	23
810	678	11	14
811	678	14	24
812	679	11	13
813	679	14	26
814	680	11	13
815	680	14	22
816	681	11	15
817	681	14	22
818	682	11	15
819	682	14	23
820	683	11	15
821	683	14	24
822	684	11	14
823	684	14	26
824	685	11	14
825	685	14	22
826	686	11	14
827	686	14	23
828	687	11	13
829	687	14	25
830	688	11	13
831	688	14	26
832	689	11	13
833	689	14	22
834	690	11	12
835	690	14	24
836	691	11	12
837	691	14	25
838	692	11	12
839	692	14	26
840	693	11	15
841	693	14	23
842	694	11	15
843	694	14	24
844	695	11	15
845	695	14	25
846	696	11	14
847	696	14	22
848	697	11	14
849	697	14	23
850	698	11	14
851	698	14	24
852	699	11	13
853	699	14	26
854	700	11	13
855	700	14	22
856	701	12	17
857	701	15	27
858	702	12	17
859	702	15	28
860	703	12	17
861	703	15	29
862	704	12	18
863	704	15	31
864	705	12	18
865	705	15	27
866	706	12	18
867	706	15	28
868	707	12	17
869	707	15	30
870	708	12	17
871	708	15	31
872	709	12	17
873	709	15	27
874	710	12	18
875	710	15	29
876	711	12	18
877	711	15	30
878	712	12	18
879	712	15	31
880	713	12	17
881	713	15	28
882	714	12	17
883	714	15	29
884	715	12	17
885	715	15	30
886	716	12	18
887	716	15	27
888	717	12	18
889	717	15	28
890	718	12	18
891	718	15	29
892	719	12	17
893	719	15	31
894	720	12	17
895	720	15	27
896	721	12	17
897	721	15	27
898	722	12	17
899	722	15	28
900	723	12	17
901	723	15	29
902	724	12	18
903	724	15	31
904	725	12	18
905	725	15	27
906	726	12	18
907	726	15	28
908	727	12	17
909	727	15	30
910	728	12	17
911	728	15	31
912	729	12	17
913	729	15	27
914	730	12	18
915	730	15	29
916	731	12	18
917	731	15	30
918	732	12	18
919	732	15	31
920	733	12	17
921	733	15	28
922	734	12	17
923	734	15	29
924	735	12	17
925	735	15	30
926	736	12	18
927	736	15	27
928	737	12	18
929	737	15	28
930	738	12	18
931	738	15	29
932	739	12	17
933	739	15	31
934	740	12	17
935	740	15	27
936	741	12	17
937	741	15	27
938	742	12	17
939	742	15	28
940	743	12	17
941	743	15	29
942	744	12	18
943	744	15	31
944	745	12	18
945	745	15	27
946	746	12	18
947	746	15	28
948	747	12	17
949	747	15	30
950	748	12	17
951	748	15	31
952	749	12	17
953	749	15	27
954	750	12	18
955	750	15	29
956	751	12	18
957	751	15	30
958	752	12	18
959	752	15	31
960	753	12	17
961	753	15	28
962	754	12	17
963	754	15	29
964	755	12	17
965	755	15	30
966	756	12	18
967	756	15	27
968	757	12	18
969	757	15	28
970	758	12	18
971	758	15	29
972	759	12	17
973	759	15	31
974	760	12	17
975	760	15	27
976	761	12	17
977	761	15	27
978	762	12	17
979	762	15	28
980	763	12	17
981	763	15	29
982	764	12	18
983	764	15	31
984	765	12	18
985	765	15	27
986	766	12	18
987	766	15	28
988	767	12	17
989	767	15	30
990	768	12	17
991	768	15	31
992	769	12	17
993	769	15	27
994	770	12	18
995	770	15	29
996	771	12	18
997	771	15	30
998	772	12	18
999	772	15	31
1000	773	12	17
1001	773	15	28
1002	774	12	17
1003	774	15	29
1004	775	12	17
1005	775	15	30
1006	776	12	18
1007	776	15	27
1008	777	12	18
1009	777	15	28
1010	778	12	18
1011	778	15	29
1012	779	12	17
1013	779	15	31
1014	780	12	17
1015	780	15	27
1016	781	12	17
1017	781	15	27
1018	782	12	17
1019	782	15	28
1020	783	12	17
1021	783	15	29
1022	784	12	18
1023	784	15	31
1024	785	12	18
1025	785	15	27
1026	786	12	18
1027	786	15	28
1028	787	12	17
1029	787	15	30
1030	788	12	17
1031	788	15	31
1032	789	12	17
1033	789	15	27
1034	790	12	18
1035	790	15	29
1036	791	12	18
1037	791	15	30
1038	792	12	18
1039	792	15	31
1040	793	12	17
1041	793	15	28
1042	794	12	17
1043	794	15	29
1044	795	12	17
1045	795	15	30
1046	796	12	18
1047	796	15	27
1048	797	12	18
1049	797	15	28
1050	798	12	18
1051	798	15	29
1052	799	12	17
1053	799	15	31
1054	800	12	17
1055	800	15	27
1056	801	12	17
1057	801	15	27
1058	802	12	17
1059	802	15	28
1060	803	12	17
1061	803	15	29
1062	804	12	18
1063	804	15	31
1064	805	12	18
1065	805	15	27
1066	806	12	18
1067	806	15	28
1068	807	12	17
1069	807	15	30
1070	808	12	17
1071	808	15	31
1072	809	12	17
1073	809	15	27
1074	810	12	18
1075	810	15	29
1076	811	12	18
1077	811	15	30
1078	812	12	18
1079	812	15	31
1080	813	12	17
1081	813	15	28
1082	814	12	17
1083	814	15	29
1084	815	12	17
1085	815	15	30
1086	816	12	18
1087	816	15	27
1088	817	12	18
1089	817	15	28
1090	818	12	18
1091	818	15	29
1092	819	12	17
1093	819	15	31
1094	820	12	17
1095	820	15	27
1096	821	12	17
1097	821	15	27
1098	822	12	17
1099	822	15	28
1100	823	12	17
1101	823	15	29
1102	824	12	18
1103	824	15	31
1104	825	12	18
1105	825	15	27
1106	826	12	18
1107	826	15	28
1108	827	12	17
1109	827	15	30
1110	828	12	17
1111	828	15	31
1112	829	12	17
1113	829	15	27
1114	830	12	18
1115	830	15	29
1116	831	12	18
1117	831	15	30
1118	832	12	18
1119	832	15	31
1120	833	12	17
1121	833	15	28
1122	834	12	17
1123	834	15	29
1124	835	12	17
1125	835	15	30
1126	836	12	18
1127	836	15	27
1128	837	12	18
1129	837	15	28
1130	838	12	18
1131	838	15	29
1132	839	12	17
1133	839	15	31
1134	840	12	17
1135	840	15	27
1136	841	12	17
1137	841	15	27
1138	842	12	17
1139	842	15	28
1140	843	12	17
1141	843	15	29
1142	844	12	18
1143	844	15	31
1144	845	12	18
1145	845	15	27
1146	846	12	18
1147	846	15	28
1148	847	12	17
1149	847	15	30
1150	848	12	17
1151	848	15	31
1152	849	12	17
1153	849	15	27
1154	850	12	18
1155	850	15	29
1156	851	12	18
1157	851	15	30
1158	852	12	18
1159	852	15	31
1160	853	12	17
1161	853	15	28
1162	854	12	17
1163	854	15	29
1164	855	12	17
1165	855	15	30
1166	856	12	18
1167	856	15	27
1168	857	12	18
1169	857	15	28
1170	858	12	18
1171	858	15	29
1172	859	12	17
1173	859	15	31
1174	860	12	17
1175	860	15	27
1176	861	12	17
1177	861	15	27
1178	862	12	17
1179	862	15	28
1180	863	12	17
1181	863	15	29
1182	864	12	18
1183	864	15	31
1184	865	12	18
1185	865	15	27
1186	866	12	18
1187	866	15	28
1188	867	12	17
1189	867	15	30
1190	868	12	17
1191	868	15	31
1192	869	12	17
1193	869	15	27
1194	870	12	18
1195	870	15	29
1196	871	12	18
1197	871	15	30
1198	872	12	18
1199	872	15	31
1200	873	12	17
1201	873	15	28
1202	874	12	17
1203	874	15	29
1204	875	12	17
1205	875	15	30
1206	876	12	18
1207	876	15	27
1208	877	12	18
1209	877	15	28
1210	878	12	18
1211	878	15	29
1212	879	12	17
1213	879	15	31
1214	880	12	17
1215	880	15	27
1216	881	12	17
1217	881	15	27
1218	882	12	17
1219	882	15	28
1220	883	12	17
1221	883	15	29
1222	884	12	18
1223	884	15	31
1224	885	12	18
1225	885	15	27
1226	886	12	18
1227	886	15	28
1228	887	12	17
1229	887	15	30
1230	888	12	17
1231	888	15	31
1232	889	12	17
1233	889	15	27
1234	890	12	18
1235	890	15	29
1236	891	12	18
1237	891	15	30
1238	892	12	18
1239	892	15	31
1240	893	12	17
1241	893	15	28
1242	894	12	17
1243	894	15	29
1244	895	12	17
1245	895	15	30
1246	896	12	18
1247	896	15	27
1248	897	12	18
1249	897	15	28
1250	898	12	18
1251	898	15	29
1252	899	12	17
1253	899	15	31
1254	900	12	17
1255	900	15	27
1304	925	13	20
1305	925	16	33
1306	926	13	20
1307	926	16	34
1308	927	13	21
1309	927	16	32
1310	928	13	21
1311	928	16	33
1312	929	13	21
1313	929	16	34
1314	930	13	19
1315	930	16	32
1316	931	13	19
1317	931	16	33
1318	932	13	19
1319	932	16	34
1320	933	13	20
1321	933	16	32
1322	934	13	20
1323	934	16	33
1324	935	13	20
1325	935	16	34
1326	936	13	21
1327	936	16	32
1328	937	13	21
1329	937	16	33
1330	938	13	21
1331	938	16	34
1332	939	13	19
1333	939	16	32
1334	940	13	19
1335	940	16	33
1336	941	13	19
1337	941	16	32
1338	942	13	19
1339	942	16	33
1340	943	13	19
1341	943	16	34
1342	944	13	20
1343	944	16	32
1344	945	13	20
1345	945	16	33
1346	946	13	20
1347	946	16	34
1348	947	13	21
1349	947	16	32
1350	948	13	21
1351	948	16	33
1352	949	13	21
1353	949	16	34
1354	950	13	19
1355	950	16	32
1356	951	13	19
1357	951	16	33
1358	952	13	19
1359	952	16	34
1360	953	13	20
1361	953	16	32
1362	954	13	20
1363	954	16	33
1364	955	13	20
1365	955	16	34
1366	956	13	21
1367	956	16	32
1368	957	13	21
1369	957	16	33
1370	958	13	21
1371	958	16	34
1372	959	13	19
1373	959	16	32
1374	960	13	19
1375	960	16	33
1376	961	13	19
1377	961	16	32
1378	962	13	19
1379	962	16	33
1380	963	13	19
1381	963	16	34
1382	964	13	20
1383	964	16	32
1384	965	13	20
1385	965	16	33
1386	966	13	20
1387	966	16	34
1388	967	13	21
1389	967	16	32
1390	968	13	21
1391	968	16	33
1392	969	13	21
1393	969	16	34
1394	970	13	19
1395	970	16	32
1396	971	13	19
1397	971	16	33
1398	972	13	19
1399	972	16	34
1400	973	13	20
1401	973	16	32
1402	974	13	20
1403	974	16	33
1404	975	13	20
1405	975	16	34
1406	976	13	21
1407	976	16	32
1408	977	13	21
1409	977	16	33
1410	978	13	21
1411	978	16	34
1412	979	13	19
1413	979	16	32
1414	980	13	19
1415	980	16	33
1416	981	13	19
1417	981	16	32
1418	982	13	19
1419	982	16	33
1420	983	13	19
1421	983	16	34
1422	984	13	20
1423	984	16	32
1424	985	13	20
1425	985	16	33
1426	986	13	20
1427	986	16	34
1428	987	13	21
1429	987	16	32
1430	988	13	21
1431	988	16	33
1432	989	13	21
1433	989	16	34
1434	990	13	19
1435	990	16	32
1436	991	13	19
1437	991	16	33
1438	992	13	19
1439	992	16	34
1440	993	13	20
1441	993	16	32
1442	994	13	20
1443	994	16	33
1444	995	13	20
1445	995	16	34
1446	996	13	21
1447	996	16	32
1448	997	13	21
1449	997	16	33
1450	998	13	21
1451	998	16	34
1452	999	13	19
1453	999	16	32
1454	1000	13	19
1455	1000	16	33
1456	1001	13	19
1457	1001	16	32
1458	1002	13	19
1459	1002	16	33
1460	1003	13	19
1461	1003	16	34
1462	1004	13	20
1463	1004	16	32
1464	1005	13	20
1465	1005	16	33
1466	1006	13	20
1467	1006	16	34
1468	1007	13	21
1469	1007	16	32
1470	1008	13	21
1471	1008	16	33
1472	1009	13	21
1473	1009	16	34
1474	1010	13	19
1475	1010	16	32
1476	1011	13	19
1477	1011	16	33
1478	1012	13	19
1479	1012	16	34
1480	1013	13	20
1481	1013	16	32
1482	1014	13	20
1483	1014	16	33
1484	1015	13	20
1485	1015	16	34
1486	1016	13	21
1487	1016	16	32
1488	1017	13	21
1489	1017	16	33
1490	1018	13	21
1491	1018	16	34
1492	1019	13	19
1493	1019	16	32
1494	1020	13	19
1495	1020	16	33
1496	1021	13	19
1497	1021	16	32
1498	1022	13	19
1499	1022	16	33
1500	1023	13	19
1501	1023	16	34
1502	1024	13	20
1503	1024	16	32
1504	1025	13	20
1505	1025	16	33
1506	1026	13	20
1507	1026	16	34
1508	1027	13	21
1509	1027	16	32
1510	1028	13	21
1511	1028	16	33
1512	1029	13	21
1513	1029	16	34
1514	1030	13	19
1515	1030	16	32
1516	1031	13	19
1517	1031	16	33
1518	1032	13	19
1519	1032	16	34
1520	1033	13	20
1521	1033	16	32
1522	1034	13	20
1523	1034	16	33
1524	1035	13	20
1525	1035	16	34
1526	1036	13	21
1527	1036	16	32
1528	1037	13	21
1529	1037	16	33
1530	1038	13	21
1531	1038	16	34
1532	1039	13	19
1533	1039	16	32
1534	1040	13	19
1535	1040	16	33
1536	1041	13	19
1537	1041	16	32
1538	1042	13	19
1539	1042	16	33
1540	1043	13	19
1541	1043	16	34
1542	1044	13	20
1543	1044	16	32
1544	1045	13	20
1545	1045	16	33
1546	1046	13	20
1547	1046	16	34
1548	1047	13	21
1549	1047	16	32
1550	1048	13	21
1551	1048	16	33
1552	1049	13	21
1553	1049	16	34
1554	1050	13	19
1555	1050	16	32
1556	1051	13	19
1557	1051	16	33
1558	1052	13	19
1559	1052	16	34
1560	1053	13	20
1561	1053	16	32
1562	1054	13	20
1563	1054	16	33
1564	1055	13	20
1565	1055	16	34
1566	1056	13	21
1567	1056	16	32
1568	1057	13	21
1569	1057	16	33
1570	1058	13	21
1571	1058	16	34
1572	1059	13	19
1573	1059	16	32
1574	1060	13	19
1575	1060	16	33
1576	1061	13	19
1577	1061	16	32
1578	1062	13	19
1579	1062	16	33
1580	1063	13	19
1581	1063	16	34
1582	1064	13	20
1583	1064	16	32
1584	1065	13	20
1585	1065	16	33
1586	1066	13	20
1587	1066	16	34
1588	1067	13	21
1589	1067	16	32
1590	1068	13	21
1591	1068	16	33
1592	1069	13	21
1593	1069	16	34
1594	1070	13	19
1595	1070	16	32
1596	1071	13	19
1597	1071	16	33
1598	1072	13	19
1599	1072	16	34
1600	1073	13	20
1601	1073	16	32
1602	1074	13	20
1603	1074	16	33
1604	1075	13	20
1605	1075	16	34
1606	1076	13	21
1607	1076	16	32
1608	1077	13	21
1609	1077	16	33
1610	1078	13	21
1611	1078	16	34
1612	1079	13	19
1613	1079	16	32
1614	1080	13	19
1615	1080	16	33
1616	1081	13	19
1617	1081	16	32
1618	1082	13	19
1619	1082	16	33
1620	1083	13	19
1621	1083	16	34
1622	1084	13	20
1623	1084	16	32
1624	1085	13	20
1625	1085	16	33
1626	1086	13	20
1627	1086	16	34
1628	1087	13	21
1629	1087	16	32
1630	1088	13	21
1631	1088	16	33
1632	1089	13	21
1633	1089	16	34
1634	1090	13	19
1635	1090	16	32
1636	1091	13	19
1637	1091	16	33
1638	1092	13	19
1639	1092	16	34
1640	1093	13	20
1641	1093	16	32
1642	1094	13	20
1643	1094	16	33
1644	1095	13	20
1645	1095	16	34
1646	1096	13	21
1647	1096	16	32
1648	1097	13	21
1649	1097	16	33
1650	1098	13	21
1651	1098	16	34
1652	1099	13	19
1653	1099	16	32
1654	1100	13	19
1655	1100	16	33
1656	561	4	4
\.


--
-- TOC entry 5901 (class 0 OID 0)
-- Dependencies: 221
-- Name: category_filter_options_category_filter_optionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_filter_options_category_filter_optionsid_seq', 47, true);


--
-- TOC entry 5902 (class 0 OID 0)
-- Dependencies: 223
-- Name: filter_options_filter_optionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filter_options_filter_optionid_seq', 17, true);


--
-- TOC entry 5903 (class 0 OID 0)
-- Dependencies: 225
-- Name: filter_values_filter_valueid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filter_values_filter_valueid_seq', 45, true);


--
-- TOC entry 5904 (class 0 OID 0)
-- Dependencies: 227
-- Name: images_imageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_imageid_seq', 179, true);


--
-- TOC entry 5905 (class 0 OID 0)
-- Dependencies: 228
-- Name: merker_merkeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.merker_merkeid_seq', 13, true);


--
-- TOC entry 5906 (class 0 OID 0)
-- Dependencies: 230
-- Name: product_variants_variantid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_variants_variantid_seq', 1125, true);


--
-- TOC entry 5907 (class 0 OID 0)
-- Dependencies: 232
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_productid_seq', 417, true);


--
-- TOC entry 5908 (class 0 OID 0)
-- Dependencies: 234
-- Name: productstock_stockid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productstock_stockid_seq', 830, true);


--
-- TOC entry 5909 (class 0 OID 0)
-- Dependencies: 236
-- Name: shoppingcart_shoppingcartid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shoppingcart_shoppingcartid_seq', 10, true);


--
-- TOC entry 5910 (class 0 OID 0)
-- Dependencies: 240
-- Name: variant_attributes_variant_attributeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variant_attributes_variant_attributeid_seq', 1856, true);


--
-- TOC entry 5533 (class 2606 OID 61353)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 5384 (class 2606 OID 61355)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 5268 (class 2606 OID 61357)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 5283 (class 2606 OID 61359)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 5270 (class 2606 OID 61361)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 5419 (class 2606 OID 61363)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 5258 (class 2606 OID 61365)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 5302 (class 2606 OID 61367)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 5308 (class 2606 OID 61369)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 5304 (class 2606 OID 61371)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 5347 (class 2606 OID 61373)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 5327 (class 2606 OID 61375)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 5332 (class 2606 OID 61377)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 5339 (class 2606 OID 61379)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 5343 (class 2606 OID 61381)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 5351 (class 2606 OID 61383)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 5359 (class 2606 OID 61385)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 5421 (class 2606 OID 61387)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 5424 (class 2606 OID 61389)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 5427 (class 2606 OID 61391)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 5436 (class 2606 OID 61393)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 5368 (class 2606 OID 61395)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 5265 (class 2606 OID 61397)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 5324 (class 2606 OID 61399)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 5355 (class 2606 OID 61401)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 5411 (class 2606 OID 61403)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 5300 (class 2606 OID 61405)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 5529 (class 2606 OID 61407)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 5517 (class 2606 OID 61409)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 5296 (class 2606 OID 61411)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 5260 (class 2606 OID 61413)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 5291 (class 2606 OID 61415)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 5481 (class 2606 OID 61417)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 5273 (class 2606 OID 61419)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 5416 (class 2606 OID 61421)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 5432 (class 2606 OID 61423)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 5386 (class 2606 OID 61425)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 5240 (class 2606 OID 61427)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 5256 (class 2606 OID 61429)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 5246 (class 2606 OID 61431)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 5250 (class 2606 OID 61433)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 5253 (class 2606 OID 61435)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 5294 (class 2606 OID 61437)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 5526 (class 2606 OID 61439)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 5311 (class 2606 OID 61441)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 5298 (class 2606 OID 61443)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 5373 (class 2606 OID 61445)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 5403 (class 2606 OID 61447)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 5434 (class 2606 OID 61449)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 5315 (class 2606 OID 61451)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 5509 (class 2606 OID 61453)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 5457 (class 2606 OID 61455)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 5466 (class 2606 OID 61457)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 5461 (class 2606 OID 61459)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 5243 (class 2606 OID 61461)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 5449 (class 2606 OID 61463)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 5471 (class 2606 OID 61465)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 5452 (class 2606 OID 61467)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 5484 (class 2606 OID 61469)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 5501 (class 2606 OID 61471)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 5515 (class 2606 OID 61473)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 5511 (class 2606 OID 61475)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 5337 (class 2606 OID 61477)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 5498 (class 2606 OID 61479)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 5493 (class 2606 OID 61481)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 5380 (class 2606 OID 61483)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 5361 (class 2606 OID 61485)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 5365 (class 2606 OID 61487)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 5375 (class 2606 OID 61489)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 5378 (class 2606 OID 61491)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 5390 (class 2606 OID 61493)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 5393 (class 2606 OID 61495)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 5397 (class 2606 OID 61497)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 5405 (class 2606 OID 61499)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 5409 (class 2606 OID 61501)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 5439 (class 2606 OID 61503)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 5442 (class 2606 OID 61505)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 5444 (class 2606 OID 61507)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 5523 (class 2606 OID 61509)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 5476 (class 2606 OID 61511)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 5478 (class 2606 OID 61513)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 5487 (class 2606 OID 61515)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 5520 (class 2606 OID 61517)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 5531 (class 2606 OID 61519)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 5535 (class 2606 OID 61521)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 5318 (class 2606 OID 61523)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 5281 (class 2606 OID 61525)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 5276 (class 2606 OID 61527)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 5455 (class 2606 OID 61529)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 5289 (class 2606 OID 61531)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 5322 (class 2606 OID 61533)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 5430 (class 2606 OID 61535)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 5447 (class 2606 OID 61537)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 5382 (class 2606 OID 61539)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 5371 (class 2606 OID 61541)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 5263 (class 2606 OID 61543)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 5278 (class 2606 OID 61545)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 5505 (class 2606 OID 61547)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 5469 (class 2606 OID 61549)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 5459 (class 2606 OID 61551)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 5464 (class 2606 OID 61553)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 5474 (class 2606 OID 61555)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 5496 (class 2606 OID 61557)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 5414 (class 2606 OID 61559)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 5507 (class 2606 OID 61561)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 5212 (class 2606 OID 54547)
-- Name: category_filter_options category_filter_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_filter_options
    ADD CONSTRAINT category_filter_options_pkey PRIMARY KEY (category_filter_optionsid);


--
-- TOC entry 5210 (class 2606 OID 60711)
-- Name: category categoryid_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT categoryid_pk PRIMARY KEY (categoryid);


--
-- TOC entry 5214 (class 2606 OID 54549)
-- Name: filter_options filter_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_options
    ADD CONSTRAINT filter_options_pkey PRIMARY KEY (filter_optionid);


--
-- TOC entry 5216 (class 2606 OID 54551)
-- Name: filter_values filter_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_values
    ADD CONSTRAINT filter_values_pkey PRIMARY KEY (filter_valueid);


--
-- TOC entry 5218 (class 2606 OID 54553)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (imageid);


--
-- TOC entry 5208 (class 2606 OID 54555)
-- Name: brand merker_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT merker_pkey PRIMARY KEY (brandid);


--
-- TOC entry 5221 (class 2606 OID 54557)
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (variantid);


--
-- TOC entry 5225 (class 2606 OID 54559)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- TOC entry 5227 (class 2606 OID 54561)
-- Name: productstock productstock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productstock
    ADD CONSTRAINT productstock_pkey PRIMARY KEY (stockid);


--
-- TOC entry 5229 (class 2606 OID 54563)
-- Name: shoppingcart shoppingcart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart
    ADD CONSTRAINT shoppingcart_pkey PRIMARY KEY (shoppingcartid);


--
-- TOC entry 5231 (class 2606 OID 54565)
-- Name: shoppingcartitems shoppingcartitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcartitems
    ADD CONSTRAINT shoppingcartitems_pkey PRIMARY KEY (shoppingcartid, variantid);


--
-- TOC entry 5233 (class 2606 OID 54567)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (keycloakid);


--
-- TOC entry 5238 (class 2606 OID 54569)
-- Name: variant_attributes variant_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_attributes
    ADD CONSTRAINT variant_attributes_pkey PRIMARY KEY (variant_attributeid);


--
-- TOC entry 5328 (class 1259 OID 61562)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON keycloak.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 5329 (class 1259 OID 61563)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON keycloak.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 5241 (class 1259 OID 61564)
-- Name: idx_admin_event_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON keycloak.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 5244 (class 1259 OID 61565)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 5254 (class 1259 OID 61566)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- TOC entry 5247 (class 1259 OID 61567)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- TOC entry 5248 (class 1259 OID 61568)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 5251 (class 1259 OID 61569)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- TOC entry 5284 (class 1259 OID 61570)
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- TOC entry 5266 (class 1259 OID 61571)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON keycloak.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 5261 (class 1259 OID 61572)
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- TOC entry 5271 (class 1259 OID 61573)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- TOC entry 5292 (class 1259 OID 61574)
-- Name: idx_client_session_session; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_client_session_session ON keycloak.client_session USING btree (session_id);


--
-- TOC entry 5279 (class 1259 OID 61575)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 5285 (class 1259 OID 61576)
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- TOC entry 5406 (class 1259 OID 61577)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 5286 (class 1259 OID 61578)
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 5309 (class 1259 OID 61579)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- TOC entry 5305 (class 1259 OID 61580)
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- TOC entry 5306 (class 1259 OID 61581)
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- TOC entry 5312 (class 1259 OID 61582)
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- TOC entry 5313 (class 1259 OID 61583)
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- TOC entry 5319 (class 1259 OID 61584)
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- TOC entry 5320 (class 1259 OID 61585)
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- TOC entry 5325 (class 1259 OID 61586)
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 5356 (class 1259 OID 61587)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- TOC entry 5357 (class 1259 OID 61588)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- TOC entry 5330 (class 1259 OID 61589)
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 5333 (class 1259 OID 61590)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 5334 (class 1259 OID 61591)
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 5335 (class 1259 OID 61592)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 5340 (class 1259 OID 61593)
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 5341 (class 1259 OID 61594)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 5344 (class 1259 OID 61595)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 5345 (class 1259 OID 61596)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 5348 (class 1259 OID 61597)
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 5349 (class 1259 OID 61598)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 5352 (class 1259 OID 61599)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 5353 (class 1259 OID 61600)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 5362 (class 1259 OID 61601)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON keycloak.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 5363 (class 1259 OID 61602)
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- TOC entry 5366 (class 1259 OID 61603)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- TOC entry 5376 (class 1259 OID 61604)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 5369 (class 1259 OID 61605)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- TOC entry 5387 (class 1259 OID 61606)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- TOC entry 5388 (class 1259 OID 61607)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- TOC entry 5394 (class 1259 OID 61608)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON keycloak.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 5398 (class 1259 OID 61609)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON keycloak.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 5399 (class 1259 OID 61610)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON keycloak.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 5400 (class 1259 OID 61611)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON keycloak.offline_user_session USING btree (created_on);


--
-- TOC entry 5401 (class 1259 OID 61612)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON keycloak.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 5407 (class 1259 OID 61613)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- TOC entry 5417 (class 1259 OID 61614)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- TOC entry 5274 (class 1259 OID 61615)
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- TOC entry 5422 (class 1259 OID 61616)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- TOC entry 5428 (class 1259 OID 61617)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 5425 (class 1259 OID 61618)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 5412 (class 1259 OID 61619)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- TOC entry 5437 (class 1259 OID 61620)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 5440 (class 1259 OID 61621)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- TOC entry 5445 (class 1259 OID 61622)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- TOC entry 5450 (class 1259 OID 61623)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- TOC entry 5453 (class 1259 OID 61624)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- TOC entry 5462 (class 1259 OID 61625)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 5467 (class 1259 OID 61626)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 5472 (class 1259 OID 61627)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 5479 (class 1259 OID 61628)
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- TOC entry 5287 (class 1259 OID 61629)
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 5482 (class 1259 OID 61630)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- TOC entry 5485 (class 1259 OID 61631)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- TOC entry 5391 (class 1259 OID 61632)
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- TOC entry 5395 (class 1259 OID 61633)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON keycloak.offline_client_session USING btree (user_session_id);


--
-- TOC entry 5499 (class 1259 OID 61634)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 5488 (class 1259 OID 61635)
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- TOC entry 5489 (class 1259 OID 61636)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON keycloak.user_attribute USING btree (name, value);


--
-- TOC entry 5494 (class 1259 OID 61637)
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- TOC entry 5316 (class 1259 OID 61638)
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- TOC entry 5502 (class 1259 OID 61639)
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- TOC entry 5521 (class 1259 OID 61640)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- TOC entry 5524 (class 1259 OID 61641)
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- TOC entry 5527 (class 1259 OID 61642)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- TOC entry 5503 (class 1259 OID 61643)
-- Name: idx_user_service_account; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_user_service_account ON keycloak.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 5512 (class 1259 OID 61644)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 5513 (class 1259 OID 61645)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 5518 (class 1259 OID 61646)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- TOC entry 5536 (class 1259 OID 61647)
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- TOC entry 5490 (class 1259 OID 61648)
-- Name: user_attr_long_values; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX user_attr_long_values ON keycloak.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 5491 (class 1259 OID 61649)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: keycloak; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON keycloak.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 5219 (class 1259 OID 60706)
-- Name: idx_product_variants_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_product_variants_productid ON public.product_variants USING btree (productid);


--
-- TOC entry 5222 (class 1259 OID 60705)
-- Name: idx_products_brandid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_brandid ON public.products USING btree (brandid);


--
-- TOC entry 5223 (class 1259 OID 60704)
-- Name: idx_products_categoryid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_categoryid ON public.products USING btree (categoryid);


--
-- TOC entry 5234 (class 1259 OID 60708)
-- Name: idx_variant_attributes_filter_optionid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_attributes_filter_optionid ON public.variant_attributes USING btree (filter_optionid);


--
-- TOC entry 5235 (class 1259 OID 60709)
-- Name: idx_variant_attributes_filter_valueid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_attributes_filter_valueid ON public.variant_attributes USING btree (filter_valueid);


--
-- TOC entry 5236 (class 1259 OID 60707)
-- Name: idx_variant_attributes_variantid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_variant_attributes_variantid ON public.variant_attributes USING btree (variantid);


--
-- TOC entry 5564 (class 2606 OID 61650)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 5578 (class 2606 OID 61655)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5558 (class 2606 OID 61660)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5575 (class 2606 OID 61665)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5560 (class 2606 OID 61670)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5565 (class 2606 OID 61675)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 5624 (class 2606 OID 61680)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES keycloak.user_session(id);


--
-- TOC entry 5567 (class 2606 OID 61685)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 5594 (class 2606 OID 61690)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5620 (class 2606 OID 61695)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5566 (class 2606 OID 61700)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 5591 (class 2606 OID 61705)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5596 (class 2606 OID 61710)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 5613 (class 2606 OID 61715)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5622 (class 2606 OID 61720)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5582 (class 2606 OID 61725)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- TOC entry 5592 (class 2606 OID 61730)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5587 (class 2606 OID 61735)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5571 (class 2606 OID 61740)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 5554 (class 2606 OID 61745)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- TOC entry 5555 (class 2606 OID 61750)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5556 (class 2606 OID 61755)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5557 (class 2606 OID 61760)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5563 (class 2606 OID 61765)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES keycloak.user_session(id);


--
-- TOC entry 5623 (class 2606 OID 61770)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5561 (class 2606 OID 61775)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 5562 (class 2606 OID 61780)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 5568 (class 2606 OID 61785)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 5584 (class 2606 OID 61790)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 5559 (class 2606 OID 61795)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5570 (class 2606 OID 61800)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- TOC entry 5569 (class 2606 OID 61805)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5588 (class 2606 OID 61810)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5619 (class 2606 OID 61815)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- TOC entry 5617 (class 2606 OID 61820)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 5618 (class 2606 OID 61825)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5552 (class 2606 OID 61830)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5611 (class 2606 OID 61835)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5601 (class 2606 OID 61840)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 5606 (class 2606 OID 61845)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 5602 (class 2606 OID 61850)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 5603 (class 2606 OID 61855)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 5553 (class 2606 OID 61860)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5612 (class 2606 OID 61865)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 5604 (class 2606 OID 61870)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5605 (class 2606 OID 61875)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 5599 (class 2606 OID 61880)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 5597 (class 2606 OID 61885)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 5598 (class 2606 OID 61890)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5600 (class 2606 OID 61895)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 5607 (class 2606 OID 61900)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 5572 (class 2606 OID 61905)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 5615 (class 2606 OID 61910)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- TOC entry 5614 (class 2606 OID 61915)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5576 (class 2606 OID 61920)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 5577 (class 2606 OID 61925)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 5589 (class 2606 OID 61930)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5590 (class 2606 OID 61935)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5580 (class 2606 OID 61940)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5581 (class 2606 OID 61945)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- TOC entry 5625 (class 2606 OID 61950)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5610 (class 2606 OID 61955)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5585 (class 2606 OID 61960)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 5573 (class 2606 OID 61965)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5586 (class 2606 OID 61970)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- TOC entry 5574 (class 2606 OID 61975)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5595 (class 2606 OID 61980)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5608 (class 2606 OID 61985)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 5609 (class 2606 OID 61990)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 5593 (class 2606 OID 61995)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 5616 (class 2606 OID 62000)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 5621 (class 2606 OID 62005)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 5583 (class 2606 OID 62010)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 5579 (class 2606 OID 62015)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: postgres
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


--
-- TOC entry 5537 (class 2606 OID 55028)
-- Name: category_filter_options category_filter_options_filter_optionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_filter_options
    ADD CONSTRAINT category_filter_options_filter_optionid_fkey FOREIGN KEY (filter_optionid) REFERENCES public.filter_options(filter_optionid);


--
-- TOC entry 5542 (class 2606 OID 60712)
-- Name: products categoryid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT categoryid_fk FOREIGN KEY (categoryid) REFERENCES public.category(categoryid);


--
-- TOC entry 5538 (class 2606 OID 60717)
-- Name: category_filter_options categoryid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_filter_options
    ADD CONSTRAINT categoryid_fk FOREIGN KEY (categoryid) REFERENCES public.category(categoryid);


--
-- TOC entry 5539 (class 2606 OID 55033)
-- Name: filter_values filter_values_filter_optionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filter_values
    ADD CONSTRAINT filter_values_filter_optionid_fkey FOREIGN KEY (filter_optionid) REFERENCES public.filter_options(filter_optionid);


--
-- TOC entry 5540 (class 2606 OID 55038)
-- Name: images images_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- TOC entry 5541 (class 2606 OID 55043)
-- Name: product_variants product_variants_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- TOC entry 5543 (class 2606 OID 55048)
-- Name: products products_merkenavnid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_merkenavnid_fkey FOREIGN KEY (brandid) REFERENCES public.brand(brandid);


--
-- TOC entry 5544 (class 2606 OID 55053)
-- Name: productstock productstock_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productstock
    ADD CONSTRAINT productstock_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5546 (class 2606 OID 55058)
-- Name: shoppingcart shoppingcart_keycloakid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart
    ADD CONSTRAINT shoppingcart_keycloakid_fkey FOREIGN KEY (keycloakid) REFERENCES public.users(keycloakid);


--
-- TOC entry 5547 (class 2606 OID 55063)
-- Name: shoppingcartitems shoppingcartitems_shoppingcartid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcartitems
    ADD CONSTRAINT shoppingcartitems_shoppingcartid_fkey FOREIGN KEY (shoppingcartid) REFERENCES public.shoppingcart(shoppingcartid);


--
-- TOC entry 5548 (class 2606 OID 55068)
-- Name: shoppingcartitems shoppingcartitems_variantid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcartitems
    ADD CONSTRAINT shoppingcartitems_variantid_fkey FOREIGN KEY (variantid) REFERENCES public.product_variants(variantid);


--
-- TOC entry 5549 (class 2606 OID 55073)
-- Name: variant_attributes variant_attributes_filter_optionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_attributes
    ADD CONSTRAINT variant_attributes_filter_optionid_fkey FOREIGN KEY (filter_optionid) REFERENCES public.filter_options(filter_optionid);


--
-- TOC entry 5550 (class 2606 OID 55078)
-- Name: variant_attributes variant_attributes_filter_valueid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_attributes
    ADD CONSTRAINT variant_attributes_filter_valueid_fkey FOREIGN KEY (filter_valueid) REFERENCES public.filter_values(filter_valueid);


--
-- TOC entry 5551 (class 2606 OID 55083)
-- Name: variant_attributes variant_attributes_variantid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variant_attributes
    ADD CONSTRAINT variant_attributes_variantid_fkey FOREIGN KEY (variantid) REFERENCES public.product_variants(variantid);


--
-- TOC entry 5545 (class 2606 OID 60722)
-- Name: productstock variantid_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productstock
    ADD CONSTRAINT variantid_fk FOREIGN KEY (variantid) REFERENCES public.product_variants(variantid);


-- Completed on 2025-06-12 21:19:13

--
-- PostgreSQL database dump complete
--

