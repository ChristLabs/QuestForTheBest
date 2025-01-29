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
        public static List<Cocktail> GetCocktails()
        {
            var ret = new List<Cocktail>();

            using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
            {
                using (var cmd = sqlConn.CreateCommand())
				{
					cmd.CommandText = @"
						SELECT CocktailName
								,CocktailDescription
								,DateOfQuest
							FROM Cocktails;";

					sqlConn.Open();

					using var dr = cmd.ExecuteReader();
					while (dr.Read())
					{
						ret.Add(new Cocktail()
						{
							CocktailName = dr.GetString(0),
							CocktailDescription = dr.GetString(1),
							DateOfQuest = dr.GetDateTime(2)
						});
					}
				}
			}

            return ret;
        }
    }
}