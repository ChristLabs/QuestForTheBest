using System.Net;
using System.Net.Mime;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace QuestForTheBest.Controllers
{
    public class RequestExceptionHandlingAttribute : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            base.OnException(context);

#if DEBUG
            //-- When debugging, we want to see the error
            context.Result = new ContentResult()
            {
                StatusCode = StatusCodes.Status500InternalServerError,
                ContentType = MediaTypeNames.Text.Plain,
                Content = context.Exception.ToString()
            };
#else
            //-- In release, hide the exception with a 500 server error
            //-- Logging should have already taken place
            context.Result = new ContentResult()
            {
                StatusCode = StatusCodes.Status500InternalServerError,
                ContentType = MediaTypeNames.Text.Plain,
                Content = context.Exception.Message.ToString()
            };
#endif
        }
    }
}
