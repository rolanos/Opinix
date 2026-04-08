using Statista.Domain.Entities;

public class Classifier
{
    public Guid Id { get; set; }
    public string Name { get; set; } = "";
    public Guid? ParentId { get; set; }
    public Classifier? Parent { get; set; }
    public List<Classifier> Children { get; set; } = new();
    public ICollection<AppFile> Files { get; set; } = new List<AppFile>();
}