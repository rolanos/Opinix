using MediatR;
using Statista.Domain.Entities;

namespace Statista.Application.Features.Questions.Queries.GetGeneralQuestion;

public record GetGeneralQuestionQuery() : IRequest<Question?>;