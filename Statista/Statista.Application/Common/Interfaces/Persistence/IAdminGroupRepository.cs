namespace Statista.Application.Common.Interfaces.Persistence;

public interface IAdminGroupRepository
{
    Task<AdminGroup?> CreateAdminGroup(AdminGroup adminGroup);
    Task<ICollection<AdminGroup>> GetAdminGroupBySurveyId(Guid surveyId);
    Task<AdminGroup?> UpdateAdmin(AdminGroup adminGroup);
    Task<AdminGroup?> DeleteAdminGroup(AdminGroup adminGroup);
}