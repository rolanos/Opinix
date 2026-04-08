using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class SurveyConfigurationRepository : ISurveyConfigurationRepository
{
    private readonly PostgresDbContext _dbContext;

    public SurveyConfigurationRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<SurveyConfiguration?> CreateSurveyConfiguration(SurveyConfiguration surveyConfiguration)
    {
        await _dbContext.AddAsync(surveyConfiguration);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.SurveyConfiguration.FirstOrDefaultAsync(i => i.Id == surveyConfiguration.Id);
    }

    public async Task<SurveyConfiguration?> DeleteById(Guid id)
    {
        var surveyConfiguration = await _dbContext.SurveyConfiguration.FirstOrDefaultAsync(u => u.Id == id);
        if (surveyConfiguration is not null)
        {
            _dbContext.SurveyConfiguration.Remove(surveyConfiguration);
            await _dbContext.SaveChangesAsync();
            return surveyConfiguration;
        }
        return null;
    }

    public async Task<SurveyConfiguration?> GetSurveyConfigurationById(Guid id)
    {
        return await _dbContext.SurveyConfiguration.FirstOrDefaultAsync(u => u.Id == id);
    }

    public async Task<SurveyConfiguration?> GetSurveyConfigurationBySurveyId(Guid surveyId)
    {
        return await _dbContext.SurveyConfiguration.FirstOrDefaultAsync(u => u.SurveyId == surveyId);
    }

    public async Task<SurveyConfiguration?> Update(SurveyConfiguration surveyConfiguration)
    {
        _dbContext.Update(surveyConfiguration);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.SurveyConfiguration.FirstOrDefaultAsync(u => u.Id == surveyConfiguration.Id);
    }
}