using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Files.Commands.CreateFile;
using Statista.Application.Features.Files.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFileCommandHandler : IRequestHandler<CreateFileCommand, AppFileResponse>
{
    private readonly IFileRepository _fileRepository;
    private readonly IMapper _mapper;

    public CreateFileCommandHandler(IFileRepository fileRepository, IMapper mapper)
    {
        _fileRepository = fileRepository;
        _mapper = mapper;
    }

    //https://www.youtube.com/watch?v=6-FNejMrVuk
    public async Task<AppFileResponse> Handle(CreateFileCommand request, CancellationToken cancellationToken)
    {
        //ext
        List<string> validExtensions = new List<string>() { ".jpg", ".jpeg", ".png" };
        string extension = Path.GetExtension(request.FormFile.FileName.ToLower());
        if (!validExtensions.Contains(extension))
        {
            throw new HandlerException("Недопустимый формат");
        }
        //file size
        long size = request.FormFile.Length;
        if (size > (5 * 1024 * 1024))
        {
            throw new HandlerException("Максимальный размер не должен привышать 5 Мб");
        }
        //name
        var fileId = Guid.NewGuid();
        var fileName = fileId.ToString() + extension;
        // Чтение файла в массив байтов
        byte[] fileData;
        using (var memoryStream = new MemoryStream())
        {
            await request.FormFile.CopyToAsync(memoryStream);
            fileData = memoryStream.ToArray();
        }
        var file = new Domain.Entities.AppFile
        {
            Id = fileId,
            FullName = fileName,
            Size = size,
            FileData = fileData,
            ElementId = request.ElementId,
            CreatedDate = DateTime.UtcNow,
        };
        var createdFile = await _fileRepository.CreateFile(file);
        if (createdFile == null)
        {
            throw new HandlerException("File not created");
        }
        return _mapper.Map<AppFileResponse>(createdFile);
    }
}