namespace Statista.Application.Features.Surveys.Dto;

public class SurveyResponse
{
    public Guid Id { get; set; }
    public Guid CreatedById { get; set; }
    public string Title { get; set; }
    public string? Annotation { get; set; }
    public DateTime CreatedDate { get; set; }
}