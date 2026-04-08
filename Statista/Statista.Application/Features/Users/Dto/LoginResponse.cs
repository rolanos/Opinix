namespace Statista.Application.Features.Users.Dto;

using Statista.Domain.Entities.Email;

public record LoginResponse(string Message, EmailMessage EmailMessage);

public record LoginResponseMessage(string Message, string? Email);