using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Attribute
{
    [AttributeUsage(AttributeTargets.Class)] // 属性的应用目标  Class 代表类
    public class TableAttribute:System.Attribute
    {
        private readonly string _tabName;

        public TableAttribute(string tabName)
        {
            _tabName = tabName;
        }

        public string TabNameByCustom => _tabName;
    }
}
