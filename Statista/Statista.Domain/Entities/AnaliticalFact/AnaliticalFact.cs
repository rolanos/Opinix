namespace Statista.Domain.Entities;

public class AnaliticalFact
{
    public Guid Id { get; set; }
    public Guid? UserInfoId { get; set; }
    public UserInfo? UserInfo { get; set; }
    public Guid QuestionId { get; set; }
    public Question Question { get; set; }
    public Guid? AvailableAnswerId { get; set; }
    public AvailableAnswer? AvailableAnswer { get; set; }
    public string AnswerValue { get; set; }
    public DateTime AnswerTime { get; set; }
}