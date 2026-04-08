namespace Statista.Application.Features.Files.Dto;

public class FileDataResponse : AppFileResponse
{
    public byte[] FileData { get; set; } = [];
}