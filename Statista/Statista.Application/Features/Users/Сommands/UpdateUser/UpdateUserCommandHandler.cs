using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Users.CreateUser;

public class UpdateUserCommandHandler : IRequestHandler<UpdateUserCommand, User>
{
    private readonly IUserRepository _userRepository;

    private IMapper _mapper;
    public UpdateUserCommandHandler(IMapper mapper, IUserRepository userRepository)
    {
        _mapper = mapper;
        _userRepository = userRepository;
    }

    public async Task<User> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.Id);
        if (user is not null)
        {
            var updatedUser = new User
            {
                Id = request.Id,
                Email = request.Email,
                CreatedDate = user.CreatedDate,
                UpdatedDate = DateTime.UtcNow,
            };
            updatedUser = await _userRepository.UpdateUser(updatedUser);
            if (updatedUser is null)
            {
                throw new HandlerException("User update error");
            }
            return updatedUser;
        }
        else
        {
            throw new NotFoundException("User not found");
        }
    }
}