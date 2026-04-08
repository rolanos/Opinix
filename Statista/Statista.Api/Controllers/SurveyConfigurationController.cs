using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;
using Statista.Application.Features.SurveyConfigurations.Queries.GetSurveyConfiguration;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("survey_configurations")]
public class SurveyConfigurationController : BaseController
{

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetSurveyConfigurationBySurveyId([FromQuery] GetSurveyConfigurationQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPatch]
    public async Task<IActionResult> CreateSurveyConfiguration(UpdateSurveyConfigurationCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Created(nameof(result), result);
    }
}