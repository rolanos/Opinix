using Statista.Domain.Entities;

public class Survey
{
    public Guid Id { get; set; }
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public List<Answer> Answers { get; set; } = new();
    public List<AdminGroup> AdminGroup { get; set; } = new();
    public List<RespondentGroup> RespondentGroup { get; set; } = new();
    public DateTime CreatedDate { get; set; }
}