namespace Statista.Application.Features.SurveyConfigurations.Dto;

public class SurveyConfigurationResponse
{
    public Guid Id { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public bool IsAnonymous { get; set; } = false;
    public Guid SurveyId { get; set; }
}