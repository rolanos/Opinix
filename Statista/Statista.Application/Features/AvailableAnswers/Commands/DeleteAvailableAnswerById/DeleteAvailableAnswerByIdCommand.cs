
using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Surveys.CreateSurvey;

public record DeleteAvailableAnswerByIdCommand(Guid Id) : IRequest<AvailableAnswer>;