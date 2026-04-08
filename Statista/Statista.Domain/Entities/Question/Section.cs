namespace Statista.Domain.Entities;

public class Section
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public Guid FormId { get; set; }
    public Form Form { get; set; }
    public Guid? ParentSection;
    public Section? ParentSecton { get; set; }
    public Guid? SectionTypeId { get; set; }
    public Classifier? SectionType { get; set; }
    public ICollection<Section> ChildrenSections { get; set; } = new List<Section>();
    public ICollection<Question> Questions { get; set; }
    public int? Order { get; set; }
}