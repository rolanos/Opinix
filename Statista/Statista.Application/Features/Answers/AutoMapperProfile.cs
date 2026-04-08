using AutoMapper;
using Statista.Application.Features.Answers.Dto;
using Statista.Application.Features.AvailableAnswers.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Answers;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Answer, AnswerResponse>().ReverseMap();
    }
}