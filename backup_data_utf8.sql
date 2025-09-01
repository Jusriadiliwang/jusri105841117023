--
-- PostgreSQL database dump
--

\restrict ajkYt6iIMMQ8wa6y5Jfq6EQ3lBjgSfQ5IsKcBUb09WjM6tv5EUltWQT6M0sCHaZ

-- Dumped from database version 17.5 (1b53132)
-- Dumped by pg_dump version 17.6

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
-- Name: neon_auth; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA neon_auth;


ALTER SCHEMA neon_auth OWNER TO neondb_owner;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users_sync; Type: TABLE; Schema: neon_auth; Owner: neondb_owner
--

CREATE TABLE neon_auth.users_sync (
    raw_json jsonb NOT NULL,
    id text GENERATED ALWAYS AS ((raw_json ->> 'id'::text)) STORED NOT NULL,
    name text GENERATED ALWAYS AS ((raw_json ->> 'display_name'::text)) STORED,
    email text GENERATED ALWAYS AS ((raw_json ->> 'primary_email'::text)) STORED,
    created_at timestamp with time zone GENERATED ALWAYS AS (to_timestamp((trunc((((raw_json ->> 'signed_up_at_millis'::text))::bigint)::double precision) / (1000)::double precision))) STORED,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);


ALTER TABLE neon_auth.users_sync OWNER TO neondb_owner;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.customers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    image_url character varying(255) NOT NULL
);


ALTER TABLE public.customers OWNER TO neondb_owner;

--
-- Name: invoices; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.invoices (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id uuid NOT NULL,
    amount integer NOT NULL,
    status character varying(255) NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.invoices OWNER TO neondb_owner;

--
-- Name: revenue; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.revenue (
    month character varying(4) NOT NULL,
    revenue integer NOT NULL
);


ALTER TABLE public.revenue OWNER TO neondb_owner;

--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Data for Name: users_sync; Type: TABLE DATA; Schema: neon_auth; Owner: neondb_owner
--

COPY neon_auth.users_sync (raw_json, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.customers (id, name, email, image_url) FROM stdin;
d6e15727-9fe1-4961-8c5b-ea44a9bd81aa	Evil Rabbit	evil@rabbit.com	/customers/evil-rabbit.png
3958dc9e-742f-4377-85e9-fec4b6a6442a	Lee Robinson	lee@robinson.com	/customers/lee-robinson.png
13d07535-c59e-4157-a011-f8d2ef4e0cbb	Balazs Orban	balazs@orban.com	/customers/balazs-orban.png
cc27c14a-0acf-4f4a-a6c9-d45682c144b9	Amy Burns	amy@burns.com	/customers/amy-burns.png
3958dc9e-712f-4377-85e9-fec4b6a6442a	Delba de Oliveira	delba@oliveira.com	/customers/delba-de-oliveira.png
76d65c26-f784-44a2-ac19-586678f7c2f2	Michael Novotny	michael@novotny.com	/customers/michael-novotny.png
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.invoices (id, customer_id, amount, status, date) FROM stdin;
0d7ee67b-e5ca-4ef8-9b02-18b063e3ab8d	3958dc9e-712f-4377-85e9-fec4b6a6442a	20348	pending	2022-11-14
5f6ccd00-2ca2-4eda-83e3-4aadf8d7428f	cc27c14a-0acf-4f4a-a6c9-d45682c144b9	3040	paid	2022-10-29
a49f8116-2f78-4551-87f7-60c2cf27bc54	76d65c26-f784-44a2-ac19-586678f7c2f2	44800	paid	2023-09-10
6154da21-0db2-47d5-8d10-9c2e89555d74	d6e15727-9fe1-4961-8c5b-ea44a9bd81aa	15795	pending	2022-12-06
4f058265-a008-4719-a88c-a975526a7dc4	3958dc9e-742f-4377-85e9-fec4b6a6442a	54246	pending	2023-07-16
8034a198-5c6e-4b15-9327-135e37204972	d6e15727-9fe1-4961-8c5b-ea44a9bd81aa	666	pending	2023-06-27
29ca471f-f338-4ae9-9128-ad74df61a3c0	76d65c26-f784-44a2-ac19-586678f7c2f2	32545	paid	2023-06-09
3c767a73-2880-4b7e-9f71-a6399cea197b	cc27c14a-0acf-4f4a-a6c9-d45682c144b9	1250	paid	2023-06-17
2859975f-144a-44d1-ac57-6551bba7083d	13d07535-c59e-4157-a011-f8d2ef4e0cbb	34577	pending	2023-08-05
b544c068-a43b-4396-8946-6411248837e4	13d07535-c59e-4157-a011-f8d2ef4e0cbb	8546	paid	2023-06-07
e627a61d-4659-40c5-8d20-d5dee1d010e7	3958dc9e-712f-4377-85e9-fec4b6a6442a	500	paid	2023-08-19
85354da3-86cf-4ee0-a17f-7cdc0cd07b10	13d07535-c59e-4157-a011-f8d2ef4e0cbb	8945	paid	2023-06-03
214395cc-35bd-4d8f-91c9-d8ec4c039ebf	3958dc9e-742f-4377-85e9-fec4b6a6442a	1000	paid	2022-06-05
eb77e7dd-cc26-4f51-a695-0b219f8965ef	d6e15727-9fe1-4961-8c5b-ea44a9bd81aa	99900	paid	2025-08-20
\.


--
-- Data for Name: revenue; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.revenue (month, revenue) FROM stdin;
Jan	2000
Apr	2500
May	2300
Mar	2200
Feb	1800
Jun	3200
Jul	3500
Sep	2500
Oct	2800
Nov	3000
Aug	3700
Dec	4800
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, name, email, password) FROM stdin;
410544b2-4001-4271-9855-fec4b6a6442a	User	user@nextmail.com	$2b$10$RXyLMbTPvjsdbPzYoejvduVLgrltQVk5RKmOpaOi8jFasCyYrUhTG
\.


--
-- Name: users_sync users_sync_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: neondb_owner
--

ALTER TABLE ONLY neon_auth.users_sync
    ADD CONSTRAINT users_sync_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: revenue revenue_month_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.revenue
    ADD CONSTRAINT revenue_month_key UNIQUE (month);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_sync_deleted_at_idx; Type: INDEX; Schema: neon_auth; Owner: neondb_owner
--

CREATE INDEX users_sync_deleted_at_idx ON neon_auth.users_sync USING btree (deleted_at);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict ajkYt6iIMMQ8wa6y5Jfq6EQ3lBjgSfQ5IsKcBUb09WjM6tv5EUltWQT6M0sCHaZ

