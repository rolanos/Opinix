using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Statista.Infrastructure.Persistence.Configurations;

public class RespondentGroupConfigurations : IEntityTypeConfiguration<RespondentGroup>
{
    public void Configure(EntityTypeBuilder<RespondentGroup> builder)
    {
        ConfigureRespondentGroupTable(builder);
    }

    private void ConfigureRespondentGroupTable(EntityTypeBuilder<RespondentGroup> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("RespondentGroup");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(r => new { r.SurveyId, r.UserId });
    }
}