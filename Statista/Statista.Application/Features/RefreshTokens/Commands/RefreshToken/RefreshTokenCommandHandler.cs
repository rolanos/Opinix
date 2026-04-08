using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.RefreshTokens.Dto;
using Statista.Application.Features.Surveys.CreateSurvey;
using Statista.Domain.Errors;

namespace Statista.Application.Features.RefreshTokens.Commands.RefreshToken;

public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, RefreshTokenResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenRepository;
    private readonly IRefreshTokenRepository _refreshTokenRepository;
    private readonly IUserRepository _userRepository;
    private readonly IMapper _mapper;

    public RefreshTokenCommandHandler(IJwtTokenGenerator jwtTokenRepository,
                                      IRefreshTokenRepository refreshTokenRepository,
                                      IUserRepository userRepository,
                                      IMapper mapper)
    {
        _jwtTokenRepository = jwtTokenRepository;
        _refreshTokenRepository = refreshTokenRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<RefreshTokenResponse> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.UserId);
        if (user == null)
        {
            throw new NotFoundException("Пользователь с таким id не найден");
        }
        var currentRefreshToken = await _refreshTokenRepository.GetTokenByUserId(request.UserId, cancellationToken);
        if (currentRefreshToken != null)
        {
            if (currentRefreshToken.ExpiresOnUtc > DateTime.UtcNow)
            {

                return new RefreshTokenResponse()
                {
                    AccessToken = await _jwtTokenRepository.GenerateToken(user),
                    RefreshToken = currentRefreshToken.Token,
                };
            }
        }

        var newRefreshToken = new Domain.Entities.RefreshToken
        {
            Id = Guid.NewGuid(),
            Token = _jwtTokenRepository.GenerateRefreshToken(),
            UserId = request.UserId,
            ExpiresOnUtc = DateTime.UtcNow.AddDays(7),
        };
        var result = await _refreshTokenRepository.SaveToken(newRefreshToken, cancellationToken);
        if (result != null && currentRefreshToken != null)
        {
            return new RefreshTokenResponse()
            {
                AccessToken = await _jwtTokenRepository.GenerateToken(user),
                RefreshToken = currentRefreshToken.Token,
            };
        }
        else
        {
            throw new HandlerException("Не удалось обновить токен");
        }

    }
}