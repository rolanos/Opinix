using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Forms.Commands.CreateForm;
using Statista.Application.Features.Forms.Dto;
using Statista.Application.Features.Forms.Queries.GetAllForms;
using Statista.Application.Features.Forms.Queries.GetFormById;
using Statista.Application.Features.Forms.Queries.GetFormsByUserId;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("forms")]
public class FormController : BaseController
{
    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetAllForms([FromQuery] GetAllFormsQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [AllowAnonymous]
    [Route("formId")]
    public async Task<IActionResult> GetFormById([FromQuery] GetFormByIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpGet]
    [Route("userId")]
    public async Task<IActionResult> GetFormByUserId([FromQuery] GetFormsByUserIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateForm(CreateFormCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        var mappedResult = mapper.Map<FormResponse>(result);
        return Created(nameof(mappedResult), mappedResult);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteForm(DeleteFormByIdCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(mapper.Map<FormResponse>(result));
    }
}