using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Statista.Api.Controllers;

[ApiController]
public abstract class BaseController : ControllerBase
{
    private IMediator? _mediator;
    private IMapper? _mapper;

    private ILogger<BaseController>? _logger;

    protected IMediator mediator => (_mediator ??= HttpContext.RequestServices.GetService<IMediator>()) ?? throw new ArgumentException("DI error: no IMediator in BaseController");
    protected IMapper mapper => (_mapper ??= HttpContext.RequestServices.GetService<IMapper>()) ?? throw new ArgumentException("DI error: no IMapper in BaseController");
    protected ILogger<BaseController> logger
    {
        get
        {
            return (_logger ??= HttpContext.RequestServices.GetService<ILogger<BaseController>>()) ?? throw new ArgumentException("DI error: no ILogger in BaseController");
        }
    }

    protected Guid? GetUserId()
    {
        // Или альтернативный вариант через JwtRegisteredClaimNames
        var userId = User.Claims?.FirstOrDefault()?.Value;

        if (userId != null)
        {
            return Guid.Parse(userId);
        }
        return null;
    }
}