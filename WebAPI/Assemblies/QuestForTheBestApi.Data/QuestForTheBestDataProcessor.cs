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
	}
}