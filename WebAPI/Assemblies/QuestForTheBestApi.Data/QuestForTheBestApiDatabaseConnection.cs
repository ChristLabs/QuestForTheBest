using static System.Reflection.Metadata.BlobBuilder;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;

namespace QuestForTheBestApi.Data
{
    public class QuestForTheBestApiDatabaseConnection
    {
        public static string conn {  get; set; }

        public QuestForTheBestApiDatabaseConnection(IConfiguration config) => conn = config.GetConnectionString("DefaultConnection");
    }
}