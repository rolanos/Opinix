using Microsoft.AspNetCore.Identity;

namespace Statista.Domain.Entities;

public class User : IdentityUser<Guid>
{
    public Guid UserInfoId { get; set; }
    public UserInfo UserInfo { get; set; }
    public DateTime CreatedDate { get; set; }
    public DateTime UpdatedDate { get; set; }
}