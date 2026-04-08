using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Surveys.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public class GetSurveysQueryHandler : IRequestHandler<GetSurveysQuery, ICollection<SurveyResponse>>
{
    private readonly ISurveyRepository _surveyRepository;

    private readonly IMapper _mapper;

    public GetSurveysQueryHandler(ISurveyRepository surveyRepository, IMapper mapper)
    {
        _surveyRepository = surveyRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<SurveyResponse>> Handle(GetSurveysQuery request, CancellationToken cancellationToken)
    {
        var surveys = await _surveyRepository.GetAllSurveys();
        var result = new List<SurveyResponse>();
        foreach (var survey in surveys)
        {
            result.Add(_mapper.Map<SurveyResponse>(survey));
        }
        return result.AsReadOnly();
    }
}