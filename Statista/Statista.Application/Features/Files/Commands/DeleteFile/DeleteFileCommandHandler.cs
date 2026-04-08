using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Files.Commands.CreateFile;
using Statista.Application.Features.Files.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class DeleteFileCommandHandler : IRequestHandler<DeleteFileCommand, AppFileResponse>
{
    private readonly IFileRepository _fileRepository;
    private readonly IMapper _mapper;

    public DeleteFileCommandHandler(IFileRepository fileRepository, IMapper mapper)
    {
        _fileRepository = fileRepository;
        _mapper = mapper;
    }

    public async Task<AppFileResponse> Handle(DeleteFileCommand request, CancellationToken cancellationToken)
    {
        var file = await _fileRepository.GetFileById(request.FileId, cancellationToken);
        if (file == null)
        {
            throw new NotFoundException("File not found");
        }
        var deleteResult = await _fileRepository.DeleteFile(file);
        return _mapper.Map<AppFileResponse>(deleteResult);
    }
}