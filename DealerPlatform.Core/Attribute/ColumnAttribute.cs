using System;

namespace DealerPlatform.Core.Attribute
{
    [AttributeUsage(AttributeTargets.Property)] // 属性的应用限制  Property代表
    public class ColumnAttribute:System.Attribute
    {
        private readonly string _colName;

        public ColumnAttribute(string colName)
        {
            _colName = colName;
        }

        public string ColNameByCustom => _colName;
    }
}
