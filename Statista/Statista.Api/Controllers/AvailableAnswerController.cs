using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AvailableAnswers.Commands.UpdateAvailableAnswer;
using Statista.Application.Features.AvailableAnswers.Dto;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("avaliable_answers")]
public class AvaliableAnswerController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateAvailableAnswer(CreateAvailableAnswerCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();

        var mappedResult = mapper.Map<AvailableAnswerResponse>(result);
        return Created(nameof(mappedResult), mappedResult);
    }

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetSectionsByFormId([FromQuery] GetAvailableAnswersByQuestionIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPatch]
    public async Task<IActionResult> UpdateAvailableAnswer(UpdateAvailableAnswerCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(mapper.Map<AvailableAnswerResponse>(result));
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteById(DeleteAvailableAnswerByIdCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}