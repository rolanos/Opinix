using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Forms.Dto;

namespace Statista.Application.Features.Forms.Queries.GetFormsByUserId;

public class GetFormsByUserIdQueryHandler : IRequestHandler<GetFormsByUserIdQuery, ICollection<FormResponse>>
{
    private readonly IFormRepository _formRepository;

    private readonly IMapper _mapper;

    public GetFormsByUserIdQueryHandler(IFormRepository formRepository, IMapper mapper)
    {
        _formRepository = formRepository;
        _mapper = mapper;
    }

    public async Task<ICollection<FormResponse>> Handle(GetFormsByUserIdQuery request, CancellationToken cancellationToken)
    {
        var forms = await _formRepository.GetFormsByUserId(request.UserId);
        var result = new List<FormResponse>();
        foreach (var form in forms)
        {
            result.Add(_mapper.Map<FormResponse>(form));
        }
        return result;
    }
}