using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public class SqlHelperWrite:SqlHelperBase
    {
        public SqlHelperWrite(SqlHelperOptions options):base(options)
        {
            
        }

        public override void OnConfiguring(SqlHelperBuilder sqlHelperBuilder)
        {
            if (!sqlHelperBuilder.IsConfiged)//若没有注入
            {
                var conStrWrite = SqlConnectionStringHelper.GetSectionValue("ConStrWrite");
                sqlHelperBuilder.UseSqlServer(conStrWrite);
            }
        }
    }
}
