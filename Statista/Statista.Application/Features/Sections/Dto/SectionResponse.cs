using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Sections.Dto;

public class SectionResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; } = "Пустой заголовок";
    public Guid FormId { get; set; }
    public int? Order { get; set; }
    public ICollection<QuestionResponse> Questions { get; set; } = new List<QuestionResponse>();
}