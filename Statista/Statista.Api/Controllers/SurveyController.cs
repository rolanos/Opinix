using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Route("surveys")]
public class SurveyController : BaseController
{
    [HttpGet]
    public async Task<IActionResult> GetSurveys()
    {
        var result = await mediator.Send(new GetSurveysQuery());
        return Ok(result);
    }
}