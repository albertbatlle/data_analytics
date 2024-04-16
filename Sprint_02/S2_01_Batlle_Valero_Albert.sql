#### NIVELL 1 ####
USE transactions;
#Ex1
#Mostra totes les transaccions realitzades per empreses d'Alemanya.

-- Solució subquery amb WHERE:
SELECT id
FROM transaction
WHERE company_id in
	(
	SELECT id as pais
	FROM company
	WHERE country = 'Germany'
    )
;

#A continuació, afegim la mateixa consulta utilitzant un Join
SELECT transaction.id, company.country
FROM transactions.transaction
JOIN transactions.company
ON company.id = transaction.company_id
WHERE company.country = 'Germany'
#AND transaction.declined = 0
;

/* La consulta ens mostra totes les transaccions camp id de la taula transaction, i hem afegit el camp country de la taula company per 
assegurar que el país sigui Alemanya*/

#Ex2
/* Màrqueting està preparant alguns informes de tancaments de gestió, et demanen que els passis un llistat de les empreses 
que han realitzat transaccions superiors a la mitjana de totes les transaccions.
*/

-- Solució subquery amb SELECT:
SELECT DISTINCT company_name as Nom_Companyia
FROM company
WHERE id in (
	SELECT company_id
    FROM transaction
    WHERE amount > 
		(
		SELECT AVG(amount) as Mitjana
		FROM transaction
		)
	)
;

