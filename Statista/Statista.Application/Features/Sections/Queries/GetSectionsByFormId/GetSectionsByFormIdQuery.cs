using MediatR;
using Statista.Application.Features.Sections.Dto;

namespace Statista.Application.Features.Surveys.Queries.GetSurveys;

public record GetSectionsByFormIdQuery(Guid FormId) : IRequest<ICollection<SectionResponse>>;