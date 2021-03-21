using System;
using System.Text.Encodings.Web;
using System.Text.Unicode;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.WebEncoders;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Api.Infrastructure.Extensions
{
    public static class ServiceCollectionExtensions
    {
        private static IServiceCollection AddProduces(this IServiceCollection services)
        {
            if (services is null)
            {
                throw new ArgumentNullException($"{nameof(AddProduces)}: {nameof(services)} is null.");
            }

            //services.Configure<MvcOptions>(options => options.Filters.Add(new ProducesAttribute("application/json")));
            return services;
        }

        private static IServiceCollection AddAllowAllOrigin(this IServiceCollection services)
        {
            if (services is null)
            {
                throw new ArgumentNullException($"{nameof(AddAllowAllOrigin)}: {nameof(services)} is null.");
            }

            services.AddCors(options =>
            {
                options.AddPolicy("AllowAllOrigin",
                    builder => builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
            });
            return services;
        }

        public static IServiceCollection AddServerMainConfig(this IServiceCollection services)
        {
            return services.AddServerMainConfig<ServiceOptions>();
        }

        public static IServiceCollection AddServerMainConfig<T>(this IServiceCollection services)
            where T : ServiceOptions, new()
        {
            if (services is null)
            {
                throw new ArgumentNullException($"{nameof(AddServerMainConfig)}: {nameof(services)} is null.");
            }

            using var serviceProvider = services.BuildServiceProvider();
            var configuration = serviceProvider.GetService<IConfiguration>();
            services.AddOptions();

            services.Configure<T>(configuration.GetSection("Service"));
            services.AddSingleton(configuration.GetOptions<T>("Service"));

            services.Configure<KestrelServerOptions>(configuration.GetSection("Kestrel"));

            services.AddProduces();
            services.AddAllowAllOrigin();

            services.AddControllers()
                .AddNewtonsoftJson(options =>
                {
                    options.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
                    options.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
                    options.SerializerSettings.DateFormatHandling = DateFormatHandling.IsoDateFormat;
                    options.SerializerSettings.DateTimeZoneHandling = DateTimeZoneHandling.Utc;
                });
            services.Configure<WebEncoderOptions>(options =>
                options.TextEncoderSettings = new TextEncoderSettings(UnicodeRanges.All));

            return services;
        }
    }
}