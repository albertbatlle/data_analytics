#Partint d'alguns arxius CSV dissenyaràs i crearàs la teva base de dades.
#Nivell 1

/*Descàrrega els arxius CSV, estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui, 
almenys 4 taules de les quals puguis realitzar les següents consultes:
*/

# En primer lloc crearem la nova base de dades i procedirem a sel·leccionar-la.
CREATE DATABASE ecommerce;
use ecommerce;

#Un cop fet això, crearem les diferents taules i carregaremm les dades d'aquestes amb Data Import Wizard.

CREATE TABLE IF NOT EXISTS transactions (
	id VARCHAR(50) PRIMARY KEY,
    card_id VARCHAR(15),
    company_id VARCHAR(15),
    timestamp VARCHAR(30),
    amount decimal(20,2),
    declined boolean,
    product_ids VARCHAR(30),
    user_id INT,
    lat VARCHAR(30),
    longitude VARCHAR(30)
);

/*Malgrat que hem afegit les dades  amb Data Import Wizard, procedeixo a afegir la metodologia que hauríem d'utitlitzar per carregar les 
dades del fitxer csv directament desde l'ordinador per totes i cadascuna de les taules. 
*/

#En primer lloc, haurem de comprovar els permisos de privilegi des d'on es pot carregar l'arxiu i modificar l'arxiu my.ini
SELECT @@secure_file_priv;

LOAD DATA INFILE
#'C:\Users\Albert\OneDrive\Bureau\IT Academy\Sprint 4\csv\transactions.csv'
'transactions.csv'
#'C:\ProgramData\MySQL\MySQL Server 8.0\Data\transactions.csv'
INTO TABLE transactions
FIELDS terminated by ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
;


CREATE TABLE IF NOT EXISTS companies(
	id VARCHAR(15) PRIMARY KEY,
    company_name VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(50),
    country VARCHAR(35),
    website VARCHAR(50)
);

LOAD DATA INFILE
'companies.csv'
INTO TABLE companies
FIELDS terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
;

CREATE TABLE IF NOT EXISTS products(
	id INT PRIMARY KEY,
    product_name VARCHAR(40),
    price varchar(15),
    colour VARCHAR(20),
    weight decimal(10,2),
    warehouse_id VARCHAR(15)
);

LOAD DATA INFILE
'products.csv'
INTO TABLE products
FIELDS terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
;

CREATE TABLE IF NOT EXISTS credit_cards(
	id VARCHAR(15) PRIMARY KEY,
    user_id INT,
    iban VARCHAR(50),
    pan VARCHAR(30),
    pint INT(4),
    cvv int(3),
    track1 VARCHAR(55),
    track2 VARCHAR(55),
    expiring_date VARCHAR(15)
);

LOAD DATA INFILE
'credit_cards.csv'
INTO TABLE credit_cards
FIELDS terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
;

CREATE TABLE IF NOT EXISTS users(
	id int primary key,
    name varchar(55),
    surname varchar(55),
    phone varchar(30),
    email varchar(55),
    birth_date varchar(30),
    country varchar(30),
    city varchar(50),
    postal_code varchar(25),
    address varchar(
    55)
);

LOAD DATA INFILE
'users_usa.csv'
INTO TABLE users
FIELDS terminated by ','
ENCLOSED BY '"' -- OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 lines
;

LOAD DATA INFILE
'users_uk.csv'
INTO TABLE users
FIELDS terminated by ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 lines
;

LOAD DATA INFILE
'users_ca.csv'
INTO TABLE users
FIELDS terminated by ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 lines
;

#Un cop introduides les dades de les diferents taules, procedirem a crear les relacions entre les diferents entitats.
#En primer lloc, crearem els indexs de la taula de Fets.

show create table transactions;
show create table users;

ALTER TABLE transactions
ADD index  (card_id),
ADD index (company_id),
ADD index (user_id),
ADD index (product_ids);

#I a posteriori, afegirem la vinculació amb les diferents taules de dimensions.

ALTER TABLE credit_cards
ADD foreign key (id) REFERENCES transactions(card_id);

ALTER TABLE companies
ADD FOREIGN KEY (id) REFERENCES transactions(company_id);

#Al crear la vinculació entre la taula users i transactions ens salta un error 1452, i per això desactivarem 
#momentàniament les claus forànies.

/*
ALTER TABLE transactions
ADD constraint fk_user_id foreign key(user_id)
REFERENCES users(id);
*/

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE users
ADD FOREIGN KEY (id) REFERENCES transactions(user_id);

SET FOREIGN_KEY_CHECKS=1;

# Per ara tenim un error d'incompatibilitat entre les columnes a vincular de la taula products i transactions, ho mirarem més endavant.

#ALTER TABLE products
#ADD FOREIGN KEY (id) REFERENCES transactions(product_ids);


#Ex1
#Realitza una subconsulta que mostri tots els usuaris amb més de 30 transaccions utilitzant almenys 2 taules.

