CREATE TABLE Persona(
    Dni VARCHAR(9) CONSTRAINT Pers_PK PRIMARY KEY,
    Nombre VARCHAR(50)
);

CREATE TABLE Arbitro(
    Dni VARCHAR(9),
    NumTemporadas NUMBER(4,0),
    
    CONSTRAINT Arb_FK FOREIGN KEY(Dni) REFERENCES Persona(Dni),
    CONSTRAINT Arb_PK PRIMARY KEY(Dni)
);

CREATE TABLE Entrenador(
    Dni VARCHAR(9),
    CONSTRAINT Ent_FK FOREIGN KEY(Dni) REFERENCES Persona(Dni),
    CONSTRAINT Ent_PK PRIMARY KEY(Dni)
);


CREATE TABLE Equipo(
    Nif VARCHAR(9),
    Presupuesto INTEGER,
    Nombre VARCHAR(50),
    DniEntrenador VARCHAR(9),
    
    CONSTRAINT Eq_PK PRIMARY KEY(Nif),
    CONSTRAINT Eq_FK FOREIGN KEY(DniEntrenador) REFERENCES Entrenador(Dni)
);


CREATE TABLE Jugador(
    Dni VARCHAR(9),
    Dorsal NUMBER(2,0),
    Ficha INTEGER,
    Demarcacion VARCHAR(15),
    NifEquipo VARCHAR(9),
    
    CONSTRAINT Jug_FK FOREIGN KEY(Dni) REFERENCES Persona(Dni),
    CONSTRAINT Jug_PK PRIMARY KEY(Dni),
    CONSTRAINT Jug_FK2 FOREIGN KEY(NifEquipo) REFERENCES Equipo(Nif)
);

CREATE TABLE Partido(
    Jornada NUMBER(2,0),
    Estadio VARCHAR(25),
    DiaHora DATE,
    NifEquipoLocal VARCHAR(9),
    NifEquipoVis VARCHAR(9),
    DniArbPrincipal VARCHAR(9),
    
    CONSTRAINT Part_PK PRIMARY KEY(Jornada, Estadio),
    CONSTRAINT Part_FK FOREIGN KEY(NifEquipoLocal) REFERENCES Equipo(Nif),
    CONSTRAINT Part_FK2 FOREIGN KEY(NifEquipoVis) REFERENCES Equipo(Nif),
    CONSTRAINT Part_FK3 FOREIGN KEY(DniArbPrincipal) REFERENCES Arbitro(Dni)
);

CREATE TABLE Acta(
    idActa NUMBER(8,0),
    Jornada NUMBER(2,0),
    Estadio VARCHAR(25),
    DniArbitro VARCHAR(9),

    CONSTRAINT Act_FK2 FOREIGN KEY(DniArbitro) REFERENCES Arbitro(Dni),
    CONSTRAINT Act_PK PRIMARY KEY(idActa),
    CONSTRAINT Act_FK FOREIGN KEY(Jornada, Estadio) REFERENCES Partido(Jornada, Estadio)
);

CREATE TABLE Incidencia(
    idActa NUMBER(8,0),
    Minuto NUMBER(2,0),
    Tipo VARCHAR(14),
    Explicacion VARCHAR(50),
    
    CONSTRAINT Inc_FK FOREIGN KEY(idActa) REFERENCES Acta(idActa),
    CONSTRAINT Inc_PK PRIMARY KEY(idActa,Minuto)
);

CREATE TABLE Interviene(
    idActa NUMBER(8,0),
    Minuto NUMBER(2,0),
    DniJugador VARCHAR(9),
    Sancion VARCHAR(12),
    
    CONSTRAINT Int_FK FOREIGN KEY(idActa, Minuto) REFERENCES Incidencia(idActa, Minuto),
    CONSTRAINT Int_PK PRIMARY KEY(idActa,Minuto, DniJugador)
);

CREATE TABLE ArbitroSecundario(
    Jornada NUMBER(2,0),
    Estadio VARCHAR(25),
    DniArbitro VARCHAR(9),
    
    CONSTRAINT ArbSec_FK FOREIGN KEY (Jornada, Estadio) REFERENCES Partido(Jornada, Estadio),
    CONSTRAINT ArbSec_FK2 FOREIGN KEY (DniArbitro) REFERENCES Arbitro(Dni),
    CONSTRAINT ArbSec_PK PRIMARY KEY (Jornada, Estadio, DniArbitro)
);
/*
drop table arbitroSecundario;
drop table interviene;
drop table incidencia;
drop table jugador;
drop table acta;
drop table partido;
drop table equipo;
drop table entrenador;
drop table arbitro;
drop table persona;
*/

