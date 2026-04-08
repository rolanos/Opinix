using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.SurveyConfigurations.Dto;
using Statista.Application.Features.SurveyConfigurations.Queries.GetSurveyConfiguration;

namespace Statista.Application.Users.Queries.GetUserByEmail;

public class GetSurveyConfigurationQueryHandler : IRequestHandler<GetSurveyConfigurationQuery, SurveyConfigurationResponse>
{
    private readonly ISurveyConfigurationRepository _surveyConfigurationRepository;

    private readonly IMapper _mapper;

    public GetSurveyConfigurationQueryHandler(ISurveyConfigurationRepository surveyConfigurationRepository, IMapper mapper)
    {
        _surveyConfigurationRepository = surveyConfigurationRepository;
        _mapper = mapper;
    }

    public async Task<SurveyConfigurationResponse> Handle(GetSurveyConfigurationQuery request, CancellationToken cancellationToken)
    {
        var user = await _surveyConfigurationRepository.GetSurveyConfigurationBySurveyId(request.SurveyId);
        return _mapper.Map<SurveyConfigurationResponse>(user);
    }
}