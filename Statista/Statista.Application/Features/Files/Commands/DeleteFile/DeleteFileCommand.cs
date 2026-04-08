
using MediatR;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files.Commands.CreateFile;

public record DeleteFileCommand(Guid FileId) : IRequest<AppFileResponse>;