namespace Statista.Domain.Entities;

public class SurveyConfiguration
{
    public Guid Id { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public bool IsAnonymous { get; set; } = false;
    public Guid SurveyId { get; set; }
    public Survey Survey { get; set; }
}