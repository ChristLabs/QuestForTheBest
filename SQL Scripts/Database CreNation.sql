USE db_ab2350_questforthebest
GO

--DROP TABLE Scores;
--DROP TABLE Bars;
--DROP TABLE Questers;
--DROP TABLE Quests;
--DROP TABLE Cocktails;


CREATE TABLE Cocktails (
	CocktailId smallint IDENTITY(1, 1)
		CONSTRAINT PK_Cocktails_CocktailId PRIMARY KEY,
	CocktailName nvarchar(100) NOT NULL,
	CocktailDescription nvarchar(1000) NOT NULL
);

INSERT INTO Cocktails (CocktailName, CocktailDescription)
VALUES ('Margarita', 'A vibrant Mexican cocktail. Discover how to make the perfect Margarita.')
		,('Moscow Mule', 'A refreshing, spicy, and tangy classic. Discover how to make the perfect Moscow Mule.')
		,('Mai Tai', 'A classic refreshing cocktail. Learn how to craft the perfect Mai Tai.')
		,('Whiskey Sour', 'A balanced, sweet, and sour cocktail. Learn about the Whiskey Sour.')
		,('Manhattan', 'The sophisticated classic from New York City. Learn more about its history and how to make it.')
		,('Hot Toddy', 'Warm, soothing, and perfectly spiced. Learn more about this cozy classic.');

CREATE TABLE Quests (
	QuestId smallint IDENTITY(1, 1)
		CONSTRAINT PK_Quests_QuestId PRIMARY KEY,
	PrimaryCocktailId smallint NOT NULL
		CONSTRAINT FK_Quests_PrimaryCocktailId_Cocktails_CocktailId FOREIGN KEY REFERENCES Cocktails(CocktailId),
	SecondaryCocktailId smallint NULL
		CONSTRAINT FK_Quests_SecondaryCocktailId_Cocktails_CocktailId FOREIGN KEY REFERENCES Cocktails(CocktailId),
	DateOfQuest date NOT NULL
);

DECLARE @Margarita smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Margarita');
DECLARE @MoscowMule smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Moscow Mule');
DECLARE @MaiTai smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Mai Tai');
DECLARE @WhiskeySour smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Whiskey Sour');
DECLARE @Manhattan smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Manhattan');
DECLARE @HotToddy smallint = (SELECT CocktailId FROM Cocktails WHERE CocktailName = 'Hot Toddy');

INSERT INTO Quests (PrimaryCocktailId, DateOfQuest)
VALUES (@Margarita, '05/19/2023')
		,(@MoscowMule, '10/06/2023')
		,(@MaiTai, '01/19/2024')
		,(@WhiskeySour, '04/05/2024')
		,(@Manhattan, '10/01/2024')
		,(@HotToddy, '02/07/2025')

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
		,('Luna', NULL)
		,('Autumn Lavender', 'Autumn')
		,('Lindsey', NULL)
		,('Kelsey Bonnicksen', 'Kelsinki')
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
	QuestId smallint NOT NULL
		CONSTRAINT FK_Scores_QuestId_Quests_QuestId FOREIGN KEY REFERENCES Quests(QuestId),
	CocktailId smallint NOT NULL
		CONSTRAINT FK_Scores_CocktailId_Cocktails_CocktailId FOREIGN KEY REFERENCES Cocktails(CocktailId),
	QuesterId smallint NOT NULL
		CONSTRAINT FK_Scores_QuesterId_Questers_QuesterId FOREIGN KEY REFERENCES Questers(QuesterId),
	BarId smallint NOT NULL
		CONSTRAINT FK_Scores_BarId_Bars_BarId FOREIGN KEY REFERENCES Bars(BarId),
	Score decimal(4, 2) NOT NULL
)

-- QuestIds
DECLARE @MargaritaQuest smallint = (
	SELECT c.CocktailId
		FROM Quests q
			INNER JOIN Cocktails c
				ON q.PrimaryCocktailId = c.CocktailId
		WHERE CocktailName = 'Margarita');

DECLARE @MoscowMuleQuest smallint = (
	SELECT c.CocktailId
		FROM Quests q
			INNER JOIN Cocktails c
				ON q.PrimaryCocktailId = c.CocktailId
		WHERE CocktailName = 'Moscow Mule');

