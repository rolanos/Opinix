using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class SectionConfiguration : IEntityTypeConfiguration<Section>
{
    public void Configure(EntityTypeBuilder<Section> builder)
    {
        ConfigureTable(builder);
    }

    private void ConfigureTable(EntityTypeBuilder<Section> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Section");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
    }
}