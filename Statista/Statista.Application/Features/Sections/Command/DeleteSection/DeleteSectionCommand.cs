
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Sections.Command.DeleteSection;

public record DeleteSectionCommand(Guid Id) : IRequest<Section>;