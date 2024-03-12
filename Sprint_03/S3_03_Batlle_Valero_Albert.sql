#Nivell 3
#Ex1
/*La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. Un company del teu equip va realitzar modificacions en la base 
de dades, però no recorda com les va realitzar. Et demana que l'ajudis a deixar els comandos executats per a obtenir el següent diagrama:

*/
#Anem a començar les modificacions començant per la taula credit_card
#Començarem modificant els tipus de dada dels camps existents.

/* No aplicarem aplicarem aquest primer canvi perquè al ser la PK volem que es mantingui amb el mateix tipus de varchar(15) que té la Foreign
Key de la taula transaction credit_card_id que també és varchar(15). Si les dades d'aquests camps fossin diferents ens podria generar problemes
en la seva relació.

ALTER TABLE credit_card
MODIFY column id varchar(20);
*/

ALTER table credit_card
modify column iban varchar(50);

alter table credit_card
modify column pin varchar(4);

alter table credit_card
modify column expiring_date varchar(10);

#En darrer lloc, en aquesta taula afegirem el camp fecha_actual i com que el camp es diu fecha actual, farem que tingui el valor de camp
# a la data de creació de la columna; i si afegissim registres a continuació és crearien amb la actual, i que s'actualitzi cada cop que fem una modificació.  

Alter table credit_card
ADD column fecha_actual DATE DEFAULT (current_date);

show create table credit_card;
select *
FROM credit_card;

#Anem a continuar amb les modificacions ara a la taula company.
#En aquest cas, només hem de suprimir el camp website

ALTER TABLE company
DROP COLUMN website; 

show create table company;
select *
FROM company;

#Prosseguim ara amb les modificacions ara a la taula company.
#En aquesta taula només haurem d'indicar que el camp user_id és un index, per poder utilitzar el camp com a Foreign Key 
#quan creem la taula user

ALTER TABLE transaction
ADD index(user_id);

show create table transaction;
select *
FROM transaction;

#Anem a acabar les modificacions de la base de dades amb la creació de la taula user

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        personal_email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255),
        FOREIGN KEY(id) REFERENCES transaction(user_id)        
    );

#I per últim anem a introduir les dades de la taula user
#Com que hem canviat el nom del email a personal_email, el modificarem a email, ja que a les dades introduir el camp apareix com a email

Alter table user
change column personal_email email varchar(150);

SET foreign_key_checks = 0;