DECLARE @MaiTaiQuest smallint = (
	SELECT c.CocktailId
		FROM Quests q
			INNER JOIN Cocktails c
				ON q.PrimaryCocktailId = c.CocktailId
		WHERE CocktailName = 'Mai Tai');

DECLARE @WhiskeySourQuest smallint = (
	SELECT c.CocktailId
		FROM Quests q
			INNER JOIN Cocktails c
				ON q.PrimaryCocktailId = c.CocktailId
		WHERE CocktailName = 'Whiskey Sour');

DECLARE @ManhattanQuest smallint = (
	SELECT c.CocktailId
		FROM Quests q
			INNER JOIN Cocktails c
				ON q.PrimaryCocktailId = c.CocktailId
		WHERE CocktailName = 'Manhattan');

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
DECLARE @Luna smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Luna');
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
INSERT INTO Scores (QuestId, CocktailId, BarId, QuesterId, Score)
VALUES --,(@Margarita, @, @, 0)
		(@MargaritaQuest, @Margarita, @Kokos, @JamesWitt, 7)
		,(@MargaritaQuest, @Margarita, @Kokos, @TimBusacker, 8)
		,(@MargaritaQuest, @Margarita, @Kokos, @JoseMejia, 6.5)
		,(@MargaritaQuest, @Margarita, @Kokos, @StephanieHerrera, 7.5)
		,(@MargaritaQuest, @Margarita, @Kokos, @AngelaNoyen, 7.5)
		,(@MargaritaQuest, @Margarita, @Kokos, @EricGrimsted, 8)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @JamesWitt, 7)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @TimBusacker, 8.5)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @JoseMejia, 7.3)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @StephanieHerrera, 8)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @AngelaNoyen, 9.5)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @EricGrimsted, 8.5)
		,(@MargaritaQuest, @Margarita, @EqualLatin, @KristonTrevino, 4)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @JamesWitt, 8)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @TimBusacker, 9)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @JoseMejia, 7.9)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @StephanieHerrera, 8.5)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @AngelaNoyen, 8.5)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @EricGrimsted, 8.75)
		,(@MargaritaQuest, @Margarita, @DosHermanos, @KristonTrevino, 8)
		,(@MargaritaQuest, @Margarita, @Filibuster, @JamesWitt, 6)
		,(@MargaritaQuest, @Margarita, @Filibuster, @TimBusacker, 7)
		,(@MargaritaQuest, @Margarita, @Filibuster, @JoseMejia, 6)
		,(@MargaritaQuest, @Margarita, @Filibuster, @StephanieHerrera, 6.5)
		,(@MargaritaQuest, @Margarita, @Filibuster, @KristonTrevino, 5)
		,(@MargaritaQuest, @Margarita, @Filibuster, @PeterCaderoSmith, 4)
		,(@MargaritaQuest, @Margarita, @LaEsquinita, @JamesWitt, 6.5)
		,(@MargaritaQuest, @Margarita, @LaEsquinita, @TimBusacker, 7.5)
		,(@MargaritaQuest, @Margarita, @LaEsquinita, @JoseMejia, 7.2)
		,(@MargaritaQuest, @Margarita, @LaEsquinita, @StephanieHerrera, 7)
		,(@MargaritaQuest, @Margarita, @LaEsquinita, @EricGrimsted, 6.2)
		--,(@MoscowMule, @, @, 0)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @TimBusacker, 5.7)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @JamesWitt, 6)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @JahrelBalon, 5)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @Me, 6)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @EricGrimsted, 6.5)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @JoseMejia, 6.2)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @KristonTrevino, 5)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @StephanieHerrera, 7)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @RobertShields, 6)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @PeterCaderoSmith, 7.2)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @CollinSavunen, 5)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @Luna, 7.5)
		,(@MoscowMuleQuest, @MoscowMule, @Well80, @AutumnLavender, 8)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @TimBusacker, 7.8)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @JamesWitt, 8)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @JahrelBalon, 7)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @Me, 7.7)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @EricGrimsted, 7)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @JoseMejia, 7.6)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @KristonTrevino, 7.5)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @RobertShields, 7)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @PeterCaderoSmith, 8.7)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @CollinSavunen, 8)
		,(@MoscowMuleQuest, @MoscowMule, @Cryptatropa, @Lindsey, 8.5)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @TimBusacker, 4)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @JamesWitt, 4)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @JahrelBalon, 4)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @Me, 4)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @EricGrimsted, 5)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @JoseMejia, 5.2)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @KristonTrevino, 0)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @RobertShields, 5)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @PeterCaderoSmith, 1.2)
		,(@MoscowMuleQuest, @MoscowMule, @LeVoyeur, @CollinSavunen, 4)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @TimBusacker, 6.9)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @JamesWitt, 7)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @JahrelBalon, 7.5)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @Me, 6.9)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @EricGrimsted, 7.6)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @JoseMejia, 6.3)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @KristonTrevino, 7)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @RobertShields, 8)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @PeterCaderoSmith, 6.9)
		,(@MoscowMuleQuest, @MoscowMule, @CheekyMartini, @CollinSavunen, 7.5)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @TimBusacker, 3.1)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @JamesWitt, 5)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @EricGrimsted, 6)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @JoseMejia, 0)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @KristonTrevino, 1)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @RobertShields, 4)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @PeterCaderoSmith, 0.9)
		,(@MoscowMuleQuest, @MoscowMule, @TheSpar, @CollinSavunen, 6)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @TimBusacker, 6)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @JamesWitt, 6)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @EricGrimsted, 7.7)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @JoseMejia, 6.8)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @KristonTrevino, 6.5)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @RobertShields, 7)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @PeterCaderoSmith, 6.7)
		,(@MoscowMuleQuest, @MoscowMule, @TheMark, @CollinSavunen, 6.2)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @TimBusacker, 6.1)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @JamesWitt, 5)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @EricGrimsted, 6.5)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @RobertShields, 7)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @PeterCaderoSmith, 6.4)
		,(@MoscowMuleQuest, @MoscowMule, @Cove, @CollinSavunen, 6.5)
		--,(@MaiTai, @, @, 0)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @TimBusacker, 7.9)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @JahrelBalon, 7)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @Me, 8)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @EricGrimsted, 7.75)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @PeterCaderoSmith, 8)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @KelseyBonnicksen, 7.8)
		,(@MaiTaiQuest, @MaiTai, @Cynara, @AngelaNoyen, 7)
		,(@MaiTaiQuest, @MaiTai, @Cove, @TimBusacker, 5.1)
		,(@MaiTaiQuest, @MaiTai, @Cove, @JamesWitt, 6.5)
		,(@MaiTaiQuest, @MaiTai, @Cove, @JahrelBalon, 6)
		,(@MaiTaiQuest, @MaiTai, @Cove, @Me, 5)
		,(@MaiTaiQuest, @MaiTai, @Cove, @EricGrimsted, 6.75)
		,(@MaiTaiQuest, @MaiTai, @Cove, @PeterCaderoSmith, 5.8)
		,(@MaiTaiQuest, @MaiTai, @Cove, @KristonTrevino, 4)
		,(@MaiTaiQuest, @MaiTai, @Cove, @KelseyBonnicksen, 6)
		,(@MaiTaiQuest, @MaiTai, @Cove, @AngelaNoyen, 6)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @TimBusacker, 6.1)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @JamesWitt, 5.5)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @JahrelBalon, 6.5)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @Me, 3)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @EricGrimsted, 6)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @PeterCaderoSmith, 5.8)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @KristonTrevino, 4)
		,(@MaiTaiQuest, @MaiTai, @TheMark, @KelseyBonnicksen, 4.5)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @TimBusacker, 8.1)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @JamesWitt, 7)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @JahrelBalon, 8)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @Me, 8.3)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @EricGrimsted, 3)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @PeterCaderoSmith, 8.4)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @KristonTrevino, 5)
		,(@MaiTaiQuest, @MaiTai, @CheekyMartini, @KelseyBonnicksen, 2)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @TimBusacker, 7.4)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @JamesWitt, 8)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @JahrelBalon, 7.5)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @Me, 8.5)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @EricGrimsted, 7.9)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @PeterCaderoSmith, 8.5)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @KristonTrevino, 7)
		,(@MaiTaiQuest, @MaiTai, @ShinyPrize, @KelseyBonnicksen, 8.8)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @TimBusacker, 7.6)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @JamesWitt, 6.5)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @JahrelBalon, 8)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @Me, 6)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @EricGrimsted, 8.25)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @PeterCaderoSmith, 8.5)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @KristonTrevino, 6)
		,(@MaiTaiQuest, @MaiTai, @Cryptatropa, @KelseyBonnicksen, 9.1)
		,(@MaiTaiQuest, @MaiTai, @Well80, @TimBusacker, 5)
		,(@MaiTaiQuest, @MaiTai, @Well80, @JamesWitt, 4)
		,(@MaiTaiQuest, @MaiTai, @Well80, @Me, 4)
		,(@MaiTaiQuest, @MaiTai, @Well80, @EricGrimsted, 5)
		,(@MaiTaiQuest, @MaiTai, @Well80, @KelseyBonnicksen, 4.5)
		--,(@WhiskeySour, @, @, 0)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @TimBusacker, 7.6)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @JamesWitt, 7.2)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @JahrelBalon, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @Me, 7.7)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @EricGrimsted, 8.1)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @KristonTrevino, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @KatGriffin, 5)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @SarahHarlan, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @JoseMejia, 7.2)
		,(@WhiskeySourQuest, @WhiskeySour, @ChristJimExperience, @BonnieWitt, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @TimBusacker, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @JamesWitt, 6.32)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @JahrelBalon, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @Me, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @EricGrimsted, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @KristonTrevino, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @KatGriffin, 6.5)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @SarahHarlan, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @UptownGrill, @JoseMejia, 6.5)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @TimBusacker, 8)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @JamesWitt, 7.9)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @JahrelBalon, 7.5)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @Me, 7.2)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @EricGrimsted, 6.5)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @KristonTrevino, 7.5)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @SarahHarlan, 4)
		,(@WhiskeySourQuest, @WhiskeySour, @CheekyMartini, @JoseMejia, 7.9)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @TimBusacker, 7.2)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @JamesWitt, 6.2)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @JahrelBalon, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @Me, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @EricGrimsted, 7)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @KristonTrevino, 6.5)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @SarahHarlan, 7.8)
		,(@WhiskeySourQuest, @WhiskeySour, @Filibuster, @JoseMejia, 6.2)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @TimBusacker, 5.5)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @JamesWitt, 4)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @JahrelBalon, 5.5)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @Me, 3)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @EricGrimsted, 5.8)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @KristonTrevino, 6)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @SarahHarlan, 5)
		,(@WhiskeySourQuest, @WhiskeySour, @Cryptatropa, @JoseMejia, 5.3)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @TimBusacker, 8.5)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @JamesWitt, 8.2)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @JahrelBalon, 8)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @Me, 8.6)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @EricGrimsted, 8.2)
		,(@WhiskeySourQuest, @WhiskeySour, @ShinyPrize, @JoseMejia, 8.2)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @TimBusacker, 4)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @JamesWitt, 3)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @Me, 2.1)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @EricGrimsted, 3)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @KristonTrevino, 5)
		,(@WhiskeySourQuest, @WhiskeySour, @Cove, @JoseMejia, 2.05)
		--,(@Manhattan, @, @, 0)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @TimBusacker, 9)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @JamesWitt, 8)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @BonnieWitt, 8.8)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @KelseyBonnicksen, 6.5)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @EricGrimsted, 8)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @KristonTrevino, 8.5)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @Stephanie, 7.5)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @ChristianRowe, 8.3)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @ClaytonTupper, 8)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @GeorgeTanasse, 9)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @PeterCaderoSmith, 9.4)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @CollinSavunen, 8)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @Me, 9)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @JahrelBalon, 6)
		,(@ManhattanQuest, @Manhattan, @ShinyPrize, @Kaliene, 8.5)
		,(@ManhattanQuest, @Manhattan, @PigBar, @TimBusacker, 5)
		,(@ManhattanQuest, @Manhattan, @PigBar, @JamesWitt, 5.5)
		,(@ManhattanQuest, @Manhattan, @PigBar, @BonnieWitt, 6)
		,(@ManhattanQuest, @Manhattan, @PigBar, @EricGrimsted, 5.2)
		,(@ManhattanQuest, @Manhattan, @PigBar, @KristonTrevino, 4)
		,(@ManhattanQuest, @Manhattan, @PigBar, @Stephanie, 3.5)
		,(@ManhattanQuest, @Manhattan, @PigBar, @KyleaJohnson, 4.3)
		,(@ManhattanQuest, @Manhattan, @PigBar, @ChristianRowe, 4.9)
		,(@ManhattanQuest, @Manhattan, @PigBar, @ClaytonTupper, 4)
		,(@ManhattanQuest, @Manhattan, @PigBar, @GeorgeTanasse, 3)
		,(@ManhattanQuest, @Manhattan, @PigBar, @PeterCaderoSmith, 4)
		,(@ManhattanQuest, @Manhattan, @PigBar, @CollinSavunen, 5)
		,(@ManhattanQuest, @Manhattan, @PigBar, @Me, 2)
		,(@ManhattanQuest, @Manhattan, @PigBar, @JahrelBalon, 2)
		,(@ManhattanQuest, @Manhattan, @PigBar, @Kaliene, 3.5)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @TimBusacker, 6.1)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @JamesWitt, 4)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @BonnieWitt, 2)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @KelseyBonnicksen, 7.6)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @EricGrimsted, 5)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @KristonTrevino, 5.5)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @Stephanie, 6.1)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @KyleaJohnson, 6)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @ChristianRowe, 6.6)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @ClaytonTupper, 6)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @GeorgeTanasse, 4)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @PeterCaderoSmith, 7.5)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @CollinSavunen, 6.5)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @Me, 5.2)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @JahrelBalon, 4)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @Lindsey, 2.1)
		,(@ManhattanQuest, @Manhattan, @Cryptatropa, @Kaliene, 3.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @TimBusacker, 5.9)
		,(@ManhattanQuest, @Manhattan, @Cove, @JamesWitt, 5)
		,(@ManhattanQuest, @Manhattan, @Cove, @BonnieWitt, 6.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @KelseyBonnicksen, 8.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @EricGrimsted, 5.8)
		,(@ManhattanQuest, @Manhattan, @Cove, @KristonTrevino, 3.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @Stephanie, 2.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @KyleaJohnson, 6.1)
		,(@ManhattanQuest, @Manhattan, @Cove, @ChristianRowe, 7.1)
		,(@ManhattanQuest, @Manhattan, @Cove, @ClaytonTupper, 6.8)
		,(@ManhattanQuest, @Manhattan, @Cove, @GeorgeTanasse, 6.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @PeterCaderoSmith, 3.2)
		,(@ManhattanQuest, @Manhattan, @Cove, @Me, 6)
		,(@ManhattanQuest, @Manhattan, @Cove, @JahrelBalon, 3.5)
		,(@ManhattanQuest, @Manhattan, @Cove, @Lindsey, 8.1)
		,(@ManhattanQuest, @Manhattan, @Cove, @Kaliene, 6.2)
		,(@ManhattanQuest, @Manhattan, @Legends, @TimBusacker, 6.9)
		,(@ManhattanQuest, @Manhattan, @Legends, @JamesWitt, 6)
		,(@ManhattanQuest, @Manhattan, @Legends, @BonnieWitt, 6)
		,(@ManhattanQuest, @Manhattan, @Legends, @KristonTrevino, 4)
		,(@ManhattanQuest, @Manhattan, @Legends, @Stephanie, 3)
		,(@ManhattanQuest, @Manhattan, @Legends, @ChristianRowe, 5.1)
		,(@ManhattanQuest, @Manhattan, @Legends, @ClaytonTupper, 7.5)
		,(@ManhattanQuest, @Manhattan, @Legends, @GeorgeTanasse, 7.5)
		,(@ManhattanQuest, @Manhattan, @Legends, @PeterCaderoSmith, 7)
		,(@ManhattanQuest, @Manhattan, @Legends, @Me, 6.5)
		,(@ManhattanQuest, @Manhattan, @Legends, @JahrelBalon, 4.5)
		,(@ManhattanQuest, @Manhattan, @Legends, @Lindsey, 6.9)
		,(@ManhattanQuest, @Manhattan, @Legends, @Kaliene, 6.6)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @TimBusacker, 8.2)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @JamesWitt, 6.5)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @KelseyBonnicksen, 5.5)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @EricGrimsted, 7.2)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @KristonTrevino, 8.5)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @Stephanie, 7)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @ChristianRowe, 8.9)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @GeorgeTanasse, 9.3)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @PeterCaderoSmith, 7.9)
		,(@ManhattanQuest, @Manhattan, @CheekyMartini, @Me, 7.7)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @TimBusacker, 7.7)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @JamesWitt, 6)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @EricGrimsted, 7.9)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @ChristianRowe, 6.4)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @GeorgeTanasse, 7.5)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @PeterCaderoSmith, 6.5)
		,(@ManhattanQuest, @Manhattan, @Filibuster, @Me, 8.5);