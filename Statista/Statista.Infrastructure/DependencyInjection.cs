using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Infrastructure.Authentithication;
using Statista.Infrastructure.Persistence;
using Statista.Infrastructure.Persistence.Repositories;
using Statista.Infrastructure.Services;
using Statista.Domain.Entities;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, ConfigurationManager configuration)
    {
        var serviceProvider = services.BuildServiceProvider();
        var env = serviceProvider.GetService<IHostingEnvironment>();
        var connectionString = configuration.GetConnectionString("DbConnectionLocal");
        if (env?.IsDevelopment() ?? true)
        {
            connectionString = configuration.GetConnectionString("DbConnectionLocal");
        }
        if (env?.IsProduction() ?? true)
        {
            connectionString = configuration.GetConnectionString("DbConnection");
        }
        services.Configure<JwtSettings>(configuration.GetSection(JwtSettings.SectionName));
        services.AddDbContext<PostgresDbContext>(options => options.UseNpgsql(connectionString));
        services.AddIdentityCore<User>(options =>
        {
            // Настройка пароля
            options.Password.RequireDigit = false;
            options.Password.RequiredLength = 8;
            options.Password.RequireNonAlphanumeric = false;
            options.Password.RequireUppercase = false;
            options.Password.RequireLowercase = false;

            // Настройка блокировки
            options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);
            options.Lockout.MaxFailedAccessAttempts = 5;

            // Настройка пользователя
            options.User.RequireUniqueEmail = true;
        })
        .AddRoles<IdentityRole<Guid>>()
        .AddEntityFrameworkStores<PostgresDbContext>()
        .AddSignInManager<SignInManager<User>>()
        .AddUserManager<UserManager<User>>()
        .AddDefaultTokenProviders();
        services.AddCustomAuthentication(configuration);
        services.AddPersistence();

        services.AddSingleton<IJwtTokenGenerator, JwtTokenGenerator>();
        services.AddSingleton<IDateTimeProvider, DateTimeProvider>();
        return services;
    }

    public static IServiceCollection AddPersistence(this IServiceCollection services)
    {
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<ISurveyRepository, SurveyRepository>();
        services.AddScoped<IFormRepository, FormRepository>();
        services.AddScoped<ISectionRepository, SectionRepository>();
        services.AddScoped<IQuestionRepository, QuestionRepository>();
        services.AddScoped<IAvailableAnswerRepository, AvailableAnswerRepository>();
        services.AddScoped<IAnswerRepository, AnswerRepository>();
        services.AddScoped<IClassifierRepository, ClassifierRepository>();
        services.AddScoped<IUserInfoRepository, UserInfoRepository>();
        services.AddScoped<IAnaliticalRepository, AnaliticalRepository>();
        services.AddScoped<ISurveyConfigurationRepository, SurveyConfigurationRepository>();
        services.AddScoped<IAdminGroupRepository, AdminGroupRepository>();
        services.AddScoped<IFileRepository, FileRepository>();
        services.AddScoped<IRefreshTokenRepository, RefreshTokenRepository>();

        services.AddScoped<IMailService, CustomMailService>();

        return services;
    }

}