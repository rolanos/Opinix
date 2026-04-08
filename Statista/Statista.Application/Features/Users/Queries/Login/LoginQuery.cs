using MediatR;
using Statista.Application.Features.Users.Dto;

namespace Statista.Application.Authentification.Queries.Login;

public record LoginQuery(
    string Email,
    string Password) : IRequest<LoginResponse>;