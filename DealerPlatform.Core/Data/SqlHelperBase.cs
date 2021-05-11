using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DealerPlatform.Core.Data
{
    public class SqlHelperBase
    {
        private SqlHelperOptions _options;

        public SqlHelperBase(SqlHelperOptions options)
        {
            //在构造函数中调用  将依赖注入的sqlHelperBuilder方法传递给它
            //之后子类重写该方法就使用的是依赖注入的 sqlHelperBuilder 实例
            SqlHelperBuilder builder = new SqlHelperBuilder(options);
            OnConfiguring(builder);
            _options = options;
        }

        /// <summary>
        /// 虚方法，用于子类重写
        /// </summary>
        /// <param name="sqlHelperBuilder"></param>
        public virtual void OnConfiguring(SqlHelperBuilder sqlHelperBuilder)
        {
        }

        /// <summary>
        /// 查询返回DataTable
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="sqlParameters">参数</param>
        /// <returns></returns>
        public DataTable ExecuteDataTable(string sql, params SqlParameter[] sqlParameters)
        {
            //创建数据库连接
            using SqlConnection conn = new SqlConnection(_options.ConStr);
            conn.Open();
            //创建数据库操作类
            SqlCommand cmd = new SqlCommand(sql, conn);
            //将查询参数赋予操作类
            cmd.Parameters.AddRange(sqlParameters);
            //创建读取类
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            //创建返回数据载体
            DataSet ds = new DataSet();
            //数据填充
            sda.Fill(ds);
            return ds.Tables[0];
        }

        /// <summary>
        /// 返回非查询操作影响的行数
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="sqlParameters">参数</param>
        /// <returns></returns>
        public int ExecuteNoneQuery(string sql, params SqlParameter[] sqlParameters)
        {
            using SqlConnection conn = new SqlConnection(_options.ConStr);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddRange(sqlParameters);
            return cmd.ExecuteNonQuery();
        }

        /// <summary>
        /// 返回非查询操作的第一行第一列
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="sqlParameters">参数</param>
        /// <returns></returns>
        public object ExecuteScalar(string sql, params SqlParameter[] sqlParameters)
        {
            using SqlConnection conn = new SqlConnection(_options.ConStr);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddRange(sqlParameters);
            return cmd.ExecuteScalar();
        }

        /// <summary>
        /// C# 的 null 转换为 DBNull
        /// </summary>
        /// <param name="value">转化的值</param>
        /// <returns></returns>
        public static object ToDbValue(object value)
        {
            return value.Equals(null) ? DBNull.Value : value;
        }

        /// <summary>
        /// DBNull 转换为 C# 的 null
        /// </summary>
        /// <param name="value">转化的值</param>
        /// <returns></returns>
        public static object ToCSharpValue(object value)
        {
            return value.Equals(DBNull.Value) ? null : value;
        }
    }
}
