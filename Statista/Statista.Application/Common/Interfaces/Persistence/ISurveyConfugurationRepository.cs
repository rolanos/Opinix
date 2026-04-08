using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface ISurveyConfigurationRepository
{
    Task<SurveyConfiguration?> CreateSurveyConfiguration(SurveyConfiguration surveyConfiguration);
    Task<SurveyConfiguration?> GetSurveyConfigurationBySurveyId(Guid surveyId);
    Task<SurveyConfiguration?> GetSurveyConfigurationById(Guid id);
    Task<SurveyConfiguration?> DeleteById(Guid id);
    Task<SurveyConfiguration?> Update(SurveyConfiguration surveyConfiguration);
}