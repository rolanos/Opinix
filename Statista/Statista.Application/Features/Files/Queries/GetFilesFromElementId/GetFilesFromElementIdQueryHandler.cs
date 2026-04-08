using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Files.Queries.GetFilesFromElementId;

public class GetFilesFromElementIdQueryHandler : IRequestHandler<GetFilesFromElementIdQuery, ICollection<AppFileResponse>>
{
    private readonly IFileRepository _fileRepository;

    private readonly IMapper _mapper;

    public GetFilesFromElementIdQueryHandler(IFileRepository fileRepository, IMapper mapper)
    {
        _fileRepository = fileRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<AppFileResponse>> Handle(GetFilesFromElementIdQuery request, CancellationToken cancellationToken)
    {
        var files = await _fileRepository.GetFilesByElementId(request.ElementId);

        return _mapper.Map<ICollection<AppFileResponse>>(files);
    }
}