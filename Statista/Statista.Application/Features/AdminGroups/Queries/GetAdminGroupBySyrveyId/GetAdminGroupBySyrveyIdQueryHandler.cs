using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;

public class GetAdminGroupBySurveyIdQueryHandler : IRequestHandler<GetAdminGroupBySurveyIdQuery, ICollection<AdminGroupResponse>>
{
    private readonly IAdminGroupRepository _adminGroupRepository;

    private readonly IMapper _mapper;

    public GetAdminGroupBySurveyIdQueryHandler(IAdminGroupRepository adminGroupRepository, IMapper mapper)
    {
        _adminGroupRepository = adminGroupRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<AdminGroupResponse>> Handle(GetAdminGroupBySurveyIdQuery request, CancellationToken cancellationToken)
    {
        var adminGroup = await _adminGroupRepository.GetAdminGroupBySurveyId(request.SurveyId);
        var result = new List<AdminGroupResponse>();
        foreach (var item in adminGroup)
        {
            result.Add(_mapper.Map<AdminGroupResponse>(item));
        }

        return result;
    }
}