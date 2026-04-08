using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class DeleteFormByIdCommandHandler : IRequestHandler<DeleteFormByIdCommand, Form>
{
    private readonly IFormRepository _formRepository;

    public DeleteFormByIdCommandHandler(IFormRepository formRepository)
    {
        _formRepository = formRepository;
    }

    public async Task<Form> Handle(DeleteFormByIdCommand request, CancellationToken cancellationToken)
    {
        var newSurvey = await _formRepository.DeleteById(request.Id);
        if (newSurvey is null)
        {
            throw new HandlerException("Form have not deleted");
        }
        return newSurvey;
    }
}