using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class AnswerRepository : IAnswerRepository
{
    private readonly PostgresDbContext _dbContext;

    public AnswerRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Answer?> CreateAnswer(Answer answer)
    {
        await _dbContext.AddAsync(answer);

        await _dbContext.SaveChangesAsync();

        var userInfo = await _dbContext.UserInfo.FirstOrDefaultAsync(i => i.UserId == answer.RespondentId);

        var analiticFact = new AnaliticalFact
        {
            Id = Guid.NewGuid(),
            UserInfoId = userInfo?.Id,
            QuestionId = answer.QuestionId,
            AvailableAnswerId = answer.AnswerValueId,
            AvailableAnswer = answer.AnswerValue,
            AnswerValue = answer.AnswerMeaning,
            AnswerTime = DateTime.UtcNow,
        };

        await _dbContext.AddAsync(analiticFact);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Answers.FirstOrDefaultAsync(u => u.Id == answer.Id);
    }

    public async Task<ICollection<Answer>> GetAnswersByQuestionId(Guid questionId)
    {
        return await _dbContext.Answers.AsNoTracking()
                                        .Where(u => u.QuestionId == questionId).ToListAsync();
    }

    public async Task<ICollection<Answer>> GetAnswersBySurveyId(Guid surveyId)
    {
        throw new NotImplementedException("In development");
    }

    public async Task<ICollection<Answer>> GetAnswersByUserId(Guid userId, CancellationToken cancellationToken)
    {
        return await _dbContext.Answers.AsNoTracking()
                                       .Where(u => u.RespondentId == userId)
                                       .ToListAsync(cancellationToken);
    }
}