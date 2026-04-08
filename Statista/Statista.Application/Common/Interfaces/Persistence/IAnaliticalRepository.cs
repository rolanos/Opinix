using Statista.Application.Features.Analitical.Dto;
using Statista.Domain.Entities;

namespace Statista.Application.Common.Interfaces.Persistence;

public interface IAnaliticalRepository
{
    Task<AnaliticalComplexResult> Analyse(AnaliticalParameters parameters);
}