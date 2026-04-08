using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.AdminGroups.Dto;
using Statista.Domain.Constants;
using Statista.Domain.Errors;

namespace Statista.Application.Features.AdminGroups.Commands.DeleteAdminGroup;

public class DeleteAdminGroupCommandHandler : IRequestHandler<DeleteAdminGroupCommand, AdminGroupResponse>
{
    private readonly IAdminGroupRepository _adminGroupRepository;
    private readonly ISurveyRepository _surveyRepository;
    private readonly IUserRepository _userRepository;
    private readonly IMapper _mapper;

    public DeleteAdminGroupCommandHandler(IAdminGroupRepository adminGroupRepository,
                                          ISurveyRepository surveyRepository,
                                          IUserRepository userRepository,
                                          IMapper mapper)
    {
        _adminGroupRepository = adminGroupRepository;
        _surveyRepository = surveyRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<AdminGroupResponse> Handle(DeleteAdminGroupCommand request, CancellationToken cancellationToken)
    {
        var adminGroups = await _adminGroupRepository.GetAdminGroupBySurveyId(request.SurveyId);

        var adminGroup = adminGroups.FirstOrDefault(a => a.UserId == request.UserId);

        if (adminGroup is null)
        {
            throw new NotFoundException("Admin group not found");
        }

        if (adminGroup.RoleId == RoleTypeConstants.SurveyAdmin.Id)
        {
            throw new HandlerException("Can't delete admin");
        }

        var deletedAdminGroup = await _adminGroupRepository.DeleteAdminGroup(adminGroup);

        if (deletedAdminGroup is null)
        {
            throw new HandlerException("Admin Group have not deleted");
        }

        return _mapper.Map<AdminGroupResponse>(deletedAdminGroup);
    }
}