using System.Net;
using Microsoft.AspNetCore.Http;

namespace Statista.Domain.Errors;

public class NotFoundException : HandlerException
{
    public NotFoundException(string message) : base(statusCode: (int)StatusCodes.Status404NotFound,
                                                    errorMessage: message)
    { }
}