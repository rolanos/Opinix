using AutoMapper;
using Statista.Application.Features.Sections.Dto;
using Statista.Domain.Entities;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Section, SectionResponse>().ReverseMap()
            .ForMember(dest => dest.Questions, opt => opt.MapFrom(src => src.Questions));
    }
}