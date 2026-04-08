using Microsoft.AspNetCore.Http;

public static class HttpAccessorExtension
{
    public static Guid? GetUserId(this IHttpContextAccessor accessor)
    {
        var scope = accessor.HttpContext;
        if (scope == null)
        {
            return null;
        }
        var userId = scope.User.Claims?.FirstOrDefault()?.Value;

        if (userId != null)
        {
            return Guid.Parse(userId);
        }
        return null;
    }
}