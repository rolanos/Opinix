namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticalComplexResponse
{
    public int TotalCount { get; set; } = 0;
    public Guid QuestionId { get; set; }
    public ICollection<AnaliticalResponse> Data { get; set; } = new List<AnaliticalResponse>();
}