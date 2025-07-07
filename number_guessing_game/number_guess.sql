--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES ('shivam', 1, 12);
INSERT INTO public.users VALUES ('user_1751904217816', 2, 68);
INSERT INTO public.users VALUES ('user_1751904217817', 5, 123);
INSERT INTO public.users VALUES ('user_1751904366835', 2, 161);
INSERT INTO public.users VALUES ('user_1751904366836', 5, 114);
INSERT INTO public.users VALUES ('user_1751904390847', 2, 693);
INSERT INTO public.users VALUES ('user_1751904390848', 5, 62);
INSERT INTO public.users VALUES ('user_1751904556979', 2, 275);
INSERT INTO public.users VALUES ('user_1751904556980', 5, 483);
INSERT INTO public.users VALUES ('', 0, NULL);
INSERT INTO public.users VALUES ('user_1751905113478', 2, 734);
INSERT INTO public.users VALUES ('user_1751905113479', 5, 283);
INSERT INTO public.users VALUES ('user_1751905202592', 2, 748);
INSERT INTO public.users VALUES ('user_1751905202593', 5, 465);
INSERT INTO public.users VALUES ('Pradeep', 2, 11);
INSERT INTO public.users VALUES ('user_1751905275982', 2, 565);
INSERT INTO public.users VALUES ('user_1751905275983', 5, 113);
INSERT INTO public.users VALUES ('user_1751905308702', 2, 543);
INSERT INTO public.users VALUES ('user_1751905308703', 5, 460);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

