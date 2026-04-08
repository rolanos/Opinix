using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class RefreshTokenRepository : IRefreshTokenRepository
{
    private readonly PostgresDbContext _dbContext;

    public RefreshTokenRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<RefreshToken?> GetTokenByUserId(Guid userId, CancellationToken cancellationToken)
    {
        return await _dbContext.RefreshTokens.FirstOrDefaultAsync(r => r.UserId == userId);
    }

    public async Task<RefreshToken?> SaveToken(RefreshToken token, CancellationToken cancellationToken)
    {
        await _dbContext.RefreshTokens.Where(r => r.UserId == token.UserId).ExecuteDeleteAsync();

        _dbContext.Add(token);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.RefreshTokens.FirstOrDefaultAsync(r => r.Id == token.Id);
    }
}