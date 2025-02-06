using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using QuestForTheBest.Controllers;
using QuestForTheBestApi.Data;
using QuestForTheBestApi.Data.Models;

namespace QuestForTheBestApi.Controllers
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
        [RequestExceptionHandling]
        public int GetTotalScores() => QuestForTheBestDataProcessor.GetTotalScores();

        [HttpGet]
        [Route("GetHighestScores")]
        [RequestExceptionHandling]
        public object GetHighestScores() => QuestForTheBestDataProcessor.GetHighestScores();

        [HttpGet]
        [Route("GetHighestCocktailScores")]
        [RequestExceptionHandling]
        public object GetHighestCocktailScores() => QuestForTheBestDataProcessor.GetHighestCocktailScores();

        [HttpGet]
        [Route("GetQuests")]
        [RequestExceptionHandling]
        public List<Quest> GetQuests() => QuestForTheBestDataProcessor.GetQuests();

        [HttpGet]
        [Route("GetScoresByCocktail")]
        [RequestExceptionHandling]
        public List<object> GetScoresByCocktail() => QuestForTheBestDataProcessor.GetScoresByCocktail();

        [HttpGet]
        [Route("GetScoresByQuester")]
        [RequestExceptionHandling]
        public List<object> GetScoresByQuester() => QuestForTheBestDataProcessor.GetScoresByQuester();

        [HttpGet]
        [Route("GetScoresByBar")]
        [RequestExceptionHandling]
        public List<object> GetScoresByBar() => QuestForTheBestDataProcessor.GetScoresByBar();

        [HttpGet]
        [Route("GetMapData")]
        [RequestExceptionHandling]
        public List<object> GetMapData() => QuestForTheBestDataProcessor.GetMapData();
    }
}
