using Statista.Domain.Entities;

public class RespondentGroup
{
    public Guid SurveyId { get; set; }
    public Survey Survey { get; set; }
    public Guid UserId { get; set; }
    public User User { get; set; }
}