/*EJERCICIO 1*/
CREATE TABLE E_CORREDOR(
    NIF VARCHAR2(9) CONSTRAINT Corr_PK PRIMARY KEY, 
    Nombre VARCHAR2(50),
    FecNacim DATE
);

CREATE TABLE E_TIPO(
    IdTipo VARCHAR2(4),
    Descripcion VARCHAR(100),
    
    CONSTRAINT tipo_PK PRIMARY KEY(IdTipo)
);


CREATE TABLE E_CARRERA(
    IdCarrera INTEGER,
    Nombre VARCHAR2(50),
    Fecha DATE,
    Tipo VARCHAR2(4),
    
    CONSTRAINT E_CARR_PK PRIMARY KEY(IdCarrera),
    CONSTRAINT E_carr_FK FOREIGN KEY (Tipo) REFERENCES E_TIPO(IdTipo)
);


CREATE TABLE E_RESULTADO(
    NIF VARCHAR2(9),
    IdCarrera INTEGER,
    Tiempo NUMBER(2,2),
    
    CONSTRAINT result_FK FOREIGN KEY(NIF) REFERENCES E_CORREDOR(NIF),
    CONSTRAINT result_FK2 FOREIGN KEY(IdCarrera) REFERENCES E_CARRERA(IdCarrera),
    CONSTRAINT result_PK PRIMARY KEY(NIF, IdCarrera)
);

/*drop table E_Resultado cascade constraints;
drop table E_Carrera cascade constraints;
drop table E_Tipo cascade constraints;
drop table E_Corredor cascade constraints;*/
-------------------------------------------------------------------------------------------------

/*EJERCICIO 2*/

INSERT INTO HISTORICO (NIF, IdCarrera, Tiempo)
     (SELECT R1.NIF, R1.IdCarrera, R1.Tiempo
     FROM E_RESULTADO R1 JOIN E_CARRERA C1 ON R1.IdCarrera = C1.IdCarrera
     WHERE EXTRACT(YEAR FROM C1.Fecha) < 2016);


UPDATE E_RESULTADO
SET Tiempo = Tiempo * 1.15
WHERE IDCARRERA = 3 or IDCARRERA = 5;

-------------------------------------------------------------------------------------------------

/*EJERCICIO 3*/

SELECT *
FROM E_CARRERA C1
WHERE C1.Fecha BETWEEN DATE '2016-06-01' AND DATE '2016-12-31'
ORDER BY C1.Tipo, C1.Fecha DESC; 

-----------------------------------------------------------------

SELECT * 
FROM E_CORREDOR C1 JOIN E_RESULTADO R1 ON C1.NIF = R1.NIF
     JOIN E_CARRERA C2 ON C2.IDCARRERA = R1.IDCARRERA
WHERE C2.NOMBRE = 'San Lorenzo 2016' 
  AND C1.FECNACIM BETWEEN DATE '1980-01-01' AND DATE '1989-12-31';

-----------------------------------------------------------------

SELECT C1.NOMBRE, MAX(R1.TIEMPO), AVG(R1.TIEMPO)
FROM E_CORREDOR C1 JOIN E_RESULTADO R1 ON C1.NIF = R1.NIF
     JOIN E_CARRERA C2 ON C2.IDCARRERA = R1.IDCARRERA
WHERE C2.TIPO = '21K'
GROUP BY C1.NOMBRE;

-----------------------------------------------------------------

SELECT C1.NOMBRE, C1.NIF
FROM E_CORREDOR C1 JOIN E_RESULTADO R1 ON C1.NIF = R1.NIF
     JOIN E_CARRERA C2 ON C2.IDCARRERA = R1.IDCARRERA
WHERE C2.TIPO = 'Media Maratón' 
--Y no existe en la seleccion de informacion de ese tio, donde el tipo es san silvestre
  AND NOT EXISTS (SELECT *
                  FROM E_CORREDOR O2 JOIN E_RESULTADO O3 ON O2.NIF = O3.NIF
                        JOIN E_CARRERA O4 ON O4.IDCARRERA = O3.IDCARRERA
                  WHERE C1.NIF = O2.NIF 
                    AND O4.TIPO = 'San Silvestre');

