
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.UserInfos.Commands.UpdateUserInfo;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("user_infos")]
public class UserInfoController : BaseController
{
    [HttpPut]
    public async Task<IActionResult> UpdateUserInfo(UpdateUserInfoCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(result);
    }
}