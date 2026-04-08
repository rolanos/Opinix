namespace Statista.Domain.Entities;

public class AppFile
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public long Size { get; set; }
    public byte[] FileData { get; set; } = [];
    public Guid ElementId { get; set; }
    public DateTime CreatedDate { get; set; }
}