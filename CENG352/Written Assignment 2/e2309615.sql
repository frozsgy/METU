--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: increment_user_review_count(); Type: FUNCTION; Schema: public; Owner: ceng352
--

CREATE FUNCTION public.increment_user_review_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE users
SET review_count = review_count + 1
WHERE user_id = NEW.user_id;
RETURN NULL;
END
$$;


ALTER FUNCTION public.increment_user_review_count() OWNER TO ceng352;

--
-- Name: reject_insertion(); Type: FUNCTION; Schema: public; Owner: ceng352
--

CREATE FUNCTION public.reject_insertion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
DELETE FROM review WHERE user_id = NEW.user_id;
DELETE FROM tip WHERE user_id = NEW.user_id;
--RAISE EXCEPTION 'Reviews with 0 stars are not allowed';
RETURN NULL;
END
$$;


ALTER FUNCTION public.reject_insertion() OWNER TO ceng352;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: business; Type: TABLE; Schema: public; Owner: ceng352
--

CREATE TABLE public.business (
    business_id character varying(22) NOT NULL,
    business_name text NOT NULL,
    address text,
    state character varying(3),
    is_open boolean,
    stars real
);


ALTER TABLE public.business OWNER TO ceng352;

--
-- Name: review; Type: TABLE; Schema: public; Owner: ceng352
--

CREATE TABLE public.review (
    review_id character varying(22) NOT NULL,
    user_id character varying(22) NOT NULL,
    business_id character varying(22) NOT NULL,
    stars real,
    date timestamp without time zone,
    useful bigint,
    funny bigint,
    cool bigint
);


ALTER TABLE public.review OWNER TO ceng352;

--
-- Name: businesscount; Type: VIEW; Schema: public; Owner: ceng352
--

CREATE VIEW public.businesscount AS
 SELECT b.business_id,
    b.business_name,
    r.count AS review_count
   FROM (public.business b
     JOIN ( SELECT r_1.business_id,
            count(r_1.review_id) AS count
           FROM public.review r_1
          GROUP BY r_1.business_id) r ON (((b.business_id)::text = (r.business_id)::text)));


ALTER TABLE public.businesscount OWNER TO ceng352;

--
-- Name: friend; Type: TABLE; Schema: public; Owner: ceng352
--

CREATE TABLE public.friend (
    user_id1 character varying(22) NOT NULL,
    user_id2 character varying(22) NOT NULL
);


ALTER TABLE public.friend OWNER TO ceng352;

--
-- Name: tip; Type: TABLE; Schema: public; Owner: ceng352
--

CREATE TABLE public.tip (
    tip_id integer NOT NULL,
    business_id character varying(22) NOT NULL,
    user_id character varying(22) NOT NULL,
    date timestamp without time zone,
    tip_text text,
    compliment_count bigint
);


ALTER TABLE public.tip OWNER TO ceng352;

--
-- Name: tip_tip_id_seq; Type: SEQUENCE; Schema: public; Owner: ceng352
--

CREATE SEQUENCE public.tip_tip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tip_tip_id_seq OWNER TO ceng352;

--
-- Name: tip_tip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ceng352
--

ALTER SEQUENCE public.tip_tip_id_seq OWNED BY public.tip.tip_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ceng352
--

CREATE TABLE public.users (
    user_id character varying(22) NOT NULL,
    user_name text NOT NULL,
    review_count bigint,
    yelping_since timestamp without time zone,
    useful bigint,
    funny bigint,
    cool bigint,
    fans bigint,
    average_stars real
);


ALTER TABLE public.users OWNER TO ceng352;

--
-- Name: tip tip_id; Type: DEFAULT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.tip ALTER COLUMN tip_id SET DEFAULT nextval('public.tip_tip_id_seq'::regclass);


--
-- Name: business business_pkey; Type: CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.business
    ADD CONSTRAINT business_pkey PRIMARY KEY (business_id);


--
-- Name: friend friend_pkey; Type: CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_pkey PRIMARY KEY (user_id1, user_id2);


--
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- Name: tip tip_pkey; Type: CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.tip
    ADD CONSTRAINT tip_pkey PRIMARY KEY (tip_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: u_bid; Type: INDEX; Schema: public; Owner: ceng352
--

CREATE INDEX u_bid ON public.business USING btree (business_id);

ALTER TABLE public.business CLUSTER ON u_bid;


--
-- Name: u_bid_tip; Type: INDEX; Schema: public; Owner: ceng352
--

CREATE INDEX u_bid_tip ON public.tip USING btree (business_id);

ALTER TABLE public.tip CLUSTER ON u_bid_tip;


--
-- Name: review updatereviewcount; Type: TRIGGER; Schema: public; Owner: ceng352
--

CREATE TRIGGER updatereviewcount AFTER INSERT ON public.review FOR EACH ROW EXECUTE FUNCTION public.increment_user_review_count();


--
-- Name: review zerotrigger; Type: TRIGGER; Schema: public; Owner: ceng352
--

CREATE TRIGGER zerotrigger BEFORE INSERT ON public.review FOR EACH ROW WHEN ((new.stars = (0)::double precision)) EXECUTE FUNCTION public.reject_insertion();


--
-- Name: friend friend_user_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_user_id1_fkey FOREIGN KEY (user_id1) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: friend friend_user_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.friend
    ADD CONSTRAINT friend_user_id2_fkey FOREIGN KEY (user_id2) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: review review_business_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_business_id_fkey FOREIGN KEY (business_id) REFERENCES public.business(business_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: review review_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tip tip_business_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.tip
    ADD CONSTRAINT tip_business_id_fkey FOREIGN KEY (business_id) REFERENCES public.business(business_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tip tip_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ceng352
--

ALTER TABLE ONLY public.tip
    ADD CONSTRAINT tip_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

