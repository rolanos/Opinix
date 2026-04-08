using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public class DeleteAvailableAnswerByIdCommandHandler : IRequestHandler<DeleteAvailableAnswerByIdCommand, AvailableAnswer>
{
    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    public DeleteAvailableAnswerByIdCommandHandler(IAvailableAnswerRepository availableAnswerRepository)
    {
        _availableAnswerRepository = availableAnswerRepository;
    }

    public async Task<AvailableAnswer> Handle(DeleteAvailableAnswerByIdCommand request, CancellationToken cancellationToken)
    {
        var deletedAvailableAnswer = await _availableAnswerRepository.DeleteById(request.Id);
        if (deletedAvailableAnswer is null)
        {
            throw new HandlerException("Avaliable Answer has not deleted");
        }
        return deletedAvailableAnswer;
    }
}