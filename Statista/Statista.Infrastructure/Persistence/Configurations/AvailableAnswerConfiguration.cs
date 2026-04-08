using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class AvailableAnswerConfiguration : IEntityTypeConfiguration<AvailableAnswer>
{
    public void Configure(EntityTypeBuilder<AvailableAnswer> builder)
    {
        ConfigureTable(builder);
    }

    private void ConfigureTable(EntityTypeBuilder<AvailableAnswer> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("AvailableAnswer");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
    }
}