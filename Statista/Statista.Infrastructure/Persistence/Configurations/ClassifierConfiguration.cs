using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Statista.Infrastructure.Persistence.Configurations;

public class ClassifierConfiguration : IEntityTypeConfiguration<Classifier>
{
    public void Configure(EntityTypeBuilder<Classifier> builder)
    {
        ConfigurePermissionTable(builder);
    }

    private void ConfigurePermissionTable(EntityTypeBuilder<Classifier> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Classifier");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(p => p.Id);
    }
}