using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IUserRepository
{
    Task Add(User user);
    Task<User?> GetUserById(Guid id);
    Task<User?> GetUserByEmail(string email);
    Task<ICollection<User?>> GetUsers();
    Task<User?> UpdateUser(User user);
    Task<User?> DeleteUserById(Guid id);
}