using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Application.Features.Questions.Queries.GetUserGeneralQuestions;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Queries.GetGeneralQuestionsHistory;

public class GetUserGeneralQuestionsQueryHandler : IRequestHandler<GetUserGeneralQuestionsQuery, ICollection<QuestionResponse>>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IUserRepository _userRepository;

    private readonly IMapper _mapper;

    public GetUserGeneralQuestionsQueryHandler(IQuestionRepository questionRepository, IUserRepository userRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _userRepository = userRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<QuestionResponse>> Handle(GetUserGeneralQuestionsQuery request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.UserId);
        if (user == null)
        {
            throw new NotFoundException("Пользователь не найден");
        }
        var questions = await _questionRepository.GetUserGeneralQuestions(request.UserId, cancellationToken);
        return _mapper.Map<ICollection<QuestionResponse>>(questions);
    }
}