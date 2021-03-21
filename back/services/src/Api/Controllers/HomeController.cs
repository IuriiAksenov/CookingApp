using Api.Infrastructure;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    /// <summary>
    ///     The default home controller.
    /// </summary>
    [Route(ServicesList.ApiService + "/home")]
    public class HomeController
    {
        /// <summary>
        ///     Get information about the service.
        /// </summary>
        /// <returns>
        ///     The <see cref="string" />.
        /// </returns>
        /// <response code="200">Returns OK</response>
        [HttpGet]
        public ActionResult<string> Get()
        {
            return ServicesList.ApiService;
        }
    }
}