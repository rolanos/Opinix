using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Classifiers.Dto;
using Statista.Application.Features.Classifiers.Queries.GetAllQuestionTypes;
using Statista.Domain.Constants;

namespace Statista.Application.Features.Classifiers.Queries.GetAllSurveyTypes;

public class GetAllQuestionTypesQueryHandler : IRequestHandler<GetAllQuestionTypesQuery, ICollection<ClassifierResponse>>
{
    private readonly IClassifierRepository _classifierRepository;

    private readonly IMapper _mapper;

    public GetAllQuestionTypesQueryHandler(IClassifierRepository classifierRepository, IMapper mapper)
    {
        _classifierRepository = classifierRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<ClassifierResponse>> Handle(GetAllQuestionTypesQuery request, CancellationToken cancellationToken)
    {
        var roles = await _classifierRepository.GetAllChildrenByParentId(QuestionTypeConstants.QuestionTypeParent.Id);

        return _mapper.Map<ICollection<ClassifierResponse>>(roles);
    }
}