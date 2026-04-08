using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IRefreshTokenRepository
{
    Task<RefreshToken?> SaveToken(RefreshToken token, CancellationToken cancellationToken);  
    Task<RefreshToken?> GetTokenByUserId(Guid userId, CancellationToken cancellationToken);  
}