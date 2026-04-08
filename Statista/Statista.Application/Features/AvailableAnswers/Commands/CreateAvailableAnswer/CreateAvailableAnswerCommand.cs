
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public record CreateAvailableAnswerCommand(Guid QuestionId,
                                           string? Text,
                                           string? ImageLink) : IRequest<AvailableAnswer>;