using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class AnswerConfiguration : IEntityTypeConfiguration<Answer>
{
    public void Configure(EntityTypeBuilder<Answer> builder)
    {
        ConfigureTable(builder);
    }

    private void ConfigureTable(EntityTypeBuilder<Answer> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Answer");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
    }
}