using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface ISectionRepository
{
    Task<Section?> CreateSection(Section section);
    Task<ICollection<Section>> GetSectionsByFormId(Guid formId);
    Task<Section?> DeleteById(Guid id);
}