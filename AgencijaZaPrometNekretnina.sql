CREATE DATABASE APN
GO

USE APN 
GO

/*Kreiranje tabela*/
CREATE TABLE Nekretnina
(
	NekretninaID int identity(1,1) not null,
	ProdavciID int not null,
	KategorijaID int not null,
	LokacijaID int not null,
	Adresa nvarchar(100) not null,
	Kvadratura nvarchar (10) not null,
	Cena decimal(14,4) not null,
	ProcenatOdProdaje nvarchar(5) not null
)
GO

CREATE TABLE Prodavci
( 
	ProdavciID int identity(1,1) not null,
	Ime nvarchar(50) not null,
	Prezime nvarchar(70) not null,
	JMBG char(13) not null,
	Adresa nvarchar(100) not null,
	BrojTelefona nvarchar(50) not null
)
GO

CREATE TABLE Kupci
(
	KupciID int identity(1,1) not null,
	Ime nvarchar(50) not null,
	Prezime nvarchar(70) not null,
	JMBG char(13) not null,
	BrojTelefona nvarchar(50) not null
)
GO

CREATE TABLE Kategorija
(
	KategorijaID int identity(1,1) not null,
	NazivKategorije nvarchar(100) not null
)
GO

CREATE TABLE Lokacija
(
	LokacijaID int identity(1,1) not null,
	NazivLokacije nvarchar(100) not null
)
GO

CREATE TABLE Zaposleni
(
	ZaposleniID int identity(1,1) not null,
	Ime nvarchar(50) not null,
	Prezime nvarchar(100) not null,
	JMBG nvarchar(50) not null
)
GO

CREATE TABLE AdministrativnoOsoblje
(
	ZaposleniID int not null,
	AdministrativnoOsobljeID int identity(1,1) not null,
	StrucnaSprema nvarchar(100) not null
)
GO

CREATE TABLE Agent
(
	ZaposleniID int not null,
	AgentID int identity(1,1) not null,
	SifraLicence nvarchar(100) not null
)
GO

CREATE TABLE KategorijeAgent
(
	KategorijeAgentID int identity(1,1) not null,
	KategorijaID int not null,
	ZaposleniID int not null,
	AgentID int not null,
    BrojKategorije int not null
)
GO

CREATE TABLE LokacijaAgent
(
	LokacijaAgentID int identity(1,1) not null,
	LokacijaID int not null,
	ZaposleniID int not null,
	AgentID int not null ,
               Adresa nvarchar(100) not null
)
GO

CREATE TABLE Arhiva
(
	ArhivaID int identity(1,1) not null,
	NekretninaID int not null,
	ZaposleniID int not null,
    AgentID int not null,
    DatumArhiviranja date not null
)
GO

CREATE TABLE Evidencija
(
	EvidencijaID int identity(1,1) not null,
    AgentID int not null,
	ZaposleniID int not null,
	KupciID int not null,
       NapomeneKupaca nvarchar(100) null
)
GO

CREATE TABLE Zakazivanje
(
	ZakazivanjeID int identity(1,1) not null,
	KupciID int not null,
	ZaposleniID int not null,
	AgentID int not null,
	NekretninaID int not null,
	DatumZakazivanja date not null

)
GO

CREATE TABLE Ugovori
(
	UgovoriID int identity(1,1) not null,
	ProdavciID int not null,
	NekretninaID int not null,
	KupciID int not null,
	BrojUgovora int not null,
	DatumOvere date not null
)
GO
create table Pregovara(
PregovaraID int identity(1,1) not null,
ProdavciID int  not null ,
AgentID int not null,
ZaposleniID int not null,
DatumPregovora date)
go

/*Kreiranje primarnih kljuceva*/

ALTER TABLE Nekretnina
	ADD CONSTRAINT PK_NekretninaID
	PRIMARY KEY(NekretninaID)
GO

ALTER TABLE Prodavci
	ADD CONSTRAINT PK_ProdavciID
	PRIMARY KEY(ProdavciID)
GO

ALTER TABLE Kupci
	ADD CONSTRAINT PK_KupciID
	PRIMARY KEY(KupciID)
GO

ALTER TABLE Kategorija
	ADD CONSTRAINT PK_KategorijaID
	PRIMARY KEY(KategorijaID)
GO

ALTER TABLE Lokacija
	ADD CONSTRAINT PK_LokacijaID
	PRIMARY KEY(LokacijaID)
GO

ALTER TABLE Zaposleni
	ADD CONSTRAINT PK_ZaposleniID
	PRIMARY KEY(ZaposleniID)
GO

