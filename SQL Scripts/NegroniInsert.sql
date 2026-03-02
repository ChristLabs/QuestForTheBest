USE db_ab2350_questforthebest
GO

BEGIN TRAN
	-- QuestId
	DECLARE @NegroniQuest smallint = (
		SELECT c.CocktailId
			FROM Quests q
				INNER JOIN Cocktails c
					ON q.PrimaryCocktailId = c.CocktailId
			WHERE CocktailName = 'Negroni');

	-- CocktailID
	DECLARE @NegroniCocktail smallint = (
		SELECT CocktailId
			FROM Cocktails
			WHERE CocktailName = 'Negroni'
	);

	-- Questers
	INSERT INTO Questers(QuesterName, QuesterNickname)
	VALUES
		('Crystal', 'Chrysanthemum'),
		('Christian Oakley', 'Oakley')

	DECLARE @TimBusacker smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Tim Busacker'); -- Timbo
	DECLARE @Chrysanthemum smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Crystal');
	DECLARE @Me smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Christian Armstrong'); -- Christ
	DECLARE @CollinSavunen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Collin Savunen'); -- Colin
	DECLARE @ChristianOakley smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Christian Oakley'); -- Christian
	DECLARE @KelseyBonnicksen smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kelsey Wheeler'); -- Kelsey
	DECLARE @PeterCaderoSmith smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Peter Cadero-Smith'); -- Drunken Baller
	DECLARE @KristonTrevino smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Kriston Trevino'); -- Kriston
	DECLARE @JamesWitt smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'James Witt'); -- Jimbo
	DECLARE @JahrelBalon smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Jahrel Balon'); -- JB
	DECLARE @EricGrimsted smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Eric Grimsted'); -- Eric
	DECLARE @AndrewWheeler smallint = (SELECT QuesterId FROM Questers WHERE QuesterName = 'Andrew Wheeler'); -- Andrew

	-- Bars
	INSERT INTO Bars (BarName, Latitude, Longitude)
	VALUES ('Altitude 15', 47.045771, -122.899536),
		('Christ', 47.249170, -122.434535);

	DECLARE @ShinyPrize smallint = (SELECT BarId FROM Bars WHERE BarName = 'Shiny Prize');
	DECLARE @Valentinas smallint = (SELECT BarId FROM Bars WHERE BarName = 'Valentina''s');
	DECLARE @Cryptatropa smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cryptatropa');
	DECLARE @Altitude15 smallint = (SELECT BarId FROM Bars WHERE BarName = 'Altitude 15');
	DECLARE @CheekyMartini smallint = (SELECT BarId FROM Bars WHERE BarName = 'Cheeky Martini');
	DECLARE @Filibuster smallint = (SELECT BarId FROM Bars WHERE BarName = 'Filibuster');
	DECLARE @TheBusStop smallint = (SELECT BarId FROM Bars WHERE BarName = 'The Bus Stop');
	DECLARE @Legends smallint = (SELECT BarId FROM Bars WHERE BarName = 'Legends');
	DECLARE @Christ smallint = (SELECT BarId FROM Bars WHERE BarName = 'Christ');

	INSERT INTO Scores (QuestId, CocktailId, BarId, QuesterId, Score)
	VALUES  -- =====================
			-- Shiny Prize
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @TimBusacker, 8.2),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @Me, 8.7),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @CollinSavunen, 8.0),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @ChristianOakley, 8.0),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @KristonTrevino, 8.0),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @PeterCaderoSmith, 8.9),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @JamesWitt, 7.0),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @JahrelBalon, 5.0),
			(@NegroniQuest, @NegroniCocktail, @ShinyPrize, @EricGrimsted, 7.1),

			-- =====================
			-- Valentina's
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @TimBusacker, 8.1),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @Chrysanthemum, 5.0),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @Me, 6.7),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @CollinSavunen, 8.0),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @KristonTrevino, 7.5),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @JamesWitt, 6.5),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @JahrelBalon, 7.0),
			(@NegroniQuest, @NegroniCocktail, @Valentinas, @EricGrimsted, 7.2),

			-- =====================
			-- Cryptatropa
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @TimBusacker, 7.2),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @Me, 6.0),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @CollinSavunen, 6.8),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @KelseyBonnicksen, 4.7),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @KristonTrevino, 6.0),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @PeterCaderoSmith, 6.5),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @JamesWitt, 6.0),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @JahrelBalon, 4.0),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @EricGrimsted, 6.8),
			(@NegroniQuest, @NegroniCocktail, @Cryptatropa, @AndrewWheeler, 6.0),

			-- =====================
			-- Altitude 15
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @TimBusacker, 5.1),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @Me, 3.0),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @CollinSavunen, 6.5),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @KelseyBonnicksen, 9.5),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @KristonTrevino, 5.0),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @JamesWitt, 5.5),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @JahrelBalon, 3.0),
			(@NegroniQuest, @NegroniCocktail, @Altitude15, @AndrewWheeler, 6.9),

			-- =====================
			-- Cheeky Martini
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @TimBusacker, 7.7),
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @Me, 7.5),
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @CollinSavunen, 7.6),
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @KristonTrevino, 6.5),
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @JahrelBalon, 6.5),
			(@NegroniQuest, @NegroniCocktail, @CheekyMartini, @AndrewWheeler, 6.9),

			-- =====================
			-- Filibuster
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @TimBusacker, 7.3),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @Chrysanthemum, 3.0),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @Me, 7.3),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @CollinSavunen, 7.5),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @KelseyBonnicksen, 6.7),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @KristonTrevino, 7.5),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @JamesWitt, 6.5),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @JahrelBalon, 6.0),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @EricGrimsted, 7.4),
			(@NegroniQuest, @NegroniCocktail, @Filibuster, @AndrewWheeler, 7.1),

			-- =====================
			-- The Bus Stop
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @TimBusacker, 7.2),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @Me, 7.1),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @CollinSavunen, 7.7),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @KelseyBonnicksen, 5.1),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @KristonTrevino, 7.0),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @JahrelBalon, 6.5),
			(@NegroniQuest, @NegroniCocktail, @TheBusStop, @AndrewWheeler, 6.5),

			-- =====================
			-- Legends
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Legends, @TimBusacker, 3.0),
			(@NegroniQuest, @NegroniCocktail, @Legends, @Me, 1.0),
			(@NegroniQuest, @NegroniCocktail, @Legends, @CollinSavunen, 1.0),
			(@NegroniQuest, @NegroniCocktail, @Legends, @KristonTrevino, 1.0),

			-- =====================
			-- Christ
			-- =====================
			(@NegroniQuest, @NegroniCocktail, @Christ, @TimBusacker, 7.3),
			(@NegroniQuest, @NegroniCocktail, @Christ, @Me, 7.7),
			(@NegroniQuest, @NegroniCocktail, @Christ, @CollinSavunen, 7.8),
			(@NegroniQuest, @NegroniCocktail, @Christ, @KelseyBonnicksen, 5.0),
			(@NegroniQuest, @NegroniCocktail, @Christ, @JamesWitt, 5.5),
			(@NegroniQuest, @NegroniCocktail, @Christ, @JahrelBalon, 4.8),
			(@NegroniQuest, @NegroniCocktail, @Christ, @AndrewWheeler, 6.1);


	DECLARE @QuestId int = @NegroniQuest; -- swap this for any quest

	DECLARE @cols nvarchar(max);
	DECLARE @sql nvarchar(max);

	SELECT @cols = STRING_AGG(QUOTENAME(x.BarName), ',') WITHIN GROUP (ORDER BY x.BarName)
		FROM (
			SELECT DISTINCT b.BarName AS BarName
				FROM Scores AS sc
					INNER JOIN Bars AS b
						ON b.BarId = sc.BarId
				WHERE sc.QuestId = @QuestId
		) AS x;

	IF @cols IS NULL OR LTRIM(RTRIM(@cols)) = ''
	BEGIN
		RAISERROR('No bars/scores found for the provided QuestId.', 16, 1);
		RETURN;
	END

	SET @sql = N'
		WITH s AS
		(
			SELECT q.QuesterId AS QuesterId
					,q.QuesterName AS QuesterName
					,b.BarName AS BarName
					,CAST(sc.Score AS decimal(10,2)) AS Score
				FROM Scores AS sc
					INNER JOIN Questers AS q
						ON q.QuesterId = sc.QuesterId
					INNER JOIN Bars AS b
						ON b.BarId = sc.BarId
				WHERE sc.QuestId = @QuestId
		),
		p AS
		(
			SELECT *
				FROM s AS s1
				PIVOT
				(
					MAX(Score) FOR BarName IN (' + @cols + N')
				) AS pv
		),
		avgRow AS
		(
			SELECT CAST(0 AS int) AS QuesterId
					,''Average'' AS QuesterName
					,s2.BarName AS BarName
					,CAST(ROUND(AVG(s2.Score), 2) AS decimal(10,2)) AS Score
				FROM s AS s2
				GROUP BY s2.BarName
		),
		avgPivot AS
		(
			SELECT *
				FROM avgRow AS ar
				PIVOT
				(
					MAX(Score) FOR BarName IN (' + @cols + N')
				) AS ap
		),
		overall AS
		(
			SELECT CAST(ROUND(AVG(s3.Score), 2) AS decimal(10,2)) AS OverallAvg
				FROM s AS s3
		)
		SELECT r.QuesterId AS QuesterId
				,r.Quester AS Quester
				,' + @cols + N'
				,r.Average AS Average
			FROM
			(
				SELECT
					p1.QuesterId AS QuesterId,
					p1.QuesterName AS Quester,
					' + @cols + N',
					CAST(ROUND(
						(
							SELECT AVG(s4.Score)
								FROM s AS s4
								WHERE s4.QuesterId = p1.QuesterId
						)
					, 2) AS decimal(10,2)) AS Average,
					CAST(0 AS int) AS SortOrder
				FROM p AS p1

				UNION ALL

				SELECT
					ap1.QuesterId AS QuesterId,
					ap1.QuesterName AS Quester,
					' + @cols + N',
					o1.OverallAvg AS Average,
					CAST(1 AS int) AS SortOrder
				FROM avgPivot AS ap1
				CROSS JOIN overall AS o1
			) AS r
			ORDER BY r.SortOrder,
				r.QuesterId;
	';

	EXEC sp_executesql
		@sql,
		N'@QuestId int',
		@QuestId = @QuestId;

ROLLBACK TRAN;