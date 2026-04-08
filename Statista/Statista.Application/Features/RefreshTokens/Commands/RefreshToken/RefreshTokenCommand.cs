using MediatR;
using Statista.Application.Features.RefreshTokens.Dto;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public record RefreshTokenCommand(Guid UserId, string RefreshToken) : IRequest<RefreshTokenResponse>;