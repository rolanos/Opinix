using MediatR;

namespace Statista.Application.Features.Users.Queries.CheckModerate;

public record CheckModerateQuery(Guid UserId) : IRequest<bool>;