ALTER TABLE AdministrativnoOsoblje
	ADD CONSTRAINT PK_AdministrativnoOsobljeID
	PRIMARY KEY(AdministrativnoOsobljeID,ZaposleniID)
GO

ALTER TABLE Agent
	ADD CONSTRAINT PK_AgentID
	PRIMARY KEY(AgentID,ZaposleniID)
GO

ALTER TABLE KategorijeAgent
	ADD CONSTRAINT PK_KategorijeAgentID
	PRIMARY KEY(KategorijeAgentID,KategorijaID,ZaposleniID,AgentID)
GO

ALTER TABLE LokacijaAgent
	ADD CONSTRAINT PK_LokacijaAgentID
	PRIMARY KEY(LokacijaAgentID,LokacijaID,ZaposleniID,AgentID)
GO

ALTER TABLE Arhiva
	ADD CONSTRAINT PK_ArhivaID
	PRIMARY KEY(ArhivaID,AgentID,NekretninaID,ZaposleniID)
GO

ALTER TABLE Evidencija
	ADD CONSTRAINT PK_EvidencijaID
	PRIMARY KEY(EvidencijaID,AgentID,ZaposleniID,KupciID)
GO

ALTER TABLE Zakazivanje
	ADD CONSTRAINT PK_ZakazivanjeID
	PRIMARY KEY(ZakazivanjeID,KupciID,ZaposleniID,AgentID,NekretninaID)
GO

ALTER TABLE Ugovori
	ADD CONSTRAINT PK_UgovoriID
	PRIMARY KEY(UgovoriID,ProdavciID,NekretninaID,KupciID)
	GO

	ALTER TABLE Pregovara
	ADD CONSTRAINT PK_PregovaraID
	PRIMARY KEY (PregovaraID,ProdavciID,AgentID,ZaposleniID)

/*Kreiranje stranih kljuceva*/

ALTER TABLE Nekretnina
	ADD CONSTRAINT FK_Prodavci
	FOREIGN KEY(ProdavciID)
	REFERENCES Prodavci(ProdavciID)
GO

ALTER TABLE Nekretnina
	ADD CONSTRAINT FK_Kategorija
	FOREIGN KEY(KategorijaID)
	REFERENCES Kategorija(KategorijaID)
GO

ALTER TABLE Nekretnina
	ADD CONSTRAINT FK_Lokacija
	FOREIGN KEY(LokacijaID)
	REFERENCES Lokacija(LokacijaID)
GO

ALTER TABLE AdministrativnoOsoblje
	ADD CONSTRAINT FK_ZaposleniOsoblje
	FOREIGN KEY(ZaposleniID)
	REFERENCES Zaposleni(ZaposleniID)
GO

ALTER TABLE Agent
	ADD CONSTRAINT FK_ZaposleniAgent
	FOREIGN KEY(ZaposleniID)
	REFERENCES Zaposleni(ZaposleniID)
GO

ALTER TABLE KategorijeAgent
	ADD CONSTRAINT FK_AgentKategorija
	FOREIGN KEY(KategorijaID)
	REFERENCES Kategorija(KategorijaID)
GO

ALTER TABLE KategorijeAgent
	ADD CONSTRAINT FK_KategorijaZaposleni
	FOREIGN KEY(AgentID,ZaposleniID)
	REFERENCES Agent(AgentID,ZaposleniID)
GO

ALTER TABLE LokacijaAgent
	ADD CONSTRAINT FK_AgentLokacija
	FOREIGN KEY(LokacijaID)
	REFERENCES Lokacija(LokacijaID)
GO

ALTER TABLE LokacijaAgent
	ADD CONSTRAINT FK_LokacijaZaposleni
	FOREIGN KEY(AgentID,ZaposleniID)
	REFERENCES Agent(AgentID,ZaposleniID)
GO

ALTER TABLE Arhiva
	ADD CONSTRAINT FK_Nekretnina
	FOREIGN KEY(NekretninaID)
	REFERENCES Nekretnina(NekretninaID)
GO

ALTER TABLE Arhiva
	ADD CONSTRAINT FK_Zaposleni
	FOREIGN KEY(ZaposleniID)
	REFERENCES Zaposleni(ZaposleniID)
GO

ALTER TABLE Evidencija
	ADD CONSTRAINT FK_ZaposleniEvidencija
	FOREIGN KEY(ZaposleniID)
	REFERENCES Zaposleni(ZaposleniID)
GO

ALTER TABLE Evidencija
	ADD CONSTRAINT FK_KupciEvidencija
	FOREIGN KEY(KupciID)
	REFERENCES Kupci(KupciID)
GO

