using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Authentification.Commands.Register;
using Statista.Application.Authentification.Queries.Login;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Application.Features.Users.Dto;
using Statista.Application.Features.Users.Queries.CheckModerate;
using Statista.Application.Features.Users.Queries.ConfirmEmail;
using Statista.Domain.Entities;

namespace Statista.Api.Controllers;

[ApiController]
[Route("auth")]
public class AuthenticationController : BaseController
{
    private readonly IMediator _mediator;

    private readonly UserManager<User> _userManager;

    private readonly SignInManager<User> _signInManager;

    private readonly IMailService _mailService;

    public AuthenticationController(IMediator mediator,
                                    UserManager<User> userManager,
                                    SignInManager<User> signInManager,
                                    IMailService mailService)
    {
        _mediator = mediator;
        _userManager = userManager;
        _mailService = mailService;
        _signInManager = signInManager;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterCommand request)
    {

        var authResult = await _mediator.Send(request);

        if (authResult.EmailMessage != null)
        {
            _mailService.SendEmail(authResult.EmailMessage);
        }

        return Ok(new LoginResponseMessage(authResult.Message, authResult.EmailMessage?.ToEmail));
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginQuery request)
    {
        var authResult = await _mediator.Send(request);

        if (authResult.EmailMessage != null)
        {
            _mailService.SendEmail(authResult.EmailMessage);
        }

        return Ok(new LoginResponseMessage(authResult.Message, authResult.EmailMessage?.ToEmail));
    }

    [HttpPost("confirm_email")]
    public async Task<IActionResult> ConfirmToken(ConfirmEmailQuery request)
    {
        var result = await _mediator.Send(request);

        HttpContext.Response.Headers.Append("Authorization", "Bearer " + result.AccessToken);

        return Ok(result);
    }

    [HttpGet("check-moderate")]
    public async Task<IActionResult> CheckModerate([FromQuery] CheckModerateQuery request)
    {
        var result = await _mediator.Send(request);

        return Ok(result);
    }

    [HttpPost("logout")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        await _signInManager.SignOutAsync(); // Удаляет куки/токен
        return Ok();
    }

    [HttpPost("refresh-token")]
    public async Task<IActionResult> RefreshToken(RefreshTokenCommand request)
    {
        var result = await _mediator.Send(request);

        HttpContext.Response.Headers.Append("Authorization", "Bearer " + result.AccessToken);

        return Ok(result);
    }
}