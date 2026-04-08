using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Domain.Constants;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Users.Queries.CheckModerate;

public class CheckModerateQueryHandler : IRequestHandler<CheckModerateQuery, bool>
{
    private readonly UserManager<User> _userManager;

    private readonly IMapper _mapper;

    public CheckModerateQueryHandler(UserManager<User> userManager, IMapper mapper)
    {
        _userManager = userManager;
        _mapper = mapper;
    }

    public async Task<bool> Handle(CheckModerateQuery request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByIdAsync(request.UserId.ToString());
        if (user == null)
        {
            throw new NotFoundException("Пользователь не найден");
        }
        var roles = await _userManager.GetRolesAsync(user);
        return roles.Contains(RolesConstants.Admin) || roles.Contains(RolesConstants.Moderator);    
    }
}