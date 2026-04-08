using MediatR;
using Statista.Application.Features.Users.Dto;

namespace Statista.Application.Features.Users.Queries.ConfirmEmail;

public record ConfirmEmailQuery(string Email, string Token) : IRequest<LoginConfirmResponse>;