ALTER TABLE Zakazivanje
	ADD CONSTRAINT FK_KupciZakazivanje
	FOREIGN KEY(KupciID)
	REFERENCES Kupci(KupciID)
GO

ALTER TABLE Zakazivanje
	ADD CONSTRAINT FK_NekretninaZakazivanje
	FOREIGN KEY(NekretninaID)
	REFERENCES Nekretnina(NekretninaID)
GO

ALTER TABLE Zakazivanje
	ADD CONSTRAINT FK_AgentZakazivanje
	FOREIGN KEY(AgentID,ZaposleniID)
	REFERENCES Agent(AgentID,ZaposleniID)
GO

ALTER TABLE Ugovori
	ADD CONSTRAINT FK_ProdavciUgovori
	FOREIGN KEY(ProdavciID)
	REFERENCES Prodavci(ProdavciID)
GO

ALTER TABLE Ugovori
	ADD CONSTRAINT FK_UgovoriKupci
	FOREIGN KEY(KupciID)
	REFERENCES Kupci(KupciID)
GO

ALTER TABLE Ugovori
	ADD CONSTRAINT FK_NekretninaUgovori
	FOREIGN KEY(NekretninaID)
	REFERENCES Nekretnina(NekretninaID)
GO
ALTER TABLE Pregovara
ADD CONSTRAINT FK_ProdavciPregovara
FOREIGN KEY (ProdavciID)
REFERENCES Prodavci(ProdavciID)

ALTER TABLE Pregovara
ADD CONSTRAINT FK_AgentPregovara
FOREIGN KEY (AgentID,ZaposleniID)
REFERENCES Agent(AgentID,ZaposleniID)


/*STORED PROCEDURE*/

/*Insert stored procedure*/
CREATE PROCEDURE ins_Nekretnina
	@ProdavciID int,
	@KategorijaID int,
	@LokacijaID int,
	@Adresa nvarchar(100),
	@Kvadratura nvarchar(10),
	@Cena decimal(14,4),
	@ProcenatOdprodaje nvarchar(5)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Nekretnina(ProdavciID,KategorijaID,LokacijaID,Adresa,Kvadratura,Cena,ProcenatOdProdaje)
	VALUES(@ProdavciID,@KategorijaID,@LokacijaID,@Adresa,@Kvadratura,@Cena,@ProcenatOdprodaje)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Prodavci
	@Ime nvarchar(50),
	@Prezime nvarchar(70),
	@JMBG char(13),
	@Adresa nvarchar(100),
	@BrojTelefona nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Prodavci(Ime,Prezime,JMBG,Adresa,BrojTelefona)
	VALUES(@Ime,@Prezime,@JMBG,@Adresa,@BrojTelefona)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Kupci
	@Ime nvarchar(50),
	@Prezime nvarchar(70),
	@JMBG char(13),
	@BrojTelefona nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Kupci(Ime,Prezime,JMBG,BrojTelefona)
	VALUES(@Ime,@Prezime,@JMBG,@BrojTelefona)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Kategorija
	@NazivKategorije nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Kategorija(NazivKategorije)
	VALUES(@NazivKategorije)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Lokacija
	@NazivLokacije nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Lokacija(NazivLokacije)
	VALUES(@NazivLokacije)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Zaposleni
	@Ime nvarchar(50),
	@Prezime nvarchar(70),
	@JMBG nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Zaposleni(Ime,Prezime,JMBG)
	VALUES(@Ime,@Prezime,@JMBG)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_AdministrativnoOsoblje
	@ZaposleniID int,
	@StrucnaSprema nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO AdministrativnoOsoblje(ZaposleniID,StrucnaSprema)
	VALUES(@ZaposleniID,@StrucnaSprema)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Agent
	@ZaposleniID int,
	@SifraLicence nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Agent(ZaposleniID,SifraLicence)
	VALUES(@ZaposleniID,@SifraLicence)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_KategorijeAgent
	@KategorijaID int,
	@ZaposleniID int,
	@AgentID int,
       @BrojKategorije int
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO KategorijeAgent(KategorijaID,ZaposleniID,AgentID,BrojKategorije)
	VALUES(@KategorijaID,@ZaposleniID,@AgentID,@BrojKategorije)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_LokacijaAgent
	@LokacijaID int,
	@ZaposleniID int,
	@AgentID int,
    @Adresa nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO LokacijaAgent(LokacijaID,ZaposleniID,AgentID,Adresa)
	VALUES(@LokacijaID,@ZaposleniID,@AgentID,@Adresa)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Arhiva
	@NekretninaID int,
	@ZaposleniID int,
       @AgentID int,
       @DatumArhiviranja date   
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Arhiva(NekretninaID,ZaposleniID,AgentID,DatumArhiviranja)
	VALUES(@NekretninaID,@ZaposleniID,@AgentID,@DatumArhiviranja)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Evidencija
    @KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NapomeneKupaca nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Evidencija (ZaposleniID,KupciID,AgentID,NapomeneKupaca)
	VALUES(@ZaposleniID,@KupciID,@AgentID,@NapomeneKupaca)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Zakazivanje
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretnineID int,
	@DatumZakazivanja date
	
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Zakazivanje(KupciID,ZaposleniID,AgentID,NekretninaID,DatumZakazivanja)
	VALUES(@KupciID,@ZaposleniID,@AgentID,@NekretnineID,@DatumZakazivanja)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE ins_Ugovori
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int,
	@BrojUgovora int,
	@DatumOvere date
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Ugovori(ProdavciID,NekretninaID,KupciID,BrojUgovora,DatumOvere)
	VALUES(@ProdavciID,@NekretninaID,@KupciID,@BrojUgovora,@DatumOvere)
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROC ins_Pregovara
    @ProdavciID int,
	@AgentID int,
	@ZaposleniID int,
	@DatumPregovora date
	AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Pregovara
	(ProdavciID,AgentID,ZaposleniID,DatumPregovora)
	VALUES
	(@ProdavciID,@AgentID,@ZaposleniID,@DatumPregovora) 
	IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

