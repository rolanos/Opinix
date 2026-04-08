using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Sections.Command.DeleteSection;
using Statista.Application.Features.Sections.Dto;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Surveys.Queries.GetSurveys;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("sections")]
public class SectionController : BaseController
{
    [HttpPost]
    public async Task<IActionResult> CreateSections(CreateSectionCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return Ok();
        var mappedResult = mapper.Map<SectionResponse>(result);
        return Created(nameof(mappedResult), mappedResult);
    }

    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetSectionsByFormId([FromQuery] GetSectionsByFormIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteSection(DeleteSectionCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}