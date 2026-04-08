using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Commands.DeleteQuestionById;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class DeleteQuestionByIdCommandHandler : IRequestHandler<DeleteQuestionByIdCommand, Question>
{
    private readonly IQuestionRepository _questionRepository;

    public DeleteQuestionByIdCommandHandler(IQuestionRepository questionRepository)
    {
        _questionRepository = questionRepository;
    }

    public async Task<Question> Handle(DeleteQuestionByIdCommand request, CancellationToken cancellationToken)
    {
        var deleted = await _questionRepository.DeleteById(request.Id);
        if (deleted is null)
        {
            throw new HandlerException("Question have not deleted");
        }
        return deleted;
    }
}