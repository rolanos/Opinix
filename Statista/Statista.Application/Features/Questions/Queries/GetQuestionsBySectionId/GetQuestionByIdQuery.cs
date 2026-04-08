using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Queries.GetQuestionsBySectionId;

public record GetQuestionByIdQuery(Guid Id) : IRequest<QuestionResponse>;