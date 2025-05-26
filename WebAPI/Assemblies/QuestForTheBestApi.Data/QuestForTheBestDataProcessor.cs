using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Protocols;
using System.Runtime.InteropServices;
using QuestForTheBestApi.Data;
using QuestForTheBestApi.Data.Models;

namespace QuestForTheBestApi.Data
{
	public static class QuestForTheBestDataProcessor
	{
		public static int GetTotalScores()
		{
			int ret = 0;
			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"SELECT COUNT(*)
											FROM Scores;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					if (dr.Read())
					{
						ret = dr.GetInt32(0);
					}
				}
			}

			return ret;
		}

		public static List<object> GetHighestScores()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						SELECT TOP (5) 
								COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
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
							ORDER BY s.Score DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							QuesterName = dr.GetString(0),
							Score = dr.GetDecimal(1),
							CocktailName = dr.GetString(2),
							BarName = dr.GetString(3),
							DateOfQuest = dr.GetDateTime(4)
						});
					}
				}
			}

			return ret;
		}

		public static List<object> GetHighestCocktailScores()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
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
							ORDER BY AverageScore DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							CocktailName = dr.GetString(0),
							BarName = dr.GetString(1),
							AverageScore = dr.GetString(2)
						});
					}
				}
			}

			return ret;
		}

		public static List<Quest> GetQuests()
		{
			var ret = new List<Quest>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						SELECT q.QuestId
								,c.CocktailId
								,c.CocktailName
								,c.CocktailDescription
								,q.DateOfQuest
							FROM Quests q
								INNER JOIN Cocktails c
									ON q.PrimaryCocktailId = c.CocktailId;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new Quest()
						{
							QuestId = dr.GetInt16(0),
							CocktailId = dr.GetInt16(1),
							CocktailName = dr.GetString(2),
							CocktailDescription = dr.GetString(3),
							DateOfQuest = dr.GetDateTime(4)
						});
					}
				}
			}

			return ret;
		}

		public static List<object> GetScoresByCocktail()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						SELECT c.CocktailName, STR(AVG(s.Score), 4, 2) AS AverageScore
							FROM Scores s
								INNER JOIN Cocktails c
									ON s.CocktailId = c.CocktailId
							GROUP BY c.CocktailName
							ORDER BY AverageScore DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new 
						{
							CocktailName = dr.GetString(0),
							AverageScore = dr.GetString(1)
						});
					}
				}
			}

			return ret;
		}

		public static List<object> GetScoresByQuester()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						SELECT COALESCE(q.QuesterNickname, q.QuesterName) AS QuesterName
								,STR(AVG(s.Score), 4, 2) AS AverageScore
								,COUNT(s.QuestId) AS CocktailsDrank
							FROM Scores s
								INNER JOIN Questers q
									ON s.QuesterId = q.QuesterId
							GROUP BY q.QuesterId, q.QuesterNickname, q.QuesterName
							ORDER BY AverageScore DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							QuesterName = dr.GetString(0),
							AverageScore = dr.GetString(1),
							CocktailsDrank = dr.GetInt32(2)
						});
					}
				}
			}

			return ret;
		}

		public static List<object> GetScoresByBar()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
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
							ORDER BY AverageScore DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							BarName = dr.GetString(0),
							AverageScore = dr.GetString(1),
							TimesVisited = dr.GetInt32(2),
							CocktailsDrank = dr.GetInt32(3)
						});
					}
				}
			}

			return ret;
		}

		public static List<object> GetQuestWinners()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
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
											AND s.CocktailId = q.PrimaryCocktailId
								GROUP BY q.QuestId, c.CocktailId, c.CocktailName, b.BarId, b.BarName
						)
						SELECT *
							FROM cte_CocktailPlacements
							WHERE Placement = 1
							ORDER BY DateOfQuest ASC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							CocktailName = dr.GetString(0),
							BarName = dr.GetString(1),
							DateOfQuest = dr.GetDateTime(2),
							AverageScore = dr.GetString(3)
						});
					}
				}
			}

			return ret;
		}

		public static object GetDrunkestGuy()
		{
			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						WITH cte_QuesterScoreCounts AS (
							SELECT q.QuesterId, COUNT(s.Score) AS QuesterScoreCount
								FROM Scores s
									INNER JOIN Questers q
										ON s.QuesterId = q.QuesterId
								GROUP BY q.QuesterId
						)
						SELECT q.QuesterName
								,q.QuesterNickname
								,qsc.QuesterScoreCount
								,(SELECT CAST(CAST(qsc.QuesterScoreCount AS decimal) / COUNT(*) * 100 AS decimal(4, 2)) FROM Scores) AS PercentageOfTotal
							FROM cte_QuesterScoreCounts qsc
								INNER JOIN Questers q
									ON qsc.QuesterId = q.QuesterId
							ORDER BY qsc.QuesterScoreCount DESC;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						return new
						{
							QuesterName = dr.GetString(0),
							QuesterNickname = dr.GetString(1),
							QuesterScoreCount = dr.GetInt32(2),
							PercentageOfTotal = dr.GetDecimal(3)
						};
					}
				}
			}

			return null;
		}

		public static List<object> GetMapData()
		{
			var ret = new List<object>();

			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
			{
				using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
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
								AND b.Latitude IS NOT NULL
								AND b.Longitude IS NOT NULL
							ORDER BY BarId;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new
						{
							BarId = dr.GetInt16(0),
							Latitude = dr.GetDecimal(1).ToString(),
							Longitude = dr.GetDecimal(2).ToString(),
							BarName = dr.GetString(3),
							AverageScore = dr.GetString(4),
							BestCocktail = dr.GetString(5),
							TimesVisited = dr.GetInt32(6),
						});
					}
				}
			}

			return ret;
		}
	}
}