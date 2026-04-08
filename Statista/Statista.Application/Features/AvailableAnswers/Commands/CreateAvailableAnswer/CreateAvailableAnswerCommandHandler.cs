using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public class CreateAvailableAnswerCommandHandler : IRequestHandler<CreateAvailableAnswerCommand, AvailableAnswer>
{
    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAvailableAnswerCommandHandler(IAvailableAnswerRepository availableAnswerRepository)
    {
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<AvailableAnswer> Handle(CreateAvailableAnswerCommand request, CancellationToken cancellationToken)
    {
        var availableAnswer = new AvailableAnswer
        {
            Id = Guid.NewGuid(),
            Text = request.Text,
            ImageLink = request.ImageLink,
            QuestionId = request.QuestionId,
        };
        var newAvailableAnswer = await _availableAnswerRepository.CreateAvailableAnswer(availableAnswer);
        if (newAvailableAnswer is null)
        {
            throw new HandlerException("Avaliable Answer have not created");
        }
        return newAvailableAnswer;
    }
}