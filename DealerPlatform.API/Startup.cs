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
                ////��Ӱ�ȫ����
                //s.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                //{
                //    Description = "ֱ�����¿�������JWT���ɵ�Token����ʽΪBearer {token}��ע�����֮����Ҫ�пո�",
                //    Name = "Authorization", //jwtĬ�ϵĲ�������
                //    In = ParameterLocation.Header, //��jwt�����Header��  
                //    Type = SecuritySchemeType.ApiKey,
                //    BearerFormat = "JWT",
                //    Scheme = "Bearer"
                //});
                ////��Ӱ�ȫҪ�� {value1,value2}
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


            //services.AddMemoryCache();//�`�J?�s

            /*
            * ��������                                             ���ÿ�������       ���ֽ�any  ����ʱʹ��                                     ���������Header()��Method()��Origin()
            * ������Ϊ����ǰ���ܹ�������  �����ú�˵������ܹ�����ǰ��
            */
            services.AddCors(ac => ac.AddPolicy("any", cp => cp.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin()));

            //��д����������ע��
            services.AddDbContext<SqlHelperRead>();
            services.AddDbContext<SqlHelperWrite>();

            //����ִ�ע��
            //services.AddScoped(typeof(IRepository<>),typeof(Repository<>));

            #region AutoMapper�Զ�ӳ��  ����ס���Nuget   AutoMapper.Extensions.Microsoft.DependencyInjection ����
            var serviceAssembly = Assembly.Load("DealerPlatform.Service");//����Service���򼯣���autoMapperע��Course.Service
            services.AddAutoMapper(serviceAssembly);
            #endregion

            /*
             *Core ���Ĳ�ע�� �����нӿ���   ͨ������ע��
             */
            var assemblyOfCore = Assembly.Load("DealerPlatform.Core");
            //var repository = assemblyOfCore.GetTypes().FirstOrDefault(m => m.Name == "Repository`1");
            //var iRepository = repository.GetInterface("IRepository`1").GetGenericTypeDefinition(); //
            //services.AddScoped(iRepository, repository);
            var coreTypes = assemblyOfCore.GetTypes().Where(x => !x.IsAbstract && !x.IsEnum);//�ҵ����зǳ�����
            foreach (var type in coreTypes)
            {
                foreach (var typeOfInterface in type.GetInterfaces())
                {
                    //GetGenericTypeDefinition  ���ؿ����ڹ��쵱ǰ���͵ķ������͵� Type ����
                    services.AddScoped(typeOfInterface.GetGenericTypeDefinition(), type);
                }
            }

            /*
             *Service �����ע�� �����нӿ���   ͨ������ע��
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
