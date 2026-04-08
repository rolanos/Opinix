using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateQuestionCommandHandler : IRequestHandler<CreateQuestionCommand, QuestionCreateResponse>
{
    private readonly IQuestionRepository _questionRepository;

    public CreateQuestionCommandHandler(IQuestionRepository questionRepository)
    {
        _questionRepository = questionRepository;
    }

    public async Task<QuestionCreateResponse> Handle(CreateQuestionCommand request, CancellationToken cancellationToken)
    {
        var question = new Question
        {
            Id = Guid.NewGuid(),
            Title = request.Title,
            TypeId = request.TypeId,
            SectionId = request.SectionId,
            CreatedDate = DateTime.UtcNow,
            IsGeneral = request.IsGeneral,
            CreatedById = request.UserId ?? Guid.Empty,
        };
        var newQuestion = await _questionRepository.CreateQuestion(question);
        if (newQuestion is null)
        {
            throw new HandlerException("Не удалось создать вопрос");
        }
        return new QuestionCreateResponse("Вопрос отправлен на модерацию", newQuestion.Id);
    }
}