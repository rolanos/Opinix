using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class AnaliticalFactConfiguration : IEntityTypeConfiguration<AnaliticalFact>
{
    public void Configure(EntityTypeBuilder<AnaliticalFact> builder)
    {
        ConfigureTable(builder);
    }

    private void ConfigureTable(EntityTypeBuilder<AnaliticalFact> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("AnaliticalFact");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
    }
}