using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IFormRepository
{
    Task<Form?> CreateForm(Form form);
    Task<ICollection<Form>> GetAllForms();
    Task<ICollection<Form>> GetFormsByUserId(Guid userId);
    Task<Form?> GetFormBySurveyId(Guid surveyId);
    Task<Form?> GetFormById(Guid id);
    Task<Form?> DeleteById(Guid id);
}