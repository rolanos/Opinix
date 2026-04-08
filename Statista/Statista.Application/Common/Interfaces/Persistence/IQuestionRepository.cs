using Statista.Domain.Constants;
using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IQuestionRepository
{
    Task<Question?> CreateQuestion(Question question);
    Task<Question?> GetGeneralQuestion();
    Task<Question?> GetGeneralNoModeratedQuestion(CancellationToken cancellationToken);
    Task<Question?> GetQuestionById(Guid id);
    Task<ICollection<Question>> GetUserGeneralQuestions(Guid userId, CancellationToken cancellationToken);
    Task<Question?> UpdateQuestion(Question question);
    Task<Question?> SetModerate(Question question, bool moderate, CancellationToken cancellationToken);
    Task<Question?> DeleteById(Guid id);
}