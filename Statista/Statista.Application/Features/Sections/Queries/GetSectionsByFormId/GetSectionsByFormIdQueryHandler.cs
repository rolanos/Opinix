using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Sections.Dto;
using Statista.Application.Features.Surveys.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public class GetSectionsByFormIdHandler : IRequestHandler<GetSectionsByFormIdQuery, ICollection<SectionResponse>>
{
    private readonly ISectionRepository _sectionRepository;

    private readonly IMapper _mapper;

    public GetSectionsByFormIdHandler(ISectionRepository sectionRepository, IMapper mapper)
    {
        _sectionRepository = sectionRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<SectionResponse>> Handle(GetSectionsByFormIdQuery request, CancellationToken cancellationToken)
    {
        var surveys = await _sectionRepository.GetSectionsByFormId(request.FormId);
        var result = new List<SectionResponse>();
        foreach (var survey in surveys)
        {
            result.Add(_mapper.Map<SectionResponse>(survey));
        }
        return result.AsReadOnly();
    }
}