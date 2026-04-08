using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Queries.GetUserGeneralHistoryQuestions;

public record GetUserGeneralHistoryQuestionsQuery(Guid UserId) : IRequest<ICollection<QuestionResponse>>;