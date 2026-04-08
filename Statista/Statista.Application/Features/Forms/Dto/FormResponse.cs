namespace Statista.Application.Features.Forms.Dto;

public class FormResponse
{
    public Guid Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public Guid? TypeId { get; set; }
    public Guid SurveyId { get; set; }
    public Guid CreatedById { get; set; }
    public DateTime CreatedDate { get; set; }
}