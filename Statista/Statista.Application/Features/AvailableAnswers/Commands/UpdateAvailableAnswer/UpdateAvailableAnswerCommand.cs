
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.AvailableAnswers.Commands.UpdateAvailableAnswer;

public record UpdateAvailableAnswerCommand(Guid Id,
                                           string? Text,
                                           string? ImageLink) : IRequest<AvailableAnswer>;