/*Update stored procedure*/
CREATE PROCEDURE upd_Nekretnina
	@NekretninaID int,
	@ProdavciID int,
	@KategorijaID int,
	@LokacijaID int,
	@Adresa nvarchar(100),
	@Kvadratura nvarchar (10),
	@Cena decimal(14,4),
	@ProcenatOdProdaje nvarchar(5)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Nekretnina
	SET
		ProdavciID=@ProdavciID,
		KategorijaID=@KategorijaID,
		LokacijaID=@LokacijaID,
		Adresa=@Adresa,
		Kvadratura=@Kvadratura,
		Cena=@Cena,
		ProcenatOdProdaje=@ProcenatOdProdaje
	WHERE
		NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Prodavci
	@ProdavciID int,
	@Ime nvarchar(50),
	@Prezime nvarchar(70),
	@JMBG char(13),
	@Adresa nvarchar(50),
	@BrojTelefona nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Prodavci
	SET
		Ime=@Ime,
		Prezime=@Prezime,
		JMBG=@JMBG,
		Adresa=@Adresa,
		BrojTelefona=@BrojTelefona
	WHERE
		ProdavciID=@ProdavciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Kupci
	@KupciID int,
	@Ime nvarchar(50),
	@Prezime nvarchar(70),
	@JMBG char(13),
	@BrojTelefona nvarchar(50)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Kupci
	SET
		Ime=@Ime,
		Prezime=@Prezime,
		JMBG=@JMBG,
		BrojTelefona=@BrojTelefona
	WHERE
		KupciID=@KupciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO


