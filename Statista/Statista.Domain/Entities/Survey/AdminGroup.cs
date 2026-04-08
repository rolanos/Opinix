using Statista.Domain.Entities;

public class AdminGroup
{
    public Guid SurveyId { get; set; }
    public Survey Survey { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; }
    public Guid RoleId { get; set; }
    public Classifier Role { get; set; }
}