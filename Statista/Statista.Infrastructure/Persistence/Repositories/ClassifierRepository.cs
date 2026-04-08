using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

class ClassifierRepository : IClassifierRepository
{
    private readonly PostgresDbContext _dbContext;

    public ClassifierRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Classifier?> CreateClassifier(Classifier classifier)
    {
        var contains = await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == classifier.Id);
        if (contains == null)
        {
            await _dbContext.AddAsync(classifier);

            await _dbContext.SaveChangesAsync();

            return await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == classifier.Id);
        }
        return contains;
    }

    public async Task<ICollection<Classifier>> GetAllChildrenByParentId(Guid? parentId)
    {
        var list = await _dbContext.Classifiers.AsNoTracking()
                                        .Include((u) => u.Files)
                                        .Where(c => c.ParentId == parentId).ToListAsync();
        for (int i = 0; i < list.Count; i++)
        {
            list[i]!.Files = await GetFilesByClassifier(list[i]);
        }
        return list;
    }

    public async Task<Classifier?> GetClassifierById(Guid id)
    {
        var classifier = await _dbContext.Classifiers.FirstOrDefaultAsync(c => c.Id == id);
        if (classifier != null)
        {
            classifier.Files = await GetFilesByClassifier(classifier);
        }
        return classifier;
    }

    public async Task<bool> HasData()
    {
        return await _dbContext.Classifiers.AnyAsync();
    }

    private async Task<ICollection<AppFile>> GetFilesByClassifier(Classifier classifier)
    {
        return await _dbContext.Files.AsNoTracking()
                                     .Where(f => f.ElementId == classifier.Id)
                                     .ToListAsync();
    }
}