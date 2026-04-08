using Statista.Application.Users.Dto;

namespace Statista.Application.Features.Users.Dto;

public record LoginConfirmResponse(UserResponse User, string AccessToken, string RefreshToken);