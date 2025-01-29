USE db_ab2350_questforthebest
GO


CREATE TABLE Cocktails (
	CocktailId smallint IDENTITY(1, 1)
		CONSTRAINT PK_Cocktails_CocktailId PRIMARY KEY,
	CocktailName nvarchar(100) NOT NULL,
	CocktailDescription nvarchar(1000) NOT NULL,
	DateOfQuest date NULL
);

INSERT INTO Cocktails (CocktailName, CocktailDescription, DateOfQuest)
VALUES ('Margarita', 'A vibrant Mexican cocktail. Discover how to make the perfect Margarita.', '05/19/2023')
		,('Moscow Mule', 'A refreshing, spicy, and tangy classic. Discover how to make the perfect Moscow Mule.', '10/06/2023')
		,('Mai Tai', 'A classic refreshing cocktail. Learn how to craft the perfect Mai Tai.', '01/19/2024')
		,('Whiskey Sour', 'A balanced, sweet, and sour cocktail. Learn about the Whiskey Sour.', '04/05/2024')
		,('Manhattan', 'The sophisticated classic from New York City. Learn more about its history and how to make it.', '10/01/2024')
		,('Hot Toddy', 'Warm, soothing, and perfectly spiced. Learn more about this cozy classic.', '02/07/2025');

CREATE TABLE Questers (
	QuesterId smallint IDENTITY(1, 1)
		CONSTRAINT PK_Questers_QuesterId PRIMARY KEY,
	QuesterName nvarchar(100) NOT NULL,
	QuesterNickname nvarchar(100) NULL
);

INSERT INTO Questers (QuesterName, QuesterNickname) 
VALUES ('Christian Armstrong', 'Christ')
		,('Jahrel Balon', 'JB')
		,('Tim Busacker', 'Timbo')
		,('James Witt', 'Jimbo')
		,('Peter Cadero-Smith', 'Pete')
		,('Eric Grimsted', 'Eric')
		,('Stephanie Herrera', 'Stephano')
		,('Jose Mejia', 'Jose')
		,('Angela Noyen', 'Angela')
		,('Kriston Trevino', 'Kriston')
		,('Robert Shields', 'Bobby')
		,('Collin Savunen', 'Collin')
		,('Shawn', NULL)
		,('Autumn Lavender', 'Autumn')
		,('Lindsey', NULL)
		,('Kelsey Bonnicksen', NULL)
		,('Kat Griffin', 'Kat')
		,('Sarah Harlan', 'Sarah')
		,('Bonnie Witt', 'Bonbo')
		,('Kylea Johnson', 'Kylea')
		,('Christian Rowe', 'C3P-Rowe')
		,('Clayton Tupper', 'Tupperware')
		,('Stephanie', '')
		,('George Tanasse', 'Georgous')
		,('Kaliene', NULL);

CREATE TABLE Bars (
	BarId smallint IDENTITY(1, 1)
		CONSTRAINT PK_Bars_BarId PRIMARY KEY,
    BarName	nvarchar(100)
);

INSERT INTO Bars (BarName) VALUES
	('Koko''s'),
	('Equal Latin'),
	('Dos Hermanos'),
	('Filibuster'),
	('La Esquinita'),
	('Well 80'),
	('Cryptatropa'),
	('Le Voyeur'),
	('Cheeky Martini'),
	('The Spar'),
	('The Mark'),
	('Cove'),
	('Cynara'),
	('Shiny Prize'),
	('Christ-Jim Experience'),
	('Uptown Grill'),
	('Pig Bar'),
	('Legends');

CREATE TABLE Scores (
	CocktailId smallint NOT NULL
		CONSTRAINT FK_Scores_CocktailId_Cocktails_CocktailId FOREIGN KEY REFERENCES Cocktails(CocktailId),
	QuesterId smallint NOT NULL
		CONSTRAINT FK_Scores_QuesterId_Questers_QuesterId FOREIGN KEY REFERENCES Questers(QuesterId),
	BarId smallint NOT NULL
		CONSTRAINT FK_Scores_BarId_Bars_BarId FOREIGN KEY REFERENCES Bars(BarId),
	Score decimal(4, 2) NOT NULL
)

