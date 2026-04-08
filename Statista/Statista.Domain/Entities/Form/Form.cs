namespace Statista.Domain.Entities;

public class Form
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public Guid? TypeId { get; set; }
    public Classifier? Type { get; set; }
    public Guid SurveyId { get; set; }
    public Survey Survey { get; set; }
    public DateTime CreatedDate { get; set; }
    public ICollection<Section> Sections { get; set; }
}