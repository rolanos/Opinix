using MediatR;
using Statista.Application.Users.Dto;

namespace Statista.Application.Users.Queries.GetUserById;

public record GetUserByIdQuery(Guid Id) : IRequest<UserResponse>;