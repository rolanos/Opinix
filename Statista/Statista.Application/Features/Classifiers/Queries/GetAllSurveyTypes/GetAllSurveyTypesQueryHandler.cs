using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Classifiers.Dto;
using Statista.Domain.Constants;

namespace Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;

public class GetAllSurveyTypesQueryHandler : IRequestHandler<GetAllSurveyTypesQuery, ICollection<ClassifierResponse>>
{
    private readonly IClassifierRepository _classifierRepository;

    private readonly IMapper _mapper;

    public GetAllSurveyTypesQueryHandler(IClassifierRepository classifierRepository, IMapper mapper)
    {
        _classifierRepository = classifierRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ClassifierResponse>> Handle(GetAllSurveyTypesQuery request, CancellationToken cancellationToken)
    {
        var roles = await _classifierRepository.GetAllChildrenByParentId(SurveyTypeConstants.SurveyTypeParent.Id);

        return _mapper.Map<ICollection<ClassifierResponse>>(roles);
    }
}