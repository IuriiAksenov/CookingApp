using System.Collections.Generic;

namespace Api.Infrastructure
{
    public static class ServicesList
    {
        public const string ApiService = "api";

        public static IEnumerable<string> AsEnumerable()
        {
            yield return ApiService;
        }
    }
}