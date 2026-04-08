using MediatR;
using Statista.Application.Features.Classifiers.Dto;

namespace Statista.Application.Features.Classifiers.Queries.GetAllQuestionTypes;

public record GetAllQuestionTypesQuery() : IRequest<ICollection<ClassifierResponse>>;