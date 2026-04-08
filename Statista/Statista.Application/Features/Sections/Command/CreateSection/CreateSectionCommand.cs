using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public record CreateSectionCommand(string Title,
                                   Guid FormId) : IRequest<Section>;