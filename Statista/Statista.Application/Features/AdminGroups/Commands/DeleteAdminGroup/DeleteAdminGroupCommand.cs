
using MediatR;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups.Commands.DeleteAdminGroup;

public record DeleteAdminGroupCommand(Guid SurveyId, Guid UserId) : IRequest<AdminGroupResponse>;