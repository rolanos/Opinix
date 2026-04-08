using FluentValidation;
using MediatR;
using Statista.Application.Authentification.Commands.Register;

public class ValidatorBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
where TRequest : IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidatorBehaviour(IEnumerable<IValidator<TRequest>> validators) => _validators = validators;

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var failures = _validators
                .Select(v => v.Validate(request))
                .SelectMany(result => result.Errors)
                .Where(error => error != null)
                .ToList();

        if (failures.Any())
        {
            var errorFieldsMessages = failures.Select(x => x.ErrorMessage + ", ").ToArray();

            throw new Exception(
                $"Command Validation Errors for type {typeof(TRequest).Name}. " +
                $"Validation failed : {string.Join(string.Empty, errorFieldsMessages)}", new ValidationException("Validation exception", failures));
        }

        var response = await next();
        return response;
    }
}