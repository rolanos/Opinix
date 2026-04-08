using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Analitical.Dto;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AnaliticalRepository : IAnaliticalRepository
{
    private readonly PostgresDbContext _dbContext;

    public AnaliticalRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<AnaliticalComplexResult> Analyse(AnaliticalParameters parameters)
    {
        Guid _;
        var complex = new AnaliticalComplexResult()
        {
            QuestionId = parameters.QuestionId,
        };
        var now = DateTime.UtcNow;
        complex.AnaliticalResults = await _dbContext.AnaliticalFacts
        .Where(f => f.QuestionId == parameters.QuestionId)
        .Include(f => f.UserInfo)
        //Filter by Gender param
        .Where(f => parameters.IsMan == null || (f.UserInfo != null && f.UserInfo.IsMan == parameters.IsMan))
        // //Filter by Dates param
        .Where(f =>
            (parameters.AgeFrom == null && parameters.AgeTo == null) ||
            (f.UserInfo != null &&
            f.UserInfo.Birthday != null &&
            (
                parameters.AgeFrom == null ||
                (now.Year - f.UserInfo.Birthday.Value.Year) >= parameters.AgeFrom
            ) &&
            (
                parameters.AgeTo == null ||
                (now.Year - f.UserInfo.Birthday.Value.Year) <= parameters.AgeTo
            ))
        )
        .GroupBy(f => new { f.AnswerValue, f.AvailableAnswerId }) // Группируем по обоим полям
        .Select(g => new AnaliticalResult
        {
            AnswerId = g.Key.AvailableAnswerId,
            AnswerValue = g.Key.AnswerValue,
            Count = g.Count()
        })
        .ToListAsync();
        complex.TotalCount = complex.AnaliticalResults.Sum(r => r.Count);
        return complex;
    }
}