USE db_ab2350_questforthebest
GO

-- Total Scores
SELECT COUNT(*) AS TotalScores
	FROM Scores;

-- Average score by cocktail
SELECT c.CocktailName, STR(AVG(s.Score), 4, 2) AS AverageScore
	FROM Scores s
		INNER JOIN Cocktails c
			ON s.CocktailId = c.CocktailId
	GROUP BY c.CocktailName
	ORDER BY AverageScore DESC;

-- Average Score by Bar
WITH cte_BarsAndQuests AS (
	SELECT DISTINCT s.QuestId, s.BarId
		FROM Scores s
		GROUP BY s.QuestId, s.BarId
),
cte_BarsTimesVisited AS (
	SELECT DISTINCT bnq.BarId, COUNT(bnq.QuestId) AS TimesVisited
		FROM cte_BarsAndQuests bnq
		GROUP BY bnq.BarId
)
SELECT b.BarName
		,STR(AVG(s.Score), 4, 2) AS AverageScore
		,MAX(btv.TimesVisited) AS TimesVisited
		,COUNT(s.Score) AS CocktailsDrank
	FROM Scores s
		INNER JOIN cte_BarsTimesVisited btv
			ON s.BarId = btv.BarId
		INNER JOIN Bars b
			ON btv.BarId = b.BarId
	GROUP BY b.BarName
	ORDER BY AverageScore DESC;

-- Average score by person
SELECT COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
		,STR(AVG(s.Score), 4, 2) AS AverageScore
		,COUNT(s.QuestId) AS CocktailsDrank
	FROM Scores s
		INNER JOIN Questers q
			ON s.QuesterId = q.QuesterId
	GROUP BY q.QuesterId, q.QuesterNickname, q.QuesterName
	ORDER BY AverageScore DESC;

-- Most Scores
SELECT COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
		,COUNT(s.QuestId) AS CocktailsDrank
	FROM Scores s
		INNER JOIN Questers q
			ON s.QuesterId = q.QuesterId
	GROUP BY q.QuesterId, q.QuesterNickname, q.QuesterName
	ORDER BY CocktailsDrank DESC;

-- Highest score given
SELECT TOP (5) COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
				,STR(s.Score, 4, 2) AS Score
				,c.CocktailName
				,b.BarName
				,quest.DateOfQuest
	FROM Scores s
		INNER JOIN Questers q
			ON s.QuesterId = q.QuesterId
		INNER JOIN Bars b
			ON s.BarId = b.BarId
		INNER JOIN Cocktails c
			ON s.CocktailId = c.CocktailId
		INNER JOIN Quests quest
			ON s.QuestId = quest.QuestId
	ORDER BY s.Score DESC;

-- Highest average score for a bar's cocktail
SELECT TOP (5)
		c.CocktailName
		,b.BarName 
		,STR(AVG(s.Score), 4, 2) AS AverageScore
	FROM Scores s
		INNER JOIN Cocktails c
			ON s.CocktailId = c.CocktailId
		INNER JOIN Bars b
			ON s.BarId = b.BarId
	GROUP BY c.CocktailId, c.CocktailName, b.BarId, b.BarName
	ORDER BY AverageScore DESC;

WITH cte_AverageScores AS (
	SELECT b.BarId, STR(AVG(s.Score), 4, 2) AS AverageScore
		FROM Bars b
			INNER JOIN Scores s
				ON b.BarId = s.BarId
		GROUP BY b.BarId
), cte_BestCocktails AS (
	SELECT b.BarId
			,c.CocktailId
			,STR(AVG(s.Score), 4, 2) AS AverageScore
			,ROW_NUMBER() OVER (PARTITION BY b.BarId ORDER BY STR(AVG(s.Score), 4, 2) DESC) AS Placement
		FROM Bars b
			INNER JOIN Scores s
				ON b.BarId = s.BarId
			INNER JOIN Cocktails c
				ON s.CocktailId = c.CocktailId
		GROUP BY b.BarId, c.CocktailId
), cte_BarsAndQuests AS (
	SELECT DISTINCT s.QuestId, s.BarId
		FROM Scores s
		GROUP BY s.QuestId, s.BarId
), cte_BarsTimesVisited AS (
	SELECT DISTINCT bnq.BarId, COUNT(bnq.QuestId) AS TimesVisited
		FROM cte_BarsAndQuests bnq
		GROUP BY bnq.BarId
)
SELECT b.BarId
		,b.Latitude
		,b.Longitude
		,b.BarName
		,cteAvg.AverageScore
		,c.CocktailName
		,btv.TimesVisited
	FROM Bars b
		INNER JOIN cte_AverageScores cteAvg
			ON b.BarId = cteAvg.BarId
		INNER JOIN cte_BestCocktails cteBest
			ON b.BarId = cteBest.BarId
		INNER JOIN Cocktails c
			ON cteBest.CocktailId = c.CocktailId
		INNER JOIN cte_BarsTimesVisited btv
			ON b.BarId = btv.BarId
	WHERE Placement = 1
	ORDER BY BarId;

-- Quest Winners
WITH cte_CocktailPlacements AS (
	SELECT c.CocktailName
			,b.BarName
			,MAX(q.DateOfQuest) AS DateOfQuest
			,STR(AVG(s.Score), 4, 2) AS AverageScore
			,ROW_NUMBER() OVER (PARTITION BY q.QuestId ORDER BY STR(AVG(s.Score), 4, 2) DESC) AS Placement
		FROM Scores s
			INNER JOIN Cocktails c
				ON s.CocktailId = c.CocktailId
			INNER JOIN Bars b
				ON s.BarId = b.BarId
			INNER JOIN Quests q
				ON s.QuestId = q.QuestId
		GROUP BY q.QuestId, c.CocktailId, c.CocktailName, b.BarId, b.BarName
)
SELECT *
	FROM cte_CocktailPlacements
	WHERE Placement = 1
	ORDER BY DateOfQuest ASC;

-- Drunkest Guy
WITH cte_QuesterScoreCounts AS (
SELECT q.QuesterId, COUNT(s.Score) AS QuesterScoreCount
	FROM Scores s
		INNER JOIN Questers q
			ON s.QuesterId = q.QuesterId
	GROUP BY q.QuesterId
)
SELECT TOP (1) q.QuesterName
		,q.QuesterNickname
		,qsc.QuesterScoreCount
		,(SELECT CAST(CAST(qsc.QuesterScoreCount AS decimal) / COUNT(*) * 100 AS decimal(4, 2)) FROM Scores) AS PercentageOfTotal
	FROM cte_QuesterScoreCounts qsc
		INNER JOIN Questers q
			ON qsc.QuesterId = q.QuesterId
	ORDER BY qsc.QuesterScoreCount DESC;