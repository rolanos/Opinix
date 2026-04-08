using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Queries.GetModerateQuestion;

public record GetModerateQuestion() : IRequest<QuestionResponse?>;