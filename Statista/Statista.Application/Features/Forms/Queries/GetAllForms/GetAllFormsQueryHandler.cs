using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetAllForms;

public class GetAllFormsQueryHandler : IRequestHandler<GetAllFormsQuery, ICollection<FormResponse>>
{
    private readonly IFormRepository _formRepository;

    private readonly IMapper _mapper;

    public GetAllFormsQueryHandler(IFormRepository formRepository, IMapper mapper)
    {
        _formRepository = formRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<FormResponse>> Handle(GetAllFormsQuery request, CancellationToken cancellationToken)
    {
        var forms = await _formRepository.GetAllForms();
        var result = new List<FormResponse>();
        foreach (var form in forms)
        {
            result.Add(_mapper.Map<FormResponse>(form));
        }
        return result.AsReadOnly();
    }
}