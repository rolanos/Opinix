using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Configurations;

public class UserConfigurations : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        ConfigureUserTable(builder);
    }

    private void ConfigureUserTable(EntityTypeBuilder<User> builder)
    {
        //Указываем таблицу для конфигурации
        builder.ToTable("User");
        //Указываем какой у нас ключ в таблице
        builder.HasKey(u => u.Id);
        //Для свойства Id указываем, что оно не должно автоматически генерироваться
        builder.Property(u => u.Id).ValueGeneratedNever();

        builder.HasOne(u => u.UserInfo).WithOne(i => i.User).HasForeignKey<UserInfo>(i => i.UserId);

        builder.Property(u => u.Email).HasMaxLength(100);

        builder.Property(u => u.PasswordHash);
    }
}