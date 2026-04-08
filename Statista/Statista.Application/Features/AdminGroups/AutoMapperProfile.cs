using AutoMapper;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<AdminGroup, AdminGroupResponse>().ReverseMap();
    }
}