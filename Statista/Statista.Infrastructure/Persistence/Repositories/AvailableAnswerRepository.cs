using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AvailableAnswerRepository : IAvailableAnswerRepository
{
    private readonly PostgresDbContext _dbContext;

    public AvailableAnswerRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AvailableAnswer?> CreateAvailableAnswer(AvailableAnswer availableAnswer)
    {
        var orderedAnswers = await GetAvailableAnswersByQuestionId(availableAnswer.QuestionId);

        if (orderedAnswers.Any())
        {
            availableAnswer.Order = orderedAnswers.Last().Order + 1;
        }

        await _dbContext.AddAsync(availableAnswer);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.AvailableAnswers.FirstOrDefaultAsync(u => u.Id == availableAnswer.Id);
    }

    public async Task<AvailableAnswer?> DeleteById(Guid id)
    {
        var availableAnswer = await _dbContext.AvailableAnswers.AsNoTracking()
                                                               .FirstOrDefaultAsync(u => u.Id == id);

        if (availableAnswer is not null)
        {
            var orderedAnswers = await GetAvailableAnswersByQuestionId(availableAnswer.QuestionId);
            var current = orderedAnswers.FirstOrDefault(a => a.Id == id);
            if (orderedAnswers == null || current == null)
                return null;

            _dbContext.AvailableAnswers.Remove(availableAnswer);
            await _dbContext.SaveChangesAsync();

            foreach (var otherAnswer in orderedAnswers)
            {
                if (otherAnswer.Order > availableAnswer.Order)
                {
                    otherAnswer.Order -= 1;
                    await UpdateAvailableAnswer(otherAnswer);
                }
            }
            return availableAnswer;
        }
        return null;
    }

    public async Task<AvailableAnswer?> GetAvailableAnswerById(Guid id)
    {
        return await _dbContext.AvailableAnswers.AsNoTracking()
                                                .FirstOrDefaultAsync(u => u.Id == id);
    }

    public async Task<ICollection<AvailableAnswer>> GetAvailableAnswersByQuestionId(Guid questionId)
    {
        return await _dbContext.AvailableAnswers
                                      .AsNoTracking()
                                      .Where(a => a.QuestionId == questionId)
                                      .OrderBy(a => a.Order)
                                      .ToListAsync();
    }

    public async Task<AvailableAnswer?> UpdateAvailableAnswer(AvailableAnswer availableAnswer)
    {
        _dbContext.Update(availableAnswer);

        await _dbContext.SaveChangesAsync();

        return await GetAvailableAnswerById(availableAnswer.Id);
    }
}