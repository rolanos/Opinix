using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Queries.GetUserGeneralHistoryQuestions;

public class GetUserGeneralHistoryQuestionsQueryHandler : IRequestHandler<GetUserGeneralHistoryQuestionsQuery, ICollection<QuestionResponse>>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IAnswerRepository _answerRepository;

    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public GetUserGeneralHistoryQuestionsQueryHandler(IQuestionRepository questionRepository,
                                                      IAnswerRepository answerRepository,
                                                      IUserRepository userRepository,
                                                      IMapper mapper)
    {
        _questionRepository = questionRepository;
        _answerRepository = answerRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<QuestionResponse>> Handle(GetUserGeneralHistoryQuestionsQuery request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.UserId);
        if (user == null)
        {
            throw new NotFoundException("Пользователь не найден");
        }
        var answers = await _answerRepository.GetAnswersByUserId(request.UserId, cancellationToken);
        var questions = new List<QuestionResponse>();
        foreach (var item in answers)
        {
            var question = await _questionRepository.GetQuestionById(item.QuestionId);
            questions.Add(_mapper.Map<QuestionResponse>(question));
        }
        return questions;
    }
}