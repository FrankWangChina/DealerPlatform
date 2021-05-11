using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public class SqlConnectionStringHelper
    {
        private static IConfiguration _configuration;

        static SqlConnectionStringHelper()
        {
            //配置文件名
            var fileName = "appsettings.json";
            //或企业更根目录
            var basedir = AppContext.BaseDirectory;
            //文件路径
            var filePath = $"{basedir}/{fileName}";
            var builder = new ConfigurationBuilder().AddJsonFile(filePath, false, true);
            _configuration = builder.Build();
        }
        public static string GetSectionValue(string key)
        {
            return _configuration.GetSection(key).Value;
        }
    }
}
