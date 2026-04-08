using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Users.CreateUser;

public record DeleteUserCommand(Guid id) : IRequest<User>;
