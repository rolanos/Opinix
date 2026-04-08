using Statista.Domain.Entities;

namespace Statista.Application.Features.Analitical.Dto;


public class AnaliticalComplexResult
{
    public int TotalCount { get; set; } = 0;
    public Guid QuestionId { get; set; }
    public ICollection<AnaliticalResult> AnaliticalResults { get; set; }
}

public class AnaliticalResult
{
    public Guid? AnswerId { get; set; }
    public AvailableAnswer? AvailableAnswer { get; set; }
    public string? AnswerValue { get; set; }
    public int Count { get; set; }
}