using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Commands.CreateGeneralQuestionForm;

public class CreateGeneralQuestionCommandHandler : IRequestHandler<CreateGeneralQuestionFormCommand, QuestionCreateResponse>
{
    private readonly IQuestionRepository _questionRepository;
    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateGeneralQuestionCommandHandler(IQuestionRepository questionRepository, IAvailableAnswerRepository availableAnswerRepository)
    {
        _questionRepository = questionRepository;
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<QuestionCreateResponse> Handle(CreateGeneralQuestionFormCommand request, CancellationToken cancellationToken)
    {
        var question = new Question
        {
            Id = Guid.NewGuid(),
            Title = request.Title,
            TypeId = request.TypeId,
            CreatedDate = DateTime.UtcNow,
            IsGeneral = true,
            CreatedById = request.UserId ?? Guid.Empty,
        };
        var newQuestion = await _questionRepository.CreateQuestion(question);
        if (newQuestion is null)
        {
            throw new HandlerException("Не удалось создать вопрос");
        }
        foreach (var item in request.answers)
        {
            var availableAnswer = new AvailableAnswer
            {
                Id = Guid.NewGuid(),
                Text = item.Text,
                ImageLink = null,
                QuestionId = question.Id,
            };
            var newAvailableAnswer = await _availableAnswerRepository.CreateAvailableAnswer(availableAnswer);
            if (newAvailableAnswer is null)
            {
                await _questionRepository.DeleteById(newQuestion.Id);
                throw new HandlerException("Avaliable Answer have not created");
            }
        }
        return new QuestionCreateResponse("Вопрос отправлен на модерацию", newQuestion.Id);
    }
}