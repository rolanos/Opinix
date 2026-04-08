using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace Statista.Infrastructure.Authentithication;

public static class AuthenticationExtension
{
    public static IServiceCollection AddCustomAuthentication(this IServiceCollection services, IConfiguration configuration)
    {
        var _jwtSettings = configuration.GetSection(nameof(JwtSettings)).Get<JwtSettings>();
        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(opt =>
                {
                    opt.RequireHttpsMetadata = false;
                    opt.SaveToken = true;
                    opt.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateAudience = false,
                        ValidateIssuer = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = _jwtSettings.Issuer,
                        ValidAudience = _jwtSettings.Audience,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.Secret)),
                        // ValidateIssuer = true,
                        // ValidateAudience = true,
                        // ValidateIssuerSigningKey = true,
                    };
                })
                .AddCookie()
                .AddIdentityCookies();
        // services.AddSingleton<IAuthorizationHandler, PermissionRequirementsHandler>();
        // services.AddAuthorizationBuilder()
        //     .AddPolicy(Permissions.Read, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Read)))
        //     .AddPolicy(Permissions.Create, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Create)))
        //     .AddPolicy(Permissions.Update, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Update)))
        //     .AddPolicy(Permissions.Delete, builder => builder.Requirements.Add(new PermissionRequirements(Permissions.Delete)));

        return services;
    }
}