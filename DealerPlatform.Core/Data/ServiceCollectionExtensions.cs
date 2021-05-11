using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public static class ServiceCollectionExtensions
    {
        /// <summary>
        /// 将依赖注入打包  用于注入StartUp
        /// </summary>
        /// <typeparam name="TContext"></typeparam>
        /// <param name="service"></param>
        public static void AddDbContext<TContext>(this IServiceCollection service) where TContext : SqlHelperBase
        {
            service.AddScoped<TContext>();
            //service.AddTransient<SqlHelperBuilder>();
            service.AddTransient<SqlHelperOptions>();
        }
    }
}
