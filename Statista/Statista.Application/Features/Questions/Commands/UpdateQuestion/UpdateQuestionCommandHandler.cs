using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Commands.UpdateQuestion;

public class CreateQuestionCommandHandler : IRequestHandler<UpdateQuestionCommand, QuestionResponse>
{
    private readonly IQuestionRepository _questionRepository;
    private readonly IMapper _mapper;

    public CreateQuestionCommandHandler(IQuestionRepository questionRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<QuestionResponse> Handle(UpdateQuestionCommand request, CancellationToken cancellationToken)
    {
        var question = await _questionRepository.GetQuestionById(request.Id);
        if (question != null)
        {
            if (request.Title != null)
            {
                question.Title = request.Title;
            }
            var updatedQuestion = await _questionRepository.UpdateQuestion(question);
            if (updatedQuestion != null)
            {
                return _mapper.Map<QuestionResponse>(updatedQuestion);
            }
            else
            {
                throw new HandlerException("Question not updated");
            }
        }
        else
        {
            throw new NotFoundException("Question not found");
        }

    }
}