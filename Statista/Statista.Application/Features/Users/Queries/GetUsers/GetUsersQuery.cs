using MediatR;
using Statista.Application.Users.Dto;

namespace Statista.Application.Users.Queries.GetUsers;

public record GetUsersQuery() : IRequest<ICollection<UserResponse>>;