-- CocktailIds
DECLARE @Margarita smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Margarita');
DECLARE @MoscowMule smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Moscow Mule');
DECLARE @MaiTai smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Mai Tai');
DECLARE @WhiskeySour smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Whiskey Sour');
DECLARE @Manhattan smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Manhattan');

-- QuesterIds
DECLARE @Me smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Christian Armstrong');
DECLARE @JahrelBalon smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Jahrel Balon');
DECLARE @TimBusacker smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Tim Busacker');
DECLARE @JamesWitt smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'James Witt');
DECLARE @PeterCaderoSmith smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Peter Cadero-Smith');
DECLARE @EricGrimsted smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Eric Grimsted');
DECLARE @StephanieHerrera smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Stephanie Herrera');
DECLARE @JoseMejia smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Jose Mejia');
DECLARE @AngelaNoyen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Angela Noyen');
DECLARE @KristonTrevino smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kriston Trevino');
DECLARE @RobertShields smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Robert Shields');
DECLARE @CollinSavunen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Collin Savunen');
DECLARE @Shawn smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Shawn');
DECLARE @AutumnLavender smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Autumn Lavender');
DECLARE @Lindsey smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Lindsey');
DECLARE @KelseyBonnicksen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kelsey Bonnicksen');
DECLARE @KatGriffin smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kat Griffin');
DECLARE @SarahHarlan smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Sarah Harlan');
DECLARE @BonnieWitt smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Bonnie Witt');
DECLARE @KyleaJohnson smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kylea Johnson');
DECLARE @ChristianRowe smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Christian Rowe');
DECLARE @ClaytonTupper smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Clayton Tupper');
DECLARE @Stephanie smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Stephanie');
DECLARE @GeorgeTanasse smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'George Tanasse');
DECLARE @Kaliene smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kaliene');

-- BarIds
DECLARE @Kokos smallint = (SELECT BarId FROM Bars WHERE BarName = 'Koko''s');
DECLARE @EqualLatin smallint = (SELECT BarId FROM Bars WHERE BarName = 'Equal Latin');
DECLARE @DosHermanos smallint = (SELECT BarId FROM Bars WHERE BarName = 'Dos Hermanos');
DECLARE @Filibuster smallint = (SELECT BarId FROM Bars WHERE BarName = 'Filibuster');
DECLARE @LaEsquinita smallint = (SELECT BarId FROM Bars WHERE BarName = 'La Esquinita');
DECLARE @Well80 smallint = (SELECT BarId FROM Bars WHERE BarName = 'Well 80');
DECLARE @Cryptatropa smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cryptatropa');
DECLARE @LeVoyeur smallint = (SELECT BarId FROM Bars WHERE BarName = 'Le Voyeur');
DECLARE @CheekyMartini smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cheeky Martini');
DECLARE @TheSpar smallint = (SELECT BarId FROM Bars WHERE BarName = 'The Spar');
DECLARE @TheMark smallint = (SELECT BarId FROM Bars WHERE BarName = 'The Mark');
DECLARE @Cove smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cove');
DECLARE @Cynara smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cynara');
DECLARE @ShinyPrize smallint = (SELECT BarId FROM Bars WHERE BarName = 'Shiny Prize');
DECLARE @ChristJimExperience smallint = (SELECT BarId FROM Bars WHERE BarName = 'Christ-Jim Experience');
DECLARE @UptownGrill smallint = (SELECT BarId FROM Bars WHERE BarName = 'Uptown Grill');
DECLARE @PigBar smallint = (SELECT BarId FROM Bars WHERE BarName = 'Pig Bar');
DECLARE @Legends smallint = (SELECT BarId FROM Bars WHERE BarName = 'Legends');

