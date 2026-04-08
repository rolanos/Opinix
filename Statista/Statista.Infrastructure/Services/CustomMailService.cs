using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using MimeKit;
using Statista.Domain.Entities.Email;
using Statista.Domain.Errors;

namespace Statista.Infrastructure.Services;

public class CustomMailService : IMailService
{
    public CustomMailService(ILogger<CustomMailService> logger, IConfiguration configuration)
    {
        _logger = logger;
        _appEmail = configuration.GetValue<string>("APP_EMAIL") ?? Environment.GetEnvironmentVariable("APP_EMAIL");
        _appEmailPassword = configuration.GetValue<string>("APP_EMAIL_PASSWORD") ?? Environment.GetEnvironmentVariable("APP_EMAIL_PASSWORD");
    }
    private readonly ILogger<CustomMailService> _logger;

    private readonly string? _appEmail;

    private readonly string? _appEmailPassword;

    public void SendEmail(EmailMessage data)
    {
        try
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Opinix", _appEmail));
            message.To.Add(new MailboxAddress("", data.ToEmail));
            message.Subject = data.Title;
            message.Body = new BodyBuilder() { HtmlBody = data.Body }.ToMessageBody();

            using (MailKit.Net.Smtp.SmtpClient client = new MailKit.Net.Smtp.SmtpClient())
            {
                client.Connect("smtp.mail.ru", 465, true);
                client.Authenticate(_appEmail, _appEmailPassword);
                client.Send(message);

                client.Disconnect(true);
                _logger.LogInformation($"Сообщение пользователю с почтой {data.ToEmail} было отправлено на почту");
            }
        }
        catch (Exception e)
        {
            _logger.LogError(e.GetBaseException().Message);
            throw new HandlerException("Невозможно отправить сообщение");
        }
    }
}