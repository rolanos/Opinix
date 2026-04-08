using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Domain.Constants;
using Statista.Domain.Entities;
using Statista.Domain.Errors;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFormCommandHandler : IRequestHandler<CreateFormCommand, Form>
{
    private readonly ISurveyRepository _surveyRepository;
    private readonly ISurveyConfigurationRepository _surveyConfigurationRepository;
    private readonly IFormRepository _formRepository;
    private readonly ISectionRepository _sectionRepository;
    private readonly IClassifierRepository _classifierRepository;

    public CreateFormCommandHandler(ISurveyRepository surveyRepository,
                                    ISurveyConfigurationRepository surveyConfigurationRepository,
                                    IFormRepository formRepository,
                                    ISectionRepository sectionRepository,
                                    IClassifierRepository classifierRepository)
    {
        _surveyRepository = surveyRepository;
        _surveyConfigurationRepository = surveyConfigurationRepository;
        _formRepository = formRepository;
        _sectionRepository = sectionRepository;
        _classifierRepository = classifierRepository;
    }

    public async Task<Form> Handle(CreateFormCommand request, CancellationToken cancellationToken)
    {
        var surveyId = Guid.NewGuid();
        var formId = Guid.NewGuid();
        if (request.TypeId != null)
        {
            var type = await _classifierRepository.GetClassifierById(request.TypeId.GetValueOrDefault());
            if (type == null)
            {
                throw new NotFoundException("Survey type not found");
            }
        }
        var adminGroup = new AdminGroup
        {
            SurveyId = surveyId,
            UserId = request.CreatedById,
            RoleId = RoleTypeConstants.SurveyAdmin.Id,
        };
        var survey = new Survey
        {
            Id = surveyId,
            FormId = formId,
            AdminGroup = [adminGroup],
            CreatedDate = DateTime.UtcNow,
        };
        var surveyConfiguration = new SurveyConfiguration
        {
            Id = Guid.NewGuid(),
            IsAnonymous = false,
            SurveyId = surveyId,
        };
        var form = new Form
        {
            Id = formId,
            Name = request.Name,
            TypeId = request.TypeId,
            Description = request.Description,
            CreatedDate = DateTime.UtcNow,
            SurveyId = surveyId,
        };
        var emptySection = new Section
        {
            Id = Guid.NewGuid(),
            Title = "Пустой заголовок",
            FormId = formId,
            Order = 1,
        };

        var newSurvey = await _surveyRepository.CreateSurvey(survey);

        if (newSurvey is null)
        {
            throw new HandlerException("Survey have not created");
        }

        var newSurveyConfiguration = await _surveyConfigurationRepository.CreateSurveyConfiguration(surveyConfiguration);

        if (newSurveyConfiguration is null)
        {
            throw new HandlerException("Survey configuration have not created");
        }

        var newform = await _formRepository.CreateForm(form);

        if (newform is null)
        {
            throw new HandlerException("Form have not created");
        }

        var newEmptySection = await _sectionRepository.CreateSection(emptySection);

        if (newEmptySection is null)
        {
            throw new HandlerException("Section have not created");
        }

        return newform;
    }
}