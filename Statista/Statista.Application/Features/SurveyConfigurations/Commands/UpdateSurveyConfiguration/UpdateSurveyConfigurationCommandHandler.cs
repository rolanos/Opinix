using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.SurveyConfigurations.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.SurveyConfigurations.Commands.UpdateSurveyConfiguration;

public class UpdateSurveyConfigurationCommandHandler : IRequestHandler<UpdateSurveyConfigurationCommand, SurveyConfigurationResponse>
{
    private readonly ISurveyConfigurationRepository _surveyConfigurationRepository;

    private IMapper _mapper;
    public UpdateSurveyConfigurationCommandHandler(IMapper mapper, ISurveyConfigurationRepository surveyConfigurationRepository)
    {
        _mapper = mapper;
        _surveyConfigurationRepository = surveyConfigurationRepository;
    }

    public async Task<SurveyConfigurationResponse> Handle(UpdateSurveyConfigurationCommand request, CancellationToken cancellationToken)
    {
        var surveyConfiguration = await _surveyConfigurationRepository.GetSurveyConfigurationById(request.Id);
        if (surveyConfiguration is not null)
        {
            if (request.StartDate != null)
            {
                DateTime date;
                DateTime.TryParse(request.StartDate, out date);
                surveyConfiguration.StartDate = date;
            }
            if (request.EndDate != null)
            {
                DateTime date;
                DateTime.TryParse(request.EndDate, out date);
                surveyConfiguration.EndDate = date;
            }
            if (request.IsAnonymous != null)
            {
                surveyConfiguration.IsAnonymous = request.IsAnonymous ?? false;
            }

            var updatedConfiguration = await _surveyConfigurationRepository.Update(surveyConfiguration);

            if (updatedConfiguration is null)
            {
                throw new HandlerException("Survey configuration update error");
            }
            return _mapper.Map<SurveyConfigurationResponse>(updatedConfiguration);
        }
        else
        {
            throw new NotFoundException("Survey configuration not found");
        }
    }
}