#-- Insertamos datos de user
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "1", "Zeus", "Gamble", "1-282-581-0551", "interdum.enim@protonmail.edu", "Nov 17, 1985",         "United States", "Lowell", "73544", "348-7818 Sagittis St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "2", "Garrett", "Mcconnell", "(718) 257-2412", "integer.vitae.nibh@protonmail.org", "Aug 23, 1992",         "United States", "Des Moines", "59464", "903 Sit Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "3", "Ciaran", "Harrison", "(522) 598-1365", "interdum.feugiat@aol.org", "Apr 29, 1998",         "United States", "Columbus", "56518", "736-2063 Tellus St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "4", "Howard", "Stafford", "1-411-740-3269", "ornare.egestas@icloud.edu", "Feb 18, 1989",         "United States", "Kailua", "77417", "Ap #545-2244 Erat. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "5", "Hayfa", "Pierce", "1-554-541-2077", "et.malesuada.fames@hotmail.org", "Sep 26, 1998",         "United States", "Sandy", "31564", "341-2821 Ultrices Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "6", "Joel", "Tyson", "(718) 288-8020", "gravida.nunc.sed@yahoo.ca", "Oct 15, 1989",         "United States", "Nashville", "96838", "888-2799 Amet Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "7", "Rafael", "Jimenez", "(817) 689-0478", "eget@outlook.ca", "Dec 4, 1981",         "United States", "Hillsboro", "29874", "8627 Malesuada Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "8", "Nissim", "Franks", "(692) 157-3469", "egestas.aliquam.fringilla@google.ca", "Aug 1, 1993",         "United States", "Jackson", "61750", "Ap #251-7144 Integer St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "9", "Mannix", "Mcclain", "(590) 883-2184", "aliquam.nisl@outlook.com", "Jan 24, 1987",         "United States", "Richmond", "35987", "647-3080 Lacus. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "10", "Robert", "Mccarthy", "(324) 746-6771", "fermentum@protonmail.com", "Apr 30, 1984",         "United States", "Eugene", "85526", "P.O. Box 773, 3594 Ornare St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "11", "Joan", "Baird", "(981) 429-8106", "et@outlook.net", "Feb 25, 1990",         "United States", "Lincoln", "35211", "P.O. Box 687, 8917 Ligula St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "12", "Benedict", "Wheeler", "1-515-824-2855", "tincidunt.donec.vitae@hotmail.couk", "Aug 6, 1999",         "United States", "Lewiston", "92393", "748-8694 Porttitor Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "13", "Allegra", "Stanton", "1-927-753-6488", "proin.eget@protonmail.ca", "May 19, 1990",         "United States", "Kearney", "14947", "4457 Ante. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "14", "Sara", "Flynn", "1-311-646-9333", "integer@outlook.net", "Dec 27, 1988",         "United States", "Warren", "20288", "P.O. Box 865, 4397 Ante St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "15", "Noelani", "Patrick", "1-723-488-5894", "sem.magna@google.com", "Sep 17, 1993",         "United States", "Orlando", "47987", "596-5044 Sapien, Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "16", "Eric", "Roth", "1-218-549-8253", "lorem.sit@yahoo.net", "Sep 7, 1988",         "United States", "Reading", "96697", "P.O. Box 541, 5137 Non Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "17", "Bruce", "Gill", "(744) 732-8628", "metus@aol.net", "Mar 4, 1990",         "United States", "Davenport", "43415", "Ap #836-9508 Vitae, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "18", "Russell", "Jimenez", "(657) 779-2438", "orci@outlook.edu", "Aug 26, 1993",         "United States", "Hattiesburg", "75647", "4095 Quam Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "19", "Nicholas", "Travis", "1-330-223-9652", "libero.dui@hotmail.com", "Jul 15, 1981",         "United States", "Jacksonville", "71727", "Ap #459-539 Lectus Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "20", "Kelsey", "Bates", "(653) 724-4754", "ullamcorper.nisl@aol.com", "May 6, 1981",         "United States", "Gulfport", "50423", "824-3624 Lacinia St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "21", "Hall", "Reeves", "(241) 759-9235", "erat.eget@hotmail.edu", "Jul 22, 1987",         "United States", "Warren", "85521", "Ap #745-5948 Sollicitudin St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "22", "Allistair", "Holmes", "1-265-323-0812", "donec.tempor.est@protonmail.com", "Nov 5, 1990",         "United States", "Montpelier", "85914", "Ap #794-4229 Ante Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "23", "Kelsie", "Bass", "1-837-832-5631", "consequat@google.ca", "Apr 2, 1990",         "United States", "Jefferson City", "97237", "407-7562 A, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "24", "Nolan", "Cash", "(273) 334-3785", "nam@hotmail.com", "Sep 9, 1994",         "United States", "Owensboro", "61256", "501-2733 Luctus. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "25", "Wanda", "Campbell", "(702) 823-5535", "sagittis@google.couk", "May 31, 1999",         "United States", "San Jose", "88665", "Ap #337-8747 Auctor. Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "26", "Aquila", "Strickland", "1-246-231-5495", "enim.sit@icloud.com", "Sep 28, 1982",         "United States", "Colchester", "26637", "Ap #260-4612 Massa Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "27", "Diana", "Williamson", "1-285-365-7779", "id.nunc@google.com", "Dec 14, 1991",         "United States", "Kearney", "93484", "362-9552 Sed Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "28", "Elmo", "Cain", "1-663-583-6021", "nec.metus.facilisis@google.org", "Oct 13, 1980",         "United States", "Columbus", "25225", "P.O. Box 585, 4446 Suspendisse St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "29", "Deacon", "Sharpe", "(312) 529-1643", "hendrerit@icloud.net", "Sep 19, 1979",         "United States", "Naperville", "63967", "672-9145 Ullamcorper, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "30", "Martena", "Blackwell", "1-336-632-3280", "at.nisi.cum@icloud.org", "Feb 21, 1987",         "United States", "Columbia", "53144", "641 Lacus. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "31", "Francis", "Bryant", "(654) 360-7374", "quisque.ac.libero@protonmail.edu", "Aug 17, 1992",         "United States", "Waterbury", "91358", "P.O. Box 596, 9052 Quisque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "32", "Chase", "Yang", "1-771-216-5335", "pellentesque.eget@google.net", "Apr 23, 1999",         "United States", "Duluth", "32807", "207-9951 Mi, Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "33", "Venus", "Sanders", "(679) 326-6342", "nec.ante.maecenas@aol.com", "Jan 6, 1990",         "United States", "Little Rock", "40790", "4840 Lorem Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "34", "Sopoline", "Branch", "1-557-503-3642", "nec@yahoo.org", "Apr 8, 1979",         "United States", "Gary", "79667", "745 Vivamus Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "35", "Yvonne", "Gibson", "1-424-288-3275", "risus@outlook.org", "Jan 7, 1993",         "United States", "Vancouver", "21213", "Ap #356-7162 Ligula Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "36", "Raymond", "Thornton", "1-581-648-7426", "enim.nisl@google.edu", "Dec 6, 1982",         "United States", "Kansas City", "26231", "746-3251 Aptent Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "37", "Graiden", "Glover", "(888) 957-3868", "non.hendrerit@hotmail.ca", "Nov 11, 1987",         "United States", "Portland", "35397", "Ap #497-8090 Vel Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "38", "Abra", "Doyle", "(367) 861-9621", "augue.eu@outlook.edu", "Aug 22, 1986",         "United States", "Chicago", "54137", "409-9169 Cubilia St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "39", "Nyssa", "Shaffer", "1-899-494-4941", "malesuada.fames@google.ca", "Jul 2, 1991",         "United States", "Columbus", "27828", "4215 Libero Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "40", "Astra", "Alexander", "1-877-546-5066", "lectus.nullam.suscipit@google.org", "Mar 12, 1983",         "United States", "Columbus", "78276", "P.O. Box 384, 117 Et St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "41", "Uriel", "Hebert", "1-265-846-2455", "donec@outlook.com", "Nov 30, 1981",         "United States", "Juneau", "33549", "670-5867 Eget Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "42", "Lucy", "Branch", "(459) 164-9989", "odio.etiam@aol.couk", "Oct 31, 1991",         "United States", "Joliet", "27874", "134-848 Orci, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "43", "Jayme", "Chavez", "(542) 568-7326", "fusce.feugiat@outlook.com", "Jul 29, 1984",         "United States", "Aurora", "28283", "8659 Enim. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "44", "Aquila", "Haley", "1-951-243-1892", "tempus.risus@outlook.edu", "Jan 21, 1996",         "United States", "Newark", "51734", "Ap #197-7436 Neque. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "45", "Richard", "O'donnell", "1-275-844-6782", "ac.nulla@outlook.org", "Oct 4, 1986",         "United States", "Frankfort", "72520", "P.O. Box 333, 3191 Ullamcorper, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "46", "Alika", "Valdez", "(781) 178-0838", "dapibus.gravida@yahoo.net", "Aug 8, 1990",         "United States", "Salem", "55729", "P.O. Box 580, 196 Cras Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "47", "Herrod", "Wright", "(575) 645-3218", "odio.auctor.vitae@yahoo.edu", "Nov 11, 1999",         "United States", "Fort Wayne", "72865", "8745 Elementum Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "48", "Patrick", "Reyes", "1-607-729-5993", "conubia.nostra@icloud.com", "Jul 29, 1986",         "United States", "San Jose", "96740", "1150 Etiam Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "49", "Lev", "Roth", "1-685-331-7392", "auctor.vitae.aliquet@yahoo.net", "Dec 3, 1981",         "United States", "Richmond", "52748", "P.O. Box 455, 4035 Ullamcorper, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "50", "Aretha", "Chang", "1-634-250-1977", "suspendisse.aliquet.molestie@hotmail.edu", "May 11, 1998",         "United States", "Jonesboro", "26937", "491 Neque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "51", "Lionel", "Griffith", "1-816-243-8788", "ultricies.sem.magna@yahoo.org", "Apr 3, 1993",         "United States", "Wichita", "17638", "P.O. Box 191, 5848 A, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "52", "Sheila", "Sullivan", "(426) 608-1653", "arcu.vel@google.edu", "May 17, 1981",         "United States", "Sacramento", "48147", "Ap #644-7695 Nec, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "53", "Lucas", "Lloyd", "(513) 819-9413", "sagittis.duis.gravida@outlook.net", "Jun 20, 1980",         "United States", "Waterbury", "56684", "745-3814 Metus. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "54", "Emma", "Park", "(581) 468-8549", "vel.turpis.aliquam@icloud.org", "May 27, 1991",         "United States", "Topeka", "70684", "Ap #558-7250 Vivamus Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "55", "Barrett", "Andrews", "(573) 474-8979", "ligula.consectetuer@protonmail.edu", "Nov 28, 1995",         "United States", "Tacoma", "14982", "5363 Rhoncus Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "56", "Odysseus", "Frye", "(236) 402-6048", "sociis.natoque@outlook.org", "Feb 19, 1983",         "United States", "Norman", "74030", "772-6878 Sociosqu Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "57", "Daquan", "Kirk", "1-748-565-9125", "ultricies@hotmail.ca", "Dec 22, 1994",         "United States", "Grand Rapids", "46875", "5438 Odio. Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "58", "Sandra", "Owens", "1-961-472-4829", "eu.enim@icloud.ca", "Oct 14, 1980",         "United States", "Fort Worth", "44233", "465-230 Ullamcorper, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "59", "Heather", "Bradshaw", "1-535-845-1352", "luctus.et@aol.couk", "Dec 4, 1984",         "United States", "Kaneohe", "85163", "6641 Convallis St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "60", "Roth", "Cook", "(122) 759-2618", "ullamcorper.eu@icloud.edu", "Nov 23, 1996",         "United States", "Aurora", "26839", "Ap #815-8102 Ante. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "61", "Duncan", "Romero", "1-226-441-1416", "ligula.aenean.euismod@hotmail.com", "Feb 4, 1990",         "United States", "Hilo", "68158", "267-173 Felis Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "62", "Phyllis", "Holt", "1-806-654-1534", "metus.vitae.velit@outlook.couk", "Jun 7, 1987",         "United States", "Newark", "81711", "Ap #111-6364 Libero. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "63", "Beverly", "Burt", "(336) 263-4576", "aliquam.enim@aol.edu", "Dec 12, 1996",         "United States", "Pittsburgh", "18438", "P.O. Box 632, 6754 Fringilla Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "64", "Irma", "Whitehead", "1-332-774-7232", "mauris.quis@google.org", "Feb 14, 1988",         "United States", "Norman", "47637", "393-6189 Sem Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "65", "Yeo", "Emerson", "(473) 596-9486", "lacinia.at.iaculis@aol.net", "Sep 26, 1993",         "United States", "Salem", "71835", "Ap #897-3426 Orci, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "66", "Bert", "Juarez", "1-404-537-2914", "pede.nec@outlook.net", "Sep 14, 1988",         "United States", "Colchester", "85478", "757-6748 Placerat St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "67", "Kenneth", "Morrison", "1-214-178-7152", "elementum.sem.vitae@outlook.org", "Sep 10, 1981",         "United States", "Saint Louis", "65146", "801-4640 Odio Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "68", "Whoopi", "Ford", "1-548-301-4313", "enim.diam.vel@google.com", "Apr 30, 1979",         "United States", "Bloomington", "76233", "P.O. Box 312, 3903 Aliquam Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "69", "Stone", "Atkinson", "1-751-189-8258", "etiam@outlook.com", "Jan 31, 1993",         "United States", "Columbus", "36506", "Ap #820-7449 Tellus Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "70", "Debra", "Farley", "(377) 214-5814", "non.justo@aol.com", "Jan 31, 1985",         "United States", "San Jose", "88326", "P.O. Box 855, 7643 Eu Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "71", "Emerson", "Hess", "1-342-775-1174", "orci.tincidunt.adipiscing@icloud.ca", "May 12, 1984",         "United States", "Mesa", "33568", "Ap #191-5633 Lectus Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "72", "Jael", "Robles", "(267) 616-3375", "lorem.eget.mollis@protonmail.net", "Jun 6, 1983",         "United States", "Spokane", "97103", "266 Dictum Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "73", "Warren", "Christian", "1-125-829-9354", "malesuada.vel@icloud.ca", "Jan 12, 1993",         "United States", "Boise", "95246", "Ap #323-5264 Convallis Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "74", "Zelenia", "Good", "1-971-397-7840", "aenean@google.couk", "Sep 21, 1988",         "United States", "Wichita", "78518", "176-5987 Sociis St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "75", "Colleen", "Juarez", "1-647-277-0329", "sodales@yahoo.edu", "May 25, 1990",         "United States", "Lewiston", "36194", "919-2582 Et, St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "76", "Glenna", "Gutierrez", "(567) 428-5368", "amet@outlook.couk", "Sep 25, 1990",         "United States", "Newark", "58673", "9288 Posuere St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "77", "Jared", "Compton", "1-416-623-5165", "vel.quam@outlook.net", "Jan 18, 1999",         "United States", "Norfolk", "13086", "354-782 Tempor Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "78", "Camilla", "Zimmerman", "(403) 839-3861", "enim@aol.com", "Nov 20, 1997",         "United States", "Aurora", "79643", "Ap #612-9307 Metus Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "79", "Preston", "Hubbard", "(485) 611-5951", "in.cursus.et@protonmail.com", "Aug 16, 2000",         "United States", "Savannah", "73062", "P.O. Box 761, 364 Mauris Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "80", "Sophia", "Bradford", "(795) 358-4243", "eu@outlook.com", "Feb 10, 1985",         "United States", "Paradise", "89058", "Ap #425-5343 Fermentum Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "81", "Acton", "Gallegos", "1-784-875-8068", "rhoncus.donec@yahoo.org", "Feb 6, 1989",         "United States", "Lexington", "54348", "5613 Ut St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "82", "Stacey", "Moses", "(768) 696-2845", "ante.iaculis.nec@hotmail.edu", "Sep 7, 1985",         "United States", "South Portland", "84463", "Ap #786-4555 Scelerisque Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "83", "Dana", "Ware", "1-997-209-1750", "nisi.a@outlook.net", "Nov 29, 1979",         "United States", "Hillsboro", "59188", "Ap #801-3094 Nec Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "84", "Craig", "Shepherd", "1-817-268-8038", "feugiat@protonmail.net", "Jul 21, 1997",         "United States", "Dover", "29670", "P.O. Box 629, 4780 Egestas Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "85", "Dawn", "Murray", "1-818-547-6341", "ante.dictum.mi@outlook.couk", "Dec 13, 1989",         "United States", "Fairbanks", "67154", "8209 Morbi Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "86", "Quintessa", "Buckley", "1-461-623-4184", "justo.sit.amet@hotmail.ca", "Dec 16, 1987",         "United States", "Anchorage", "95823", "572-4088 Tempor, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "87", "Camden", "Carpenter", "1-842-231-7504", "enim.commodo@google.ca", "Aug 14, 1981",         "United States", "Waterbury", "78847", "5748 Amet Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "88", "Holmes", "Ramsey", "(913) 726-8674", "id.erat@aol.net", "Jul 3, 1998",         "United States", "Augusta", "35453", "P.O. Box 359, 8428 Nec, St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "89", "Lars", "Mercado", "1-561-562-1561", "sem.vitae@aol.net", "Apr 27, 1991",         "United States", "Huntsville", "34901", "Ap #892-9811 Proin St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "90", "Alika", "Kinney", "(625) 262-0063", "parturient@hotmail.org", "Jan 3, 1996",         "United States", "Davenport", "64481", "P.O. Box 898, 349 Ultricies Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "91", "Serina", "Carter", "(852) 256-1633", "tellus.id.nunc@icloud.com", "Feb 14, 1984",         "United States", "Reading", "72245", "424-6510 Sit Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "92", "Lynn", "Riddle", "1-387-885-4057", "vitae.aliquet@outlook.edu", "Sep 21, 1984",         "United States", "Bozeman", "61871", "P.O. Box 712, 7907 Est St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "93", "Kimberley", "Avila", "(614) 862-3520", "magna.phasellus@outlook.com", "Apr 4, 1997",         "United States", "Burlington", "71305", "269-4732 Maecenas Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "94", "Kim", "Zimmerman", "(406) 496-7968", "sed.dictum@hotmail.couk", "Oct 7, 1981",         "United States", "Pittsburgh", "89349", "Ap #274-5686 Nec Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "95", "Chase", "Ellis", "(322) 137-3271", "quisque.purus@hotmail.edu", "Dec 19, 2000",         "United States", "New Haven", "72721", "1311 Accumsan Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "96", "Brennan", "Wynn", "(831) 607-3574", "nullam.ut@yahoo.net", "Nov 1, 1988",         "United States", "Lewiston", "74004", "Ap #774-4981 Elementum Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "97", "Joseph", "Davidson", "1-184-847-8256", "mauris@outlook.net", "Jan 18, 1987",         "United States", "Allentown", "88451", "P.O. Box 178, 6049 Luctus St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "98", "Cassandra", "Ferguson", "(594) 318-2465", "eu@google.couk", "May 8, 1992",         "United States", "Tuscaloosa", "83383", "497-7857 Eget, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "99", "Reed", "Rutledge", "1-472-670-2236", "facilisis.facilisis@outlook.net", "Feb 17, 1997",         "United States", "Newport News", "36951", "225-6073 Magna Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "100", "Melodie", "Mclean", "1-677-221-7152", "risus.varius@google.ca", "Sep 15, 1989",         "United States", "College", "11838", "Ap #644-8492 Sagittis St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "101", "Sarah", "Beck", "(358) 691-4345", "vitae.risus@aol.couk", "Apr 9, 1983",         "United States", "Great Falls", "67129", "665-9047 In, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "102", "Jasper", "Landry", "1-397-765-1118", "consectetuer.euismod@aol.org", "Apr 16, 1982",         "United States", "Columbus", "11595", "Ap #374-7325 Sodales Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "103", "Upton", "Chavez", "(227) 785-6484", "euismod.est@aol.ca", "Mar 15, 1986",         "United States", "Essex", "95631", "1990 Vel, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "104", "Martha", "Barlow", "(732) 326-5448", "vulputate@hotmail.net", "Oct 29, 1988",         "United States", "Chicago", "41512", "Ap #311-7103 In Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "105", "Hashim", "Rose", "(858) 313-6727", "urna@icloud.com", "Mar 28, 1983",         "United States", "Tacoma", "99632", "8034 Tortor, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "106", "Tanner", "Valenzuela", "1-346-421-3135", "nascetur.ridiculus@google.net", "Apr 6, 1993",         "United States", "Naperville", "31130", "Ap #114-2616 Fusce Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "107", "Victor", "Valencia", "(239) 569-1938", "non.enim@hotmail.couk", "May 1, 1998",         "United States", "Warren", "15158", "Ap #182-9926 At St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "108", "Germaine", "Suarez", "1-931-750-6983", "risus@icloud.com", "Feb 1, 1984",         "United States", "Cleveland", "36183", "Ap #383-1856 Mauris Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "109", "Raven", "Reynolds", "(667) 453-9731", "sed@aol.com", "Jul 11, 1986",         "United States", "Rockville", "64325", "P.O. Box 753, 3474 Orci, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "110", "Neil", "Powers", "(864) 881-6737", "nec.metus@aol.edu", "Sep 3, 1980",         "United States", "Clarksville", "46921", "571-2024 Quam Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "111", "Astra", "Baldwin", "1-643-565-3266", "adipiscing.ligula.aenean@protonmail.net", "Jul 3, 1999",         "United States", "Indianapolis", "74764", "932-8297 Ac Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "112", "Ryder", "Cole", "1-572-759-8544", "nec.enim.nunc@protonmail.net", "Sep 4, 1990",         "United States", "South Portland", "52161", "Ap #286-4884 Arcu. Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "113", "Risa", "Frost", "1-712-488-5451", "neque.pellentesque@outlook.org", "May 5, 1996",         "United States", "Kearney", "88986", "Ap #678-785 Leo. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "114", "Jasmine", "Castro", "1-512-143-0648", "lorem@google.ca", "Jan 5, 1987",         "United States", "San Jose", "94101", "9948 Dictum. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "115", "Urielle", "Holman", "1-424-793-4354", "leo@google.ca", "Oct 11, 1985",         "United States", "Green Bay", "29058", "268-1889 Adipiscing Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "116", "Sacha", "Compton", "(265) 342-4775", "sed.dictum.proin@yahoo.org", "Sep 1, 1981",         "United States", "Wilmington", "94151", "Ap #722-5423 Velit. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "117", "Halla", "Pearson", "(681) 698-7518", "lacus.etiam@protonmail.couk", "Apr 19, 1994",         "United States", "Biloxi", "65926", "664-903 In, Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "118", "Brooke", "Jensen", "(124) 739-9067", "purus.mauris.a@icloud.ca", "Aug 23, 1981",         "United States", "Erie", "68334", "P.O. Box 718, 9538 Velit Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "119", "Damian", "Mcgee", "(712) 572-8735", "neque.nullam@hotmail.edu", "Sep 20, 1988",         "United States", "Racine", "67561", "Ap #383-8201 Orci Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "120", "Solomon", "Blake", "1-814-753-4054", "in.at.pede@hotmail.edu", "Feb 23, 1990",         "United States", "Glendale", "32725", "469-4293 Aenean St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "121", "Ainsley", "Herrera", "1-380-341-6875", "est.congue@hotmail.couk", "Mar 28, 1996",         "United States", "Madison", "64252", "779-913 Cras Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "122", "Desiree", "Carey", "(888) 429-3660", "pellentesque.tellus.sem@protonmail.edu", "Sep 10, 1989",         "United States", "Reading", "71452", "P.O. Box 651, 6745 Donec St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "123", "Dominique", "Tillman", "1-956-793-8208", "vitae.dolor.donec@google.ca", "Sep 28, 1999",         "United States", "New Orleans", "33029", "618-3352 Amet, Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "124", "Walter", "Larsen", "(435) 652-7642", "et.netus.et@yahoo.net", "Sep 15, 1979",         "United States", "College", "31347", "Ap #946-1494 Mauris Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "125", "Celeste", "Ellis", "1-847-855-3441", "dapibus.rutrum@yahoo.org", "Jan 29, 1994",         "United States", "Wichita", "84214", "Ap #521-1005 Dolor Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "126", "Kim", "Mooney", "1-252-337-6661", "sed.nec@google.org", "Nov 28, 2000",         "United States", "Lewiston", "84345", "377-2270 Ante St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "127", "Ezra", "Beard", "(743) 567-0923", "morbi.sit@google.com", "Apr 8, 1984",         "United States", "Los Angeles", "43908", "P.O. Box 783, 1432 Inceptos Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "128", "Lucas", "Dawson", "(404) 491-1122", "in.consectetuer.ipsum@yahoo.com", "Sep 13, 1983",         "United States", "Shreveport", "82532", "P.O. Box 926, 2853 Non, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "129", "Amber", "Blevins", "(734) 712-6456", "nunc@outlook.org", "Aug 14, 1979",         "United States", "Honolulu", "51863", "P.O. Box 878, 292 Orci Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "130", "Oscar", "Neal", "1-923-222-4140", "magna.nec@icloud.net", "Dec 29, 1983",         "United States", "Casper", "94343", "653 Posuere Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "131", "Hiram", "Preston", "(774) 220-4835", "ridiculus.mus@yahoo.net", "Jan 14, 1996",         "United States", "Rochester", "24724", "P.O. Box 579, 727 Ipsum Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "132", "Gisela", "Johnston", "(223) 563-2771", "accumsan.sed@outlook.couk", "Jul 29, 1993",         "United States", "Auburn", "58677", "489-8011 Faucibus Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "133", "Iona", "Soto", "1-249-240-5843", "tristique.aliquet@protonmail.com", "Apr 15, 1998",         "United States", "Iowa City", "73017", "Ap #327-9970 Sollicitudin St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "134", "Tiger", "Davis", "(571) 492-5568", "nonummy.ut@hotmail.ca", "Apr 12, 1997",         "United States", "Aurora", "80460", "P.O. Box 346, 7204 Quam. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "135", "Zahir", "Swanson", "(758) 354-1913", "nam.ac@hotmail.couk", "Jan 12, 1991",         "United States", "Dover", "27834", "684 Sed Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "136", "Sonya", "Hobbs", "1-508-176-1405", "quis.pede@aol.com", "Jan 8, 1981",         "United States", "Memphis", "24123", "Ap #959-1231 Aliquam Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "137", "Brody", "Goodwin", "1-789-944-8575", "donec.felis@outlook.couk", "Apr 2, 1982",         "United States", "Tucson", "61282", "779-7842 Dolor Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "138", "Wesley", "Bush", "1-814-353-8532", "fermentum.arcu@hotmail.com", "Feb 8, 1987",         "United States", "Owensboro", "77662", "270-4210 Et, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "139", "Walker", "Gibson", "1-935-527-2111", "ipsum.primis@yahoo.edu", "Jan 20, 1980",         "United States", "Annapolis", "99895", "P.O. Box 694, 6043 Dolor. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "140", "Oprah", "Nicholson", "(485) 970-9786", "a@google.edu", "Sep 19, 1981",         "United States", "Bridgeport", "38328", "8543 Velit Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "141", "Clark", "Hewitt", "1-522-475-6115", "et.malesuada@aol.couk", "Oct 20, 1997",         "United States", "Tuscaloosa", "35547", "Ap #260-1064 Quisque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "142", "Wyatt", "Morris", "1-402-317-8621", "consequat@google.org", "Oct 11, 1992",         "United States", "Salt Lake City", "37463", "P.O. Box 436, 6802 Purus Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "143", "Genevieve", "Nolan", "1-346-724-1579", "quis@outlook.com", "Sep 3, 1990",         "United States", "Springfield", "37616", "Ap #124-9427 Ante. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "144", "Jeanette", "Blanchard", "1-287-355-3938", "amet.dapibus@google.couk", "Jul 6, 1996",         "United States", "San Jose", "26707", "Ap #529-6734 Ipsum Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "145", "Ursula", "Stewart", "1-442-838-6756", "commodo.auctor.velit@outlook.ca", "Feb 17, 1994",         "United States", "Lincoln", "69791", "161-6225 Ac, Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "146", "Priscilla", "Skinner", "(468) 855-0771", "laoreet.lectus@aol.edu", "Jul 31, 1980",         "United States", "Sandy", "86701", "207-6998 At Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "147", "Brody", "Talley", "(307) 307-2751", "metus.sit.amet@outlook.org", "Jun 13, 1991",         "United States", "Fayetteville", "42374", "469-5852 Tellus Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "148", "Kerry", "Adkins", "(528) 872-1974", "augue.eu.tempor@icloud.couk", "Mar 13, 1983",         "United States", "Dallas", "86373", "Ap #422-4836 Nunc Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "149", "Brock", "Doyle", "(265) 140-9567", "cursus.a@aol.edu", "Feb 19, 1986",         "United States", "Tuscaloosa", "77945", "Ap #172-5737 Lorem St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "150", "Oleg", "Coleman", "1-131-139-5673", "dis@outlook.edu", "Dec 2, 1981",         "United States", "Indianapolis", "28528", "722-3056 Eu, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "151", "Meghan", "Hayden", "0800 746 6747", "arcu.vel@hotmail.ca", "Jul 2, 1980",         "United Kingdom", "Tullibody", "A1Y 3TC", "Ap #432-4493 Aliquet Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "152", "Hakeem", "Alford", "(0111) 367 0184", "adipiscing.ligula@google.edu", "Sep 30, 1979",         "United Kingdom", "Kettering", "O21 7JV", "551-8930 Lobortis Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "153", "Keegan", "Pugh", "(016977) 3851", "sodales.nisi@aol.org", "Jul 27, 1994",         "United Kingdom", "Whitehaven", "HQ8V 7YP", "Ap #312-5898 Consectetuer St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "154", "Cooper", "Bullock", "(021) 2521 6627", "et@outlook.net", "Nov 2, 1986",         "United Kingdom", "Presteigne", "U18 0DN", "872-1866 Pede Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "155", "Joshua", "Russell", "055 4409 5286", "justo.nec.ante@outlook.edu", "Jan 23, 1984",         "United Kingdom", "Hatfield", "B5H 5CS", "Ap #285-4727 Auctor. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "156", "Remedios", "Case", "055 3114 1566", "mollis.phasellus.libero@aol.com", "Oct 9, 1994",         "United Kingdom", "North Berwick", "QR0 8CW", "479-3690 Turpis Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "157", "Philip", "Carey", "0800 640 6251", "phasellus@yahoo.net", "Oct 10, 1992",         "United Kingdom", "Lochgilphead", "CE2 6HT", "196-1103 Quisque Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "158", "Fatima", "Dyer", "0800 1111", "adipiscing@google.org", "Dec 24, 1988",         "United Kingdom", "Northampton", "IL3X 6XD", "Ap #435-7194 Scelerisque, St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "159", "Kylynn", "Acevedo", "056 5727 9602", "dignissim.lacus.aliquam@google.org", "May 10, 2000",         "United Kingdom", "Pitlochry", "K3 8UL", "871-3506 Lectus. Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "160", "Lael", "Moody", "07123 850737", "nunc.sed@aol.org", "Nov 19, 1987",         "United Kingdom", "Brora", "Q87 5JM", "Ap #633-810 Purus. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "161", "Nora", "Reeves", "(01692) 29410", "ac@aol.com", "Dec 24, 1989",         "United Kingdom", "Blaenau Ffestiniog", "T37 5PO", "Ap #956-407 Et St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "162", "Francesca", "Sawyer", "(01632) 32279", "nunc@protonmail.com", "Apr 27, 1985",         "United Kingdom", "Bolton", "B35 2LE", "654-6011 Sociis Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "163", "Denton", "Blackburn", "(015406) 66385", "tincidunt@outlook.edu", "Jan 29, 1985",         "United Kingdom", "March", "YI3K 0GV", "Ap #219-2146 A, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "164", "Preston", "Hood", "0845 46 47", "convallis.est.vitae@yahoo.edu", "Jul 29, 1986",         "United Kingdom", "Elgin", "R22 2AI", "Ap #828-7829 Suspendisse Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "165", "Nora", "Cantrell", "0500 767716", "varius.et.euismod@protonmail.net", "Feb 6, 1988",         "United Kingdom", "Carterton", "Q2 8QE", "1041 Lectus, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "166", "Matthew", "Woodard", "070 6461 3432", "urna@outlook.net", "Jan 31, 1991",         "United Kingdom", "Bonnyrigg", "RN4P 8WW", "5258 Magna. Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "167", "Sheila", "Dickerson", "(01645) 68676", "et.lacinia@hotmail.ca", "Jul 26, 1998",         "United Kingdom", "Peterhead", "WM3E 9RO", "Ap #541-5450 Ullamcorper. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "168", "Donna", "Rivers", "07553 472381", "elit.erat@aol.org", "Jun 9, 1990",         "United Kingdom", "Weston-super-Mare", "H8G 8FL", "690-204 Mauris, St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "169", "Linda", "Gaines", "(011370) 15148", "faucibus@outlook.edu", "Oct 15, 1992",         "United Kingdom", "Newbury", "I5 4TY", "P.O. Box 600, 6215 Nulla Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "170", "William", "Benjamin", "0800 1111", "porttitor@icloud.ca", "May 15, 1987",         "United Kingdom", "Coldstream", "KY0 0DY", "662-8112 Praesent Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "171", "Gary", "Robbins", "0500 856738", "dolor.dolor@google.edu", "Nov 8, 1995",         "United Kingdom", "Stoke-on-Trent", "N41 3PZ", "P.O. Box 262, 1554 Vel, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "172", "Yoko", "Calhoun", "055 0680 3951", "dui.nec@outlook.org", "Oct 28, 1998",         "United Kingdom", "Lochgilphead", "GV7Y 7OL", "166-9231 Nulla. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "173", "Bertha", "Sloan", "070 7845 5485", "et.eros@aol.couk", "Mar 24, 1996",         "United Kingdom", "Dunstable", "VB7 5NO", "P.O. Box 257, 1885 Tincidunt, Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "174", "Amal", "Kennedy", "(0121) 837 5655", "tellus@aol.com", "Dec 26, 1986",         "United Kingdom", "Kircudbright", "JP9Q 1AK", "Ap #224-4191 Et Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "175", "Brent", "Bates", "0500 221383", "ipsum.primis.in@aol.ca", "Apr 8, 1996",         "United Kingdom", "Brodick", "WJ1Q 2LP", "P.O. Box 249, 1044 Erat Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "176", "Lucas", "Stevenson", "0800 1111", "quis.pede.praesent@google.net", "Sep 9, 1998",         "United Kingdom", "Dover", "VU8 7QH", "832-6324 Nunc Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "177", "Lisandra", "Carpenter", "07624 223711", "nunc@google.net", "Aug 20, 2000",         "United Kingdom", "Keith", "XA5V 0RZ", "Ap #681-4983 Nec, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "178", "Guinevere", "Kemp", "070 1590 7780", "suscipit@google.net", "Jun 18, 1987",         "United Kingdom", "Kingussie", "XX8 1SH", "Ap #801-3785 Lacus. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "179", "Stuart", "Small", "(016977) 2504", "sodales.elit.erat@icloud.net", "Apr 21, 1983",         "United Kingdom", "Basingstoke", "AG9B 3SE", "P.O. Box 484, 610 Et Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "180", "Amelia", "Valenzuela", "(016977) 9972", "ac.nulla@google.couk", "Feb 27, 1986",         "United Kingdom", "Stockport", "BK0M 3FQ", "2729 Feugiat. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "181", "Kermit", "O'brien", "076 8212 1580", "cursus@google.com", "Jan 15, 1995",         "United Kingdom", "St. Andrews", "D5 2TG", "Ap #659-5780 Elit. Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "182", "Dane", "Shepard", "0975 985 5842", "vehicula@hotmail.net", "Oct 13, 1999",         "United Kingdom", "Selkirk", "T8Q 7XU", "P.O. Box 148, 5146 Placerat. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "183", "Germane", "Whitehead", "(016977) 7528", "malesuada.malesuada.integer@aol.net", "Oct 20, 1982",         "United Kingdom", "Alva", "GC6Y 2EW", "895-5715 Ipsum. Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "184", "Ulla", "Ramirez", "055 1225 6227", "phasellus.elit@icloud.couk", "Oct 30, 1998",         "United Kingdom", "Sromness", "ED8P 8YK", "9746 Aliquet St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "185", "Molly", "Gilliam", "0800 120 8023", "donec@outlook.couk", "Dec 21, 1993",         "United Kingdom", "Banchory", "U8H 7PH", "P.O. Box 202, 5638 Mi Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "186", "Dale", "Gonzales", "056 1962 2173", "velit.in.aliquet@protonmail.org", "Oct 14, 1989",         "United Kingdom", "Dorchester", "A3X 1PW", "289-2745 Aliquet Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "187", "David", "Vance", "0500 351083", "vulputate.velit.eu@protonmail.org", "Aug 6, 1996",         "United Kingdom", "Tregaron", "TS6A 1YW", "P.O. Box 921, 3511 Tempus, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "188", "Keane", "Mckinney", "0345 629 4218", "at.arcu@google.net", "Jul 6, 1993",         "United Kingdom", "Leominster", "QJ73 6UB", "102-637 Ac Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "189", "Walter", "Lamb", "(016977) 7335", "ut.erat@hotmail.edu", "Apr 23, 1998",         "United Kingdom", "Biggleswade", "OA9M 7PV", "592-7699 In Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "190", "Shellie", "Valenzuela", "0500 899570", "dictum.phasellus.in@google.couk", "Jun 27, 1998",         "United Kingdom", "Fort William", "K5G 6GF", "2506 Natoque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "191", "Deirdre", "Todd", "056 3122 8029", "purus.mauris.a@icloud.org", "Dec 16, 1984",         "United Kingdom", "Millport", "PR67 4CE", "3423 A, Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "192", "Phoebe", "Roth", "076 5361 4786", "arcu.eu@google.org", "Feb 2, 1981",         "United Kingdom", "Buckie", "R6W 3JZ", "9091 At Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "193", "Minerva", "Wilkins", "07581 368219", "aliquam.adipiscing@yahoo.edu", "Aug 31, 2000",         "United Kingdom", "Shaftesbury", "N9R 8TC", "437-5979 Et Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "194", "Porter", "Francis", "0500 257479", "quis.accumsan@aol.couk", "Jul 20, 1991",         "United Kingdom", "Newton Abbot", "O4 2AI", "132-7918 Elementum, Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "195", "Rosalyn", "Blake", "(015905) 28451", "integer@protonmail.net", "Apr 25, 1984",         "United Kingdom", "Swindon", "P4 6UA", "Ap #694-5578 Viverra. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "196", "Blaze", "Duke", "0800 060 8337", "quis@hotmail.ca", "Feb 12, 1992",         "United Kingdom", "March", "V5 2UL", "416-2357 Vel, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "197", "Carly", "Mathews", "(024) 5216 7655", "mauris@protonmail.edu", "May 23, 1996",         "United Kingdom", "Bathgate", "KH0E 3HR", "8486 Nunc Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "198", "Keely", "Fox", "0800 1111", "id.mollis@google.net", "Jul 1, 1989",         "United Kingdom", "Blairgowrie", "N4 5WB", "8716 Mi St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "199", "Lewis", "Melendez", "(016977) 5758", "non@yahoo.net", "Jul 8, 1990",         "United Kingdom", "March", "JM6 4QS", "Ap #615-7530 Nunc Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "200", "Nero", "Mills", "056 4507 5712", "adipiscing@protonmail.org", "Aug 8, 1984",         "United Kingdom", "Newtown", "KK80 6UC", "Ap #809-8475 Donec Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "201", "Iola", "Powers", "018-139-4717", "ante.blandit@outlook.edu", "Mar 20, 2000",         "Canada", "Rigolet", "V6T 6M7", "154-5415 Auctor St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "202", "Maxwell", "Holden", "045-402-7693", "donec@hotmail.edu", "Dec 2, 1986",         "Canada", "Murdochville", "S7E 6E0", "Ap #880-6372 Ultrices. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "203", "Jarrod", "Fields", "010-741-8105", "sit.amet@google.couk", "Jan 6, 1982",         "Canada", "Baddeck", "K3X 6Z5", "441-8969 Rhoncus Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "204", "Emerson", "Sharp", "068-138-9383", "ante.iaculis@outlook.ca", "Oct 15, 1994",         "Canada", "Maple Creek", "Y2C 9E6", "517-6759 Ut, Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "205", "Sonya", "Mckee", "041-151-9737", "magna.phasellus.dolor@google.ca", "May 7, 1983",         "Canada", "Dieppe", "E7S 4P8", "Ap #916-8051 A St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "206", "Harper", "Hart", "030-656-1670", "fringilla.donec@outlook.net", "Nov 17, 2000",         "Canada", "Québec City", "B4K 0J6", "8588 Massa. Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "207", "Yvonne", "Hatfield", "003-854-1445", "magna.et.ipsum@google.edu", "Sep 22, 1981",         "Canada", "Rae-Edzo", "20Y 8L2", "Ap #636-8055 Egestas St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "208", "Burke", "Graham", "064-568-4454", "vel@yahoo.org", "Feb 23, 1993",         "Canada", "Annapolis Royal", "S4Y 8V5", "Ap #983-6042 Amet Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "209", "Athena", "Malone", "027-280-8275", "pellentesque.tincidunt@yahoo.ca", "Dec 14, 1991",         "Canada", "Cambridge Bay", "93Z 5S5", "Ap #388-8542 Est St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "210", "Slade", "Poole", "084-771-1363", "amet@icloud.com", "Feb 16, 2001",         "Canada", "Ottawa", "A1S 9W6", "601-6142 Etiam St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "211", "Larissa", "Carpenter", "066-617-3711", "congue@aol.org", "Jan 21, 1998",         "Canada", "Cumberland", "S5Y 2L8", "7285 Sed St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "212", "Zeph", "Schmidt", "056-157-7412", "vestibulum.lorem@hotmail.ca", "Apr 10, 1986",         "Canada", "Fort Smith", "V3G 8B3", "4756 Tempor Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "213", "Blake", "Strickland", "067-339-3024", "ac.libero.nec@yahoo.com", "Apr 15, 1983",         "Canada", "Mission", "R0V 9R2", "P.O. Box 207, 6843 Imperdiet Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "214", "Cleo", "George", "026-867-1198", "pellentesque.habitant@outlook.net", "Dec 24, 1998",         "Canada", "Kakisa", "R6W 8G7", "Ap #266-9424 Orci St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "215", "Keegan", "Watson", "058-771-3718", "interdum.enim.non@protonmail.edu", "May 2, 1996",         "Canada", "Oxford County", "S7H 0G4", "270-2964 Aliquet Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "216", "Tana", "Stout", "035-569-5523", "et.magnis.dis@aol.net", "Jun 28, 1983",         "Canada", "Municipal District", "D6Y 8V7", "7884 Vulputate Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "217", "Avye", "Key", "016-727-3427", "non.dui@yahoo.net", "Mar 16, 1987",         "Canada", "Marystown", "37N 1N0", "P.O. Box 712, 8627 Mi Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "218", "Sonia", "Dejesus", "091-540-1865", "ipsum.porta@google.edu", "Jun 13, 1997",         "Canada", "Fredericton", "H6H 1C1", "231-8704 Tempor Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "219", "Ivan", "Saunders", "036-230-9218", "egestas.blandit.nam@icloud.org", "Jul 7, 1985",         "Canada", "Houston", "b5M 0E6", "350-1489 Sit Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "220", "Martha", "Roth", "077-482-6236", "semper.rutrum@yahoo.edu", "Apr 5, 1994",         "Canada", "Gander", "A3X 8E4", "Ap #179-4366 Pellentesque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "221", "Sasha", "Emerson", "024-226-4281", "tempor.augue.ac@icloud.couk", "Aug 24, 1981",         "Canada", "Watson Lake", "H3X 9N3", "885-8605 Egestas Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "222", "Theodore", "Barry", "098-447-1583", "at.pede.cras@google.ca", "Feb 16, 1983",         "Canada", "Ucluelet", "B2C 5H2", "786-2757 Diam Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "223", "Linus", "Willis", "056-347-2535", "ultrices.posuere@yahoo.couk", "Mar 23, 1992",         "Canada", "Lourdes", "B0R 4L1", "6491 Cursus St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "224", "Raymond", "Oneil", "001-668-7183", "lorem@outlook.ca", "Jan 21, 1987",         "Canada", "Watson Lake", "E9K 1S7", "172 Enim. St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "225", "Ursa", "Kelly", "007-454-7455", "vitae.diam@icloud.ca", "Aug 21, 1996",         "Canada", "West Vancouver", "T0G 8G4", "540-895 Bibendum. Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "226", "Willa", "Rowland", "011-259-1714", "sociosqu.ad.litora@outlook.net", "Feb 19, 2001",         "Canada", "Paulatuk", "S4T 5M8", "Ap #728-8176 A, St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "227", "Idola", "Bowen", "039-398-2123", "gravida.molestie.arcu@outlook.org", "Jan 18, 1991",         "Canada", "Dieppe", "S1Y 5T7", "Ap #685-1370 Curabitur Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "228", "Leonard", "Davenport", "033-159-5147", "venenatis@yahoo.net", "Oct 30, 1989",         "Canada", "Beauport", "27C 8H7", "P.O. Box 293, 261 Donec Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "229", "Wade", "Russell", "002-612-8695", "ipsum@yahoo.org", "Oct 13, 1987",         "Canada", "Guysborough", "66A 5X8", "579-6807 Tellus Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "230", "Dean", "Donovan", "064-828-4927", "dolor.elit@outlook.org", "Jan 31, 1989",         "Canada", "Cornwall", "b3C 9X8", "346-6657 Diam Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "231", "Zoe", "Morrow", "039-828-3280", "lacinia@google.com", "Oct 25, 1987",         "Canada", "Town of Yarmouth", "S1A 9G5", "Ap #672-8013 Natoque St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "232", "Elijah", "Stone", "035-145-1918", "in@yahoo.net", "Jan 24, 1988",         "Canada", "Shawinigan", "74W 5N4", "Ap #210-4430 Donec Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "233", "Griffith", "Golden", "056-674-6383", "nunc@yahoo.org", "Dec 4, 1989",         "Canada", "Municipal District", "53S 8R5", "190-7471 Dolor. Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "234", "Camilla", "Roach", "011-421-2427", "tristique.senectus@hotmail.edu", "Feb 27, 1993",         "Canada", "Brandon", "R2E 1C9", "Ap #858-5803 Praesent Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "235", "Medge", "Nieves", "044-518-5071", "ac@icloud.couk", "Jun 11, 1993",         "Canada", "Ponoka", "H7R 2T8", "561-787 Pellentesque Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "236", "Gemma", "Calderon", "049-527-1060", "in.faucibus.morbi@aol.edu", "Nov 12, 1989",         "Canada", "Champlain", "S4J 1P5", "983-9057 Integer Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "237", "Drake", "Walsh", "048-338-9721", "libero.integer@google.edu", "Jan 22, 1984",         "Canada", "Flin Flon", "f8T 7B4", "P.O. Box 511, 7500 Interdum Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "238", "Chester", "Haynes", "059-783-3104", "ut@protonmail.edu", "Sep 13, 1988",         "Canada", "Cochrane", "74M 8T1", "P.O. Box 284, 9364 Ultrices St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "239", "Melissa", "Cameron", "012-127-5563", "quisque.varius@protonmail.ca", "Feb 21, 1992",         "Canada", "Beausejour", "B0K 2P6", "Ap #147-7582 Ante St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "240", "Jada", "Porter", "074-247-8256", "condimentum.donec@aol.ca", "Sep 8, 1987",         "Canada", "North Vancouver", "R5L 6C1", "P.O. Box 557, 8889 Erat Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "241", "Xandra", "Spencer", "016-322-6574", "cursus.in@outlook.net", "Jun 22, 1989",         "Canada", "Fraser-Fort George", "P1B 8C8", "P.O. Box 848, 3751 Ante, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "242", "Neville", "Donovan", "027-122-5812", "ac@protonmail.edu", "May 21, 1988",         "Canada", "Cape Breton Island", "R8H 1V7", "326-1559 Nunc. Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "243", "Alan", "Vazquez", "084-548-5311", "sapien.gravida.non@protonmail.couk", "Jun 17, 1996",         "Canada", "Fort Good Hope", "41T 4T0", "697-3023 Donec Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "244", "Andrew", "Strong", "037-676-0570", "nulla.at@google.ca", "May 17, 1997",         "Canada", "Watson Lake", "Z1B 9R8", "P.O. Box 961, 5209 Ridiculus Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "245", "Iola", "Griffith", "081-781-2806", "magna@protonmail.couk", "May 5, 1995",         "Canada", "Penticton", "A2E 1B5", "P.O. Box 912, 8949 Quis Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "246", "Lewis", "Lynn", "061-978-2835", "consectetuer.adipiscing@outlook.edu", "Jun 13, 1979",         "Canada", "Neuville", "20N 5E1", "Ap #549-4391 Dapibus St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "247", "Olga", "Case", "083-633-4683", "turpis@yahoo.edu", "Jul 4, 1991",         "Canada", "Lions Bay", "N1J 8P7", "P.O. Box 140, 3589 Vestibulum. Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "248", "Allen", "Calhoun", "024-836-3222", "ipsum.non@outlook.ca", "Nov 1, 1987",         "Canada", "Cambridge Bay", "N7J 8S7", "Ap #698-8629 Nulla Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "249", "Rhea", "Harvey", "052-042-5654", "proin@protonmail.org", "Jul 2, 1997",         "Canada", "Weyburn", "j7L 2S9", "910-7903 Habitant Avenue");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "250", "Hilda", "Levy", "088-867-5267", "et.libero@yahoo.org", "Dec 21, 1994",         "Canada", "Baddeck", "B4R 5C5", "P.O. Box 306, 6953 At Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "251", "Zane", "Collier", "098-548-1455", "in.aliquet.lobortis@icloud.com", "Aug 25, 1980",         "Canada", "Beaconsfield", "H4Y 6Y2", "P.O. Box 309, 103 Neque Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "252", "Zephania", "Collins", "031-817-1549", "urna.vivamus@icloud.ca", "Jun 29, 1994",         "Canada", "Arviat", "Y8X 0E8", "237-5532 Donec St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "253", "Keane", "Parks", "048-303-4775", "consectetuer.adipiscing@google.edu", "Oct 2, 1986",         "Canada", "Town of Yarmouth", "T2R 4Z7", "793-2776 Ornare St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "254", "John", "Cotton", "085-253-4901", "diam@yahoo.org", "Sep 26, 1983",         "Canada", "Colwood", "53K 8S9", "Ap #324-6329 Ipsum Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "255", "Blaze", "Daniel", "087-870-8309", "felis@protonmail.org", "Oct 11, 1998",         "Canada", "Swan Hills", "Y1N 5X1", "811-6644 Id, Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "256", "Lane", "Paul", "044-254-6877", "nec.euismod@aol.edu", "Aug 10, 1983",         "Canada", "Saskatoon", "T3J 3X5", "P.O. Box 850, 1002 Purus. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "257", "Heather", "Burks", "053-588-8671", "primis.in@protonmail.com", "Oct 13, 1994",         "Canada", "Dieppe", "86W 9G5", "Ap #966-2226 Congue, Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "258", "Stone", "Robbins", "076-226-5738", "tempus.eu.ligula@google.edu", "Jun 26, 1980",         "Canada", "Caledon", "R4R 6Y3", "Ap #169-3524 Quam Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "259", "Slade", "Downs", "034-228-4880", "nunc@protonmail.net", "May 28, 1994",         "Canada", "Minitonas", "T2Y 5Z1", "Ap #219-2963 Tristique Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "260", "Grace", "Rowe", "071-756-4297", "convallis.convallis@hotmail.edu", "Mar 25, 1987",         "Canada", "Abbotsford", "Y7S 3W6", "Ap #417-5793 Tincidunt Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "261", "Violet", "Weber", "019-661-3744", "aliquet.metus@hotmail.couk", "Sep 23, 1984",         "Canada", "Ucluelet", "W4C 3H8", "102-5355 Aliquet. Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "262", "Brett", "Kirby", "076-166-2169", "auctor.nunc.nulla@outlook.org", "Dec 12, 1988",         "Canada", "Banff", "S6V 7V5", "Ap #431-3047 Adipiscing Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "263", "Ima", "Hendricks", "065-953-8795", "diam.proin@icloud.net", "Nov 6, 1990",         "Canada", "Whitehorse", "78V 0B5", "Ap #750-483 Lorem, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "264", "Keiko", "Guerra", "034-741-6314", "blandit@outlook.ca", "Dec 12, 1993",         "Canada", "Bathurst", "T7C 9N8", "Ap #243-4259 Lectus Street");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "265", "Chloe", "Keith", "022-178-1548", "arcu.eu@protonmail.org", "Jan 10, 1999",         "Canada", "Oliver", "B5T 7L6", "P.O. Box 289, 3192 Cursus St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "266", "Aiko", "Chaney", "026-660-1876", "ante.ipsum.primis@protonmail.ca", "Oct 16, 1986",         "Canada", "Vancouver", "R8S 1E1", "821-3499 Sapien. Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "267", "Ocean", "Nelson", "079-481-2745", "aenean@yahoo.com", "Dec 26, 1991",         "Canada", "Charlottetown", "85X 3P4", "Ap #732-8357 Pede, Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "268", "Clark", "Olson", "029-086-1867", "nunc@icloud.net", "Mar 15, 1987",         "Canada", "Montague", "S3Y 1W6", "1315 Est Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "269", "Haley", "Fitzpatrick", "055-871-6664", "in.aliquet@outlook.org", "Jan 10, 1996",         "Canada", "Pangnirtung", "R0Y 1E3", "P.O. Box 914, 451 Nam Rd.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "270", "Elton", "Roberson", "096-325-5107", "tristique.pharetra@google.net", "Oct 12, 1990",         "Canada", "McCallum", "R0V 4P6", "2857 Natoque Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "271", "Leandra", "Cherry", "089-285-7016", "lobortis.quis@hotmail.ca", "Sep 2, 1991",         "Canada", "Gander", "H6S 6M9", "554-9293 Sollicitudin Av.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "272", "Hedwig", "Gilbert", "064-204-8788", "sem.eget@icloud.edu", "Apr 16, 1991",         "Canada", "Tuktoyaktuk", "Q4C 3G7", "P.O. Box 496, 5145 Sapien Road");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "273", "Hilary", "Ferguson", "060-710-1604", "sapien.molestie.orci@google.edu", "Nov 3, 1981",         "Canada", "Pangnirtung", "12T 5G4", "Ap #736-4628 Cras St.");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "274", "Jameson", "Hunt", "024-732-2321", "fringilla@protonmail.com", "Jan 29, 1982",         "Canada", "Township of Minden Hills", "B6V 6N4", "224-4927 Praesent Ave");
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) VALUES (        "275", "Kenyon", "Hartman", "082-871-7248", "convallis.ante.lectus@yahoo.com", "Aug 3, 1982",         "Canada", "Richmond", "R8H 2K2", "8564 Facilisi. St.");

SET foreign_key_checks = 1;

#Un cop introduides les dades anem a tornar a canviar el nom de la columna o camp email a personal_email

Alter table user
change column email personal_email varchar(150);

show create table user;
select *
FROM user;

# I ja tindriem totes les modificacions de la base de dades realitzades.

#Ex2
/*
L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:

ID de la transacció
Nom de l'usuari/ària
Cognom de l'usuari/ària
IBAN de la targeta de crèdit usada.
Nom de la companyia de la transacció realitzada.
Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.
*/

#Procedim a crear la vista que se'ns ha demanat.

CREATE VIEW InformeTecnico AS
SELECT transaction.id as Transaccio, user.name as Nom_usuari, user.surname as Cognom_usuari, credit_card.iban, company.company_name as Companyia
FROM transaction
join user on transaction.user_id = user.id
join credit_card on transaction.credit_card_id = credit_card.id
join company on transaction.company_id = company.id
order by 1 desc;

SELECT *
FROM informetecnico;

---
select *
FROM company;

select *
FROM credit_card;

select *
FROM transaction;

select *
FROM user;
