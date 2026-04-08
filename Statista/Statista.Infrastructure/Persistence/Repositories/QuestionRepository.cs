using Microsoft.EntityFrameworkCore;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;
using Statista.Domain.Entities;

namespace Statista.Infrastructure.Persistence.Repositories;

public class QuestionRepository : IQuestionRepository
{
    private readonly PostgresDbContext _dbContext;

    public QuestionRepository(PostgresDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<Question?> CreateQuestion(Question question)
    {
        if (!question.IsGeneral && question.SectionId != null)
        {
            var ordered = await GetOrderedQuestionsOptimizedAsync(question.SectionId.GetValueOrDefault());

            if (ordered.Any())
            {
                question.Order = ordered.Last().Order + 1;
            }
            else
            {
                question.Order = 1;
            }
        }

        await _dbContext.AddAsync(question);

        await _dbContext.SaveChangesAsync();

        return await _dbContext.Questions.FirstOrDefaultAsync(u => u.Id == question.Id);
    }

    public async Task<Question?> DeleteById(Guid id)
    {
        var question = await _dbContext.Questions.AsNoTracking()
                                              .FirstOrDefaultAsync(u => u.Id == id);
        if (question is not null)
        {
            _dbContext.Questions.Remove(question);
            await _dbContext.SaveChangesAsync();
            return question;
        }
        return null;
    }

    public async Task<Question?> GetQuestionById(Guid id)
    {
        return await _dbContext.Questions.AsNoTracking()
                                         .Include(q => q.AvailableAnswers)
                                         .FirstOrDefaultAsync(u => u.Id == id);
    }

    public async Task<Question?> UpdateQuestion(Question question)
    {
        _dbContext.Questions.Update(question);

        await _dbContext.SaveChangesAsync();

        return await GetQuestionById(question.Id);
    }

    public async Task<Question?> GetGeneralQuestion()
    {
        var list = await _dbContext.Questions.AsNoTracking()
                                             .Where(q => q.IsGeneral && q.ModerateStatusId == ModerateStatusConstants.Approved.Id)
                                             .Include(q => q.AvailableAnswers.OrderBy(a => a.Order))
                                             .ToListAsync();
        if (list.Count != 0)
        {
            return list[Random.Shared.Next(list.Count)];
        }
        return null;
    }

    private async Task<List<Question>> GetOrderedQuestionsOptimizedAsync(Guid sectionId)
    {
        return await _dbContext.Questions.AsNoTracking()
                                                  .Where(q => q.SectionId == sectionId)
                                                  .OrderBy(q => q.Order)
                                                  .ToListAsync();
    }

    public async Task<ICollection<Question>> GetUserGeneralQuestions(Guid userId, CancellationToken cancellationToken)
    {
        return await _dbContext.Questions.AsNoTracking()
                                         .Where(q => q.IsGeneral && q.CreatedById == userId)
                                         .Include(q => q.AvailableAnswers.OrderBy(a => a.Order))
                                         .OrderByDescending(q => q.CreatedDate)
                                         .ToListAsync(cancellationToken);
    }

    public async Task<Question?> GetGeneralNoModeratedQuestion(CancellationToken cancellationToken)
    {
        var res = await _dbContext.Questions.AsNoTracking()
                                         .Where(q => q.IsGeneral && q.ModerateStatusId == ModerateStatusConstants.UnderConsideration.Id)
                                         .Include(q => q.AvailableAnswers.OrderBy(a => a.Order))
                                         .OrderByDescending(q => q.CreatedDate)
                                         .ToListAsync(cancellationToken);
        return res.FirstOrDefault();
    }

    public async Task<Question?> SetModerate(Question question, bool moderate, CancellationToken cancellationToken)
    {
        if (moderate)
        {
            question.ModerateStatusId = ModerateStatusConstants.Approved.Id;
            question.ModerateStatus = ModerateStatusConstants.Approved;
        }
        else
        { 
            question.ModerateStatusId = ModerateStatusConstants.Rejected.Id;
            question.ModerateStatus = ModerateStatusConstants.Rejected;
        }
        return await UpdateQuestion(question);
    }
}