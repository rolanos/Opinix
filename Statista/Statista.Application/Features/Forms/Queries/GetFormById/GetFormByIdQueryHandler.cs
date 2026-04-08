using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetFormById;

public class GetFormByIdQueryHandler : IRequestHandler<GetFormByIdQuery, FormResponse>
{
    private readonly IFormRepository _formRepository;

    private readonly IMapper _mapper;

    public GetFormByIdQueryHandler(IFormRepository formRepository, IMapper mapper)
    {
        _formRepository = formRepository;
        _mapper = mapper;
    }

    public async Task<FormResponse> Handle(GetFormByIdQuery request, CancellationToken cancellationToken)
    {
        var form = await _formRepository.GetFormById(request.Id);

        return _mapper.Map<FormResponse>(form);
    }
}