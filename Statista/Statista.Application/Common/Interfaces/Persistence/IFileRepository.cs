using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IFileRepository
{
    Task<AppFile?> CreateFile(AppFile file);
    Task<ICollection<AppFile>> GetFilesByElementId(Guid elementId);
    Task<AppFile?> GetFileById(Guid id, CancellationToken token);
    Task<AppFile?> GetFileByName(string name, CancellationToken token);
    Task<AppFile?> DeleteFile(AppFile file);
}