using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DealerPlatform.Core;
using DealerPlatform.Core.Repository;
using DealerPlatform.Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace DealerPlatform.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;
        private readonly IRepository<Products> _repository;

        public WeatherForecastController(ILogger<WeatherForecastController> logger,IRepository<Products> repository)
        {
            _logger = logger;
            _repository = repository;
        }

        [HttpGet]
        public IEnumerable<WeatherForecast> Get()
        {
            try
            {
                var dic = new Dictionary<string, ListByCustomsEntity>();
                dic.Add("SysNo", new ListByCustomsEntity()
                {
                    value = 1,
                    isContains = true,
                    isAnd = false
                });
                dic.Add("ProductNo", new ListByCustomsEntity()
                {
                    value = "W2",
                    isContains = true,
                    isAnd = false
                });
                dic.Add("BelongTypeNo", new ListByCustomsEntity()
                {
                    value = "BC",
                    isContains = true,
                    isAnd = false
                });
                dic.Add("BelongTypeName", new ListByCustomsEntity()
                {
                    value = "123",
                    isContains = true,
                    isAnd = true
                });
                var pds = _repository.GetListByCustoms(dic);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                throw;
            }
            

            var products = _repository.GetListAll();

            var rng = new Random();
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
