using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Users.CreateUser;

public class DeleteUserByUsernameHandler : IRequestHandler<DeleteUserCommand, User>
{
    private readonly UserManager<User> _userManager;
    private readonly IUserRepository _userRepository;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public DeleteUserByUsernameHandler(UserManager<User> userManager, IUserRepository userRepository, IHttpContextAccessor httpContextAccessor)
    {
        _userManager = userManager;
        _userRepository = userRepository;
        _httpContextAccessor = httpContextAccessor;
    }

    public async Task<User> Handle(DeleteUserCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.id);
        if (user is null)
        {
            throw new HandlerException("User not found");
        }
        var fromUserId = _httpContextAccessor.GetUserId();
        if (fromUserId == null)
        {
            throw new NoAccessException();
        }
        var roles = await _userManager.GetRolesAsync(user);
        if (roles.Contains(RolesConstants.Admin))
        {
            var deleteResult = await _userManager.DeleteAsync(user);
            if (deleteResult == null)
            {
                throw new HandlerException("User not deleted");
            }
        }
        else
        {
            throw new NoAccessException();
        }

        return user;
    }
}