using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Sections.Command.DeleteSection;

public class DeleteSectionCommandHandler : IRequestHandler<DeleteSectionCommand, Section>
{
    private readonly ISectionRepository _sectionRepository;

    public DeleteSectionCommandHandler(ISectionRepository sectionRepository)
    {
        _sectionRepository = sectionRepository;
    }

    public async Task<Section> Handle(DeleteSectionCommand request, CancellationToken cancellationToken)
    {
        var newSection = await _sectionRepository.DeleteById(request.Id);
        if (newSection is null)
        {
            throw new HandlerException("Section have not deleted");
        }
        return newSection;
    }
}