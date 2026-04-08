
using MediatR;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups.Commands.UpdateAdminGroup;

public record UpdateAdminGroupCommand(Guid SurveyId, Guid UserId, Guid RoleId) : IRequest<AdminGroupResponse>;