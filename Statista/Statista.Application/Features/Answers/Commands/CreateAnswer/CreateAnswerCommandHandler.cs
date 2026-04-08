using MediatR;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateAnswerCommandHandler : IRequestHandler<CreateAnswerCommand, Guid>
{
    private readonly IAnswerRepository _answerRepository;

    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAnswerCommandHandler(IAnswerRepository answerRepository,
                                      IAvailableAnswerRepository availableAnswerRepository)
    {
        _answerRepository = answerRepository;
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<Guid> Handle(CreateAnswerCommand request, CancellationToken cancellationToken)
    {
        foreach (var answerId in request.AnswerValueIds)
        {
            var answerMeaningValue = await _availableAnswerRepository.GetAvailableAnswerById(answerId);
            var answer = new Answer
            {
                Id = Guid.NewGuid(),
                QuestionId = request.QuestionId,
                AnswerValueId = answerId,
                RespondentId = request.UserId,
                AnswerMeaning = answerMeaningValue?.Text ?? string.Empty,
            };
            var newAnswer = await _answerRepository.CreateAnswer(answer);
        }

        return request.QuestionId;
    }
}