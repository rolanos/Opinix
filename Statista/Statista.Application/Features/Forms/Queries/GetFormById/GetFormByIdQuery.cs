using MediatR;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetFormById;

public record GetFormByIdQuery(Guid Id) : IRequest<FormResponse>;