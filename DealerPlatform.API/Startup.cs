using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Autofac.Extensions.DependencyInjection;
using DealerPlatform.Core.Data;
using DealerPlatform.Core.Repository;
using DealerPlatform.Service.Comm;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;

namespace DealerPlatform.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddAutoMapper(typeof(AutoMapperConfig));
            services.AddSwaggerGen(s => {
                s.SwaggerDoc("v1", new OpenApiInfo
                {
                    Version = "v1",
                    Description = "DealerPlatformApiDemo"
                });
                ////添加安全定义
                //s.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                //{
                //    Description = "直接在下框中输入JWT生成的Token，格式为Bearer {token}，注意二者之间需要有空格",
                //    Name = "Authorization", //jwt默认的参数名称
                //    In = ParameterLocation.Header, //吧jwt存放在Header中  
                //    Type = SecuritySchemeType.ApiKey,
                //    BearerFormat = "JWT",
                //    Scheme = "Bearer"
                //});
                ////添加安全要求 {value1,value2}
                //s.AddSecurityRequirement(new OpenApiSecurityRequirement {
                //    {
                //        new OpenApiSecurityScheme {
                //            Reference = new OpenApiReference {
                //                Type = ReferenceType.SecurityScheme,
                //                Id = "Bearer"
                //            }
                //        }, new string[] { }
                //    }
                //});
            });


            //services.AddMemoryCache();//猔?

            /*
            * 跨域设置                                             设置跨域政策       名字叫any  调用时使用                                     允许的政策Header()，Method()，Origin()
            * 跨域不是为了让前端能够请求后端  而是让后端的数据能够返回前端
            */
            services.AddCors(ac => ac.AddPolicy("any", cp => cp.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin()));

            //读写分离上下文注入
            services.AddDbContext<SqlHelperRead>();
            services.AddDbContext<SqlHelperWrite>();

            //服务仓储注入
            //services.AddScoped(typeof(IRepository<>),typeof(Repository<>));

            #region AutoMapper自动映射  （记住添加Nuget   AutoMapper.Extensions.Microsoft.DependencyInjection 包）
            var serviceAssembly = Assembly.Load("DealerPlatform.Service");//加载Service程序集，将autoMapper注入Course.Service
            services.AddAutoMapper(serviceAssembly);
            #endregion

            /*
             *Core 核心层注入 将所有接口类   通过反射注入
             */
            var assemblyOfCore = Assembly.Load("DealerPlatform.Core");
            //var repository = assemblyOfCore.GetTypes().FirstOrDefault(m => m.Name == "Repository`1");
            //var iRepository = repository.GetInterface("IRepository`1").GetGenericTypeDefinition(); //
            //services.AddScoped(iRepository, repository);
            var coreTypes = assemblyOfCore.GetTypes().Where(x => !x.IsAbstract && !x.IsEnum);//找到所有非抽象类
            foreach (var type in coreTypes)
            {
                foreach (var typeOfInterface in type.GetInterfaces())
                {
                    //GetGenericTypeDefinition  返回可用于构造当前类型的泛型类型的 Type 对象
                    services.AddScoped(typeOfInterface.GetGenericTypeDefinition(), type);
                }
            }

            /*
             *Service 服务层注入 将所有接口类   通过反射注入
             */
            var assemblyOfService = Assembly.Load("DealerPlatform.Service");
            var serviceTypes = assemblyOfService.GetTypes().Where(x => !x.IsAbstract && !x.IsEnum);
            foreach (var serviceType in serviceTypes)
            {
                foreach (var iService in serviceType.GetInterfaces())
                {
                    services.AddScoped(iService, serviceType);
                }
            }

            services.AddControllers();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseSwagger();
            app.UseSwaggerUI(s => {
                s.SwaggerEndpoint("/swagger/v1/swagger.json", "DealerPlatform");
            });

            app.UseRouting();
            app.UseCors();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
