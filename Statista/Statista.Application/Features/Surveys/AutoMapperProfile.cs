using AutoMapper;
using Statista.Application.Features.Surveys.Dto;

namespace Statista.Application.Features.Surveys;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<SurveyResponse, Survey>().ReverseMap();
    }
}