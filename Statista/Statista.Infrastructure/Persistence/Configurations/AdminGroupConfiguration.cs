using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Statista.Infrastructure.Persistence.Configurations;

public class AdminGroupConfigurations : IEntityTypeConfiguration<AdminGroup>
{
    public void Configure(EntityTypeBuilder<AdminGroup> builder)
    {
        ConfigureAdminGroupTable(builder);
    }

    private void ConfigureAdminGroupTable(EntityTypeBuilder<AdminGroup> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("AdminGroup");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(a => new { a.SurveyId, a.UserId });

        builder.HasOne(a => a.Survey).WithMany(s => s.AdminGroup).HasForeignKey(a => a.SurveyId);
    }
}