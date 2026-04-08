using MediatR;
using Statista.Application.Features.SurveyConfigurations.Dto;
using Statista.Application.Users.Dto;

namespace Statista.Application.Features.SurveyConfigurations.Queries.GetSurveyConfiguration;

public record GetSurveyConfigurationQuery(Guid SurveyId) : IRequest<SurveyConfigurationResponse>;