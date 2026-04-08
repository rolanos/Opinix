namespace Statista.Application.Common.Interfaces.Persistence;

public interface IAnswerRepository
{
    Task<Answer?> CreateAnswer(Answer answer);
    Task<ICollection<Answer>> GetAnswersBySurveyId(Guid surveyId);
    Task<ICollection<Answer>> GetAnswersByQuestionId(Guid questionId);
    Task<ICollection<Answer>> GetAnswersByUserId(Guid userId, CancellationToken cancellationToken);
}