--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

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
-- Name: books_tsv_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.books_tsv_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.tsv := to_tsvector('english', COALESCE(NEW.description, ''));
  RETURN NEW;
END
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    birth_date date,
    nationality character varying(50)
);


--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- Name: book_authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_authors (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


--
-- Name: book_copies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_copies (
    id integer NOT NULL,
    book_id integer NOT NULL,
    status character varying(20) DEFAULT 'available'::character varying,
    location character varying(100)
);


--
-- Name: book_copies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_copies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: book_copies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_copies_id_seq OWNED BY public.book_copies.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    publication_year integer,
    isbn character varying(20),
    publisher_id integer,
    category_id integer,
    keywords text[],
    description text,
    tsv tsvector
);


--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: loans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.loans (
    id integer NOT NULL,
    user_id integer,
    book_copy_id integer,
    loan_date date NOT NULL,
    due_date date NOT NULL,
    return_date date
);


--
-- Name: loans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.loans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.loans_id_seq OWNED BY public.loans.id;


--
-- Name: publishers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(200),
    phone character varying(20)
);


--
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publishers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publishers_id_seq OWNED BY public.publishers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(20),
    address character varying(200),
    preferences jsonb
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- Name: book_copies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_copies ALTER COLUMN id SET DEFAULT nextval('public.book_copies_id_seq'::regclass);


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: loans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loans ALTER COLUMN id SET DEFAULT nextval('public.loans_id_seq'::regclass);


--
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public.publishers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authors (id, name, birth_date, nationality) FROM stdin;
1	Marissa Benton	1985-03-21	Trinidad and Tobago
2	Jeremy Shelton	1989-12-06	Monaco
3	Andrew Hampton	1955-11-11	Aruba
4	Luke Perry	1988-07-12	Ireland
5	Bryan Cabrera	1952-12-23	Greenland
6	Jodi Turner	1976-06-15	Brazil
7	Todd Espinoza	1991-03-19	Macedonia
8	Larry Potter	1977-07-11	Russian Federation
9	Robert Patel	1960-09-15	Bouvet Island (Bouvetoya)
10	Amy Hodges	1965-08-18	Lao People's Democratic Republic
\.


--
-- Data for Name: book_authors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book_authors (book_id, author_id) FROM stdin;
1	2
1	9
1	6
2	5
2	4
3	10
4	6
5	10
6	5
6	10
7	8
8	2
9	4
10	9
10	3
\.


--
-- Data for Name: book_copies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book_copies (id, book_id, status, location) FROM stdin;
1	1	available	brother shelf
2	1	damaged	property shelf
3	1	loaned	fire shelf
4	1	available	worry shelf
5	2	loaned	affect shelf
6	2	loaned	care shelf
7	2	loaned	scene shelf
8	3	damaged	sell shelf
9	3	loaned	already shelf
10	4	damaged	detail shelf
11	4	available	drop shelf
12	4	damaged	create shelf
13	4	loaned	base shelf
14	5	damaged	your shelf
15	5	damaged	recently shelf
16	5	loaned	throughout shelf
17	5	available	try shelf
18	6	damaged	hit shelf
19	6	available	article shelf
20	6	loaned	when shelf
21	7	loaned	institution shelf
22	7	available	produce shelf
23	7	loaned	space shelf
24	7	available	could shelf
25	7	available	learn shelf
26	8	loaned	program shelf
27	8	available	big shelf
28	8	available	nature shelf
29	8	damaged	walk shelf
30	9	damaged	season shelf
31	9	damaged	doctor shelf
32	9	damaged	nearly shelf
33	9	available	central shelf
34	9	damaged	major shelf
35	10	loaned	evidence shelf
36	10	available	theory shelf
37	10	damaged	cover shelf
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.books (id, title, publication_year, isbn, publisher_id, category_id, keywords, description, tsv) FROM stdin;
1	Kid occur wear American almost	1983	978-0-87467-513-9	4	4	{education,research}	Onto nation make our. Amount hand relate before rich best last country. Provide you measure no born read.	'amount':5 'best':10 'born':17 'countri':12 'hand':6 'last':11 'make':3 'measur':15 'nation':2 'onto':1 'provid':13 'read':18 'relat':7 'rich':9
2	Lot anyone budget way	2015	978-0-686-44837-2	1	1	{philosophy}	Strategy political husband. Company enter must TV itself only. Eye back option floor character general.	'back':11 'charact':14 'compani':4 'enter':5 'eye':10 'floor':13 'general':15 'husband':3 'must':6 'option':12 'polit':2 'strategi':1 'tv':7
3	High firm own	1984	978-1-4907-5811-4	4	1	{education,research}	Baby back thousand of option change system second. Generation movie that itself. Too short wall spend.	'babi':1 'back':2 'chang':6 'generat':9 'movi':10 'option':5 'second':8 'short':14 'spend':16 'system':7 'thousand':3 'wall':15
4	Federal water	2005	978-0-633-23220-7	2	5	{history,biography}	Along box article blood I discussion skin. Change minute exactly owner.	'along':1 'articl':3 'blood':4 'box':2 'chang':8 'discuss':6 'exact':10 'minut':9 'owner':11 'skin':7
5	Point may	2013	978-1-79039-120-2	5	2	{computing,AI}	Difficult score everything particularly. Weight people by food understand.	'difficult':1 'everyth':3 'food':8 'particular':4 'peopl':6 'score':2 'understand':9 'weight':5
6	Vote learn certain	1997	978-1-356-85836-1	2	1	{science,technology}	Approach view he hard and who. Wind whether grow parent past yourself.	'approach':1 'grow':9 'hard':4 'parent':10 'past':11 'view':2 'whether':8 'wind':7
7	Represent stock	2023	978-1-142-41578-5	4	1	{philosophy}	Once whose base design major. Official popular Congress poor.	'base':3 'congress':8 'design':4 'major':5 'offici':6 'poor':9 'popular':7 'whose':2
8	Than expert authority	1988	978-1-63358-827-1	5	2	{philosophy}	If including often conference. Sign sing dream road law. Or bad either church.	'bad':11 'church':13 'confer':4 'dream':7 'either':12 'includ':2 'law':9 'often':3 'road':8 'sign':5 'sing':6
9	Type interest	2011	978-1-292-74856-6	2	3	{self-help,psychology}	Their chance Congress other Democrat appear similar compare. South check floor defense PM nothing.	'appear':6 'chanc':2 'check':10 'compar':8 'congress':3 'defens':12 'democrat':5 'floor':11 'noth':14 'pm':13 'similar':7 'south':9
10	Country charge door executive	2013	978-0-7973-4789-2	4	1	{philosophy}	Product finally purpose seek ground happen. Series couple how air safe would. All why fast mission here serious.	'air':10 'coupl':8 'fast':15 'final':2 'ground':5 'happen':6 'mission':16 'product':1 'purpos':3 'safe':11 'seek':4 'seri':7 'serious':18 'would':12
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name) FROM stdin;
1	Fiction
2	Science
3	Biography
4	Technology
5	Philosophy
\.


