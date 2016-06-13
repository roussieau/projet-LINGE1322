SET foreign_key_checks = 0; 
DROP TABLE IF EXISTS Assureur;
DROP TABLE IF EXISTS Contrat;
DROP TABLE IF EXISTS ClasseDeTarification;
DROP TABLE IF EXISTS Modele;
DROP TABLE IF EXISTS Voiture;
DROP TABLE IF EXISTS Formule;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Remplacement;
DROP TABLE IF EXISTS TarifClient;
DROP TABLE IF EXISTS Location;



CREATE TABLE Assureur
(
    id integer NOT NULL AUTO_INCREMENT,
    nom varchar(20) NOT NULL,
    adresse varchar(40) NOT NULL,
    tel integer(12) NOT NULL,
    fax integer(12) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE(nom, adresse)
);


CREATE TABLE Contrat
(
    id integer NOT NULL AUTO_INCREMENT, 
    type varchar(10) NOT NULL,
    assureur integer NOT NULL, 
    PRIMARY KEY (id),
    FOREIGN KEY (assureur) REFERENCES Assureur(id)
);

CREATE TABLE ClasseDeTarification
(
    id integer NOT NULL AUTO_INCREMENT, 
    idContrat integer NOT NULL, 
    prixKm integer(9) NOT NULL,
    amende integer(9) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (idContrat) REFERENCES Contrat(id)
);

CREATE TABLE Modele
(
    id integer NOT NULL AUTO_INCREMENT, 
    idTarif integer NOT NULL, 
    boiteDeVitesse integer(1) NOT NULL,
    autoRadio integer(1) NOT NULL,
    portes integer(1) NOT NULL,
    climatisation integer(1) NOT NULL,
    libelle varchar(10) NOT NULL,
    marque varchar(10) NOT NULL,
    puissance integer(6) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idTarif) REFERENCES ClasseDeTarification(id)
);

CREATE TABLE Voiture
(
    numero integer NOT NULL AUTO_INCREMENT, 
    idModel integer NOT NULL, -- FK
    dateAchat date NOT NULL,
    prixAchat integer(9) NOT NULL,
    status integer(1) NOT NULL,
    retour integer(1) NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (idModel) REFERENCES Modele(id)
);


CREATE TABLE Formule
(
    id integer NOT NULL AUTO_INCREMENT, 
    Type varchar(10) NOT NULL,
    kmForfaitaire integer(6) NOT NULL,
    montant integer(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Client 
(
    numero integer NOT NULL AUTO_INCREMENT,
    nom varchar(20) NOT NULL,
    prenom varchar(20) NOT NULL,
    adresse varchar(40) NOT NULL,
    PRIMARY KEY (numero)
);

CREATE TABLE Reservation
(
    id integer NOT NULL AUTO_INCREMENT,
    numeroVoiture integer NOT NULL,
    idFormule integer NOT NULL,
    numeroClient integer NOT NULL,
    etat integer(1) NOT NULL,
    date date NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (numeroVoiture) REFERENCES Voiture(numero),
    FOREIGN KEY (iDFormule) REFERENCES Formule(id),
    FOREIGN KEY (numeroClient) REFERENCES Client(numero)
);

CREATE TABLE Remplacement 
(
    ancienne integer NOT NULL,
    nouvelle integer NOT NULL,
    FOREIGN KEY (ancienne) REFERENCES Reservation(id),
    FOREIGN KEY (nouvelle) REFERENCES Reservation(id)
);

CREATE TABLE Location
( 
    idReservation integer NOT NULL,
    startKm integer(12) NOT NULL,
    endkm integer(12) NOT NULL,
    numPermis integer(12) NOT NULL,
    caution integer(1) NOT NULL,
    date date NOT NULL,
    paye integer(1) NOT NULL,
    FOREIGN KEY (idReservation) REFERENCES Reservation(id)
);

CREATE TABLE TarifClient
(
    idTarification integer NOT NULL, 
    IDFormule integer NOT NULL, 
    montantForfaitaire integer(9) NOT NULL,
    FOREIGN KEY (idTarification) REFERENCES ClasseDeTarification(id),
    FOREIGN KEY (IDFormule) REFERENCES Formule(id)
);