CREATE PROCEDURE upd_Kategorija
	@KategorijaID int,
	@NazivKategorije nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Kategorija
	SET
		NazivKategorije=@NazivKategorije
	WHERE
		KategorijaID=@KategorijaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Lokacija
	@LokacijaID int,
	@NazivLokacije nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Lokacija
	SET
		NazivLokacije=@NazivLokacije
	WHERE
		LokacijaID=@LokacijaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Zaposleni
	@ZaposleniID int,
	@Ime nvarchar(50),
	@Prezime nvarchar(100),
	@JMBG nvarchar(50) 
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zaposleni
	SET
		Ime=@Ime,
		Prezime=@Prezime,
		JMBG=@JMBG
	WHERE
		ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_AdministrativnoOsoblje_StrucnaSprema
	@AdministrativnoOsobljeID int,
	@ZaposleniID int,
	@StrucnaSprema nvarchar(100) 
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE AdministrativnoOsoblje
	SET
		StrucnaSprema=@StrucnaSprema
	WHERE
		AdministrativnoOsobljeID=@AdministrativnoOsobljeID AND ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_AdministrativnoOsoblje_Zaposleni
	@AdministrativnoOsobljeID int,
	@ZaposleniID int,
	@az int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE AdministrativnoOsoblje
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		AdministrativnoOsobljeID=@AdministrativnoOsobljeID AND ZaposleniID=@az
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Agent_SifraLicence
	@AgentID int,
	@ZaposleniID int,
	@SifraLicence nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Agent
	SET
		SifraLicence=@SifraLicence
	WHERE
		AgentID=@AgentID AND ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Agent_Zaposleni
	@AgentID int,
	@ZaposleniID int,
	@za int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Agent
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		AgentID=@AgentID AND ZaposleniID=@za
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_KategorijeAgent_Kategorija
	@KategorijeAgentID int,
	@KategorijaID int,
	@ZaposleniID int,
	@AgentID int,
    @BrojKategorije int,
	@kak int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE KategorijeAgent
	SET
		KategorijaID=@KategorijaID
	WHERE
		AgentID=@AgentID AND ZaposleniID=@ZaposleniID AND KategorijeAgentID=@KategorijeAgentID AND BrojKategorije=@BrojKategorije AND KategorijaID=@kak 
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_KategorijeAgent_Zaposleni
	@KategorijeAgentID int,
	@KategorijaID int,
	@ZaposleniID int,
	@AgentID int,
    @BrojKategorije int
	
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE KategorijeAgent
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		AgentID=@AgentID AND KategorijaID=@KategorijaID AND KategorijeAgentID=@KategorijeAgentID AND BrojKategorije=@BrojKategorije AND ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_KategorijeAgent_Agent
	@KategorijeAgentID int,
	@KategorijaID int,
	@ZaposleniID int,
	@AgentID int,
        @BrojKategorije int,
	@kaa int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE KategorijeAgent
	SET
		AgentID=@AgentID
	WHERE
		ZaposleniID=@ZaposleniID AND KategorijaID=@KategorijaID AND KategorijeAgentID=@KategorijeAgentID AND AgentID=@kaa
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_LokacijaAgent_Lokacija
	@LokacijaAgentID int,
	@LokacijaID int,
	@ZaposleniID int,
	@AgentID int
    
	
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE LokacijaAgent
	SET
		LokacijaID=@LokacijaID
	WHERE
		ZaposleniID=@ZaposleniID AND LokacijaAgentID=@LokacijaAgentID AND AgentID=@AgentID AND LokacijaID=@LokacijaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_LokacijaAgent_Zaposleni
	@LokacijaAgentID int,
	@LokacijaID int,
	@ZaposleniID int,
	@AgentID int,
       @Adresa nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE LokacijaAgent
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		LokacijaID=@LokacijaID AND LokacijaAgentID=@LokacijaAgentID AND AgentID=@AgentID AND Adresa=@Adresa AND ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_LokacijaAgent_Agent
	@LokacijaAgentID int,
	@LokacijaID int,
	@ZaposleniID int,
	@AgentID int,
       @Adresa nvarchar(100)
	
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE LokacijaAgent
	SET
		AgentID=@AgentID
	WHERE
		LokacijaID=@LokacijaID AND LokacijaAgentID=@LokacijaAgentID AND ZaposleniID=@ZaposleniID AND Adresa=@Adresa AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Arhiva_Zaposleni
	@ArhivaID int,
	@NekretninaID int,
	@ZaposleniID int,
       @AgentID int,
       @DatumArhiviranja date,      
	@nzz int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Arhiva
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		NekretninaID=@NekretninaID AND ArhivaID=@ArhivaID AND ZaposleniID=@nzz AND AgentID=@AgentID AND DatumArhiviranja=@DatumArhiviranja
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Arhiva_Nekretnina
	@ArhivaID int,
	@NekretninaID int,
	@ZaposleniID int,
       @AgentID int,
        @DatumArhiviranja date 

AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Arhiva
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		ZaposleniID=@ZaposleniID AND ArhivaID=@ArhivaID AND AgentID=@AgentID AND DatumArhiviranja=@DatumArhiviranja AND NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Evidencija
	@EvidencijaID int,
	@ZaposleniID int,
       @AgentID int,
	@KupciID int,
	@NapomeneKupaca nvarchar(100)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Evidencija
	SET
		NapomeneKupaca=@NapomeneKupaca
	WHERE
		EvidencijaID=@EvidencijaID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND @KupciID=@KupciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Evidencija_Zaposleni
	@EvidencijaID int,
	@ZaposleniID int,
	@KupciID int,
       @AgentID int,
	@ez int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Evidencija
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		KupciID=@KupciID AND EvidencijaID=@EvidencijaID AND AgentID=@AgentID AND ZaposleniID=@ez
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_EvidencijaKupci
	@EvidencijaID int,
	@ZaposleniID int,
	@KupciID int,
    @AgentID int

AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Evidencija
	SET
		KupciID=@KupciID
	WHERE
		ZaposleniID=@ZaposleniID AND EvidencijaID=@EvidencijaID AND AgentID=@AgentID AND KupciID=@KupciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO


