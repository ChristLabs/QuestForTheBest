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
SELECT TOP (10) COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
				,s.Score
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