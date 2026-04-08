using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.AvailableAnswers.Commands.UpdateAvailableAnswer;

public class CreateAvailableAnswerCommandHandler : IRequestHandler<UpdateAvailableAnswerCommand, AvailableAnswer>
{
    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public CreateAvailableAnswerCommandHandler(IAvailableAnswerRepository availableAnswerRepository)
    {
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<AvailableAnswer> Handle(UpdateAvailableAnswerCommand request, CancellationToken cancellationToken)
    {
        var availableAnswer = await _availableAnswerRepository.GetAvailableAnswerById(request.Id);
        if (availableAnswer != null)
        {
            if (request.Text != null)
            {
                availableAnswer.Text = request.Text;
            }
            if (request.ImageLink != null)
            {
                availableAnswer.ImageLink = request.ImageLink;
            }
            var newAvailableAnswer = await _availableAnswerRepository.UpdateAvailableAnswer(availableAnswer);
            if (newAvailableAnswer is null)
            {
                throw new HandlerException("Avaliable Answer not updated");
            }
            return newAvailableAnswer;
        }
        else
        {
            throw new NotFoundException("Avaliable Answer not found");
        }
    }
}