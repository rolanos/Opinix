
using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;

namespace Statista.Infrastructure.Persistence.Repositories;

public class SurveyRepository : ISurveyRepository
{
    private readonly PostgresDbContext _dbContext;

    public SurveyRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Survey?> CreateSurvey(Survey survey)
    {
        await _dbContext.AddAsync(survey);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Surveys.FirstOrDefaultAsync(u => u.Id == survey.Id);
    }

    public async Task<Survey?> DeleteById(Guid id)
    {
        var survey = await _dbContext.Surveys.FirstOrDefaultAsync(u => u.Id == id);
        if (survey is not null)
        {
            _dbContext.Surveys.Remove(survey);
            await _dbContext.SaveChangesAsync();
            return survey;
        }
        return null;
    }

    public async Task<ICollection<Survey>> GetAllSurveys()
    {
        return await _dbContext.Surveys.ToListAsync();
    }

    public async Task<Survey?> GetSurveyById(Guid id)
    {
        return await _dbContext.Surveys.FirstOrDefaultAsync(u => u.Id == id);
    }
}