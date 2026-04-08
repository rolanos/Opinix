using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public class CreateSectionCommandHandler : IRequestHandler<CreateSectionCommand, Section>
{
    private readonly ISectionRepository _sectionRepository;

    private IMapper _mapper;
    public CreateSectionCommandHandler(IMapper mapper, ISectionRepository sectionRepository)
    {
        _mapper = mapper;
        _sectionRepository = sectionRepository;
    }

    public async Task<Section> Handle(CreateSectionCommand request, CancellationToken cancellationToken)
    {
        var survey = new Section
        {
            Id = Guid.NewGuid(),
            Title = request.Title,
            FormId = request.FormId,
        };
        var newSection = await _sectionRepository.CreateSection(survey);
        if (newSection is null)
        {
            throw new HandlerException("Section have not created");
        }
        return newSection;
    }
}