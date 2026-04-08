
using MediatR;
using Statista.Application.Features.Answers.Dto;

namespace Statista.Application.Features.Answers.Commands.CreateAnswersToForm;

public record CreateAnswersToFormCommand(Guid FormId, ICollection<CreateAnswerRequest> answers) : IRequest<Guid>;