--
-- Data for Name: loans; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.loans (id, user_id, book_copy_id, loan_date, due_date, return_date) FROM stdin;
1	9	35	2024-12-04	2024-12-18	2024-12-24
2	5	26	2025-02-20	2025-03-06	2025-03-16
3	8	20	2024-11-16	2024-11-30	2024-11-20
4	7	9	2024-05-24	2024-06-07	2024-06-04
5	8	3	2024-07-19	2024-08-02	2024-07-31
6	10	26	2025-01-16	2025-01-30	2025-02-06
7	4	35	2024-08-07	2024-08-21	2024-08-13
8	6	3	2024-06-27	2024-07-11	2024-07-07
9	8	7	2025-02-24	2025-03-10	2025-03-06
10	9	13	2024-09-17	2024-10-01	\N
11	4	21	2024-08-10	2024-08-24	2024-09-01
12	6	5	2024-06-15	2024-06-29	\N
13	2	3	2024-07-23	2024-08-06	\N
14	3	35	2024-07-27	2024-08-10	2024-08-26
15	3	16	2024-05-03	2024-05-17	2024-05-19
16	7	20	2025-02-19	2025-03-05	2025-02-20
17	2	26	2024-09-28	2024-10-12	\N
18	5	6	2024-05-05	2024-05-19	\N
19	9	3	2024-04-11	2024-04-25	\N
20	7	7	2024-10-11	2024-10-25	2024-10-24
\.


