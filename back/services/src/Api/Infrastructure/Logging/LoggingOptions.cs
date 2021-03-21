using Serilog.Events;

namespace Api.Infrastructure.Logging
{
    public class LoggingOptions
    {
        public string Path { get; set; }
        public LogLevel LogLevel { get; set; } = new LogLevel();
    }

    public class LogLevel
    {
        public LogEventLevel Default { get; set; }
        public LogEventLevel? Serilog { get; set; }
    }
}