using Microsoft.AspNetCore.Http;

namespace Statista.Domain.Errors;

public class HandlerException : Exception
{
    public int StatusCode { get; set; }
    public string ErrorMessage { get; set; } = string.Empty;

    public HandlerException(string errorMessage) : base(errorMessage)
    {
        StatusCode = StatusCodes.Status400BadRequest;
        ErrorMessage = errorMessage;
    }

    public HandlerException(int statusCode, string errorMessage) : base(errorMessage)
    {
        StatusCode = statusCode;
        ErrorMessage = errorMessage;
    }
}