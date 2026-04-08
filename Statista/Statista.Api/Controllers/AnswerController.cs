
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Answers.Commands.CreateAnswersToForm;
using Statista.Application.Features.Forms.Commands.CreateForm;

namespace Statista.Api.Controllers;

[ApiController]
[Route("answers")]
public class AnswerController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateAnswer(CreateAnswerCommand request)
    {
        var result = await mediator.Send(request);
        if (result == Guid.Empty)
            return NoContent();
        return Created(nameof(result), result);
    }

    [HttpPost("form")]
    public async Task<IActionResult> CreateAnswer(CreateAnswersToFormCommand request)
    {
        var result = await mediator.Send(request);
        if (result == Guid.Empty)
            return NoContent();
        return Created(nameof(result), result);
    }
}