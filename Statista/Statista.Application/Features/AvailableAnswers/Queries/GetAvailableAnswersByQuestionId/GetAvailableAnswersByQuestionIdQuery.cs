using MediatR;
using Statista.Application.Features.AvailableAnswers.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public record GetAvailableAnswersByQuestionIdQuery(Guid QuestionId) : IRequest<ICollection<AvailableAnswerResponse>>;