using AutoMapper;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files;

internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Domain.Entities.AppFile, AppFileResponse>().ReverseMap();
        CreateMap<Domain.Entities.AppFile, FileDataResponse>().ReverseMap();
    }
}