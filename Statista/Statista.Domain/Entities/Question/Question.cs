using System.ComponentModel;
using Statista.Domain.Constants;

namespace Statista.Domain.Entities;

public class Question
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public Guid? TypeId { get; set; }
    public Classifier? Type { get; set; }
    public Guid? SectionId { get; set; }
    public Section? Section { get; set; }
    public int Order { get; set; } = 1;
    public bool IsGeneral { get; set; }
    public ICollection<AvailableAnswer> AvailableAnswers { get; set; } = new List<AvailableAnswer>();
    public DateTime CreatedDate { get; set; }
    public Guid? ModerateStatusId { get; set; } = ModerateStatusConstants.UnderConsideration.Id;
    public Classifier? ModerateStatus { get; set; }
    public Guid? CreatedById { get; set; }
    public User? CreatedBy { get; set; }
}