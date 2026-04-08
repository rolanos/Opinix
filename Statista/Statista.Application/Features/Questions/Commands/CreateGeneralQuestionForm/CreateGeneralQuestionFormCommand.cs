using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Commands.CreateGeneralQuestionForm;

public record CreateGeneralQuestionFormCommand(
    string Title,
    Guid TypeId,
    Guid? UserId,
    ICollection<CreateAvailableAnswerForm> answers) : IRequest<QuestionCreateResponse>;

public record CreateAvailableAnswerForm(string? Text, string? ImageLink);