CREATE PROCEDURE upd_Zakazivanje_DatZak
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretninaID int,
	@DatumZakazivanja date
	
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zakazivanje
	SET
		DatumZakazivanja=@DatumZakazivanja
	WHERE
		ZakazivanjeID=@ZakazivanjeID AND KupciID=@KupciID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Zakazivanje_Kupci
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretnineID int,
	@zk int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zakazivanje
	SET
		KupciID=@KupciID
	WHERE
		ZakazivanjeID=@ZakazivanjeID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND NekretninaID=@NekretnineID AND KupciID=@zk
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Zakazivanje_Zaposleni
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretninaID int,
	@zaz int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zakazivanje
	SET
		ZaposleniID=@ZaposleniID
	WHERE
		ZakazivanjeID=@ZakazivanjeID AND KupciID=@KupciID AND AgentID=@AgentID AND NekretninaID=@NekretninaID AND ZaposleniID=@zaz
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Zakazivanje_Agent
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretninaID int,
	@zaa int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zakazivanje
	SET
		AgentID=@AgentID
	WHERE
		ZakazivanjeID=@ZakazivanjeID AND KupciID=@KupciID AND ZaposleniID=@ZaposleniID AND NekretninaID=@NekretninaID AND AgentID=@zaa
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Zakazivanje_Nekretnina
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretninaID int,
	@zan int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Zakazivanje
	SET
		NekretninaID=@NekretninaID
	WHERE
		ZakazivanjeID=@ZakazivanjeID AND KupciID=@KupciID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND NekretninaID=@zan
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Ugovori
	@UgovoriID int,
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int,
	@BrojUgovora int,
	@DatumOvere date
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Ugovori
	SET
		DatumOvere=@DatumOvere,
		BrojUgovora=@BrojUgovora
	WHERE
		UgovoriID=@UgovoriID AND KupciID=@KupciID AND ProdavciID=@ProdavciID AND NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Ugovori_Prodavci
	@UgovoriID int,
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int,
	@up int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Ugovori
	SET
		ProdavciID=@ProdavciID
	WHERE
		KupciID=@KupciID AND UgovoriID=@UgovoriID AND NekretninaID=@NekretninaID AND ProdavciID=@up
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Ugovori_Nekretnina
	@UgovoriID int,
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int,
	@un int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Ugovori
	SET
		NekretninaID=@NekretninaID
	WHERE
		KupciID=@KupciID AND UgovoriID=@UgovoriID AND ProdavciID=@ProdavciID AND NekretninaID=@un
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Ugovori_Kupci
	@UgovoriID int,
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int,
	@uk int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Ugovori
	SET
		KupciID=@KupciID
	WHERE
		NekretninaID=@NekretninaID AND UgovoriID=@UgovoriID AND ProdavciID=@ProdavciID AND KupciID=@uk
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE upd_Pregovara

	@ProdavciID int,
	@AgentID int,
	@ZaposleniID int,
	@DatumPregovora date
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Pregovara
	SET
		DatumPregovora=@DatumPregovora
	WHERE
	  ProdavciID=@ProdavciID AND AgentID=@AgentID AND ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO
CREATE PROCEDURE upd_Pregovara_Prodavci

	@ProdavciID int,
	@AgentID int,
	@ZaposleniID int,
	@upp int
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Pregovara
	SET
		ProdavciID=@ProdavciID
	WHERE
		ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND ProdavciID=@upp

		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO 

CREATE PROC upd_PregovaraAgent
    @ProdavciID int,
	@AgentID int,
	@ZaposleniID int,
	@uap int
	AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Pregovara
	SET
		AgentID=@AgentID

		where

		ProdavciID=@ProdavciID AND ZaposleniID=@ZaposleniID AND AgentID=@uap

		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO 




/*Delete stored procedure*/
CREATE PROCEDURE del_Nekretnina
	@NekretninaID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Nekretnina
	WHERE NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Prodavci
	@ProdavciID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Prodavci
	WHERE ProdavciID=@ProdavciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Kupci
	@KupciID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Kupci
	WHERE KupciID=@KupciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Kategorija
	@KategorijaID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Kategorija
	WHERE KategorijaID=@KategorijaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Lokacija
	@LokacijaID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Lokacija
	WHERE LokacijaID=@LokacijaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Zaposleni
	@ZaposleniID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Zaposleni
	WHERE ZaposleniID=@ZaposleniID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_AdministrativnoOsoblje
	@ZaposleniID int,
	@AdministrativnoOsobljeID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE AdministrativnoOsoblje
	WHERE ZaposleniID=@ZaposleniID AND AdministrativnoOsobljeID=@AdministrativnoOsobljeID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Agent
	@ZaposleniID int,
	@AgentID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Agent
	WHERE ZaposleniID=@ZaposleniID AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_KategorijeAgent
	@KategorijeAgentID int,
	@KategorijaID int,
	@ZaposleniID int,
	@AgentID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE KategorijeAgent
	WHERE KategorijeAgentID=@KategorijeAgentID AND KategorijaID=@KategorijaID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_LokacijaAgent
	@LokacijaAgentID int,
	@LokacijaID int,
	@ZaposleniID int,
	@AgentID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE LokacijaAgent
	WHERE LokacijaAgentID=@LokacijaAgentID AND LokacijaID=@LokacijaID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO
