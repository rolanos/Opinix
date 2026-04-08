using MediatR;
using Statista.Application.Features.Surveys.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public record GetSurveysQuery() : IRequest<ICollection<SurveyResponse>>;