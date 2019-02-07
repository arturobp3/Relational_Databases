CREATE TABLE Persona(
    Email VARCHAR(50) CONSTRAINT pers_PK PRIMARY KEY,
    Nombre VARCHAR(50)
);

CREATE TABLE CoordinadorCentro(
    Email VARCHAR(50),
    Telf NUMBER(9,0), --Número de 9 dígitos sin decimales
    Despacho NUMBER(3,0), --Número de 3 dígitos sin decimales
    
    CONSTRAINT Coord_FK FOREIGN KEY(Email) REFERENCES Persona(Email)
);

CREATE TABLE Mentor(
    Email VARCHAR(50) CONSTRAINT Ment_PK PRIMARY KEY,
    Num_Exp INTEGER, --Número de 38 dígitos
    
     CONSTRAINT Mentor_FK FOREIGN KEY(Email) REFERENCES Persona(Email)
);

CREATE TABLE Alumno(
    Email VARCHAR(50),
    Num_Exp INTEGER,
    EmailMentor VARCHAR(50),
    
    CONSTRAINT Alumno_PK PRIMARY KEY(Email),
    CONSTRAINT Alumno_FK FOREIGN KEY(EmailMentor) REFERENCES Mentor(Email)
);

CREATE TABLE Encuesta(
    id_Enc INTEGER,
    Titulo VARCHAR(50),
    
    CONSTRAINT Enc_PK PRIMARY KEY(id_Enc)
);

CREATE TABLE Reunion(
    EmailMentor VARCHAR(50),
    Fecha_Hora DATE,
    id_Encuesta INTEGER,

    CONSTRAINT Reu_FK FOREIGN KEY(EmailMentor) REFERENCES Mentor(Email),
    CONSTRAINT Reu2_FK FOREIGN KEY (id_Encuesta) REFERENCES Encuesta(id_Enc),
    CONSTRAINT Reu_PK PRIMARY KEY(EmailMentor, Fecha_Hora)
    
);

CREATE TABLE Pregunta(
    id_Encuesta INTEGER,
    Texto VARCHAR(100),
    NumPreg INTEGER,
    
    CONSTRAINT Preg_FK FOREIGN KEY(id_Encuesta) REFERENCES Encuesta(id_Enc),
    CONSTRAINT Preg_PK PRIMARY KEY(id_Encuesta, Texto)
);

CREATE TABLE Asiste(
    EmailPersona VARCHAR(50),
    EmailMentor VARCHAR(50),
    Fecha_Hora DATE,
    
    CONSTRAINT As_FK FOREIGN KEY(EmailPersona) REFERENCES Persona(Email),
    CONSTRAINT As2_FK FOREIGN KEY(EmailMentor, Fecha_Hora) REFERENCES Reunion(EmailMentor, Fecha_Hora),
    CONSTRAINT As_PK PRIMARY KEY(EmailPersona, EmailMentor, Fecha_Hora)
);

CREATE TABLE Responden(
    EmailPersona VARCHAR(50),
    id_Encuesta INTEGER, 
    Texto VARCHAR(100),
    
    CONSTRAINT Res_FK FOREIGN KEY(EmailPersona) REFERENCES Persona(Email),
    CONSTRAINT Res2_FK FOREIGN KEY(id_Encuesta, Texto) REFERENCES Pregunta(id_Encuesta, Texto)
);
