using Statista.Domain.Entities;

public interface IJwtTokenGenerator
{
    Task<string> GenerateToken(User user);
    string GenerateRefreshToken();
}