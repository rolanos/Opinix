using Statista.Application.Features.Classifiers.Dto;
using Statista.Application.Users.Dto;

namespace Statista.Application.Features.AdminGroups.Dto;

public class AdminGroupResponse
{
    public Guid SurveyId { get; set; }
    public Guid UserId { get; set; }
    public UserResponse User { get; set; }
    public Guid RoleId { get; set; }
    public ClassifierResponse Role { get; set; }
}