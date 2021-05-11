using System;

namespace DealerPlatform.Entity
{
    /// <summary>
    /// 用户信息主实体
    /// </summary>
    [Serializable]
    public class Customers:BaseEntity
    {
        //public System.Int32? Id { get; set; }
        public System.String CustomerNo { get; set; }
        public System.String CustomerName { get; set; }
        public System.String FirstAreaNo { get; set; }
        public System.String FirstAreaName { get; set; }
        public System.String AreaNo { get; set; }
        public System.String AreaName { get; set; }
        public System.String Province { get; set; }
        public System.String City { get; set; }
        public System.String Tel { get; set; }
        public System.String Phone { get; set; }
        public System.String Fax { get; set; }
        public System.String Address { get; set; }
        public System.String BankAccount { get; set; }
        public System.String BankNo { get; set; }
        public System.String BankName { get; set; }
        public System.String Ein { get; set; }
        public System.String CustomerNote { get; set; }
        public System.String OwnerWorkerNo { get; set; }
        public System.String OwnerWorkerName { get; set; }
        public System.String OwnerWorkerTel { get; set; }
        public System.String OpenId { get; set; }
        public System.String HeadImgUrl { get; set; }
    }
}
