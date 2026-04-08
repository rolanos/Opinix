
using MediatR;
using Statista.Application.Features.Questions.Dto;

namespace Statista.Application.Features.Questions.Commands.ConfirmModerate;

public record ConfirmModerateCommand(Guid QuestionId, bool IsModerated) : IRequest<QuestionResponse>;