--,(@Margarita, @, @, 0)
-- Margarita Scores
INSERT INTO Scores (CocktailId, BarId, QuesterId, Score)
VALUES --,(@Margarita, @, @, 0)
		(@Margarita, @Kokos, @JamesWitt, 7)
		,(@Margarita, @Kokos, @TimBusacker, 8)
		,(@Margarita, @Kokos, @JoseMejia, 6.5)
		,(@Margarita, @Kokos, @StephanieHerrera, 7.5)
		,(@Margarita, @Kokos, @AngelaNoyen, 7.5)
		,(@Margarita, @Kokos, @EricGrimsted, 8)
		,(@Margarita, @EqualLatin, @JamesWitt, 7)
		,(@Margarita, @EqualLatin, @TimBusacker, 8.5)
		,(@Margarita, @EqualLatin, @JoseMejia, 7.3)
		,(@Margarita, @EqualLatin, @StephanieHerrera, 8)
		,(@Margarita, @EqualLatin, @AngelaNoyen, 9.5)
		,(@Margarita, @EqualLatin, @EricGrimsted, 8.5)
		,(@Margarita, @EqualLatin, @KristonTrevino, 4)
		,(@Margarita, @DosHermanos, @JamesWitt, 8)
		,(@Margarita, @DosHermanos, @TimBusacker, 9)
		,(@Margarita, @DosHermanos, @JoseMejia, 7.9)
		,(@Margarita, @DosHermanos, @StephanieHerrera, 8.5)
		,(@Margarita, @DosHermanos, @AngelaNoyen, 8.5)
		,(@Margarita, @DosHermanos, @EricGrimsted, 8.75)
		,(@Margarita, @DosHermanos, @KristonTrevino, 8)
		,(@Margarita, @Filibuster, @JamesWitt, 6)
		,(@Margarita, @Filibuster, @TimBusacker, 7)
		,(@Margarita, @Filibuster, @JoseMejia, 6)
		,(@Margarita, @Filibuster, @StephanieHerrera, 6.5)
		,(@Margarita, @Filibuster, @KristonTrevino, 5)
		,(@Margarita, @Filibuster, @PeterCaderoSmith, 4)
		,(@Margarita, @LaEsquinita, @JamesWitt, 6.5)
		,(@Margarita, @LaEsquinita, @TimBusacker, 7.5)
		,(@Margarita, @LaEsquinita, @JoseMejia, 7.2)
		,(@Margarita, @LaEsquinita, @StephanieHerrera, 7)
		,(@Margarita, @LaEsquinita, @EricGrimsted, 6.2)
		--,(@MoscowMule, @, @, 0)
		,(@MoscowMule, @Well80, @TimBusacker, 5.7)
		,(@MoscowMule, @Well80, @JamesWitt, 6)
		,(@MoscowMule, @Well80, @JahrelBalon, 5)
		,(@MoscowMule, @Well80, @Me, 6)
		,(@MoscowMule, @Well80, @EricGrimsted, 6.5)
		,(@MoscowMule, @Well80, @JoseMejia, 6.2)
		,(@MoscowMule, @Well80, @KristonTrevino, 5)
		,(@MoscowMule, @Well80, @StephanieHerrera, 7)
		,(@MoscowMule, @Well80, @RobertShields, 6)
		,(@MoscowMule, @Well80, @PeterCaderoSmith, 7.2)
		,(@MoscowMule, @Well80, @CollinSavunen, 5)
		,(@MoscowMule, @Well80, @Shawn, 7.5)
		,(@MoscowMule, @Well80, @AutumnLavender, 8)
		,(@MoscowMule, @Cryptatropa, @TimBusacker, 7.8)
		,(@MoscowMule, @Cryptatropa, @JamesWitt, 8)
		,(@MoscowMule, @Cryptatropa, @JahrelBalon, 7)
		,(@MoscowMule, @Cryptatropa, @Me, 7.7)
		,(@MoscowMule, @Cryptatropa, @EricGrimsted, 7)
		,(@MoscowMule, @Cryptatropa, @JoseMejia, 7.6)
		,(@MoscowMule, @Cryptatropa, @KristonTrevino, 7.5)
		,(@MoscowMule, @Cryptatropa, @RobertShields, 7)
		,(@MoscowMule, @Cryptatropa, @PeterCaderoSmith, 8.7)
		,(@MoscowMule, @Cryptatropa, @CollinSavunen, 8)
		,(@MoscowMule, @Cryptatropa, @Lindsey, 8.5)
		,(@MoscowMule, @LeVoyeur, @TimBusacker, 4)
		,(@MoscowMule, @LeVoyeur, @JamesWitt, 4)
		,(@MoscowMule, @LeVoyeur, @JahrelBalon, 4)
		,(@MoscowMule, @LeVoyeur, @Me, 4)
		,(@MoscowMule, @LeVoyeur, @EricGrimsted, 5)
		,(@MoscowMule, @LeVoyeur, @JoseMejia, 5.2)
		,(@MoscowMule, @LeVoyeur, @KristonTrevino, 0)
		,(@MoscowMule, @LeVoyeur, @RobertShields, 5)
		,(@MoscowMule, @LeVoyeur, @PeterCaderoSmith, 1.2)
		,(@MoscowMule, @LeVoyeur, @CollinSavunen, 4)
		,(@MoscowMule, @CheekyMartini, @TimBusacker, 6.9)
		,(@MoscowMule, @CheekyMartini, @JamesWitt, 7)
		,(@MoscowMule, @CheekyMartini, @JahrelBalon, 7.5)
		,(@MoscowMule, @CheekyMartini, @Me, 6.9)
		,(@MoscowMule, @CheekyMartini, @EricGrimsted, 7.6)
		,(@MoscowMule, @CheekyMartini, @JoseMejia, 6.3)
		,(@MoscowMule, @CheekyMartini, @KristonTrevino, 7)
		,(@MoscowMule, @CheekyMartini, @RobertShields, 8)
		,(@MoscowMule, @CheekyMartini, @PeterCaderoSmith, 6.9)
		,(@MoscowMule, @CheekyMartini, @CollinSavunen, 7.5)
		,(@MoscowMule, @TheSpar, @TimBusacker, 3.1)
		,(@MoscowMule, @TheSpar, @JamesWitt, 5)
		,(@MoscowMule, @TheSpar, @EricGrimsted, 6)
		,(@MoscowMule, @TheSpar, @JoseMejia, 0)
		,(@MoscowMule, @TheSpar, @KristonTrevino, 1)
		,(@MoscowMule, @TheSpar, @RobertShields, 4)
		,(@MoscowMule, @TheSpar, @PeterCaderoSmith, 0.9)
		,(@MoscowMule, @TheSpar, @CollinSavunen, 6)
		,(@MoscowMule, @TheMark, @TimBusacker, 6)
		,(@MoscowMule, @TheMark, @JamesWitt, 6)
		,(@MoscowMule, @TheMark, @EricGrimsted, 7.7)
		,(@MoscowMule, @TheMark, @JoseMejia, 6.8)
		,(@MoscowMule, @TheMark, @KristonTrevino, 6.5)
		,(@MoscowMule, @TheMark, @RobertShields, 7)
		,(@MoscowMule, @TheMark, @PeterCaderoSmith, 6.7)
		,(@MoscowMule, @TheMark, @CollinSavunen, 6.2)
		,(@MoscowMule, @Cove, @TimBusacker, 6.1)
		,(@MoscowMule, @Cove, @JamesWitt, 5)
		,(@MoscowMule, @Cove, @EricGrimsted, 6.5)
		,(@MoscowMule, @Cove, @RobertShields, 7)
		,(@MoscowMule, @Cove, @PeterCaderoSmith, 6.4)
		,(@MoscowMule, @Cove, @CollinSavunen, 6.5)
		--,(@MaiTai, @, @, 0)
		,(@MaiTai, @Cynara, @TimBusacker, 7.9)
		,(@MaiTai, @Cynara, @JahrelBalon, 7)
		,(@MaiTai, @Cynara, @Me, 8)
		,(@MaiTai, @Cynara, @EricGrimsted, 7.75)
		,(@MaiTai, @Cynara, @PeterCaderoSmith, 8)
		,(@MaiTai, @Cynara, @KelseyBonnicksen, 7.8)
		,(@MaiTai, @Cynara, @AngelaNoyen, 7)
		,(@MaiTai, @Cove, @TimBusacker, 5.1)
		,(@MaiTai, @Cove, @JamesWitt, 6.5)
		,(@MaiTai, @Cove, @JahrelBalon, 6)
		,(@MaiTai, @Cove, @Me, 5)
		,(@MaiTai, @Cove, @EricGrimsted, 6.75)
		,(@MaiTai, @Cove, @PeterCaderoSmith, 5.8)
		,(@MaiTai, @Cove, @KristonTrevino, 4)
		,(@MaiTai, @Cove, @KelseyBonnicksen, 6)
		,(@MaiTai, @Cove, @AngelaNoyen, 6)
		,(@MaiTai, @TheMark, @TimBusacker, 6.1)
		,(@MaiTai, @TheMark, @JamesWitt, 5.5)
		,(@MaiTai, @TheMark, @JahrelBalon, 6.5)
		,(@MaiTai, @TheMark, @Me, 3)
		,(@MaiTai, @TheMark, @EricGrimsted, 6)
		,(@MaiTai, @TheMark, @PeterCaderoSmith, 5.8)
		,(@MaiTai, @TheMark, @KristonTrevino, 4)
		,(@MaiTai, @TheMark, @KelseyBonnicksen, 4.5)
		,(@MaiTai, @CheekyMartini, @TimBusacker, 8.1)
		,(@MaiTai, @CheekyMartini, @JamesWitt, 7)
		,(@MaiTai, @CheekyMartini, @JahrelBalon, 8)
		,(@MaiTai, @CheekyMartini, @Me, 8.3)
		,(@MaiTai, @CheekyMartini, @EricGrimsted, 3)
		,(@MaiTai, @CheekyMartini, @PeterCaderoSmith, 8.4)
		,(@MaiTai, @CheekyMartini, @KristonTrevino, 5)
		,(@MaiTai, @CheekyMartini, @KelseyBonnicksen, 2)
		,(@MaiTai, @ShinyPrize, @TimBusacker, 7.4)
		,(@MaiTai, @ShinyPrize, @JamesWitt, 8)
		,(@MaiTai, @ShinyPrize, @JahrelBalon, 7.5)
		,(@MaiTai, @ShinyPrize, @Me, 8.5)
		,(@MaiTai, @ShinyPrize, @EricGrimsted, 7.9)
		,(@MaiTai, @ShinyPrize, @PeterCaderoSmith, 8.5)
		,(@MaiTai, @ShinyPrize, @KristonTrevino, 7)
		,(@MaiTai, @ShinyPrize, @KelseyBonnicksen, 8.8)
		,(@MaiTai, @Cryptatropa, @TimBusacker, 7.6)
		,(@MaiTai, @Cryptatropa, @JamesWitt, 6.5)
		,(@MaiTai, @Cryptatropa, @JahrelBalon, 8)
		,(@MaiTai, @Cryptatropa, @Me, 6)
		,(@MaiTai, @Cryptatropa, @EricGrimsted, 8.25)
		,(@MaiTai, @Cryptatropa, @PeterCaderoSmith, 8.5)
		,(@MaiTai, @Cryptatropa, @KristonTrevino, 6)
		,(@MaiTai, @Cryptatropa, @KelseyBonnicksen, 9.1)
		,(@MaiTai, @Well80, @TimBusacker, 5)
		,(@MaiTai, @Well80, @JamesWitt, 4)
		,(@MaiTai, @Well80, @Me, 4)
		,(@MaiTai, @Well80, @EricGrimsted, 5)
		,(@MaiTai, @Well80, @KelseyBonnicksen, 4.5)
		--,(@WhiskeySour, @, @, 0)
		,(@WhiskeySour, @ChristJimExperience, @TimBusacker, 7.6)
		,(@WhiskeySour, @ChristJimExperience, @JamesWitt, 7.2)
		,(@WhiskeySour, @ChristJimExperience, @JahrelBalon, 7)
		,(@WhiskeySour, @ChristJimExperience, @Me, 7.7)
		,(@WhiskeySour, @ChristJimExperience, @EricGrimsted, 8.1)
		,(@WhiskeySour, @ChristJimExperience, @KristonTrevino, 7)
		,(@WhiskeySour, @ChristJimExperience, @KatGriffin, 5)
		,(@WhiskeySour, @ChristJimExperience, @SarahHarlan, 6)
		,(@WhiskeySour, @ChristJimExperience, @JoseMejia, 7.2)
		,(@WhiskeySour, @ChristJimExperience, @BonnieWitt, 6)
		,(@WhiskeySour, @UptownGrill, @TimBusacker, 7)
		,(@WhiskeySour, @UptownGrill, @JamesWitt, 6.32)
		,(@WhiskeySour, @UptownGrill, @JahrelBalon, 6)
		,(@WhiskeySour, @UptownGrill, @Me, 6)
		,(@WhiskeySour, @UptownGrill, @EricGrimsted, 7)
		,(@WhiskeySour, @UptownGrill, @KristonTrevino, 6)
		,(@WhiskeySour, @UptownGrill, @KatGriffin, 6.5)
		,(@WhiskeySour, @UptownGrill, @SarahHarlan, 7)
		,(@WhiskeySour, @UptownGrill, @JoseMejia, 6.5)
		,(@WhiskeySour, @CheekyMartini, @TimBusacker, 8)
		,(@WhiskeySour, @CheekyMartini, @JamesWitt, 7.9)
		,(@WhiskeySour, @CheekyMartini, @JahrelBalon, 7.5)
		,(@WhiskeySour, @CheekyMartini, @Me, 7.2)
		,(@WhiskeySour, @CheekyMartini, @EricGrimsted, 6.5)
		,(@WhiskeySour, @CheekyMartini, @KristonTrevino, 7.5)
		,(@WhiskeySour, @CheekyMartini, @SarahHarlan, 4)
		,(@WhiskeySour, @CheekyMartini, @JoseMejia, 7.9)
		,(@WhiskeySour, @Filibuster, @TimBusacker, 7.2)
		,(@WhiskeySour, @Filibuster, @JamesWitt, 6.2)
		,(@WhiskeySour, @Filibuster, @JahrelBalon, 7)
		,(@WhiskeySour, @Filibuster, @Me, 7)
		,(@WhiskeySour, @Filibuster, @EricGrimsted, 7)
		,(@WhiskeySour, @Filibuster, @KristonTrevino, 6.5)
		,(@WhiskeySour, @Filibuster, @SarahHarlan, 7.8)
		,(@WhiskeySour, @Filibuster, @JoseMejia, 6.2)
		,(@WhiskeySour, @Cryptatropa, @TimBusacker, 5.5)
		,(@WhiskeySour, @Cryptatropa, @JamesWitt, 4)
		,(@WhiskeySour, @Cryptatropa, @JahrelBalon, 5.5)
		,(@WhiskeySour, @Cryptatropa, @Me, 3)
		,(@WhiskeySour, @Cryptatropa, @EricGrimsted, 5.8)
		,(@WhiskeySour, @Cryptatropa, @KristonTrevino, 6)
		,(@WhiskeySour, @Cryptatropa, @SarahHarlan, 5)
		,(@WhiskeySour, @Cryptatropa, @JoseMejia, 5.3)
		,(@WhiskeySour, @ShinyPrize, @TimBusacker, 8.5)
		,(@WhiskeySour, @ShinyPrize, @JamesWitt, 8.2)
		,(@WhiskeySour, @ShinyPrize, @JahrelBalon, 8)
		,(@WhiskeySour, @ShinyPrize, @Me, 8.6)
		,(@WhiskeySour, @ShinyPrize, @EricGrimsted, 8.2)
		,(@WhiskeySour, @ShinyPrize, @JoseMejia, 8.2)
		,(@WhiskeySour, @Cove, @TimBusacker, 4)
		,(@WhiskeySour, @Cove, @JamesWitt, 3)
		,(@WhiskeySour, @Cove, @Me, 2.1)
		,(@WhiskeySour, @Cove, @EricGrimsted, 3)
		,(@WhiskeySour, @Cove, @KristonTrevino, 5)
		,(@WhiskeySour, @Cove, @JoseMejia, 2.05)
		--,(@Manhattan, @, @, 0)
		,(@Manhattan, @ShinyPrize, @TimBusacker, 9)
		,(@Manhattan, @ShinyPrize, @JamesWitt, 8)
		,(@Manhattan, @ShinyPrize, @BonnieWitt, 8.8)
		,(@Manhattan, @ShinyPrize, @KelseyBonnicksen, 6.5)
		,(@Manhattan, @ShinyPrize, @EricGrimsted, 8)
		,(@Manhattan, @ShinyPrize, @KristonTrevino, 8.5)
		,(@Manhattan, @ShinyPrize, @Stephanie, 7.5)
		,(@Manhattan, @ShinyPrize, @ChristianRowe, 8.3)
		,(@Manhattan, @ShinyPrize, @ClaytonTupper, 8)
		,(@Manhattan, @ShinyPrize, @GeorgeTanasse, 9)
		,(@Manhattan, @ShinyPrize, @PeterCaderoSmith, 9.4)
		,(@Manhattan, @ShinyPrize, @CollinSavunen, 8)
		,(@Manhattan, @ShinyPrize, @Me, 9)
		,(@Manhattan, @ShinyPrize, @JahrelBalon, 6)
		,(@Manhattan, @ShinyPrize, @Kaliene, 8.5)
		,(@Manhattan, @PigBar, @TimBusacker, 5)
		,(@Manhattan, @PigBar, @JamesWitt, 5.5)
		,(@Manhattan, @PigBar, @BonnieWitt, 6)
		,(@Manhattan, @PigBar, @EricGrimsted, 5.2)
		,(@Manhattan, @PigBar, @KristonTrevino, 4)
		,(@Manhattan, @PigBar, @Stephanie, 3.5)
		,(@Manhattan, @PigBar, @KyleaJohnson, 4.3)
		,(@Manhattan, @PigBar, @ChristianRowe, 4.9)
		,(@Manhattan, @PigBar, @ClaytonTupper, 4)
		,(@Manhattan, @PigBar, @GeorgeTanasse, 3)
		,(@Manhattan, @PigBar, @PeterCaderoSmith, 4)
		,(@Manhattan, @PigBar, @CollinSavunen, 5)
		,(@Manhattan, @PigBar, @Me, 2)
		,(@Manhattan, @PigBar, @JahrelBalon, 2)
		,(@Manhattan, @PigBar, @Kaliene, 3.5)
		,(@Manhattan, @Cryptatropa, @TimBusacker, 6.1)
		,(@Manhattan, @Cryptatropa, @JamesWitt, 4)
		,(@Manhattan, @Cryptatropa, @BonnieWitt, 2)
		,(@Manhattan, @Cryptatropa, @KelseyBonnicksen, 7.6)
		,(@Manhattan, @Cryptatropa, @EricGrimsted, 5)
		,(@Manhattan, @Cryptatropa, @KristonTrevino, 5.5)
		,(@Manhattan, @Cryptatropa, @Stephanie, 6.1)
		,(@Manhattan, @Cryptatropa, @KyleaJohnson, 6)
		,(@Manhattan, @Cryptatropa, @ChristianRowe, 6.6)
		,(@Manhattan, @Cryptatropa, @ClaytonTupper, 6)
		,(@Manhattan, @Cryptatropa, @GeorgeTanasse, 4)
		,(@Manhattan, @Cryptatropa, @PeterCaderoSmith, 7.5)
		,(@Manhattan, @Cryptatropa, @CollinSavunen, 6.5)
		,(@Manhattan, @Cryptatropa, @Me, 5.2)
		,(@Manhattan, @Cryptatropa, @JahrelBalon, 4)
		,(@Manhattan, @Cryptatropa, @Lindsey, 2.1)
		,(@Manhattan, @Cryptatropa, @Kaliene, 3.5)
		,(@Manhattan, @Cove, @TimBusacker, 5.9)
		,(@Manhattan, @Cove, @JamesWitt, 5)
		,(@Manhattan, @Cove, @BonnieWitt, 6.5)
		,(@Manhattan, @Cove, @KelseyBonnicksen, 8.5)
		,(@Manhattan, @Cove, @EricGrimsted, 5.8)
		,(@Manhattan, @Cove, @KristonTrevino, 3.5)
		,(@Manhattan, @Cove, @Stephanie, 2.5)
		,(@Manhattan, @Cove, @KyleaJohnson, 6.1)
		,(@Manhattan, @Cove, @ChristianRowe, 7.1)
		,(@Manhattan, @Cove, @ClaytonTupper, 6.8)
		,(@Manhattan, @Cove, @GeorgeTanasse, 6.5)
		,(@Manhattan, @Cove, @PeterCaderoSmith, 3.2)
		,(@Manhattan, @Cove, @Me, 6)
		,(@Manhattan, @Cove, @JahrelBalon, 3.5)
		,(@Manhattan, @Cove, @Lindsey, 8.1)
		,(@Manhattan, @Cove, @Kaliene, 6.2)
		,(@Manhattan, @Legends, @TimBusacker, 6.9)
		,(@Manhattan, @Legends, @JamesWitt, 6)
		,(@Manhattan, @Legends, @BonnieWitt, 6)
		,(@Manhattan, @Legends, @KristonTrevino, 4)
		,(@Manhattan, @Legends, @Stephanie, 3)
		,(@Manhattan, @Legends, @ChristianRowe, 5.1)
		,(@Manhattan, @Legends, @ClaytonTupper, 7.5)
		,(@Manhattan, @Legends, @GeorgeTanasse, 7.5)
		,(@Manhattan, @Legends, @PeterCaderoSmith, 7)
		,(@Manhattan, @Legends, @Me, 6.5)
		,(@Manhattan, @Legends, @JahrelBalon, 4.5)
		,(@Manhattan, @Legends, @Lindsey, 6.9)
		,(@Manhattan, @Legends, @Kaliene, 6.6)
		,(@Manhattan, @CheekyMartini, @TimBusacker, 8.2)
		,(@Manhattan, @CheekyMartini, @JamesWitt, 6.5)
		,(@Manhattan, @CheekyMartini, @KelseyBonnicksen, 5.5)
		,(@Manhattan, @CheekyMartini, @EricGrimsted, 7.2)
		,(@Manhattan, @CheekyMartini, @KristonTrevino, 8.5)
		,(@Manhattan, @CheekyMartini, @Stephanie, 7)
		,(@Manhattan, @CheekyMartini, @ChristianRowe, 8.9)
		,(@Manhattan, @CheekyMartini, @GeorgeTanasse, 9.3)
		,(@Manhattan, @CheekyMartini, @PeterCaderoSmith, 7.9)
		,(@Manhattan, @CheekyMartini, @Me, 7.7)
		,(@Manhattan, @Filibuster, @TimBusacker, 7.7)
		,(@Manhattan, @Filibuster, @JamesWitt, 6)
		,(@Manhattan, @Filibuster, @EricGrimsted, 7.9)
		,(@Manhattan, @Filibuster, @ChristianRowe, 6.4)
		,(@Manhattan, @Filibuster, @GeorgeTanasse, 7.5)
		,(@Manhattan, @Filibuster, @PeterCaderoSmith, 6.5)
		,(@Manhattan, @Filibuster, @Me, 8.5);
