using Statista.Domain.Entities.Email;

public interface IMailService
{
    public void SendEmail(EmailMessage message);
}