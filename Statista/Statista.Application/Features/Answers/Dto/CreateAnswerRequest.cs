namespace Statista.Application.Features.Answers.Dto;

public class CreateAnswerRequest
{
    public Guid QuestionId { get; set; }
    public List<Guid> AnswerValueIds { get; set; } = new List<Guid>();
    public Guid? UserId { get; set; }
}