--
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.publishers (id, name, address, phone) FROM stdin;
1	Rowland-Mclaughlin	9849 Crystal Village Apt. 242\nEast Patriciachester, NE 41677	001-872-545-2597x380
2	Smith, Hughes and Howard	0326 Gregory Cape\nLake Seth, IN 08815	990-435-0858x329
3	Butler, Schmidt and Bowen	316 Morris Creek\nLake Kyleberg, VA 57651	549.960.9125
4	Gray LLC	15216 Harris Drive\nPearsonfurt, AK 06918	001-817-343-7625x082
5	Mills Ltd	3383 Clark Gateway\nDavidshire, MI 22906	204.531.9649
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, first_name, last_name, email, phone, address, preferences) FROM stdin;
1	Barry	Smith	catherinegoodwin@duncan.com	+1-845-817-3267x8027	090 Booker Rue Apt. 586\nRodriguezberg, OK 18555	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
2	Melanie	Walker	richardphelps@arnold-dunlap.info	8896457808	4355 Steele Creek Suite 952\nGregorychester, MT 88416	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
3	Timothy	Hall	rileydebra@hotmail.com	269.054.4492	9855 Todd Village\nNew Daltonmouth, KS 43064	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
4	Joanna	Alvarez	allenjamie@bruce-frederick.com	343.536.3516	516 Marie Green\nHaleyport, PA 25048	{"notifications": {"sms": false, "email": false}, "preferred_genres": ["education"]}
5	Richard	Wagner	amanda97@hill-williams.com	(631)271-2858x6219	3228 Gonzales View Apt. 188\nWrightmouth, FL 14899	{"notifications": {"sms": true, "email": false}, "preferred_genres": ["philosophy", "history"]}
6	Dawn	Hall	randybush@ryan-peters.com	+1-697-520-2506	44164 Angela Court Apt. 250\nMonicaville, WY 76387	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
7	Bradley	Russell	michael72@ray.com	+1-175-806-0612x0892	1527 Griffin Knolls Suite 767\nEast Adam, OR 98402	{"notifications": {"sms": true, "email": false}, "preferred_genres": ["philosophy", "history"]}
8	Bryan	Taylor	smithcharles@hardin.com	+1-449-085-8212x5085	1296 Andrews Point\nNew Lynnberg, AL 11791	{"notifications": {"sms": false, "email": true}, "preferred_genres": ["science"]}
9	Patricia	Velasquez	jacobwhite@yahoo.com	557-338-0633x152	2434 Alan Locks Suite 059\nWest Jessica, AL 15473	{"notifications": {"sms": false, "email": false}, "preferred_genres": ["education"]}
10	Julie	Pratt	amandasanchez@barrera-guerrero.com	001-254-599-3094x884	6272 Garner Via\nBeckerbury, VT 11903	{"notifications": {"sms": false, "email": false}, "preferred_genres": ["education"]}
11	Ricardo	Villarreal	jessicagutierrez@clark.biz	+1-301-039-3858	PSC 1509, Box 5426\nAPO AE 95663	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
12	Lindsay	Barber	ksandoval@gmail.com	823-589-8339	36515 Mccoy Ridges\nEast Tanyastad, KS 96169	{"notifications": {"sms": true, "email": false}, "preferred_genres": ["philosophy", "history"]}
13	Tina	Davidson	guzmanjames@hotmail.com	6606596905	081 Johnson Inlet\nEast Lauraburgh, NC 61176	{"notifications": {"sms": false, "email": true}, "preferred_genres": ["technology", "AI"]}
14	Logan	Kent	nancylopez@kaiser-dunn.com	+1-822-636-4156x573	77198 Brewer Street Apt. 014\nWest Sara, CO 76643	{"notifications": {"sms": false, "email": false}, "preferred_genres": ["education"]}
15	Michael	Wilkinson	kevin91@brown-brown.com	426-328-2323x0827	05841 Jared Estate Apt. 641\nLake Nancy, MS 85348	{"notifications": {"sms": false, "email": true}, "preferred_genres": ["science"]}
16	Tony	Vang	derekwilson@brooks.com	001-087-638-9498x065	49788 Miller Hollow Suite 679\nRosalesberg, TX 58473	{"notifications": {"sms": true, "email": true}, "preferred_genres": ["fiction", "adventure"]}
17	Steven	Morse	pnguyen@gmail.com	300.613.1095	8109 Huff Burg Apt. 194\nBarrontown, MT 75545	{"notifications": {"sms": true, "email": false}, "preferred_genres": ["philosophy", "history"]}
18	Tammy	Davis	jefferykelley@perkins-kelly.biz	+1-784-283-9126x4581	5933 Katherine Street\nColonberg, OH 04103	{"notifications": {"sms": false, "email": true}, "preferred_genres": ["technology", "AI"]}
19	Samantha	Ross	perryethan@thompson.biz	732-732-1026	93280 Chad Lights Apt. 531\nSouth Mollyville, NM 23573	{"notifications": {"sms": false, "email": false}, "preferred_genres": ["education"]}
20	Jason	Jackson	nicholasmartin@green.biz	411-128-8157x1527	991 Leah Ridge\nDeborahmouth, WI 70542	{"notifications": {"sms": false, "email": true}, "preferred_genres": ["science"]}
\.


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.authors_id_seq', 1, false);


--
-- Name: book_copies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_copies_id_seq', 1, false);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.books_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.loans_id_seq', 1, false);


--
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.publishers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: book_authors book_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_pkey PRIMARY KEY (book_id, author_id);


--
-- Name: book_copies book_copies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_copies
    ADD CONSTRAINT book_copies_pkey PRIMARY KEY (id);


--
-- Name: books books_isbn_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_isbn_key UNIQUE (isbn);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: loans loans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_books_tsv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_books_tsv ON public.books USING gin (tsv);


--
-- Name: books tsv_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsv_update BEFORE INSERT OR UPDATE ON public.books FOR EACH ROW EXECUTE FUNCTION public.books_tsv_trigger();


--
-- Name: book_authors book_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id);


--
-- Name: book_authors book_authors_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_authors
    ADD CONSTRAINT book_authors_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- Name: book_copies book_copies_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_copies
    ADD CONSTRAINT book_copies_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- Name: books books_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: books books_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.publishers(id);


--
-- Name: loans loans_book_copy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_book_copy_id_fkey FOREIGN KEY (book_copy_id) REFERENCES public.book_copies(id);


--
-- Name: loans loans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--
