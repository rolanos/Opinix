using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions.Queries.GetGeneralQuestion;

public class GetGeneralQuestionQueryHandler : IRequestHandler<GetGeneralQuestionQuery, Question?>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IMapper _mapper;

    public GetGeneralQuestionQueryHandler(IQuestionRepository questionRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<Question?> Handle(GetGeneralQuestionQuery request, CancellationToken cancellationToken)
    {
        var question = await _questionRepository.GetGeneralQuestion();
        return question;
    }
}