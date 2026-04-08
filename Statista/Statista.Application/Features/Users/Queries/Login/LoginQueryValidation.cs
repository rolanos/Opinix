using FluentValidation;
using Statista.Application.Authentification.Queries.Login;

public class LoginQueryValidation : AbstractValidator<LoginQuery>
{
    public LoginQueryValidation()
    {
        RuleFor((x) => x.Email).NotEmpty().MaximumLength(50);
        RuleFor((x) => x.Password).NotEmpty().MaximumLength(50);
    }
}