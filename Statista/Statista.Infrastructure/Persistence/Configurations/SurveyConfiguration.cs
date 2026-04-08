using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class SurveyConfigurations : IEntityTypeConfiguration<Survey>
{
    public void Configure(EntityTypeBuilder<Survey> builder)
    {
        ConfigureSurveyTable(builder);
    }

    private void ConfigureSurveyTable(EntityTypeBuilder<Survey> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Survey");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
        //Для свойства Id указываем, что оно не должно автоматически генерироваться
        builder.Property(u => u.Id).ValueGeneratedNever();

        builder.HasOne(u => u.Form).WithOne(i => i.Survey).HasForeignKey<Form>(i => i.SurveyId);
    }
}