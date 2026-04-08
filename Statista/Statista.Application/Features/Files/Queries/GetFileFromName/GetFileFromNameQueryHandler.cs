using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Files.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Files.Queries.GetFilesFromElementId;

public class GetFileFromNameQueryHandler : IRequestHandler<GetFileFromNameQuery, FileDataResponse>
{
    private readonly IFileRepository _fileRepository;

    private readonly IMapper _mapper;

    public GetFileFromNameQueryHandler(IFileRepository fileRepository, IMapper mapper)
    {
        _fileRepository = fileRepository;
        _mapper = mapper;
    }

    public async Task<FileDataResponse> Handle(GetFileFromNameQuery request, CancellationToken cancellationToken)
    {
        if (request.Name == string.Empty)
        {
            throw new HandlerException("Укажите название файла");
        }

        var files = await _fileRepository.GetFileByName(request.Name, cancellationToken);

        if (files == null)
        {
            throw new NotFoundException("Не существует файла");
        }

        return _mapper.Map<FileDataResponse>(files);
    }
}