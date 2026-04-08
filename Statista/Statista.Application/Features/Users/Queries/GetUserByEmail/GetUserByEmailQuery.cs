using MediatR;
using Statista.Application.Users.Dto;

namespace Statista.Application.Users.Queries.GetUserByEmail;

public record GetUserByEmailQuery(string Email) : IRequest<UserResponse>;