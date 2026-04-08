using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.AdminGroups.Dto;
using Statista.Domain.Constants;
using Statista.Domain.Errors;

namespace Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;

public class CreateAdminGroupCommandHandler : IRequestHandler<CreateAdminGroupCommand, AdminGroupResponse>
{
    private readonly IAdminGroupRepository _adminGroupRepository;
    private readonly ISurveyRepository _surveyRepository;
    private readonly IUserRepository _userRepository;
    private readonly IMapper _mapper;

    public CreateAdminGroupCommandHandler(IAdminGroupRepository adminGroupRepository,
                                          ISurveyRepository surveyRepository,
                                          IUserRepository userRepository,
                                          IMapper mapper)
    {
        _adminGroupRepository = adminGroupRepository;
        _surveyRepository = surveyRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<AdminGroupResponse> Handle(CreateAdminGroupCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserByEmail(request.userEmail);

        if (user is null)
        {
            throw new HandlerException("User with this email not found");
        }

        var survey = await _surveyRepository.GetSurveyById(request.SurveyId);

        if (survey is null)
        {
            throw new HandlerException("Survey not found");
        }

        var adminGroups = await _adminGroupRepository.GetAdminGroupBySurveyId(survey.Id);

        var contains = adminGroups.FirstOrDefault(a => a.UserId == user.Id);

        if (contains is not null)
        {
            throw new HandlerException("User already added to admin group");
        }

        var adminGroup = new AdminGroup
        {
            SurveyId = request.SurveyId,
            UserId = user.Id,
            RoleId = RoleTypeConstants.SurveyEditor.Id,
        };

        var newAdminGroup = await _adminGroupRepository.CreateAdminGroup(adminGroup);

        if (newAdminGroup is null)
        {
            throw new HandlerException("Admin Group have not created");
        }
        return _mapper.Map<AdminGroupResponse>(newAdminGroup);
    }
}