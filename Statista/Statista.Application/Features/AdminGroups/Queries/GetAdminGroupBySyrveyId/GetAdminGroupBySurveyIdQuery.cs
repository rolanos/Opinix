using MediatR;
using Statista.Application.Features.AdminGroups.Dto;

namespace Statista.Application.Features.AdminGroups.Queries.GetAdminGroupBySyrveyId;

public record GetAdminGroupBySurveyIdQuery(Guid SurveyId) : IRequest<ICollection<AdminGroupResponse>>;