USE db_ab2350_questforthebest
GO

BEGIN TRAN
	-- QuestId
	DECLARE @French75Quest smallint = (
		SELECT q.QuestId
			FROM Quests q
				INNER JOIN Cocktails c
					ON q.PrimaryCocktailId = c.CocktailId
			WHERE CocktailName = 'French 75');

	-- CocktailID
	DECLARE @French75Cocktail smallint = (
		SELECT CocktailId
			FROM Cocktails
			WHERE CocktailName = 'French 75'
	);

	INSERT INTO Questers (QuesterName, QuesterNickname)
	VALUES ('Kyle McDonough', 'Bigorca')
			,('Karen McDonough', 'Karen')
			,('Vincent', NULL);

	DECLARE @Me smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Christian Armstrong'); -- Christ
	DECLARE @EricGrimsted smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Eric Grimsted'); -- Eric
	DECLARE @CollinSavunen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Collin Savunen'); -- Collin
	DECLARE @Bigorca smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kyle McDonough'); -- Big O
	DECLARE @TimBusacker smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Tim Busacker'); -- Timbo
	DECLARE @JamesWitt smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'James Witt'); -- Jimbo
	DECLARE @Kylea smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kylea Johnson'); -- Kylea
	DECLARE @KristonTrevino smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kriston Trevino'); -- Kriston
	DECLARE @Steph smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Stephanie'); -- Steph
	DECLARE @Karen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Karen McDonough'); -- Karen
	DECLARE @Vincent smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Vincent'); -- Vincent

	INSERT INTO Bars (BarName, Latitude, Longitude)
	VALUES ('Row', 47.045780, -122.903854)
			,('Capitol Tavern', 47.044949, -122.902485)

	DECLARE @Altitude15 smallint = (SELECT BarId FROM Bars WHERE BarName = 'Altitude 15');
	DECLARE @ShinyPrize smallint = (SELECT BarId FROM Bars WHERE BarName = 'Shiny Prize');
	DECLARE @RowBar smallint = (SELECT BarId FROM Bars WHERE BarName = 'Row');
	DECLARE @CheekyMartini smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cheeky Martini');
	DECLARE @Filibuster smallint = (SELECT BarId FROM Bars WHERE BarName = 'Filibuster');
	DECLARE @TheBusStop smallint = (SELECT BarId FROM Bars WHERE BarName = 'The Bus Stop');
	DECLARE @CapTav smallint = (SELECT BarId FROM Bars WHERE BarName = 'Capitol Tavern');

	INSERT INTO Scores (QuestId, CocktailId, BarId, QuesterId, Score)
	VALUES
	-- Altitude 15
	(@French75Quest, @French75Cocktail,  @Altitude15, @Me, 5.75)
	,(@French75Quest, @French75Cocktail,  @Altitude15, @EricGrimsted, 6.00)
	,(@French75Quest, @French75Cocktail,  @Altitude15, @CollinSavunen, 6.50)
	,(@French75Quest, @French75Cocktail,  @Altitude15, @Bigorca, 5.00)

	-- Shiny Prize
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @Me, 7.80)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @EricGrimsted, 8.40)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @CollinSavunen, 8.50)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @Bigorca, 9.00)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @TimBusacker, 8.80)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @KristonTrevino, 8.50)
	,(@French75Quest, @French75Cocktail,  @ShinyPrize, @Steph, 7.00)

	-- Row
	,(@French75Quest, @French75Cocktail,  @RowBar, @Me, 7.90)
	,(@French75Quest, @French75Cocktail,  @RowBar, @EricGrimsted, 6.90)
	,(@French75Quest, @French75Cocktail,  @RowBar, @CollinSavunen, 8.50)
	,(@French75Quest, @French75Cocktail,  @RowBar, @Bigorca, 7.50)
	,(@French75Quest, @French75Cocktail,  @RowBar, @TimBusacker, 8.10)
	,(@French75Quest, @French75Cocktail,  @RowBar, @Kylea, 7.70)
	,(@French75Quest, @French75Cocktail,  @RowBar, @KristonTrevino, 7.50)
	,(@French75Quest, @French75Cocktail,  @RowBar, @Steph, 7.00)
	,(@French75Quest, @French75Cocktail,  @RowBar, @Karen, 7.30)

	-- Cheeky Martini
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @Me, 8.20)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @EricGrimsted, 7.90)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @CollinSavunen, 7.50)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @Bigorca, 7.50)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @TimBusacker, 7.80)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @JamesWitt, 7.00)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @Kylea, 8.20)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @KristonTrevino, 8.00)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @Steph, 7.50)
	,(@French75Quest, @French75Cocktail,  @CheekyMartini, @Karen, 7.90)

	-- Filibuster
	,(@French75Quest, @French75Cocktail,  @Filibuster, @Me, 8.20)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @EricGrimsted, 8.00)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @CollinSavunen, 8.00)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @Bigorca, 7.50)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @TimBusacker, 8.10)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @JamesWitt, 7.50)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @Kylea, 8.30)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @KristonTrevino, 6.50)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @Steph, 7.25)
	,(@French75Quest, @French75Cocktail,  @Filibuster, @Karen, 8.20)

	-- The Bus Stop
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Me, 7.50)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @CollinSavunen, 7.00)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Bigorca, 7.75)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @TimBusacker, 7.60)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @JamesWitt, 6.00)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Kylea, 7.60)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @KristonTrevino, 7.00)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Steph, 6.75)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Karen, 7.10)
	,(@French75Quest, @French75Cocktail,  @TheBusStop, @Vincent, 7.00)

	-- Cap Tav
	,(@French75Quest, @French75Cocktail,  @CapTav, @Me, 6.50)
	,(@French75Quest, @French75Cocktail,  @CapTav, @CollinSavunen, 7.50)
	,(@French75Quest, @French75Cocktail,  @CapTav, @Bigorca, 7.00)
	,(@French75Quest, @French75Cocktail,  @CapTav, @TimBusacker, 8.00)
	,(@French75Quest, @French75Cocktail,  @CapTav, @JamesWitt, 6.23)
	,(@French75Quest, @French75Cocktail,  @CapTav, @KristonTrevino, 6.75)
	,(@French75Quest, @French75Cocktail,  @CapTav, @Steph, 6.50);

COMMIT TRAN;