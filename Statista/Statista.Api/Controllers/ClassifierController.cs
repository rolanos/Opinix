using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Classifiers.Queries.GetAllQuestionTypes;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyRoles;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;

namespace Statista.Api.Controllers;

[ApiController]
[Route("classifiers")]
public class ClassifierController : BaseController
{
    [HttpGet("question_types")]
    public async Task<IActionResult> GetAllQuestionTypes()
    {
        var result = await mediator.Send(new GetAllQuestionTypesQuery());
        return Ok(result);
    }

    [HttpGet("survey_roles")]
    public async Task<IActionResult> GetAllSurveyRoles()
    {
        var result = await mediator.Send(new GetAllSurveyRolesQuery());
        return Ok(result);
    }

    [HttpGet("survey_types")]
    public async Task<IActionResult> GetAllSurveyTypes()
    {
        var result = await mediator.Send(new GetAllSurveyTypesQuery());
        return Ok(result);
    }
}