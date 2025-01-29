using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Protocols;
using System.Runtime.InteropServices;
using QuestForTheBestApi.Data;

namespace QuestForTheBestApi.Data
{
	public static class QuestForTheBestDataProcessor
	{
		public static int GetTotalScores()
		{
			int ret = 0;
			using (var sqlConn = new SqlConnection(QuestForTheBestApiDatabaseConnection.conn))
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

			return ret;
		}
	}
}