#### NIVELL 1 ####

#Ex2
#Realitza la següent consulta: Has d'obtenir el nom, email i país de cada companyia, ordena les dades en funció del nom de les companyies.
SELECT company_name as Companyia, email, country as Pais
FROM transactions.company;
# Seleccionant els camps company_name, email i country de la taula company obtindrem les dades que se'ns ha demanat.

#Ex3
#Des de la secció de màrqueting et sol·liciten que els passis un llistat dels països que estan fent compres.
SELECT DISTINCT company.country as Companyia
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
ORDER BY 1;
/*Per tal d'obtenir els països on s'han realitzat compres, a l'hora de realitzar el Select utilitzem el Distinct per tal que els països 
només ens apareguin un cop i no surtin aquests repetits. Així mateix, haurem d'utilitzar un Join, ja que les dades dels països es troben a la
taula company, mentre que les dades de les vendes estan a la taula transaction.
Un cop fet el join per poder veure els diferents països que han tingut vendes els hem ordenat perquè apareguin per ordre alfabetic.
*/

#Ex4
#Des de màrqueting també volen saber des de quants països es realitzen les compres.
SELECT COUNT(DISTINCT company.country) as Total_Paisos
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id;
/*Per tal d'obtenir el nombre de països on s'han realitzat vendes, hem hagut de seleccionar el camp country de la taula company,
aplicar també un distinct, per tal que no es repeteixin els països, i un cop fet això afegir-hi un count perque ens torni el nombre total.
Igual que a la consulta anterior, necessitem el Join amb la taula transaction, ja que les vendes estan en aquesta taula.
*/

#Ex5
#El teu cap identifica un error amb la companyia que té id 'b-2354'. 
#Per tant, et sol·licita que li indiquis el país i nom de companyia d'aquest id.
SELECT company.company_name as Companyia, company.country as Pais
FROM transactions.company
WHERE company.id = "b-2354";
/*En aquest cas, la consulta a realitzar serà visualitzar els camps sol·licitats pel nostre cap company_name, coountry de la taula 
company. I afegirem un where per tal d'afegir un filtre amb el camp id per tal que només ens aparegui allò filtrat, en aquest cas
el id 'b-2354'.
*/

#Ex6
#A més, el teu cap et sol·licita que indiquis quina és la companyia amb major despesa mitjana?
SELECT company.company_name as Companyia, avg(transaction.amount) as Despesa_Mitjana
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/*Com a prèvia a partir d'aquest moment, a totes les consultes on se'ns demanin dades relatives a vendes, afegirem un filtre amb la 
clausula Where, donat que al camp boolea declined de la taula transaction totes les operacions que tenen un 1 en aquest camp no 
s'han completat i per tant, afegirem el filtre en que les operacions han de ser igual a 0.
En aquesta consulta se'ns estan demanant dos camps que estan a dues taules diferents, i per tant també haurem d'utilitzar un Join,
a més com se'ns està demanant la despesa mitjana de les companyies haurem d'utilitzar la funció avg amb el camp amount per obtenir-ho.
Altrament, com que estem utilitzant aquesta funció, haurem d'agrupar pel camp company_name, i com que necessitem que la despesa
mitjana estigui ordenada de major a menor, haurem d'ordenar pel camp de la despesa de manera descendent. 
Com que únicament necessitem l'empresa amb major despesa afegirem un limit 1, perquè només aparegui la companyia amb major despesa.
*/

#### NIVELL 2 ####

#Ex1
#El teu cap està redactant un informe de tancament de l'any i et sol·licita que li enviïs informació rellevant per al document. 
#Per a això et sol·licita verificar si en la base de dades existeixen companyies amb identificadors (id) duplicats.
SELECT count(company.id), count(distinct company.id), count(distinct company.company_name)
FROM transactions.company;
/*Per tal de realitzar aquesta consulta de verificació, seleccionarem la funció count en tres casos diferents, en primer lloc
comptarem quants ids totals té la taula, en segon lloc, en aquest comptatge del camp id afegirem la clausula distinct, per veure 
si hi ha algú codi id repetit. No hauria de ser així perquè el camp id és la Primary Key de la taula, i en darrer lloc farem un comptatge
amb la clausula distinct del camp company_name.
D'aquesta manera, podrem veure si aquest comptatge coincideix o si ens dóna un nombre diferent, si el nombre és igual vol dir que no
hi ha cap dada duplicada i que per tant tot esà correcte. En aquest cas, tots tres valors donen 100.
*/

