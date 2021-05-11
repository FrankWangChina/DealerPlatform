using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public class SqlHelperRead:SqlHelperBase
    {
        public SqlHelperRead(SqlHelperOptions options):base(options)
        {
                
        }


        public override void OnConfiguring(SqlHelperBuilder sqlHelperBuilder)
        {
            var conStrRead = SqlConnectionStringHelper.GetSectionValue("ConStrRead");
            sqlHelperBuilder.UseSqlServer(conStrRead);
        }
    }
}
