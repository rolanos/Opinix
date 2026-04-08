using AutoMapper;
using Statista.Application.Features.SurveyConfigurations.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.SurveyConfigurations;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<SurveyConfiguration, SurveyConfigurationResponse>().ReverseMap();
    }
}