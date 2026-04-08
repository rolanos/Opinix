using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Commands.ConfirmModerate;

public class ConfirmModerateCommandHandler : IRequestHandler<ConfirmModerateCommand, QuestionResponse>
{
    private readonly IMapper _mapper;
    private readonly IQuestionRepository _questionRepository;

    public ConfirmModerateCommandHandler(IMapper mapper, IQuestionRepository questionRepository)
    {
        _mapper = mapper;
        _questionRepository = questionRepository;
    }

    public async Task<QuestionResponse> Handle(ConfirmModerateCommand request, CancellationToken cancellationToken)
    {
        var question = await _questionRepository.GetQuestionById(request.QuestionId);
        if (question == null)
        {
            throw new NotFoundException("Вопрос не найден");
        }
        var newQuestion = await _questionRepository.SetModerate(question, request.IsModerated, cancellationToken);
        if (newQuestion is null)
        {
            throw new HandlerException("Не удалось принять вопрос");
        }
        return _mapper.Map<QuestionResponse>(newQuestion);
    }
}