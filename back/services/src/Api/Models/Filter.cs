namespace Api.Models
{
    public class Filter
    {
        public string Query;
        public SkillsFilter Skills { get; set; } = new SkillsFilter();
        public TablewaresFilter Tablewares { get; set; } = new TablewaresFilter();
        public int? Personas { get; set; }
        public TimesFilter Times { get; set; } = new TimesFilter();
        public TypesFilter Types { get; set; } = new TypesFilter();
    }

    public class SkillsFilter
    {
        public bool IsEnabled => IsEasy || IsMedium || IsHard;
        public bool IsEasy { get; set; } = false;
        public bool IsMedium { get; set; } = false;
        public bool IsHard { get; set; } = false;
    }

    public class TablewaresFilter
    {
        public bool IsEnabled => HasPan || HasOven || HasFryingPan;
        public bool HasPan { get; set; } = false;
        public bool HasOven { get; set; } = false;
        public bool HasFryingPan { get; set; } = false;
    }

    public class TimesFilter
    {
        public bool IsEnabled => Is10Min || IsFrom10To30Min || IsMoreThan30Min;
        public bool Is10Min { get; set; } = false;
        public bool IsFrom10To30Min { get; set; } = false;
        public bool IsMoreThan30Min { get; set; } = false;
    }

    public class TypesFilter
    {
        public bool IsEnabled => IsSweet || IsMeat || IsVegan;
        public bool IsSweet { get; set; } = false;
        public bool IsMeat { get; set; } = false;
        public bool IsVegan { get; set; } = false;
    }
}