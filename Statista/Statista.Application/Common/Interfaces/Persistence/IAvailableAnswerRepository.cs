using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IAvailableAnswerRepository
{
    Task<AvailableAnswer?> CreateAvailableAnswer(AvailableAnswer availableAnswer);
    Task<ICollection<AvailableAnswer>> GetAvailableAnswersByQuestionId(Guid questionId);
    Task<AvailableAnswer?> GetAvailableAnswerById(Guid id);
    Task<AvailableAnswer?> UpdateAvailableAnswer(AvailableAnswer availableAnswer);
    Task<AvailableAnswer?> DeleteById(Guid id);
}