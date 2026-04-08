namespace Statista.Application.Common.Interfaces.Persistence;

public interface IClassifierRepository
{
    Task<Classifier?> CreateClassifier(Classifier classifier);
    Task<Classifier?> GetClassifierById(Guid id);
    Task<ICollection<Classifier>> GetAllChildrenByParentId(Guid? parentId);
    Task<bool> HasData();
}