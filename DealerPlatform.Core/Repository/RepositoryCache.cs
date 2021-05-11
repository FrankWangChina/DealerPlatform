using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using DealerPlatform.Core.Attribute;
using DealerPlatform.Entity;

namespace DealerPlatform.Core.Repository
{
    public partial class Repository<T> : IRepository<T> where T : BaseEntity
    {

        /// <summary>
        /// 泛型缓存  ( 将反射获取的数据  以及 SQL 语句 缓存起来 )***
        /// </summary>
        static Repository()
        {
            _type = typeof(T);
            _props = _type.GetProperties();
            //_entity = (T)Activator.CreateInstance(_type);

            //以下对SQL语句缓存（待开发***********************）
            string strCols = GetColumns(false);
            var strColsNoneId = GetColumns(true);
            var cols = GetColumnArray();
            //GetListAllSql
            _getListAllSql = $"select {strCols} from {_type.GetAttributeTabName()}";//GetAttributeTabName 为属性扩展方法
            //GetListByIdSql...

            //...
        }

        private static PropertyInfo[] _props;
        private static Type _type;
        private static T _entity;
        private static string _getListAllSql;
        private static string _getListByIdSql;
        private static string _insertSql;
        private static string _insertBackSql;
        private static string _updateSql;
        private static string _deleteSql;
    }
}