CREATE PROCEDURE del_Arhiva
	@ArhivaID int,
	@NekretninaID int,
	@ZaposleniID int,
    @AgentID int       

AS
BEGIN
	BEGIN TRANSACTION
	DELETE Arhiva
	WHERE ArhivaID=@ArhivaID AND NekretninaID=@NekretninaID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Evidencija
	@EvidencijaID int,
	@ZaposleniID int,
	@KupciID int,
       @AgentID int

AS
BEGIN
	BEGIN TRANSACTION
	DELETE Evidencija
	WHERE EvidencijaID=@EvidencijaID AND ZaposleniID=@ZaposleniID AND KupciID=@KupciID AND AgentID=@AgentID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO
CREATE PROCEDURE del_Zakazivanje
	@ZakazivanjeID int,
	@KupciID int,
	@ZaposleniID int,
	@AgentID int,
	@NekretninaID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Zakazivanje
	WHERE ZakazivanjeID=@ZakazivanjeID AND KupciID=@KupciID AND ZaposleniID=@ZaposleniID AND AgentID=@AgentID AND NekretninaID=@NekretninaID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROCEDURE del_Ugovori
	@UgovoriID int,
	@ProdavciID int,
	@NekretninaID int,
	@KupciID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Ugovori
	WHERE UgovoriID=@UgovoriID AND ProdavciID=@ProdavciID AND NekretninaID=@NekretninaID AND KupciID=@KupciID
		IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

CREATE PROC del_Pregovara


@PregovaraID int,
@ProdavciID int,
@AgentID int,
@ZaposleniID int
AS
BEGIN
	BEGIN TRANSACTION
	DELETE Pregovara
	where
	PregovaraID=@PregovaraID AND AgentID=@AgentID AND ProdavciID=@ProdavciID AND ZaposleniID=@ZaposleniID
	IF @@ERROR<>0
			BEGIN
			ROLLBACK TRANSACTION
			END
		ELSE
			BEGIN
			COMMIT TRANSACTION
			END
END
GO

/*Insert podataka*/
EXEC ins_Zaposleni 'Andrijana','Nikolić','0607994715502'
EXEC ins_Zaposleni 'Katarina','Živanović','1208994715234'
EXEC ins_Zaposleni  'Sara', 'Horvat','2307998715345'
EXEC ins_Zaposleni 'Stefan','Živković','1202988710579'
EXEC ins_Zaposleni 'Irina','Ćuk','2310992715129'
EXEC ins_Zaposleni 'Aleksa','Ristić','2011994715205'
EXEC ins_Zaposleni 'Dušan','Pešić','1209981710456'
EXEC ins_Zaposleni 'Strahinja','Rupnjak','2304986715376'
EXEC ins_Zaposleni 'Nenad','Krstić','0303987715478'
EXEC ins_Zaposleni 'Jovana','Milanović','1112993715178'
GO

EXEC ins_Agent 1,'311-11F'
EXEC ins_Agent 2,'573-10G'
EXEC ins_Agent 3,'767-04Q'
EXEC ins_Agent 4,'124-06A'
EXEC ins_Agent 5,'363-07Z'
GO
EXEC ins_AdministrativnoOsoblje 6,'Tehnicar'
EXEC ins_AdministrativnoOsoblje 7,'Saobracajac'
EXEC ins_AdministrativnoOsoblje 8,'Projektant'
EXEC ins_AdministrativnoOsoblje 9,'Menadzer'
EXEC ins_AdministrativnoOsoblje 10,'Finansijski tehnicar'
GO

EXEC ins_Kategorija 'Jednosoban Stan'
EXEC ins_Kategorija 'Garsonjera'
EXEC ins_Kategorija 'Dvosoban stan'
EXEC ins_Kategorija 'Trosoban stan'
EXEC ins_Kategorija 'Cetvorosoban stan'
GO

