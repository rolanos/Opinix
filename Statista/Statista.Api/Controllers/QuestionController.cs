using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Questions.Commands.ConfirmModerate;
using Statista.Application.Features.Questions.Commands.CreateGeneralQuestionForm;
using Statista.Application.Features.Questions.Commands.DeleteQuestionById;
using Statista.Application.Features.Questions.Commands.UpdateQuestion;
using Statista.Application.Features.Questions.Dto;
using Statista.Application.Features.Questions.Queries.GetGeneralQuestion;
using Statista.Application.Features.Questions.Queries.GetModerateQuestion;
using Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;
using Statista.Application.Features.Questions.Queries.GetUserGeneralHistoryQuestions;
using Statista.Application.Features.Questions.Queries.GetUserGeneralQuestions;
using Statista.Domain.Constants;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("questions")]
public class QuestionController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateQuestion(CreateQuestionCommand request)
    {
        var userId = GetUserId();
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Created(nameof(result), result);
    }

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetQuestionsBySectionId([FromQuery] GetQuestionByIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [AllowAnonymous]
    [Route("general/next")]
    public async Task<IActionResult> GetQuestionsBySectionId()
    {
        var result = await mediator.Send(new GetGeneralQuestionQuery());
        if (result == null)
        {
            return Ok("На данный момент нет новых вопросов");
        }
        return Ok(mapper.Map<QuestionResponse>(result));
    }

    [HttpGet]
    [Authorize(Roles = $"{RolesConstants.Admin}, {RolesConstants.Moderator}")]
    [Route("general/next-to-moderate")]
    public async Task<IActionResult> GetNextToModerateQuestion()
    {
        var result = await mediator.Send(new GetModerateQuestion());
        return Ok(result);
    }

    [HttpPost]
    [Route("general/create-form")]
    public async Task<IActionResult> CreateGeneralQuestionForm([FromBody] CreateGeneralQuestionFormCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    [Authorize(Roles = $"{RolesConstants.Admin}, {RolesConstants.Moderator}")]
    [Route("general/confirm-moderate")]
    public async Task<IActionResult> ConfirmModerateQuestion([FromBody] ConfirmModerateCommand request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }


    [HttpGet]
    [Route("general/my")]
    public async Task<IActionResult> GetUserQuestions([FromQuery] GetUserGeneralQuestionsQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [Route("general/history")]
    public async Task<IActionResult> GetHistoryQuestions([FromQuery] GetUserGeneralHistoryQuestionsQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPatch]
    public async Task<IActionResult> UpdateQuestion(UpdateQuestionCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteById(DeleteQuestionByIdCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(mapper.Map<QuestionResponse>(result));
    }
}