using System.Threading.Tasks;
using Api.Infrastructure;
using Microsoft.Extensions.Hosting;

namespace Api
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var build = CustomWebHostBuilder.Create<Startup>(args).Build();

            try
            {
                await build.RunAsync();
            }
            finally
            {
                await build.StopAsync();
            }
        }
    }
}