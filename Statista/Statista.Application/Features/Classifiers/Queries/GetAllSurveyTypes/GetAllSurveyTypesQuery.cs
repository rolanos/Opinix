using MediatR;
using Statista.Application.Features.Classifiers.Dto;

namespace Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;

public record GetAllSurveyTypesQuery() : IRequest<ICollection<ClassifierResponse>>;