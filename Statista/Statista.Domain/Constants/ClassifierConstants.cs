namespace Statista.Domain.Constants;

public static class QuestionType
{
    public const string Type = "Тип вопроса";
    public const string TypeGuid = "fdd1971e-82ab-40a5-ad25-32c64633d2d3";
    public const string SingleChoise = "Одиночный выбор";
    public const string MultipleChoice = "Множественный выбор";
    public const string Scale = "Шкала";
}

public static class RoleTypes
{
    public const string Type = "Тип роли";
    public const string TypeGuid = "7b50738a-9684-4395-919a-22903510f062";
    public const string SurveyAdmin = "Администратор";
    public const string SurveyEditor = "Редактор";
}

public static class SurveyType
{
    public const string Type = "Тип опроса";
    public const string TypeGuid = "2a37cbe7-986b-498d-a3ef-d83d8f931743";
    public const string SociologicalSurvey = "Социологический опрос";
    public const string MarketingSurvey = "Маркетинговый опрос";
    public const string PsychologicalSurvey = "Психологический опрос";
}

public static class ModerateStatus
{
    public const string Type = "Статус модерации";
    public const string TypeGuid = "0627ff80-1f85-4021-b847-b7e1671d7572";
    public const string UnderConsideration = "На рассмотрении";
    public const string Rejected = "Отклонено";
    public const string Approved = "Утверждено";
}

public static class SurveyTypeConstants
{
    public static Classifier SurveyTypeParent = new Classifier
    {
        Id = Guid.Parse(SurveyType.TypeGuid),
        Name = SurveyType.Type
    };
    public static Classifier SociologicalSurvey = new Classifier
    {
        Id = Guid.Parse("9896aa2c-6289-486f-8e54-3a894537420d"),
        Name = SurveyType.SociologicalSurvey,
        ParentId = Guid.Parse(SurveyType.TypeGuid)
    };
    public static Classifier MarketingSurvey = new Classifier
    {
        Id = Guid.Parse("a5e090c1-c5de-473f-ac80-6beba3c0cf8c"),
        Name = SurveyType.MarketingSurvey,
        ParentId = Guid.Parse(SurveyType.TypeGuid)
    };
    public static Classifier PsychologicalSurvey = new Classifier
    {
        Id = Guid.Parse("93fe90f3-516c-44c5-9804-d3a4be6445d7"),
        Name = SurveyType.PsychologicalSurvey,
        ParentId = Guid.Parse(SurveyType.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        SurveyTypeParent,
        SociologicalSurvey,
        PsychologicalSurvey,
        MarketingSurvey,
    ];
}


public static class RoleTypeConstants
{
    public static Classifier RoleTypeParent = new Classifier
    {
        Id = Guid.Parse(RoleTypes.TypeGuid),
        Name = RoleTypes.Type
    };
    public static Classifier SurveyAdmin = new Classifier
    {
        Id = Guid.Parse("007287a5-1b20-4348-9e1b-1f2fababd1ca"),
        Name = RoleTypes.SurveyAdmin,
        ParentId = Guid.Parse(RoleTypes.TypeGuid)
    };
    public static Classifier SurveyEditor = new Classifier
    {
        Id = Guid.Parse("86696706-5620-4a25-a2c8-60cac77abb26"),
        Name = RoleTypes.SurveyEditor,
        ParentId = Guid.Parse(RoleTypes.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        RoleTypeParent,
        SurveyAdmin,
        SurveyEditor,
    ];
}

public static class QuestionTypeConstants
{
    public static Classifier QuestionTypeParent = new Classifier
    {
        Id = Guid.Parse(QuestionType.TypeGuid),
        Name = QuestionType.Type
    };
    public static Classifier SingleChoise = new Classifier
    {
        Id = Guid.Parse("2b517e05-2113-414b-80b6-628a7164f85b"),
        Name = QuestionType.SingleChoise,
        ParentId = Guid.Parse(QuestionType.TypeGuid)
    };
    public static Classifier MultipleChoice = new Classifier
    {
        Id = Guid.Parse("ee694d36-19f0-4cd2-a44f-19be00f31bdc"),
        Name = QuestionType.MultipleChoice,
        ParentId = Guid.Parse(QuestionType.TypeGuid),
    };
    public static Classifier Scale = new Classifier
    {
        Id = Guid.Parse("4ff1dcb2-04aa-4480-b7dc-3d1a91003572"),
        Name = QuestionType.Scale,
        ParentId = Guid.Parse(QuestionType.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        QuestionTypeParent,
        SingleChoise,
        Scale,
        MultipleChoice,
    ];
}

public static class ModerateStatusConstants
{
    public static Classifier ModerateStatusParent = new Classifier
    {
        Id = Guid.Parse(ModerateStatus.TypeGuid),
        Name = ModerateStatus.Type
    };
    public static Classifier UnderConsideration = new Classifier
    {
        Id = Guid.Parse("f3f0477d-f1fb-4569-aeba-7bd039ad593d"),
        Name = ModerateStatus.UnderConsideration,
        ParentId = Guid.Parse(ModerateStatus.TypeGuid)
    };
    public static Classifier Rejected = new Classifier
    {
        Id = Guid.Parse("f9c1b919-cc43-46f0-8b6d-efaf6f53f68c"),
        Name = ModerateStatus.Rejected,
        ParentId = Guid.Parse(ModerateStatus.TypeGuid)
    };
    public static Classifier Approved = new Classifier
    {
        Id = Guid.Parse("d7f23854-f616-4af0-a3f0-a414fb326fe3"),
        Name = ModerateStatus.Approved,
        ParentId = Guid.Parse(ModerateStatus.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        ModerateStatusParent,
        UnderConsideration,
        Rejected,
        Approved,
    ];
}