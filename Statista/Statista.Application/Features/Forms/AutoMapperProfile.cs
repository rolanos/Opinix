using AutoMapper;
using Statista.Application.Features.Forms.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<FormResponse, Form>().ReverseMap();
    }
}