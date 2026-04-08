using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.AdminGroups.Dto;
using Statista.Domain.Constants;
using Statista.Domain.Errors;

namespace Statista.Application.Features.AdminGroups.Commands.UpdateAdminGroup;

public class UpdateAdminGroupCommandHandler : IRequestHandler<UpdateAdminGroupCommand, AdminGroupResponse>
{
    private readonly IAdminGroupRepository _adminGroupRepository;
    private readonly ISurveyRepository _surveyRepository;
    private readonly IUserRepository _userRepository;
    private readonly IMapper _mapper;

    public UpdateAdminGroupCommandHandler(IAdminGroupRepository adminGroupRepository,
                                          ISurveyRepository surveyRepository,
                                          IUserRepository userRepository,
                                          IMapper mapper)
    {
        _adminGroupRepository = adminGroupRepository;
        _surveyRepository = surveyRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<AdminGroupResponse> Handle(UpdateAdminGroupCommand request, CancellationToken cancellationToken)
    {
        var survey = await _surveyRepository.GetSurveyById(request.SurveyId);

        if (survey is null)
        {
            throw new NotFoundException("Survey not found");
        }

        var adminGroups = await _adminGroupRepository.GetAdminGroupBySurveyId(survey.Id);

        var adminGroup = adminGroups.FirstOrDefault(a => a.UserId == request.UserId);

        if (adminGroup is null)
        {
            throw new HandlerException("User not added to admin group");
        }

        var containsRole = RoleTypeConstants.values.FirstOrDefault(r => r.Id == request.RoleId);

        if (containsRole is null)
        {
            throw new NotFoundException("No role with this ID");
        }

        adminGroup.RoleId = request.RoleId;
        adminGroup.Role = containsRole;

        var newAdminGroup = await _adminGroupRepository.UpdateAdmin(adminGroup);

        if (newAdminGroup is null)
        {
            throw new HandlerException("Admin Group have not updated");
        }

        return _mapper.Map<AdminGroupResponse>(newAdminGroup);
    }
}