
using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateQuestionCommand(
    string Title,
    Guid? PastQuestion,
    Guid TypeId,
    Guid? SectionId,
    Guid? UserId,
    bool IsGeneral = false) : IRequest<QuestionCreateResponse>;