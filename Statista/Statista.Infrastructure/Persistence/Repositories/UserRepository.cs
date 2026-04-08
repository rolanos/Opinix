using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Infrastructure.Persistence.Repositories;

public class UserRepository : IUserRepository
{
    private readonly PostgresDbContext _dbContext;

    public UserRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }
    public async Task Add(User user)
    {
        var a = await _dbContext.AddAsync(user);

        await _dbContext.SaveChangesAsync();
    }

    public async Task<User?> DeleteUserById(Guid id)
    {
        var user = await GetUserById(id);
        if (user is not null)
        {
            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();
            return user;
        }
        return null;
    }

    public async Task<User?> GetUserByEmail(string email)
    {
        var user = await _dbContext.Users.AsNoTracking()
                                     .Include(u => u.UserInfo)
                                     .FirstOrDefaultAsync(u => u.Email == email);
        if (user != null && user?.UserInfo != null)
        {
            var file = await _dbContext.Files.AsNoTracking()
                                             .Where(f => f.ElementId == user.UserInfo.Id)
                                             .FirstOrDefaultAsync();
            user!.UserInfo.PhotoId = file?.Id;
            user!.UserInfo.Photo = file;
        }

        return user;
    }

    public async Task<User?> GetUserById(Guid id)
    {
        var user = await _dbContext.Users.AsNoTracking()
                                     .Include(u => u.UserInfo)
                                     .FirstOrDefaultAsync(u => u.Id == id);
        if (user != null && user?.UserInfo != null)
        {
            var file = await _dbContext.Files.AsNoTracking()
                                             .Where(f => f.ElementId == user.UserInfo.Id)
                                             .FirstOrDefaultAsync();
            user!.UserInfo.PhotoId = file?.Id;
            user!.UserInfo.Photo = file;
        }

        return user;
    }

    public async Task<ICollection<User?>> GetUsers()
    {
        var users = _dbContext.Users.AsNoTracking()
                               .Include(u => u.UserInfo)
                               .ToList()
                               .AsReadOnly();
        for (int i = 0; i < users.Count; i++)
        {
            if (users[i]?.UserInfo != null)
            {
                var file = await _dbContext.Files.AsNoTracking()
                                                 .Where(f => f.ElementId == users[i]!.UserInfo.Id)
                                                 .FirstOrDefaultAsync();
                users[i]!.UserInfo.PhotoId = file?.Id;
                users[i]!.UserInfo.Photo = file;
            }

        }

        return users;
    }

    public async Task<User?> UpdateUser(User user)
    {
        var oldElement = await GetUserById(user.Id);
        if (oldElement is null)
        {
            throw new NotFoundException("In DataBase no User with this Id");
        }

        _dbContext.Entry(oldElement).CurrentValues.SetValues(user);

        await _dbContext.SaveChangesAsync();

        return await GetUserById(user.Id);
    }
}