EXEC ins_Lokacija 'Vukov Spomenik'
EXEC ins_Lokacija 'Obilicev Venac'
EXEC ins_Lokacija 'Slavija'
EXEC ins_Lokacija 'Mirijevo'
EXEC ins_Lokacija 'Knez Mihailova'
GO

EXEC ins_Prodavci'Nikola','Šuša','1205991123475','Srpskih Udarnih Brigada 11','011/4531-091'
EXEC ins_Prodavci'Dimitrije','Tanasković','2106992123475','Borska 16','011/9923-921'
EXEC ins_Prodavci'Jelisaveta','Butulija','2208993123475','Brace Baruh 33','011/4423-911'
EXEC ins_Prodavci'Mihajlo','Zivic','2504991123475','Bulevar Nikole Tesle 19','011/2123-291'
EXEC ins_Prodavci'Stefan','Nikic','2113994123475','Vase Pelagica 34','011/3923-171'
GO

EXEC ins_Kupci'Mila','Zdravkovic','1207956846983','065/8343-432'
EXEC ins_Kupci'Ljubica','Misovic','1207957446983','065/9313-432'
EXEC ins_Kupci'Ivan','Andric','1207958946983','065/7643-532'
EXEC ins_Kupci'Djuro','Milosevic','1207958246983','065/2563-932'
EXEC ins_Kupci'Mile','Suput','1207956746983','065/7653-832'
GO

EXEC ins_Nekretnina 1,3,4,'Bulevar AVNOJa 32','50m2',45000,'10%'
EXEC ins_Nekretnina 2,4,3,'Kosovska 12','44m2',35000,'10%'
EXEC ins_Nekretnina 4,1,2,'Njegoseva 64','35m2',30000,'10%'
EXEC ins_Nekretnina 5,5,4,'Gavrila Principa 102','70m2',69000,'10%'
EXEC ins_Nekretnina 2,3,5,'Ilije Garasanina 23','60m2',59000,'10%'
GO

EXEC ins_KategorijeAgent 1,3,3,1
EXEC ins_KategorijeAgent 2,1,1,2
EXEC ins_KategorijeAgent 4,2,2,1
EXEC ins_KategorijeAgent 3,4,4,1
EXEC ins_KategorijeAgent 5,5,5,2
GO

EXEC ins_LokacijaAgent 2,1,1,'Bogdana Zerajica'
EXEC ins_LokacijaAgent 1,2,2,'Krusedolska'
EXEC ins_LokacijaAgent 3,4,4,'Pilota Mihajla Petrovica'
EXEC ins_LokacijaAgent 5,3,3,'Vareska'
EXEC ins_LokacijaAgent 4,5,5,'Patrijarha Dimitrija'
GO

EXEC ins_Arhiva 2,1,5,'2016-7-13'
EXEC ins_Arhiva 1,6,6,'2016-6-12'
EXEC ins_Arhiva 3,2,6,'2016-5-12'
EXEC ins_Arhiva 4,5,7,'2016-6-13'
EXEC ins_Arhiva 5,7,8,'2016-4-23'
GO

EXEC ins_Zakazivanje 2,1,1,4,'2014-6-12'
EXEC ins_Zakazivanje 1,2,2,3,'2014-7-17'
EXEC ins_Zakazivanje 4,3,3,2,'2014-9-15'
EXEC ins_Zakazivanje 3,5,5,5,'2014-10-5'
EXEC ins_Zakazivanje 5,4,4,1,'2014-11-23'
GO

EXEC ins_Evidencija 3,2,5,'Terasa sa pogledom na ulicu.'
EXEC ins_Evidencija 2,1,5,'Dve terase, jedna ustakljena, dnevna soba i kuhinja spojene.'
EXEC ins_Evidencija 4,4,6,'Ustakljena terasa.'
EXEC ins_Evidencija 1,3,7,'Dnevna soba i kuhinja spojene.'
EXEC ins_Evidencija 5,5,8,'Bez hodnika, direktan ulazak u dnevnu sobu sa ulaznih vrata.'
GO

EXEC ins_Ugovori 4,1,2,'65412','2014-7-17'
EXEC ins_Ugovori 1,4,3,'1234','2014-11-23'
EXEC ins_Ugovori 2,3,4,'21905','2014-12-6'
EXEC ins_Ugovori 5,2,1,'1290','2014-8-5'
EXEC ins_Ugovori 3,5,5,'8752','2014-9-14'
GO

exec ins_Pregovara 1,1,1,'2014-7-11'
exec ins_Pregovara 2,2,2,'2014-6-12'
exec ins_Pregovara 3,3,3,'2014-5-23'
exec ins_Pregovara 4,3,3,'2014-7-15'
go 

