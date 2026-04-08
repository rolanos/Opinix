using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Users.Dto;
using Statista.Application.Features.Users.Queries.ConfirmEmail;
using Statista.Application.Users.Dto;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Users.Queries.GetUserByEmail;

public class ConfirmEmailQueryHandler : IRequestHandler<ConfirmEmailQuery, LoginConfirmResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly UserManager<User> _userManager;

    private readonly SignInManager<User> _signInManager;

    private readonly IUserRepository _userRepository;

    private readonly IRefreshTokenRepository _refreshTokenRepository;

    private readonly IMapper _mapper;

    public ConfirmEmailQueryHandler(IJwtTokenGenerator jwtTokenGenerator,
                                    UserManager<User> userManager,
                                    SignInManager<User> signInManager,
                                    IUserRepository userRepository,
                                    IRefreshTokenRepository refreshTokenRepository,
                                    IMapper mapper)
    {
        _jwtTokenGenerator = jwtTokenGenerator;
        _userManager = userManager;
        _signInManager = signInManager;
        _userRepository = userRepository;
        _refreshTokenRepository = refreshTokenRepository;
        _mapper = mapper;
    }

    public async Task<LoginConfirmResponse> Handle(ConfirmEmailQuery request, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByNameAsync(request.Email);

        if (user != null)
        {
            var result = await _signInManager.TwoFactorSignInAsync(TokenOptions.DefaultEmailProvider, request.Token, false, false);

            if (result.Succeeded)
            {
                var token = await _jwtTokenGenerator.GenerateToken(user);
                var userData = await _userRepository.GetUserById(user.Id);
                if (userData == null)
                {
                    throw new HandlerException("Не удалось подтвердить Email");
                }
                var refreshToken = new RefreshToken
                {
                    Id = Guid.NewGuid(),
                    UserId = userData.Id,
                    Token = _jwtTokenGenerator.GenerateRefreshToken(),
                    ExpiresOnUtc = DateTime.UtcNow.AddDays(7),
                };
                await _refreshTokenRepository.SaveToken(refreshToken, cancellationToken);
                return new LoginConfirmResponse(_mapper.Map<UserResponse>(userData), token, refreshToken.Token);
            }
            else
            {
                throw new HandlerException("Неверный код");
            }
        }
        else
        {
            throw new NotFoundException("Пользователь не найден");
        }
    }
}