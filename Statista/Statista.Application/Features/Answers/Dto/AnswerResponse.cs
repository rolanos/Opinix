namespace Statista.Application.Features.Answers.Dto;

public class AnswerResponse
{
    public Guid Id { get; set; }
    public Guid QuestionId { get; set; }
    public Guid? AnswerValueId { get; set; }
}