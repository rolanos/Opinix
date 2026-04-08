using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;
using Statista.Application.Features.AdminGroups.Commands.DeleteAdminGroup;
using Statista.Application.Features.AdminGroups.Commands.UpdateAdminGroup;
using Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("admin_groups")]
public class AdminGroupController : BaseController
{
    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetAdminGroupBySyrveyId([FromQuery] GetAdminGroupBySurveyIdQuery request)
    {
        var result = await mediator.Send(request);
        return Ok(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateAdminGroup(CreateAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Created(nameof(result), result);
    }

    [HttpPatch]
    public async Task<IActionResult> UpdateAdminGroup(UpdateAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }

    [HttpDelete]
    public async Task<IActionResult> DeleteAdminGroup(DeleteAdminGroupCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}