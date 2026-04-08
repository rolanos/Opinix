using MediatR;
using Statista.Application.Features.Analitical.Dto;

namespace Statista.Application.Features.Analitical.Queries.GetAnaliticDataByQuestion;

public record GetAnaliticDataByQuestionQuery(Guid QuestionId, AnaliticRequest? AnaliticRequest) : IRequest<AnaliticalComplexResponse>;