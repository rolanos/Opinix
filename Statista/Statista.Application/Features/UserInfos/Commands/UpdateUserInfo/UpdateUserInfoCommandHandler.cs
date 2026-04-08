using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.UserInfos.Dto;
using Statista.Domain.Errors;

namespace Statista.Application.Features.UserInfos.Commands.UpdateUserInfo;

public class UpdateUserInfoCommandHandler : IRequestHandler<UpdateUserInfoCommand, UserInfoResponse>
{
    private readonly IUserInfoRepository _userInfoRepository;

    private IMapper _mapper;
    public UpdateUserInfoCommandHandler(IMapper mapper, IUserInfoRepository userInfoRepository)
    {
        _mapper = mapper;
        _userInfoRepository = userInfoRepository;
    }

    public async Task<UserInfoResponse> Handle(UpdateUserInfoCommand request, CancellationToken cancellationToken)
    {
        var userInfo = await _userInfoRepository.GetUserInfoId(request.Id);
        if (userInfo is not null)
        {
            userInfo.Birthday = request.Birthday;
            userInfo.IsMan = request.IsMan;
            userInfo.Name = request.Name;
            var updatedUserInfo = await _userInfoRepository.UpdateUserInfo(userInfo);

            if (updatedUserInfo is null)
            {
                throw new HandlerException("User Info update error");
            }
            return _mapper.Map<UserInfoResponse>(updatedUserInfo);
        }
        else
        {
            throw new NotFoundException("User Info not founded");
        }
    }
}