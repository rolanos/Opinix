using AutoMapper;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Users.Dto;
using Statista.Domain.Constants;
using Statista.Domain.Entities;
using Statista.Domain.Entities.Email;
using Statista.Domain.Errors;

namespace Statista.Application.Authentification.Commands.Register;

public class RegisterCommandHandler : IRequestHandler<RegisterCommand, LoginResponse>
{
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    private readonly IUserRepository _userRepository;

    private readonly IUserInfoRepository _userInfoRepository;

    private readonly UserManager<User> _userManager;

    private readonly SignInManager<User> _signInManager;

    private readonly IMailService _mailService;

    private readonly IMapper _mapper;

    public RegisterCommandHandler(
        IJwtTokenGenerator jwtTokenGenerator,
        IUserRepository userRepository,
        IUserInfoRepository userInfoRepository,
        UserManager<User> userManager,
        SignInManager<User> signInManager,
        IMailService mailService,
        IMapper mapper)
    {
        _jwtTokenGenerator = jwtTokenGenerator;
        _userRepository = userRepository;
        _userInfoRepository = userInfoRepository;
        _userManager = userManager;
        _signInManager = signInManager;
        _mailService = mailService;
        _mapper = mapper;
    }

    public async Task<LoginResponse> Handle(RegisterCommand command, CancellationToken cancellationToken)
    {
        var userInfoId = Guid.NewGuid();
        var user = new User
        {
            Id = Guid.NewGuid(),
            Email = command.Email,
            UserName = command.Email,
            CreatedDate = DateTime.UtcNow,
            UpdatedDate = DateTime.UtcNow,
            UserInfoId = userInfoId,
            TwoFactorEnabled = true,
        };
        if ((await _userManager.FindByEmailAsync(command.Email)) is not null)
        {
            throw new HandlerException("User with this email already exists");
        }

        var createResult = await _userManager.CreateAsync(user, command.Password);

        if (createResult.Succeeded)
        {
            var createdUser = await _userManager.FindByEmailAsync(command.Email);
            if (createdUser == null)
            {
                throw new HandlerException("User not created");
            }
            await _userManager.AddToRoleAsync(createdUser, RolesConstants.User);

            var userInfo = new UserInfo
            {
                Id = userInfoId,
                UserId = user.Id,
            };
            await _userInfoRepository.CreateUserInfo(userInfo);
            if (!await _userManager.IsEmailConfirmedAsync(user))
            {
                var emailToken = await _userManager.GenerateEmailConfirmationTokenAsync(user);
                await _userManager.ConfirmEmailAsync(user, emailToken);
            }
            await _signInManager.SignOutAsync();
            var signInResult = await _signInManager.PasswordSignInAsync(command.Email, command.Password, false, false);


            if (signInResult.Succeeded || signInResult.RequiresTwoFactor)
            {
                // генерация токена для пользователя
                var token = await _userManager.GenerateTwoFactorTokenAsync(createdUser, TokenOptions.DefaultEmailProvider);
                var emailMessage = new EmailMessage()
                {
                    ToEmail = user.Email,
                    Title = "Подтвердите регистрацию",
                    Body = $"Подтвердите регистрацию с помощью кода: <h1>{token}</h1>"
                };
                return new("Введите код из сообщения на почте", emailMessage);
            }
            else if (signInResult.IsNotAllowed)
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
        else
        {
            throw new HandlerException("User not created");
        }
    }
}