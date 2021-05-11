using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    /// <summary>
    /// 用户密码
    /// </summary>
    [Serializable]
    public class CustomerPwds:BaseEntity
    {
        //public System.Int32? id { get; set; }
        public System.String CustomerNo { get; set; }
        public System.String CustomerPwd { get; set; }
    }
}
