namespace Statista.Domain.Entities.Email;

public class EmailMessage
{
    public string Title { get; set; } = "Пустое сообщение";
    public string Body { get; set; } = string.Empty;
    public string? ToEmail { get; set; } = string.Empty;
}