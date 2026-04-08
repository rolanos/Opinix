using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Classifiers.Dto;

public class ClassifierResponse
{
    public Guid Id { get; set; }
    public string Name { get; set; } = "";
    public Guid? ParentId { get; set; }
    public ICollection<AppFileResponse> Files { get; set; } = new List<AppFileResponse>();
}