using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IUserInfoRepository
{
    Task<UserInfo?> CreateUserInfo(UserInfo userInfo);
    Task<UserInfo?> GetUserInfoId(Guid id);
    Task<UserInfo?> GetUserInfoByUserId(Guid userId);
    Task<UserInfo?> UpdateUserInfo(UserInfo userInfo);
}