#### NIVELL 1 ####

#Ex1
#Mostra totes les transaccions realitzades per empreses d'Alemanya.

SELECT transaction.id, company.country
FROM transactions.transaction
JOIN transactions.company
ON company.id = transaction.company_id
WHERE company.country = 'Germany'
AND transaction.declined = 0;

/* La consulta ens mostra totes les transaccions camp id de la taula transaction, i hem afegit el camp country de la taula company per 
assegurar que el país sigui Alemanya*/

#Ex2
/*Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses 
que han realitzat transaccions per una suma superior a la mitjana de totes les transaccions.
*/

SELECT c1.company_name, SUM(t1.amount) as TT_Compra
FROM transactions.company c1
JOIN transactions.transaction t1
ON c1.id = t1.company_id
WHERE t1.declined = 0
GROUP BY 1
HAVING SUM(t1.amount) > 
(
SELECT AVG(transaction.amount) as Mitjana
FROM transactions.transaction
WHERE transaction.declined = 0
)
ORDER BY 2 DESC
;

/*Hem fet una subconsulta que ens mostra la mitjana de totes les transaccions, i a la consulta principal hem sel·leccionat
els camps company_name de la taula company i afegit una funció de suma del camp amount de la taula transaction. 
I per tal de comparar-los amb la mitjana hem afegit la subconsulta que esmentàvem abans en comparatiu a la suma del camp amount amb un 
having demanant que només mostri les operacions majors a la mitjana.
*/

SELECT AVG(transaction.amount)
FROM transactions.transaction
WHERE transaction.declined = 0
;

#Ex3
/*El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, 
però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? 
Comenta-ho acompanyant-ho de la informació de les transaccions.
*/
SELECT t1.id as Factura, c1.company_name as Empresa
FROM transactions.transaction t1
JOIN transactions.company c1
ON c1.id = t1.company_id
WHERE c1.company_name LIKE 'c%'
#AND t1.declined = 0
;

/*Per tal d'obtenir la informació que ens demana el departament de comptabilitat fem una consulta que ens mostri el camp id de la
taula transactions i el camp company_name de la taula company. I afegirem un filtre amb Where al camp company_name perquè només ens
mostri aquelles opereacions en que la companyia inici el seu nom amb c.*/

#Ex4
#Volem eliminar del sistema les empreses que no tenen transaccions registrades, lliura el llistat d'aquestes empreses.
SELECT company.id as Id_empresa, company.company_name as Empresa
FROM transactions.company
LEFT JOIN transactions.transaction
ON company.id = transaction.company_id
where transaction.company_id is null
;

/*Per tal de comprovar quines empreses no tenen operacions registrades fem un Left Join sent la taula de l'esquerre la taula company, i 
filtrem que el camp company_id de la taula transaction sigui null. Un cop fet això, podem comprovar que no hi ha empreses sense 
operaciones registrades. I tampoc hi ha operacions que tinguin el camp company_name buit.
*/

SELECT company.company_name
FROM transactions.company
WHERE 1 is null;

#### NIVELL 2 ####

#Ex1
/*En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la 
companyia Non Institute. Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan 
situades en el mateix país que aquesta companyia.
*/

SELECT transaction.id as Operacions, company.country, company.company_name
FROM transactions.transaction
JOIN transactions.company
ON company.id = transaction.company_id
WHERE company.country = 
(
SELECT company.country
FROM transactions.company
WHERE company.company_name = 'Non Institute'
)
;

/*Per tal d'obtenir el país de l'empresa Non Institute, farem una subconsulta filtrada pel nom d'aquesta companyia on el select ens 
mostri el país d'aquesta companyia. Un cop fet això, a la consulta principal afegirem un filtre amb la funció Where amb aquesta
subconsulta, i a la consulta principal visualitzarem el camp id de la taula transaction. Com a extra hem afegit els camps
country i company_name de la taula company per comprovar que les dades estan correctes.*/

#Ex2
#El departament de comptabilitat necessita que trobis l'empresa que ha realitzat la transacció de major suma en la base de dades.

SELECT company.company_name, sum(transaction.amount) as Vendes
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;

/*Per obtenir l'empresa que ha tingut el valor de vendes més elevat, visualitzem el nom de la companyia mitjançant el camp
company_name de la taula company i fem el sumatori del camp amount de la taula transaction. I per tal que només ens retorni un 
resultat a posteriori de l'agrupament pel camp company_name ordenarem pel sumatori del camp amount de major a menor i afegirem
un Limit 1, perquè només ens mostri la companyia amb més vendes.
*/

/* Estic intentant treure el resultat amb subconsulta.
SELECT company.company_name, MAX(TT_Vendes) as Max_Vendes
FROM transactions.company,
(
SELECT company.company_name, SUM(transaction.amount) as TT_Vendes
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
)sumaVendes
GROUP BY 1
;
*/

#### NIVELL 3 ####

#Ex1
/*S'estan establint els objectius de l'empresa per al següent trimestre, per la qual cosa necessiten una base sòlida per a avaluar 
el rendiment i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat dels països la mitjana de transaccions 
dels quals sigui superior a la mitjana general.
*/

SELECT company.country as Pais, AVG(transaction.amount) as Mitjana_Empreses
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
HAVING Mitjana_Empreses >
(
SELECT AVG(transaction.amount)
FROM transactions.transaction
WHERE transaction.declined = 0
)
ORDER BY 2 DESC
;

/*Per tal d'obtenir les empreses que tenen una mitja superior a la mitana global, caldrà afegir una subconsulta on es faci la mitjana
de totes les operacions. Aquesta la filtrarem amb un having, donat que al select de la consulta principal visualitzarem el camp 
country de la taula company i també la mitjana de les vendes de cada empresa. I és amb aquesta mitjana que haurem de comparar.
*/

#Ex2
/*Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, per la qual cosa 
et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, però el departament de recursos humans és 
exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.
*/

SELECT company.company_name as Empresa, COUNT(transaction.id) as TT_Operacions, 
CASE WHEN COUNT(transaction.id)>=4 THEN 'Si' ELSE 'No' END as Mes_4_Operacions
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
;

/*Per tal de visualitzar les empreses amb el total d'operacions que tenen i amb un boolea per determinar si té més de 4 operacions;
haurem de visualitzar els camps company_name de la taula company, i afegir dos counts del camp id de la taula transaction, un primer
perquè ens mostri el total d'operacions de cada empresa, i un segon en que li afegirem el condicional si és major o igual que 4.
En aquest cas, hem posat major igual, però el correcte seria preguntar si volem que les operacions iguals a 4 es comptin com a si o no.
Així mateix, perquè el boolea no es vegi en valor númeric, sinó com a si o no hem afegit una expressió CASE.
*/

###

SELECT *
FROM transactions.transaction;

SELECT *
FROM transactions.company;
