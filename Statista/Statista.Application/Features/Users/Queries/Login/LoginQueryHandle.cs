using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Authentification.Queries.Login;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Users.Dto;
using Statista.Domain.Entities;
using Statista.Domain.Entities.Email;
using Statista.Domain.Errors;

namespace Statista.Application.Authentification.Commands.Login;

public class LoginQueryHandler : IRequestHandler<LoginQuery, LoginResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    private readonly UserManager<User> _userManager;

    private readonly SignInManager<User> _signInManager;

    private readonly IMapper _mapper;

    public LoginQueryHandler(
        IJwtTokenGenerator jwtTokenGenerator,
        IUserRepository userRepository,
        UserManager<User> userManager,
        SignInManager<User> signInManager,
        IMapper mapper)
    {
        _jwtTokenGenerator = jwtTokenGenerator;
        _userRepository = userRepository;
        _userManager = userManager;
        _signInManager = signInManager;
        _mapper = mapper;
    }

    public async Task<LoginResponse> Handle(LoginQuery query, CancellationToken cancellationToken)
    {
        var user = await _userManager.FindByEmailAsync(query.Email);
        if (user is null)
        {
            throw new NotFoundException("Не существует пользователя с такой почтой");
        }
        if (!await _userManager.IsEmailConfirmedAsync(user))
        {
            var emailToken = await _userManager.GenerateEmailConfirmationTokenAsync(user);
            await _userManager.ConfirmEmailAsync(user, emailToken);
        }
        await _signInManager.SignOutAsync();
        var signInResult = await _signInManager.PasswordSignInAsync(query.Email, query.Password, false, false);
        if (signInResult.Succeeded || signInResult.RequiresTwoFactor)
        {
            var token = await _userManager.GenerateTwoFactorTokenAsync(user, TokenOptions.DefaultEmailProvider);
            var emailMessage = new EmailMessage()
            {
                ToEmail = user.Email,
                Title = "Подтвердите регистрацию",
                Body = $"Подтвердите регистрацию с помощью кода: <h1>{token}</h1>"
            };
            return new LoginResponse("Введите код из сообщения на почте", emailMessage);
        }
        else if (signInResult.IsNotAllowed || !signInResult.Succeeded)
        {
            throw new HandlerException("Неверные данные пользователя");
        }
        else if (signInResult.IsLockedOut)
        {
            throw new HandlerException("Пользователь заблокирован, попробуйте позже");
        }
        else
        {
            throw new HandlerException("Произошла ошибка, попробуйте позже");
        }
    }
}