using AutoMapper;
using Statista.Application.UserInfos.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.UserInfos;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<UserInfo, UserInfoResponse>().ReverseMap();
    }
}