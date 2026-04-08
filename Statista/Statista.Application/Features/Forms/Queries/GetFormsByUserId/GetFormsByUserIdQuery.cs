using MediatR;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetFormsByUserId;

public record GetFormsByUserIdQuery(Guid UserId) : IRequest<ICollection<FormResponse>>;