#A continuació la subconsulta sol·licitada.
SELECT users.id, users.name, users.surname, (SELECT count(transactions.user_id)
FROM transactions
WHERE transactions.user_id = users.id
) as Num_transaccions
FROM users
GROUP BY 1, 2, 3
having Num_transaccions>30
ORDER BY 4 desc;

#Tanmateix, per obtenir les dades sol·licitades, no caldria fer una subconsulta, i la següent consulta seria més eficient:
SELECT users.id, users.name, users.surname, count(transactions.user_id) AS Num_Operacions
FROM users
JOIN transactions ON users.id = transactions.user_id
GROUP BY 1, 2, 3
HAVING Num_Operacions > 30
ORDER BY 4 DESC;

#Ex2
#Mostra la mitjana de la suma de transaccions per IBAN de les targetes de crèdit en la companyia Donec Ltd. utilitzant almenys 2 taules.

SELECT companies.company_name as Companyia, credit_cards.iban, ROUND(AVG(transactions.amount),2) as Mitjana_transaccions
FROM transactions
JOIN companies ON transactions.company_id = companies.id
JOIN credit_cards ON transactions.card_id = credit_cards.id
#WHERE transactions.declined = 0
WHERE companies.company_name = 'Donec Ltd'
group by 1, 2
;

####
#Nivell 2

/*Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les últimes tres transaccions van 
ser declinades i genera la següent consulta:
*/

CREATE TABLE card_state as
SELECT credit_cards.id
/*	, case
	when transactions.declined = 0 then 'Activa'
    else 'Inactiva'
    end as estat_targeta*/
, if(sum(transactions.declined) = 3, 'Inactiva', 'Activa') as estat_targeta
#, transactions.declined, transactions.timestamp
FROM transactions
JOIN (SELECT transactions.timestamp, row_number() Over (partition by transactions.card_id order by transactions.timestamp DESC) as Num_operacions
FROM transactions) as sub_operacions ON transactions.timestamp = sub_operacions.timestamp
JOIN credit_cards ON credit_cards.id = transactions.card_id
WHERE Num_operacions <=3 -- aquest és el sistema que utilitzaríem si filtressim per les 3 últimes operacions, que és el que demana l'exercici
#WHERE Num_operacions <=1 -- en aquest cas, només filtrem per la última operació, ja que la targeta només estarà inactiva si és l'última operació la rebutjada.
GROUP BY 1;

#Afegirem Primary Key a la nova taula i la vincularem amb la taula credit_cards

ALTER TABLE card_state
ADD PRIMARY KEY (id),
ADD FOREIGN KEY (id) references credit_cards(id);

/*
SELECT credit_cards.id, transactions.declined, transactions.timestamp
FROM transactions
JOIN credit_cards ON credit_cards.id = transactions.card_id
;

SELECT transactions.timestamp, row_number() Over (partition by transactions.card_id order by transactions.timestamp) as row_num
FROM transactions
;
*/

#Ex1
#Quantes targetes estan actives?
SELECT estat_targeta, count(*) as TT_Targeta_Activa
FROM card_state
WHERE estat_targeta = 'Activa'
GROUP BY 1;

##

#Nivell 3

/*Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, 
tenint en compte que des de transaction tens product_ids. Genera la següent consulta:
*/

CREATE TABLE product_transaction as
SELECT id as order_id, SUBSTRING_INDEX(SUBSTRING_INDEX(product_ids, ',', numbers.n), ',', -1) AS product_id
FROM transactions
JOIN (SELECT 1 n union all select 2 union all select 3 union all select 4) numbers
ON CHAR_LENGTH (transactions.product_ids) - CHAR_LENGTH(REPLACE(transactions.product_ids, ',', ''))>=numbers.n-1
ORDER BY order_id, product_id;

# Procedim a modificar la columna product_id com a inter, afegir la clau primària i la foreign key amb la taula transactions.
ALTER table product_transaction
modify column product_id int,
add primary key (order_id, product_id),
add foreign key (order_id) references transactions(id);

#També borrarem l'index que vam afegir a la taula transactions al camp product_ids

SHOW INDEX FROM transactions;

ALTER TABLE transactions
DROP INDEX product_ids;

#I afegirem relacions amb altres taules que ens hem deixat fins ara

ALTER TABLE product_transaction
ADD FOREIGN KEY (product_id) references products(id);


SELECT *
FROM product_transaction;

#Ex1
#Necessitem conèixer el nombre de vegades que s'ha venut cada producte.

SELECT product_transaction.product_id as codi_producte, products.product_name as producte, count(product_transaction.product_id) as TT_Unitats
FROM product_transaction
JOIN products ON products.id = product_transaction.product_id
GROUP BY 1
ORDER BY 3 DESC;

#######

SELECT *
FROM card_state;

SELECT *
FROM transactions;

SELECT *
FROM credit_cards;

SELECT *
FROM companies;

SELECT *
FROM products;


