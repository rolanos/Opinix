using MediatR;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files.Queries.GetFilesFromElementId;

public record GetFilesFromElementIdQuery(Guid ElementId) : IRequest<ICollection<AppFileResponse>>;