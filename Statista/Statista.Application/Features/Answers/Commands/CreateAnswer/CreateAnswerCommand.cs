
using MediatR;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public record CreateAnswerCommand(Guid QuestionId,
                                  List<Guid> AnswerValueIds,
                                  Guid? UserId) : IRequest<Guid>;