using MediatR;
using Microsoft.AspNetCore.Mvc;
using Statista.Application.Users.Dto;
using Statista.Application.Users.Queries.GetUsers;

namespace Statista.Api.GraphQL.Queries;

public partial class Query
{
    [UseProjection]
    [UseFiltering]
    [UseSorting]
    public async Task<ICollection<UserResponse>> GetUsers([FromServices] IMediator mediator)
    {
        var result = await mediator.Send(new GetUsersQuery());
        return result;
    }
}