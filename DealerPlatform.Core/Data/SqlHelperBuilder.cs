using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public class SqlHelperBuilder
    {
        private SqlHelperOptions Options { get; }
        public bool IsConfiged => Options.IsConfiged;

        /// <summary>
        /// 构造函数 依赖注入 SqlHelperOptions 
        /// </summary>
        /// <param name="sqlHelperOptions"></param>
        public SqlHelperBuilder(SqlHelperOptions sqlHelperOptions)
        {
            Options = sqlHelperOptions;
        }

        /// <summary>
        /// 首先赋予连接字符串 步骤①
        /// </summary>
        /// <param name="sqlConStr"></param>
        public void UseSqlServer(string sqlConStr)
        {
            Options.ConStr = sqlConStr;
        }

        /// <summary>
        /// 返回连接字符串
        /// </summary>
        /// <returns></returns>
        public SqlHelperOptions GetOptions()
        {
            return Options;
        }
    }
}
