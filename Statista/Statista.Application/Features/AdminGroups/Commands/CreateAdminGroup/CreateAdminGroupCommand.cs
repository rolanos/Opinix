
using MediatR;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups.Commands.CreateAdminGroup;

public record CreateAdminGroupCommand(string userEmail, Guid SurveyId) : IRequest<AdminGroupResponse>;