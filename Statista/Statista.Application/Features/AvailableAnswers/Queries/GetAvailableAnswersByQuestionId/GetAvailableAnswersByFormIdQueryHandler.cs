using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.AvailableAnswers.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public class GetAvailableAnswersByQuestionIdQueryHandler : IRequestHandler<GetAvailableAnswersByQuestionIdQuery, ICollection<AvailableAnswerResponse>>
{
    private readonly IAvailableAnswerRepository _availableAnswerRepository;

    private readonly IMapper _mapper;

    public GetAvailableAnswersByQuestionIdQueryHandler(IAvailableAnswerRepository availableAnswerRepository, IMapper mapper)
    {
        _availableAnswerRepository = availableAnswerRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<AvailableAnswerResponse>> Handle(GetAvailableAnswersByQuestionIdQuery request, CancellationToken cancellationToken)
    {
        var answers = await _availableAnswerRepository.GetAvailableAnswersByQuestionId(request.QuestionId);
        var result = new List<AvailableAnswerResponse>();
        foreach (var answer in answers)
        {
            result.Add(_mapper.Map<AvailableAnswerResponse>(answer));
        }
        return result.AsReadOnly();
    }
}