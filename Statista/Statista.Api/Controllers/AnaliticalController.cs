using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Analitical.Dto;
using Statista.Application.Features.Analitical.Queries.GetAnaliticDataByQuestion;

namespace Statista.Api.Controllers;

[ApiController]
[Route("analitical")]
public class AnaliticalController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> CreateAnswer([FromQuery] Guid QuestionId, [FromQuery] AnaliticRequest? AnaliticRequest)
    {
        var request = new GetAnaliticDataByQuestionQuery(QuestionId, AnaliticRequest);
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}