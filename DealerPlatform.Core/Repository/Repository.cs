using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using DealerPlatform.Core.Attribute;
using DealerPlatform.Core.Data;
using DealerPlatform.Entity;

namespace DealerPlatform.Core.Repository
{
    public partial class Repository<T>: IRepository<T> where T:BaseEntity
    {
        private readonly SqlHelperRead _sqlHelperRead;
        private readonly SqlHelperWrite _sqlHelperWrite;

        public Repository(SqlHelperRead sqlHelperRead, SqlHelperWrite sqlHelperWrite)
        {
            _sqlHelperRead = sqlHelperRead;
            _sqlHelperWrite = sqlHelperWrite;
        }

        /// <summary>
        /// 获取表中所有数据
        /// </summary>
        /// <returns></returns>
        public IEnumerable<T> GetListAll()
        {
            //List<T> list = new List<T>();
            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name}");
            //list = ToModelList(dt);
            ToModelList(dt,out List<T> list);
            return list;
        }

        /// <summary>
        /// 根据Id返回实体
        /// </summary>
        /// <param name="Id">Id</param>
        /// <returns></returns>
        public T GetById(int Id)
        {
            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name} where Id=@Id",
                new SqlParameter("@Id",Id));
            return ToModel(dt.Rows[0]);
        }

        /// <summary>
        /// 单个参数条件查询
        /// </summary>
        /// <param name="propName">参数名</param>
        /// <param name="propValue">参数的值</param>
        /// <param name="isContains">等或不等</param>
        /// <returns></returns>
        public IEnumerable<T> GetListByCustom(string propName, string propValue, bool isContains = true)
        {
            string isCon = isContains ? "=" : "<>";
            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name} where {propName} {isCon} @propValue",
                new SqlParameter("@propValue",propValue));
            ToModelList(dt,out List<T> list);
            return list;
        }

        /// <summary>
        /// 多条件查询(有 = <> 和 and  or  判定)
        /// </summary>
        /// <param name="keyValuePairs"></param>
        /// <returns></returns>
        public IEnumerable<T> GetListByCustoms(Dictionary<string, ListByCustomsEntity> keyValuePairs)
        {
            List<string> whereParams = new List<string>();
            List<SqlParameter> whereParamsVal = new List<SqlParameter>();
            int index = 0;
            foreach (var keyValuePair in keyValuePairs)
            {
                var value = keyValuePair.Value;//取出
                string isCon = value.isContains ? "=" : "<>"; //等或不等
                string isAnd = value.isAnd ? "and" : "or";//并且或

                whereParams.Add($"{(index.Equals(0) ? "" : " "+isAnd)} {keyValuePair.Key} {isCon} @{keyValuePair.Key}");//拼接搜索的SQL

                whereParamsVal.Add(new SqlParameter($"@{keyValuePair.Key}",keyValuePair.Value.value));//SqlParameter 查询参数赋值
                index++;
            }

            // 定位到所有需要写在括号中的 Or 条件查询语句  OR需要（）括起来
            List<int> orIndex = GetSqlOrIndex(whereParams,4," or ");
            int startIndex = orIndex[0]-1;
            int endIndex = 0;
            int indexCount = orIndex.Count;
            for (int i = 0; i < indexCount; i++)
            {
                if (indexCount == 1)//若长度为1 （仅有一个or）
                {
                    endIndex = orIndex[0];
                    break;
                }

                if (i > 0)//第二次循环开始检查
                {
                    if (!(orIndex[i] - orIndex[i-1]).Equals(1))
                    {
                        endIndex = orIndex[i];
                        break;
                    }
                    endIndex = orIndex[indexCount - 1];
                }
            }
            whereParams[startIndex] = $"({whereParams[startIndex]}";
            whereParams[endIndex] = $"{whereParams[endIndex]})";

            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name} where " +
                                                           $"{string.Join("",whereParams)}",whereParamsVal.ToArray());
            ToModelList(dt, out List<T> list);
            return list;
        }

        /// <summary>
        ///  多条件查询 只有 = 和 and
        /// </summary>
        /// <param name="keyValuePairs"></param>
        /// <returns></returns>
        public IEnumerable<T> GetListByCustoms(Dictionary<string, string> keyValuePairs)
        {
            List<string> whereParams = new List<string>();
            List<SqlParameter> whereParamsVal = new List<SqlParameter>();

            foreach (var keyValuePair in keyValuePairs)
            {
                whereParams.Add($"{keyValuePair.Key} = @{keyValuePair.Key}");
                whereParamsVal.Add(new SqlParameter($"@{keyValuePair.Key}", keyValuePair.Value));
            }
            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name} where " +
                                                           $"{string.Join(" and ", whereParams)}", whereParamsVal.ToArray());
            ToModelList(dt, out List<T> list);
            return list;
        }

        /// <summary>
        ///  子段 where in 查询
        /// </summary>
        /// <param name="propsName"></param>
        /// <param name="propValues"></param>
        /// <returns></returns>
        public IEnumerable<T> GetListByCustomWhereIn(string propsName, params string[] propValues)
        {
            //select * from table where propName in (@propVal1,@propVal2...)

            //判断 in 值集合是否为空
            if (propValues.Length.Equals(0) || propValues.Equals(null)) return GetListAll();
            List<string> sqlParams = new List<string>();
            List<SqlParameter> sqlParamsVals = new List<SqlParameter>();
            for (int i = 0; i < propValues.Length; i++)
            {
                sqlParams.Add($"@prop{i}");
                sqlParamsVals.Add(new SqlParameter($"@prop{i}",propValues[i]));
            }
            string colsName = GetColumns(false);
            DataTable dt = _sqlHelperRead.ExecuteDataTable($"select {colsName} from {_type.Name} where {propsName} in {string.Join(",",sqlParams)}",
                sqlParamsVals.ToArray());
            ToModelList(dt, out List<T> list);
            return list;
        }

        /// <summary>
        /// 单个实体 新增
        /// </summary>
        /// <param name="t">实体类</param>
        /// <returns></returns>
        public int Insert(T t)
        {
            var props = _props.Where(x => !x.Name.Equals("Id"));
            string colsName = GetColumns(true);
            string[] cols = colsName.Split(',');//再一次拆分加上@符号
            List<string> colSqlPar = new List<string>();
            foreach (var col in cols)
            {
                colSqlPar.Add($"@{col}");
            }
            string sql = $"insert into {_type.Name} ({colsName}) values ({string.Join(",", colSqlPar)})";
            List<SqlParameter> sqlParVal = new List<SqlParameter>();
            foreach (var prop in props)
            {
                sqlParVal.Add(new SqlParameter($"@{prop.Name}", SqlHelperBase.ToDbValue(prop.GetValue(t))));//添加一个 实体类 类型的 SqlParameter 参数
            }

            int res = _sqlHelperWrite.ExecuteNoneQuery(sql, sqlParVal.ToArray());
            return res;
        }

        /// <summary>
        /// 单个实体 新增 完成后返回新增完成的实体 Id
        /// </summary>
        /// <param name="t">新增的实体值</param>
        /// <returns></returns>
        public object InsertBackResult(T t)
        {
            var props = _props.Where(x => !x.Name.Equals("Id"));
            string colsName = GetColumns(true);
            string[] cols = colsName.Split(',');//再一次拆分加上@符号
            List<string> colSqlPar = new List<string>();
            foreach (var col in cols)
            {
                colSqlPar.Add($"@{col}");
            }
            string sql = $"insert into {_type.Name} ({colsName}) output inserted.Id values ({string.Join(",", colSqlPar)})"; //加上output inserted.Id 返回插入成功的Id
            List<SqlParameter> sqlParVal = new List<SqlParameter>();
            foreach (var prop in props)
            {
                sqlParVal.Add(new SqlParameter($"@{prop.Name}", SqlHelperBase.ToDbValue(prop.GetValue(t))));//添加一个 实体类 类型的 SqlParameter 参数
            }

            object res = _sqlHelperWrite.ExecuteScalar(sql, sqlParVal.ToArray());
            return res;
        }

        /// <summary>
        /// 单个实体 修改
        /// </summary>
        /// <param name="t">实体类的值</param>
        /// <returns></returns>
        public int Update(T t)
        {
            //update table set col1=@col1.col2=@col2
            var props = _props;
            List<string> sqlPar = new List<string>();
            List<SqlParameter> sqlParVal = new List<SqlParameter>();
            foreach (var prop in props)
            {
                if (!prop.Name.Equals("Id"))
                {
                    sqlPar.Add($"{prop.Name}=@{prop.Name}");
                    sqlParVal.Add(new SqlParameter($"@{prop.Name}",SqlHelperBase.ToDbValue(prop.GetValue(t))));
                }
            }

            string sql = $"update {_type.Name} set {string.Join(",",sqlPar)} where Id=@Id";
            return _sqlHelperWrite.ExecuteNoneQuery(sql, sqlParVal.ToArray());
        }

        /// <summary>
        /// 删除 单个Id
        /// </summary>
        /// <param name="Id">单个I</param>
        /// <returns></returns>
        public int Delete(int Id)
        {
            //delete from table where id=@id
            string sql = $"delete from {_type.Name} where Id=@Id";
            return _sqlHelperWrite.ExecuteNoneQuery(sql, new SqlParameter("@Id", Id));
        }

        /// <summary>
        ///  删除 根据单个实体的Id删除数据
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public int Delete(T t)
        {
            //delete from table where id=@id
            var prop = _type.GetProperty("Id");//GetProperties 返回属性数组  |  GetProperty返回单个的属性
            string sql = $"delete from {_type.Name} where Id=@Id";
            return _sqlHelperWrite.ExecuteNoneQuery(sql,new SqlParameter("@Id", prop.GetValue(t.Id)));
        }

        /// <summary>
        /// 删除 根据其它非Id字段删除
        /// </summary>
        /// <param name="propName"></param>
        /// <param name="propVal"></param>
        /// <returns></returns>
        public int DeleteByCustomer(string propName, string propVal)
        {
            if (string.IsNullOrWhiteSpace(propName)) return 0;
            string sql = $"delete from {_type.Name} where {propName}=@{propName}";
            return _sqlHelperWrite.ExecuteNoneQuery(sql, new SqlParameter($"@{propName}", propVal));
        }

        

        /// <summary>
        /// DataTable转List
        /// </summary>
        /// <param name="dt">DataTable数据集</param>
        /// <param name="list">输出参数 list</param>
        /// <returns></returns>
        //private static List<T> ToModelList(DataTable dt,out List<T> list)
        private static void ToModelList(DataTable dt, out List<T> list)
        {
            list = new List<T>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var t = ToModel(dt.Rows[i]);
                list.Add(t);
            }
            //foreach (DataRow dr in dt.Rows)
            //{
            //    var t = ToModel(dr);
            //    list.Add(t);
            //}
        }

        /// <summary>
        ///通过反射  将数据行的内容转化为T模型类数据
        /// </summary>
        /// <param name="dr">DataRow数据行</param>
        /// <returns></returns>
        private static T ToModel(DataRow dr)
        {
            // 如果给泛型加了一个new()的约束，那么次泛型可以直接通过new方法实例化
            //TEntity entity = new TEntity();
            //如果没有给泛型加new()的约束，则需要通过反射生成实例
            //T entity = _entity;//生成一个空的Class类
            //var props = _props;//获取T的所有属性

            T entity = (T)Activator.CreateInstance(_type);
            var props = _type.GetProperties();
            foreach (var prop in props)
            {
                if (dr.Table.Columns.Contains(prop.Name))//若列名包含属性名
                {
                    prop.SetValue(entity, SqlHelperBase.ToCSharpValue(dr[prop.Name]));
                }
            }
            return entity;
        }
        /// <summary>
        /// 返回所有列名的字符串类型
        /// </summary>
        /// <returns></returns>
        private static string GetColumns(bool isInsert)
        {
            //获取类的属性
            PropertyInfo[] propsInfos = _props;
            //过滤出属性的名字（列名）
            IEnumerable<string> cols = isInsert? 
                propsInfos.Where(x => !x.Name.Equals("Id")).Select(x =>x.Name): propsInfos.Select(x => x.Name);
            string colsName =string.Join(",", cols);
            return colsName;
        }

        /// <summary>
        /// 获取表中所有列的集合
        /// </summary>
        /// <returns></returns>
        private static IEnumerable<string> GetColumnArray()
        {
            return _props.Select(x => x.GetAttributeColName());
        }

        /// <summary>
        /// 获得包含key值的对象在 List中的索引
        /// </summary>
        /// <param name="wherePar"></param>
        /// <returns></returns>
        private static List<int> GetSqlOrIndex(List<string> wherePar,int length,string key)
        {
            List<int> orIndex = new List<int>();
            for (int i = 0; i < wherePar.Count; i++)
            {
                if (wherePar[i].Substring(0, length).Equals(key))
                {
                    orIndex.Add(i);
                }
            }
            return orIndex;
        }
    }
}
