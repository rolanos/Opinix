using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Questions.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;

public class GetQuestionsBySectionIdQueryHandler : IRequestHandler<GetQuestionByIdQuery, QuestionResponse>
{
    private readonly IQuestionRepository _questionRepository;

    private readonly IMapper _mapper;

    public GetQuestionsBySectionIdQueryHandler(IQuestionRepository questionRepository, IMapper mapper)
    {
        _questionRepository = questionRepository;
        _mapper = mapper;
    }

    public async Task<QuestionResponse> Handle(GetQuestionByIdQuery request, CancellationToken cancellationToken)
    {
        var question = await _questionRepository.GetQuestionById(request.Id);
        if (question == null)
        {
            throw new HandlerException("Вопрос не найден");
        }
        return _mapper.Map<QuestionResponse>(question);
    }
}