#Ex2
#En quin dia es van realitzar les cinc vendes més costoses? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT DATE(transaction.timestamp) as Data , SUM(amount) as Total_Vendes
FROM transactions.transaction
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
/*Per tal d'obtenir els 5 dies amb major valor de vendes, haurem de sel·leccionar la visualització del camp timestamp de la taula 
transaction, però com que aquest ens mostra dia i hora, li afegirem la funció Date perquè ens aparegui en format YYYY-MM-DD i totes
les dates es puguin agrupar per dia sense que la hora sigui un element distintiu. A més, utilitzarem la funció SUM a amount per tal 
que ens sumi el total de vendes per dia.
Com ja hem comentat prèviament, agruparem per data i ordenarem pel total de vendes sumades per ordre descendent, i com que ens estan
demanat els 5 dies majors, utilitzarem un limit 5.
*/

#Ex3
#En quin dia es van realitzar les cinc vendes de menor valor? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT DATE(transaction.timestamp) as Data, SUM(amount) as Total_Vendes
FROM transactions.transaction
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2
LIMIT 5;
/*La solució d'aquesta consulta és la mateixa del exercici anterior, pero enlloc d'ordenar les vendes de manera descendent, 
cal ordenar de manera ascendent perquè el valor de vendes sigui de menor a major. Igualment limitarem a 5 resultats.
*/

#Ex4
#Quina és la mitjana de despesa per país? Presenta els resultats ordenats de major a menor mitjà.
SELECT company.country as Pais, avg(transaction.amount) as Despesa_Mitjana
FROM transactions.company
JOIN transactions.transaction
ON  company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1
ORDER BY 2 DESC;
/*En aquesta consulta haurem d'utilitzar novament el Join, perquè el camp country es troba a la taula company i el camp amount a la
taula transaction. En aquest darrer, haurem d'afegir la funció avg per obtenir la mitjana de vendes. Novament agruparem, en aquest cas
pel camp country, i ordenarem per la despesa mitjana de manera descendent.
*/

#### NIVELL 3 ####
#Ex1
/* Presenta el nom, telèfon i país de les companyies, juntament amb la quantitat total gastada, 
d'aquelles que van realitzar transaccions amb una despesa compresa entre 100 i 200 euros. 
Ordena els resultats de major a menor quantitat gastada. */
SELECT company.company_name as Companyia, company.phone as Telefon, company.country as Pais, sum(transaction.amount) as TT_Gastat
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1, 2, 3
HAVING TT_Gastat BETWEEN 100 AND 200
ORDER BY 4 DESC;
/*En aquesta consulta, haurem d'agrupar pels camps company_name, phone i country, i afegir la funció sum al camp amount de la taula
transaction. Com que les dades de vendes estan a una altra taula, caldrà afegir un Join per conectar ambdues taules.
Així mateix, com que necessitem filtrar per la despesa compresa entre 100 i 200€, afegirem un having per poder filtrar entre els valors
sumats dins aquests valors. Finalment, ordenarem pel sumatori de la despesa de manera descendent.
*/

#Ex2
#Indica el nom de les companyies que van fer compres el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022.
SELECT company.company_name as Companyia
#, DATE(timestamp)
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
#and (timestamp like '2022-03-16%' or timestamp like '2022-02-28%' or timestamp like '2022-02-13%')
and DATE(timestamp) in ('2022-03-16', '2022-02-28', '2022-02-13');
/*Per tal d'obtenir les companyies que han realitzat compres en aquestes dates, seleccionarem la visualització del camp company_name
de la taula company, al necessitar vincular-ho amb la taula transaction afegirem un Join. I filtrarem pel camp timestamp, afegint
prèviament la funció Date i hi afegirem les dates que necessitem filtrar.

*/

###

SELECT *
FROM transactions.transaction;

SELECT *
FROM transactions.company;
