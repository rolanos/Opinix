using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Queries.GetModerateQuestion;

public class GetModerateQuestionQueryHandler : IRequestHandler<GetModerateQuestion, QuestionResponse?>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IMapper _mapper;

    public GetModerateQuestionQueryHandler(IQuestionRepository questionRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<QuestionResponse?> Handle(GetModerateQuestion request, CancellationToken cancellationToken)
    {
        var question = await _questionRepository.GetGeneralNoModeratedQuestion(cancellationToken);
        if (question == null)
        {
            throw new NotFoundException("Новых вопросов больше нет");
        }
        return _mapper.Map<QuestionResponse>(question);
    }
}