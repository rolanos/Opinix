using MediatR;
using Statista.Application.Features.Users.Dto;

namespace Statista.Application.Authentification.Commands.Register;

public record RegisterCommand(string Email, string Password) : IRequest<LoginResponse>;