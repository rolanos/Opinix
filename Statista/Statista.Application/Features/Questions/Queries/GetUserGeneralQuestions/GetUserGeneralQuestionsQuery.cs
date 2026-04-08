using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Queries.GetUserGeneralQuestions;

public record GetUserGeneralQuestionsQuery(Guid UserId) : IRequest<ICollection<QuestionResponse>>;