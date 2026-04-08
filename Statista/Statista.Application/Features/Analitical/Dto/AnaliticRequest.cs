namespace Statista.Application.Features.Analitical.Dto;

public class AnaliticRequest
{
    //null - Male | Female
    //true - Male
    //false - Female
    public bool? Gender { get; set; }

    public int? AgeFrom { get; set; }

    public int? AgeTo { get; set; }
}