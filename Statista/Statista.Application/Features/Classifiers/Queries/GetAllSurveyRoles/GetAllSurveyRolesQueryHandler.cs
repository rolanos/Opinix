using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Classifiers.Dto;
using Statista.Domain.Constants;

namespace Statista.Application.Features.Classifiers.Queries.GetAllSurveyRoles;

public class GetAllSurveyRolesQueryHandler : IRequestHandler<GetAllSurveyRolesQuery, ICollection<ClassifierResponse>>
{
    private readonly IClassifierRepository _classifierRepository;

    private readonly IMapper _mapper;

    public GetAllSurveyRolesQueryHandler(IClassifierRepository classifierRepository, IMapper mapper)
    {
        _classifierRepository = classifierRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ClassifierResponse>> Handle(GetAllSurveyRolesQuery request, CancellationToken cancellationToken)
    {
        var roles = await _classifierRepository.GetAllChildrenByParentId(RoleTypeConstants.RoleTypeParent.Id);

        return _mapper.Map<ICollection<ClassifierResponse>>(roles);
    }
}