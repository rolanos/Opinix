using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class FormConfigurations : IEntityTypeConfiguration<Form>
{
    public void Configure(EntityTypeBuilder<Form> builder)
    {
        ConfigureFormTable(builder);
    }

    private void ConfigureFormTable(EntityTypeBuilder<Form> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("Form");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
        //Для свойства Id указываем, что оно не должно автоматически генерироваться
        builder.Property(u => u.Id).ValueGeneratedNever();

        builder.HasOne(u => u.Survey).WithOne(i => i.Form).HasForeignKey<Survey>(i => i.FormId);
    }
}