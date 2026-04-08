using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Statista.Domain.Errors;

public class ErrorHandlingMiddleware
{
    private readonly RequestDelegate _next;

    private readonly ILogger<ErrorHandlingMiddleware> _logger;
    public ErrorHandlingMiddleware(RequestDelegate next, ILogger<ErrorHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            _logger.LogError("Exception: {ex}", ex.Message);
            _logger.LogError("Stack trace: {ex}", ex.StackTrace);
            //Перехватываем и обрабатываем исключение
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var code = exception switch
        {
            ApplicationException => StatusCodes.Status400BadRequest,
            NotFoundException => ((NotFoundException)exception).StatusCode,
            HandlerException => ((HandlerException)exception).StatusCode,
            _ => StatusCodes.Status400BadRequest,
        };
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = code;
      
        return context.Response.WriteAsJsonAsync(new ProblemDetails
        {
            Type = exception.GetType().Name,
            Title = exception.Message,
        });
    }
}