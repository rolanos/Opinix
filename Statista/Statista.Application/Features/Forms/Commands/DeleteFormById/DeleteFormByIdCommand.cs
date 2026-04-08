
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record DeleteFormByIdCommand(Guid Id) : IRequest<Form>;