public class JwtSettings
{
    public const string SectionName = "JwtSettings";

    public string Secret { get; init; } = null!;

    public int ExpiryTimeInMinutes { get; set; }

    public string Issuer { get; set; } = null!;

    public string Audience { get; set; } = null!;

}