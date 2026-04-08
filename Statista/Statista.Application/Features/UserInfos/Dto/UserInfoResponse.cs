using Statista.Application.Features.Files.Dto;

namespace Statista.Application.UserInfos.Dto;

public class UserInfoResponse
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string? Name { get; set; }
    public bool? IsMan { get; set; }
    public DateTime? Birthday { get; set; }
    public Guid? PhotoId { get; set; }  // ссылка на файл
    public AppFileResponse? Photo { get; set; }
}