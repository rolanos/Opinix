using MediatR;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Features.Classifiers.Dto;
using Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;

namespace Statista.Api.GraphQL.Queries;

public partial class Query
{
    [UseProjection]
    [UseFiltering]
    [UseSorting]
    public async Task<ICollection<ClassifierResponse>> GetSurveyTypes([FromServices] IMediator mediator)
    {
        var result = await mediator.Send(new GetAllSurveyTypesQuery());
        return result;
    }
}
