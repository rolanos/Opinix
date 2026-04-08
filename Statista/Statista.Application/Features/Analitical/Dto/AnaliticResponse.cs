namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticalResponse
{
    public Guid? AnswerId { get; set; }
    public string? AnswerValue { get; set; }
    public int Count { get; set; }
}