using System;
using System.IO;
using Api.Infrastructure.Logging;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

namespace Api.Infrastructure
{
    public static class CustomWebHostBuilder
    {
        public static IHostBuilder Create<TStartup>(string[] args) where TStartup : class
        {
            Directory.SetCurrentDirectory(AppContext.BaseDirectory);
            var builder = new ConfigurationBuilder().SetBasePath(AppContext.BaseDirectory);
            var configuration = builder.Build();

            return Host.CreateDefaultBuilder(args).ConfigureWebHostDefaults(webBuilder =>
            {
                webBuilder.UseConfiguration(configuration);
                webBuilder.UseLogging();
                webBuilder.UseStartup<TStartup>();
            });
        }
    }
}