using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Users.CreateUser;
using Statista.Application.Users.Dto;
using Statista.Application.Users.Queries.GetUserById;
using Statista.Application.Users.Queries.GetUsers;

namespace Statista.Api.Controllers;

[ApiController]
[Authorize]
[Route("users")]
public class UserController : BaseController
{
    [HttpGet("all")]
    public async Task<IActionResult> GetUsers()
    {
        var result = await mediator.Send(new GetUsersQuery());
        return Ok(result);
    }

    [HttpGet()]
    public async Task<IActionResult> GetUserById([FromQuery] Guid id)
    {
        var result = await mediator.Send(new GetUserByIdQuery(id));
        return Ok(result);
    }

    [HttpDelete()]
    public async Task<IActionResult> DeleteUser([FromQuery] Guid id)
    {
        var result = await mediator.Send(new DeleteUserCommand(id));
        if (result == null)
            return NoContent();
        return Ok(result);
    }

    [HttpPut()]
    public async Task<IActionResult> UpdateUser(UpdateUserCommand request)
    {
        var result = await mediator.Send(request);
        if (result == null)
            return NoContent();
        return Ok(mapper.Map<UserResponse>(result));
    }
}