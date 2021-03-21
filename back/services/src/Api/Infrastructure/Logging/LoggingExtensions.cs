using System.IO;
using Api.Infrastructure.Extensions;
using Microsoft.AspNetCore.Hosting;
using Serilog;
using Serilog.Events;

namespace Api.Infrastructure.Logging
{
    public static class LoggingExtensions
    {
        public static IWebHostBuilder UseLogging(this IWebHostBuilder webHostBuilder)
        {
            return webHostBuilder.UseSerilog((context, loggerConfiguration) =>
            {
                var appOptions = context.Configuration.GetOptions<ServiceOptions>("Service");
                var loggingOptions = context.Configuration.GetOptions<LoggingOptions>("Logging");
                var level = loggingOptions.LogLevel.Serilog ?? loggingOptions.LogLevel.Default;
                Configure(loggerConfiguration, context, level, loggingOptions.Path, appOptions.Name);
            }, true);
        }

        private static void Configure(this LoggerConfiguration loggerConfiguration, WebHostBuilderContext context,
            LogEventLevel level, string logPath, string appName)
        {
            var path = Path.Combine(Path.Combine(logPath, appName), appName + "-.log");
            const string outputTemplate =
                "[{Timestamp:yyyy-MM-dd HH:mm:ss} {Level:u3}] [{RequestId}] {SourceContext}.{SourceMemberName}{Message:lj}{NewLine}{Exception}";
            loggerConfiguration.ReadFrom.Configuration(context.Configuration)
                .MinimumLevel.Is(level)
                .Enrich.FromLogContext()
                .Enrich.WithProperty("RequestId", "null")
                .WriteTo.File(path, outputTemplate: outputTemplate, rollingInterval: RollingInterval.Day)
                .WriteTo.Console(outputTemplate: outputTemplate); //,fileSizeLimitBytes:500*1024*1024);
        }
    }
}