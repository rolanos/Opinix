using AutoMapper;
using Statista.Application.UserInfos.Dto;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Menus;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<UserInfo, UserInfoResponse>().ReverseMap();
        CreateMap<User, UserResponse>().ReverseMap()
                                       .ForMember(dest => dest.UserInfo, opt => opt.MapFrom(src => src.UserInfo));
    }
}