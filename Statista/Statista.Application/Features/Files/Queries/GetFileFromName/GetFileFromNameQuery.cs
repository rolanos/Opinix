using MediatR;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files.Queries.GetFilesFromElementId;

public record GetFileFromNameQuery(string Name) : IRequest<FileDataResponse>;