using AutoMapper;
using Statista.Application.Features.Classifiers.Dto;

namespace Statista.Application.Features.Classifiers;
internal sealed class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Classifier, ClassifierResponse>().ReverseMap();
    }
}