using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace DealerPlatform.Core.Attribute
{
    public static class GetMapping
    {
        /// <summary>
        /// 获取特性标注的表名
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string GetAttributeTabName(this Type type)
        {
            //查找此类中是否标注了此特性
            if (type.IsDefined(typeof(TableAttribute), true))
            {
                //从传入的type中获取指定的特性
                TableAttribute attribute = (TableAttribute) type.GetCustomAttribute(typeof(TableAttribute), true);
                return attribute.TabNameByCustom;
            }
            return type.Name;
        }

        /// <summary>
        /// 获取特性标注的列名
        /// </summary>
        /// <param name="prop"></param>
        /// <returns></returns>
        public static string GetAttributeColName(this PropertyInfo prop)
        {
            //查找此类中是否标注了此特性
            if (prop.IsDefined(typeof(ColumnAttribute), true))
            {
                //从传入的type中获取指定的特性
                ColumnAttribute attribute = (ColumnAttribute) prop.GetCustomAttribute(typeof(ColumnAttribute), true);
                return attribute.ColNameByCustom;
            }
            return prop.Name;
        }
    }
}
