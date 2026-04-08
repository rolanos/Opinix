
using MediatR;
using Microsoft.AspNetCore.Http;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files.Commands.CreateFile;

public record CreateFileCommand(Guid ElementId, IFormFile FormFile) : IRequest<AppFileResponse>;