using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class FileRepository : IFileRepository
{
    private readonly PostgresDbContext _dbContext;

    public FileRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AppFile?> CreateFile(AppFile file)
    {
        await _dbContext.AddAsync(file);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Files.FirstOrDefaultAsync(u => u.Id == file.Id);
    }

    public async Task<AppFile?> DeleteFile(AppFile file)
    {
        var fileForDelete = await _dbContext.Files.AsNoTracking()
                                              .FirstOrDefaultAsync(f => f.Id == file.Id);
        if (fileForDelete is not null)
        {
            _dbContext.Files.Remove(fileForDelete);
            await _dbContext.SaveChangesAsync();
            return fileForDelete;
        }
        return null;
    }

    public async Task<AppFile?> GetFileById(Guid id, CancellationToken token)
    {
        return await _dbContext.Files.AsNoTracking()
                               .Where(f => f.Id == id)
                               .FirstOrDefaultAsync(token);
    }

    public async Task<AppFile?> GetFileByName(string name, CancellationToken token)
    {
        return await _dbContext.Files.AsNoTracking()
                                       .Where(f => f.FullName == name)
                                       .FirstOrDefaultAsync(token);
    }

    public async Task<ICollection<AppFile>> GetFilesByElementId(Guid elementId)
    {
        return await _dbContext.Files.AsNoTracking()
                                         .Where(f => f.ElementId == elementId)
                                         .ToListAsync();
    }
}