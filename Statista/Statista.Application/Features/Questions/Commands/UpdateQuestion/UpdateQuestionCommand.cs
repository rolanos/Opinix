
using MediatR;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions.Commands.UpdateQuestion;

public record UpdateQuestionCommand(
    Guid Id,
    string? Title,
    Guid? PastQuestion) : IRequest<QuestionResponse>;