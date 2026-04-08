using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence;

public static class DataSeedExtension
{
    public static async Task<IApplicationBuilder> AddSeeds(this IApplicationBuilder app)
    {

        var serviceScope = app.ApplicationServices.GetRequiredService<IServiceScopeFactory>().CreateScope();
        await serviceScope.ServiceProvider.SeedDatabaseAsync();
        return app;
    }
    public static async Task<IServiceProvider> SeedDatabaseAsync(this IServiceProvider services)
    {
        var dataSeeder = new DataSeeder(services);
        await dataSeeder.Seed();
        return services;
    }
}

public class DataSeeder
{
    private readonly IServiceProvider _services;

    public DataSeeder(IServiceProvider services)
    {
        using var scope = services.CreateScope();
        _services = services;
    }

    public async Task Seed()
    {
        await InsertClassifier();
        await SeedRoles();
        // Admin + Moderator + User
        await SeedUser("fixsad.dev@gmail.com", "ZbkNZY588DUJyIP0", RolesConstants.GetStrings());
        // Moderator + User
        await SeedUser("fixsad.flutter@gmail.com", "3cfqBe9IUvRnY3Tb", new[] { RolesConstants.Moderator, RolesConstants.User });
        // Users
        await SeedUser("ivankson@gmail.com", "8bv9huRHN16eAnny", new[] { RolesConstants.User });
        // Seed prepared general questions
        await SeedQuestions();
    }

    private async Task SeedRoles()
    {
        using var scope = _services.CreateScope();
        var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole<Guid>>>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<User>>();
        var _dbContext = scope.ServiceProvider.GetRequiredService<PostgresDbContext>();
        var _userInfoRepository = scope.ServiceProvider.GetRequiredService<IUserInfoRepository>();
        using var transaction = await _dbContext.Database.BeginTransactionAsync();
        string[] roles = RolesConstants.GetStrings();

        // Создаём роли, если их нет
        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
            {
                await roleManager.CreateAsync(new IdentityRole<Guid>(role));
            }
        }
        await transaction.CommitAsync();
    }

    private async Task SeedUser(string email, string password, string[] roles)
    {
        using var scope = _services.CreateScope();
        var _dbContext = scope.ServiceProvider.GetRequiredService<PostgresDbContext>();
        var _userInfoRepository = scope.ServiceProvider.GetRequiredService<IUserInfoRepository>();
        var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole<Guid>>>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<User>>();
        using var transaction = await _dbContext.Database.BeginTransactionAsync();
        var userInfoId = Guid.NewGuid();
        var user = new User
        {
            Id = Guid.NewGuid(),
            Email = email,
            UserName = email,
            CreatedDate = DateTime.UtcNow,
            UpdatedDate = DateTime.UtcNow,
            UserInfoId = userInfoId,
            TwoFactorEnabled = true,
        };
        var userFromDb = await userManager.FindByEmailAsync(email);

        var createResult = await userManager.CreateAsync(user, password);

        if (createResult.Succeeded)
        {
            var createdUser = await userManager.FindByEmailAsync(email);
            if (createdUser == null)
            {
                return;
            }

            var userInfo = new UserInfo
            {
                Id = userInfoId,
                UserId = user.Id,
            };
            await _userInfoRepository.CreateUserInfo(userInfo);
            await userManager.AddToRolesAsync(createdUser, roles);
        }
        else
        {
            return;
        }
        await transaction.CommitAsync();
    }

    private async Task InsertClassifier()
    {
        var _classifierRepository = _services.GetRequiredService<IClassifierRepository>();
        foreach (var item in QuestionTypeConstants.values)
        {
            var contains = await _classifierRepository.GetClassifierById(item.Id);
            if (contains == null) { await _classifierRepository.CreateClassifier(item); }
        }
        foreach (var item in RoleTypeConstants.values)
        {
            var contains = await _classifierRepository.GetClassifierById(item.Id);
            if (contains == null) { await _classifierRepository.CreateClassifier(item); }
        }
        foreach (var item in SurveyTypeConstants.values)
        {
            var contains = await _classifierRepository.GetClassifierById(item.Id);
            if (contains == null) { await _classifierRepository.CreateClassifier(item); }
        }
        foreach (var item in ModerateStatusConstants.values)
        {
            var contains = await _classifierRepository.GetClassifierById(item.Id);
            if (contains == null) { await _classifierRepository.CreateClassifier(item); }
        }
    }

    private async Task SeedQuestions()
    {
        using var scope = _services.CreateScope();
        var _dbContext = scope.ServiceProvider.GetRequiredService<PostgresDbContext>();
        var questionRepository = scope.ServiceProvider.GetRequiredService<IQuestionRepository>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<User>>();
        using var transaction = await _dbContext.Database.BeginTransactionAsync();

        var user = await userManager.FindByEmailAsync("fixsad.flutter@gmail.com");
        if (user == null)
        {
            await transaction.CommitAsync();
            return;
        }

        var userId = user.Id;

        // Question 1
        var q1 = new Question
        {
            Id = Guid.NewGuid(),
            Title = "Какой ваш любимый цвет?",
            TypeId = QuestionTypeConstants.SingleChoise.Id,
            IsGeneral = true,
            CreatedDate = DateTime.UtcNow,
            CreatedById = userId,
            ModerateStatusId = ModerateStatusConstants.Approved.Id,
        };
        q1.AvailableAnswers = new List<AvailableAnswer>
        {
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Красный", ImageLink = "", Order = 1, QuestionId = q1.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Синий", ImageLink = "", Order = 2, QuestionId = q1.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Зелёный", ImageLink = "", Order = 3, QuestionId = q1.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Чёрный", ImageLink = "", Order = 4, QuestionId = q1.Id },
        };

        await questionRepository.CreateQuestion(q1);

        // Question 2
        var q2 = new Question
        {
            Id = Guid.NewGuid(),
            Title = "Какие языки программирования вы используете?",
            TypeId = QuestionTypeConstants.MultipleChoice.Id,
            IsGeneral = true,
            CreatedDate = DateTime.UtcNow,
            CreatedById = userId,
            ModerateStatusId = ModerateStatusConstants.Approved.Id,
        };
        q2.AvailableAnswers = new List<AvailableAnswer>
        {
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "JavaScript", ImageLink = "", Order = 1, QuestionId = q2.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Python", ImageLink = "", Order = 2, QuestionId = q2.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "C#", ImageLink = "", Order = 3, QuestionId = q2.Id },
            new AvailableAnswer { Id = Guid.NewGuid(), Text = "Java", ImageLink = "", Order = 4, QuestionId = q2.Id },
        };

        await questionRepository.CreateQuestion(q2);

        await transaction.CommitAsync();
    }
}