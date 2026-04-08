using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Users.Dto;
using Statista.Application.Users.Queries.GetUserById;
using Statista.Domain.Errors;

namespace Statista.Application.Users.Queries.GetUserByEmail;

public class GetUserByIdQueryHandler : IRequestHandler<GetUserByIdQuery, UserResponse>
{
    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public GetUserByIdQueryHandler(IUserRepository userRepository, IMapper mapper)
    {
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<UserResponse> Handle(GetUserByIdQuery request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.Id);
        if (user == null)
        {
            throw new NotFoundException("User not found");
        }
        return _mapper.Map<UserResponse>(user);
    }
}