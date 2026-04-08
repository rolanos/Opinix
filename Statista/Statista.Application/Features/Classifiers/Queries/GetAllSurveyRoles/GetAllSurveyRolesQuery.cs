using MediatR;
using Statista.Application.Features.Classifiers.Dto;

namespace Statista.Application.Features.Classifiers.Queries.GetAllSurveyRoles;

public record GetAllSurveyRolesQuery() : IRequest<ICollection<ClassifierResponse>>;