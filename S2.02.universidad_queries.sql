-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;
-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';
-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT P.apellido1, P.apellido2, P.nombre, D.nombre AS nombre_departamento FROM persona P, departamento D, profesor PR WHERE P.id = PR.id_profesor AND PR.id_departamento = D.id ORDER BY P.apellido1, P.apellido2, P.nombre;
-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT A.nombre, C.anyo_inicio, C.anyo_fin FROM asignatura A, curso_escolar C, persona P, Alumno_se_matricula_asignatura AA WHERE P.id = AA.id_alumno AND C.id = AA.id_curso_escolar AND A.id = AA.id_asignatura AND P.nif = '26902806M';
-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT D.nombre FROM departamento D, profesor P, asignatura A, grado G WHERE D.id = P.id_departamento AND G.id = A.id_grado AND A.id_profesor = P.id_profesor AND A.id_grado = 4;
-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT P.nombre FROM persona P, curso_escolar C, alumno_se_matricula_asignatura A  WHERE C.id = A.id_curso_escolar AND P.id = A.id_alumno AND A.id_curso_escolar = 5;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT D.nombre, P.apellido1, P.apellido2, P.nombre FROM departamento D, persona P RIGHT JOIN profesor PR ON PR.id_profesor = P.id WHERE PR.id_departamento = D.id ORDER BY D.nombre, P.apellido1, P.apellido2, P.nombre;
-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT P.nombre FROM departamento D, persona P RIGHT JOIN profesor PR ON PR.id_profesor = P.id WHERE PR.id_departamento = D.id AND PR.id_departamento IS NULL;
-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT D.nombre FROM departamento D LEFT JOIN profesor P ON D.id = P.id_departamento WHERE P.id_departamento IS NULL;
-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT P.nombre FROM persona P, asignatura A RIGHT JOIN profesor PR ON PR.id_profesor = A.id_profesor WHERE PR.id_profesor = P.id AND A.id_profesor IS NULL;
-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT A.nombre FROM asignatura A LEFT JOIN profesor P ON A.id_profesor = P.id_profesor WHERE A.id_profesor IS NULL;
-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT D.nombre FROM departamento D LEFT JOIN profesor P ON D.id = P.id_departamento WHERE P.id_departamento IS NULL;

-- Consultes resum:
-- Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(tipo) FROM persona WHERE tipo = 'alumno';
-- Calcula quants alumnes van néixer en 1999.
SELECT COUNT(fecha_nacimiento) FROM persona WHERE fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT D.nombre, COUNT(*) FROM departamento D RIGHT JOIN profesor P ON P.id_departamento = D.id GROUP BY D.nombre ORDER BY COUNT(*)DESC, D.nombre;
-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT D.nombre, COUNT(P.id_profesor) FROM departamento D LEFT JOIN profesor P ON D.id = P.id_departamento GROUP BY D.nombre;
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT G.nombre, COUNT(A.id_grado) FROM grado G LEFT JOIN asignatura A ON G.id = A.id_grado GROUP BY G.nombre ORDER BY COUNT(A.id_grado)DESC, G.nombre;
-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT G.nombre, COUNT(A.id_grado) FROM asignatura A LEFT JOIN grado G ON A.id_grado = G.id GROUP BY G.nombre HAVING COUNT(A.id_grado) > 40;
-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT G.nombre, A.tipo, SUM(A.creditos) FROM grado G RIGHT JOIN asignatura A ON A.id_grado = G.id GROUP BY G.nombre, A.tipo;
-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT C.anyo_inicio, COUNT(DISTINCT A.id_alumno) FROM alumno_se_matricula_asignatura A RIGHT JOIN curso_escolar C ON C.id = A.id_curso_escolar GROUP BY C.anyo_inicio;
-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT P.id, P.nombre, P.apellido1, P.apellido2, COUNT(A.id_profesor) FROM persona P, asignatura A RIGHT JOIN profesor PR ON PR.id_profesor = A.id_profesor WHERE PR.id_profesor = P.id GROUP BY P.id ORDER BY COUNT(A.id_profesor) DESC;
-- Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);
-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT P.nombre FROM persona P, asignatura A RIGHT JOIN profesor PR ON PR.id_profesor = A.id_profesor WHERE PR.id_profesor = P.id AND A.id_profesor IS NULL;