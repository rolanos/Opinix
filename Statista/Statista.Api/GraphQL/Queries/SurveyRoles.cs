using MediatR;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Classifiers.Dto;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyRoles;

namespace Statista.Api.GraphQL.Queries;

public partial class Query
{
    [UseProjection]
    [UseFiltering]
    [UseSorting]
    public async Task<ICollection<ClassifierResponse>> GetSurveyRoles([FromServices] IMediator mediator)
    {
        var result = await mediator.Send(new GetAllSurveyRolesQuery());
        return result;
    }
}
