namespace Statista.Domain.Entities;

public class AnaliticalParameters
{
    public Guid QuestionId { get; set; }
    public bool? IsMan { get; set; }
    public int? AgeFrom { get; set; }
    public int? AgeTo { get; set; }
}