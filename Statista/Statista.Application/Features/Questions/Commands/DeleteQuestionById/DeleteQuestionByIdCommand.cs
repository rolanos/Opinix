
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions.Commands.DeleteQuestionById;

public record DeleteQuestionByIdCommand(Guid Id) : IRequest<Question>;