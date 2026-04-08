using Microsoft.AspNetCore.Http;

namespace Statista.Domain.Errors;

public class NoAccessException : HandlerException
{
    public NoAccessException() : base(statusCode: StatusCodes.Status403Forbidden,
                                                    errorMessage: "У Вас нет доступа")
    { }
}