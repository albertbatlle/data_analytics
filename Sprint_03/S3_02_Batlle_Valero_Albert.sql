#Nivell 2
#Ex1
#Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.

SET FOREIGN_KEY_CHECKS=0;

DELETE FROM transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

SET FOREIGN_KEY_CHECKS=1;

#Ex2
/*La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. 
Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: 
Nom de la companyia. Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia. 
Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.	
*/

CREATE VIEW VistaMarketing AS 
SELECT company.company_name as Companyia, company.phone as Telefon, company.country as Pais_residencia, ROUND(AVG(amount),2) as Compra_mitjana
FROM transactions.company
JOIN transactions.transaction
ON company.id = transaction.company_id
WHERE transaction.declined = 0
GROUP BY 1,2,3
ORDER BY 4 DESC;

SELECT *
FROM vistamarketing;

#Ex3
#Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

SELECT *
FROM vistamarketing
WHERE Pais_residencia ='Germany';
