using AutoMapper;
using Statista.Application.Features.AvailableAnswers.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.AvailableAnswers;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<AvailableAnswer, AvailableAnswerResponse>().ReverseMap();
    }
}