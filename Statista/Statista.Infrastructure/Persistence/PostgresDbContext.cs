using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence;

public class PostgresDbContext : IdentityDbContext<User, IdentityRole<Guid>, Guid>
{
    public PostgresDbContext(DbContextOptions<PostgresDbContext> options) : base(options)
    {
    }

    public DbSet<Survey> Surveys { get; set; } = null!;

    public DbSet<SurveyConfiguration> SurveyConfiguration { get; set; } = null!;

    public DbSet<Form> Forms { get; set; } = null!;

    public DbSet<Section> Sections { get; set; } = null!;

    public DbSet<Question> Questions { get; set; } = null!;

    public DbSet<AvailableAnswer> AvailableAnswers { get; set; } = null!;

    public DbSet<Answer> Answers { get; set; } = null!;

    public DbSet<AdminGroup> AdminGroup { get; set; } = null!;

    public DbSet<RespondentGroup> RespondentGroups { get; set; } = null!;

    public DbSet<Classifier> Classifiers { get; set; } = null!;

    public DbSet<UserInfo> UserInfo { get; set; } = null!;

    public DbSet<AnaliticalFact> AnaliticalFacts { get; set; } = null!;

    public DbSet<Domain.Entities.AppFile> Files { get; set; } = null!;

    public DbSet<RefreshToken> RefreshTokens { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(PostgresDbContext).Assembly);
        base.OnModelCreating(modelBuilder);
    }
}