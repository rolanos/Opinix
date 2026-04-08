using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class UserInfoRepository : IUserInfoRepository
{
    private readonly PostgresDbContext _dbContext;

    public UserInfoRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<UserInfo?> CreateUserInfo(UserInfo userInfo)
    {
        await _dbContext.AddAsync(userInfo);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.UserInfo.FirstOrDefaultAsync(i => i.Id == userInfo.Id);
    }

    public async Task<UserInfo?> GetUserInfoByUserId(Guid userId)
    {
        return await _dbContext.UserInfo.FirstOrDefaultAsync(i => i.UserId == userId);
    }

    public async Task<UserInfo?> GetUserInfoId(Guid id)
    {
        return await _dbContext.UserInfo.FirstOrDefaultAsync(i => i.Id == id);
    }

    public async Task<UserInfo?> UpdateUserInfo(UserInfo userInfo)
    {
        _dbContext.Update(userInfo);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.UserInfo.FirstOrDefaultAsync(i => i.Id == userInfo.Id);
    }
}