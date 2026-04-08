namespace Statista.Domain.Constants;

public static class RolesConstants
{
    public const string Admin = "Admin";
    public const string Moderator = "Moderator";
    public const string User = "User";

    public static string[] GetStrings()
    {
        return new [] {Admin,  Moderator, User};
    }
}