#A continuació, adjunto la solució de la consulta feta amb Join
SELECT c1.company_name, SUM(t1.amount) as TT_Compra
FROM transactions.company c1
JOIN transactions.transaction t1
ON c1.id = t1.company_id
GROUP BY 1
HAVING SUM(t1.amount) > 
(
SELECT AVG(transaction.amount) as Mitjana
FROM transactions.transaction
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
#WHERE transaction.declined = 0
;

#Ex3
/*El departament de comptabilitat va perdre la informació de les transaccions realitzades per una empresa, 
però no recorden el seu nom, només recorden que el seu nom iniciava amb la lletra c. Com els pots ajudar? 
Comenta-ho acompanyant-ho de la informació de les transaccions.
*/

-- Solució subquery amb SELECT:
SELECT id, (
	SELECT company_name
    FROM company
    WHERE transaction.company_id = company.id
    ) as Companyia
FROM transaction
WHERE company_id IN (
	SELECT id
    FROM company
    WHERE company_name LIKE 'c%'
    )
;


-- Solució subquery amb SELECT:
SELECT company.id, company.company_name as Companyia, 
	(
    SELECT transaction.id
    FROM transactions.transaction
    WHERE transaction.company_id = company.id
    LIMIT 1
    # Establim limit 1, perquè només ens retorni una operació de cada companyia que comença per c
    ) as Operacio
FROM transactions.company
WHERE company.company_name LIKE 'c%';

/*
Com que hem establert que només es mostri una operació de cada una de les companyies que comença amb la lletra c. Un cop comptabilitat
ens digui de quina companyia es tracta, li podrem fer arribar totes les operacions de l'empresa en qüestió, posem com exemple 
Cras Cosnulting.
*/

SELECT transaction.company_id, transaction.id as Transaccio,
	(
    SELECT company.company_name
    FROM transactions.company
    WHERE transaction.company_id = company.id
    ) as Nom_companyia
FROM transactions.transaction
WHERE transaction.company_id  like 'b-2514'
;

--
#Deixo la solució amb Joins a continuació.

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

-- Solució subquery amb WHERE:
SELECT *
FROM company
WHERE not exists (
	SELECT company_id
    FROM transaction
	WHERE company.id = transaction.company_id -- aquesta línia no cal
    )
;

-- Aquesta seria la solució on comprovaríem que no hi ha empreses registrades a la taula sense compres.

# Però el que si que podem observar és que hi ha compres realitzades per empreses, que no estan registrades a la taula de company. 

SELECT *
FROM transactions.transaction
WHERE not exists (
	SELECT company.id
    FROM transactions.company
    WHERE company.id = transaction.company_id
    )
;

SELECT *
FROM transactions.company
where id like 'b-9999';

-- A continuació, la solució feta amb Join.

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

-- Solució subquery amb FROM i WHERE:
SELECT transaction.id, empresa.country as Pais, empresa.company_name as Nom_empresa
FROM transaction, (
	SELECT *
    FROM company
    WHERE company.country = 
		(
		SELECT company.country
		FROM transactions.company
		WHERE company.company_name = 'Non Institute'
        )
	) as empresa
WHERE empresa.id = transaction.company_id
;

-- Solució subquery amb SELECT i WHERE:
SELECT id, company_id, (
	SELECT company_name
    FROM company
    WHERE id = transaction.company_id
    AND company.country in
		(
		SELECT country
		FROM company
		WHERE company_name = 'Non Institute'
		)
) as Companyia
from transaction
having Companyia is not null
;

-- Deixo la forma utilitzada amb Join per obtenir el mateix resultat:
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
#El departament de comptabilitat necessita que trobis l'empresa que ha realitzat la transacció de major a la base de dades.

-- Solució subquery amb FROM:
SELECT empreses.id as id_empresa, company_name as Companyia, amount as Max_Venda
FROM transaction, (
	SELECT *
    FROM company
    ) as Empreses
WHERE empreses.id = transaction.company_id
and amount = (
	SELECT max(amount)
	FROM transaction)
;

-- Solució subquery amb SELECT:
SELECT company.id as empresa_id, company.company_name as Empresa, (
	SELECT amount
    FROM transaction
    WHERE company.id = transaction.company_id
    and amount = (
		SELECT max(amount)
		FROM transaction)
    ) as Maxima_venda
FROM company
HAVING Maxima_venda is not null
ORDER BY Maxima_venda DESC
;

-- Deixo la solució realitzada amb Join:
SELECT company.company_name, max(transaction.amount) as Max_Venta
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
#WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;

/*Per obtenir l'empresa que ha tingut el valor de vendes més elevat, visualitzem el nom de la companyia mitjançant el camp
company_name de la taula company i fem el sumatori del camp amount de la taula transaction. I per tal que només ens retorni un 
resultat a posteriori de l'agrupament pel camp company_name ordenarem pel sumatori del camp amount de major a menor i afegirem
un Limit 1, perquè només ens mostri la companyia amb més vendes.
*/

#### NIVELL 3 ####

#Ex1
/*S'estan establint els objectius de l'empresa per al següent trimestre, per la qual cosa necessiten una base sòlida per a avaluar 
el rendiment i mesurar l'èxit en els diferents mercats. Per a això, necessiten el llistat dels països la mitjana de transaccions 
dels quals sigui superior a la mitjana general.
*/

-- Solució Subquery amb FROM:
SELECT company.country as Pais, ROUND(AVG(operacions.amount),2) as Mitjana_empreses
FROM company, (
	SELECT *
    FROM transaction
    ) as operacions
WHERE company.id = operacions.company_id
GROUP BY Pais
HAVING Mitjana_empreses >
	(
    SELECT AVG(transaction.amount)
	FROM transactions.transaction
    )
ORDER BY Mitjana_empreses DESC
;

-- Solució Subquery amb SELECT:
SELECT (
	SELECT company.country 
    FROM company 	
    WHERE company.id = transaction.company_id
    ) as Pais,
    ROUND(AVG(transaction.amount),2) as Mitjana_empreses
FROM transaction
GROUP BY Pais
HAVING Mitjana_empreses >
	(
    SELECT AVG(transaction.amount)
	FROM transactions.transaction
    )
ORDER BY Mitjana_empreses DESC
;

-- La solució utilitzant Join és la següent:
SELECT company.country as Pais, ROUND(AVG(transaction.amount),2) as Mitjana_Empreses
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
#WHERE transaction.declined = 0
GROUP BY 1
HAVING Mitjana_Empreses >
(
SELECT AVG(transaction.amount)
FROM transactions.transaction
#WHERE transaction.declined = 0
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

-- Solució Subquery amb FROM:
SELECT company.company_name as Empresa, COUNT(operations.id) as TT_Operacions, 
CASE WHEN count(operations.id)>=4 THEN 'Si' ELSE 'No' END as Mes_4_Operacions
FROM company,
	(
    SELECT *
    FROM transaction
    ) as operations
WHERE company.id = operations.company_id
GROUP BY Empresa
ORDER BY TT_Operacions DESC
;

-- Solució Subquery amb SELECT:
SELECT (
	SELECT company.company_name 
    FROM company
    WHERE company.id = transaction.company_id
    ) as Empresa, 
    COUNT(transaction.id) as TT_Operacions, 
CASE WHEN count(transaction.id)>=4 THEN 'Si' ELSE 'No' END as Mes_4_Operacions
FROM transaction
GROUP BY Empresa
ORDER BY TT_Operacions DESC
;


-- La solució amb Joins és la següent:
SELECT company.company_name as Empresa, COUNT(transaction.id) as TT_Operacions, 
CASE WHEN COUNT(transaction.id)>=4 THEN 'Si' ELSE 'No' END as Mes_4_Operacions
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
#WHERE transaction.declined = 0
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