-- PERSONA
INSERT INTO Persona VALUES('11111111A', 'David Pérez Pallas');
INSERT INTO Persona VALUES('22222222B', 'Alexandre Alemán Pérez');
INSERT INTO Persona VALUES('33333333C', 'Moisés Mateo Montañés');
INSERT INTO Persona VALUES('44444444D', 'Adrián Díaz González');
INSERT INTO Persona VALUES('55555555E', 'Juan Manuel López Amaya');
INSERT INTO Persona VALUES('66666666F', 'Iván González González');
INSERT INTO Persona VALUES('7777777777G', 'Jorge Figueroa Vázquez');
INSERT INTO Persona VALUES('01111110A', 'Zinedine Zidane');
INSERT INTO Persona VALUES('02222221B', 'Luis Enrique Martinez García');
INSERT INTO Persona VALUES('03333332C', 'Diego Simeone');


--ARBITRO
INSERT INTO Arbitro VALUES('11111111A', 10);
INSERT INTO Arbitro VALUES('22222222B', 2);
INSERT INTO Arbitro VALUES('33333333C', 5);
INSERT INTO Arbitro VALUES('44444444D', 1);
INSERT INTO Arbitro VALUES('55555555E', 23);
INSERT INTO Arbitro VALUES('66666666F', 15);
INSERT INTO Arbitro VALUES('7777777777G', 3);


--ENTRENADOR
INSERT INTO Entrenador VALUES('01111110A');
INSERT INTO Entrenador VALUES('02222221B');
INSERT INTO Entrenador VALUES('03333332C');


--EQUIPO
INSERT INTO Equipo VALUES('B84030576', 453000000, 'Real Madrid C.F', '01111110A');
INSERT INTO Equipo VALUES('G8266298', 157000000, 'F.C Barcelona', '02222221B');
INSERT INTO Equipo VALUES('A80373764', 140000000, 'Atletico de Madrid', '03333332C');


--JUGADOR
INSERT INTO Jugador VALUES('11111110A', 7, 32000000, 'Delantero', 'B84030576');
INSERT INTO Jugador VALUES('22222221B', 19, 6760000, 'CentroCampista', 'B84030576');
INSERT INTO Jugador VALUES('33333332C', 2, 4000000, 'Defensa', 'B84030576');
INSERT INTO Jugador VALUES('44444443D', 3, 5800000, 'Defensa', 'G8266298');
INSERT INTO Jugador VALUES('55555554E', 7, 4000000, 'CentroCampista', 'G8266298');
INSERT INTO Jugador VALUES('66666665F', 19, 1000000, 'Defensa', 'A80373764');
INSERT INTO Jugador VALUES('77777779G', 1, 3500000, 'Portero', 'A80373764');

--PARTIDO
INSERT INTO Partido VALUES(14, 'Camp Nou', to_date('03-SEP-2016 04:15 PM','dd-mon-yyyy hh:mi PM'), 'G8266298', 'B84030576', '11111111A');
INSERT INTO Partido VALUES(11, 'Vicente Calderón', to_date('19-NOV-2016 8:45 PM','dd-mon-yyyy hh:mi PM'), 'A80373764', 'B84030576', '66666666F');
INSERT INTO Partido VALUES(11, 'Ramón Sánchez Pizjuan', to_date('06-NOV-2016 8:45 PM','dd-mon-yyyy hh:mi PM'), 'A55662354', 'G8266298', '33333333C');
INSERT INTO Partido VALUES(24, 'Vicente Calderón', to_date('25-FEB-2017 4:15 PM','dd-mon-yyyy hh:mi PM'), 'A80373764', 'G8266298', '33333333C');


--ACTA
INSERT INTO Acta VALUES (00000001, 14, 'Camp Nou', '11111111A');
INSERT INTO Acta VALUES (00000002, 11, 'Vicente Calderón', '66666666F');


--ARBITROSECUNDARIO
INSERT INTO ArbitroSecundario VALUES(14, 'Camp Nou', '11111111A');
INSERT INTO ArbitroSecundario VALUES(11, 'Santiago Bernabeu', '66666665F');
INSERT INTO ArbitroSecundario VALUES(24, 'Vicente Calderón', '66666655F');