using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using QuestForTheBestApi.Data;

namespace TimeSlackerApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestForTheBestController : ControllerBase
    {
        #region ConnectionString
        public QuestForTheBestController(IConfiguration config)
        {
            QuestForTheBestApiDatabaseConnection conn = new QuestForTheBestApiDatabaseConnection(config);
        }
        #endregion

        [HttpGet]
        [Route("GetTotalScores")]
        public int GetTotalScores() => QuestForTheBestDataProcessor.GetTotalScores();
    }
}
