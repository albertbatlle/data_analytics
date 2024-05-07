USE ecommerce;

-- NIVELL 1

-- Ex5
 /*
 L'objectiu d'aquest exercici és crear una KPI que visualitzi la quantitat d'empreses per país que participen en les transaccions. 
 La meta empresarial és garantir que hi hagi almenys 3 empreses participants per país. 
 Per a aconseguir això, serà necessari utilitzar DAX per a calcular i representar aquesta informació de manera clara i concisa.
 */
 
 SELECT country, count(transactions.id) as Operacions
 FROM companies
 JOIN transactions
 ON transactions.company_id = companies.id
 GROUP BY country
 HAVING Operacions > 3
 ORDER BY Operacions DESC;
 
 -- Ex6
 /*
 Crea una nova KPI que permeti visualitzar la quantitat de transaccions declinades al llarg del temps. 
 L'empresa va establir un objectiu de tenir menys de 10 transaccions declinades per mes.
 */
 
 SELECT YEAR(timestamp) as Any, MONTH(timestamp) as Mes, count(id) as Total_declinat
 FROM transactions
 WHERE declined = 1
 GROUP BY Any, Mes
 ORDER BY Any DESC, Mes ASC
 ;
 
 -- Ex8
 /*
 En aquest exercici, es vol aprofundir en les transaccions realitzades per cada usuari/ària i presentar la informació de manera clara
 i comprensible. En una taula, presenta la següent informació:
Nom i cognom dels usuaris/es (caldrà crear una nova columna que combini aquesta informació).
Edat dels usuaris/es.
Mitjana de les transaccions en euros.
Mitjana de les transaccions en dòlars (conversió: 1 euro equival a 1,08 dòlars).
S'han de fer els canvis necessaris per a identificar als usuaris/es que van tenir una mitjana de 300 o més euros i 320 o més dòlars en les seves transaccions.
 */
 
SELECT concat(name," " , surname) as nom_cognom, 
timestampdiff(year, birth_date, curdate()) as edat, -- ens mostra l'edat com a null pq el tipus de data es varchar
ROUND(AVG (amount), 2) as Euro,
ROUND((AVG (amount)*1.08), 2) as Dolar
FROM users
join transactions
on transactions.user_id = users.id
GROUP BY nom_cognom, edat
HAVING Euro > 300 or Euro = 300 or Dolar > 320 or Dolar = 320
 ;

 -- NIVELL 2
 
 -- Ex1
 
 /*
 Des de l'àrea de màrqueting necessiten examinar la tendència mensual de les transaccions realitzades l'any 2021, 
 específicament, volen conèixer la variació de les transaccions en funció del mes. Recorda visualitzar la meta empresarial d'aconseguir 
 almenys 12.500 transaccions per mes. En aquest exercici, serà necessari que s'aconsegueixi identificar els mesos 
 en què no es va aconseguir la meta establerta. De ser necessari pots realitzar dues visualitzacions.
 */
 
 
  -- NIVELL 3
 
 -- Ex1
 
 /*
 La secció de màrqueting vol aprofundir en les transaccions realitzades pels usuaris i usuàries. En conseqüència, se't sol·licita 
 l'elaboració de diverses visualitzacions que incloguin:
 
o	Les mesures estadístiques claus de les variables que consideris rellevants per a comprendre les transaccions realitzades pels usuaris/es.
o	Quantitat de productes comprats per cada usuari/ària.
o	Mitjana de compres realitzades per usuari/ària, visualitza quins usuaris/es tenen una mitjana de compres superior a 150 i quins no.
o	Mostra el preu del producte més car comprat per cada usuari/ària.
o	Visualitza la distribució geogràfica dels usuaris/es.

En aquesta activitat, serà necessari que realitzis els ajustos necessaris en cada gràfic per a millorar la llegibilitat i comprensió. 
En el compliment d'aquesta tasca, s'espera que avaluïs acuradament quines variables són rellevants per a transmetre la informació 
requerida de manera efectiva.
 */
 
 SELECT name, surname, count(product_transaction.product_id) as Total_products, AVG(amount) as Mitjana_productes, 
 MAX(amount) as Max_producte, country
 FROM users
 JOIN transactions ON transactions.user_id = users.id
 JOIN product_transaction ON transactions.id = product_transaction.order_id
 GROUP BY name, surname, country
 ORDER BY Total_products DESC
 ;
 
 select *
 from product_transaction;