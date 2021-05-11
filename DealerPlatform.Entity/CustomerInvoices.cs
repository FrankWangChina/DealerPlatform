using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    /// <summary>
    /// 开户行信息
    /// </summary>
    [Serializable]
    public class CustomerInvoices:BaseEntity
    {
        //public System.Int32? Id { get; set; }
        public System.String CustomerNo { get; set; }
        public System.String InvoiceNo { get; set; }
        public System.String InvoiceEin { get; set; }
        public System.String InvoiceBank { get; set; }
        public System.String InvoiceAccount { get; set; }
        public System.String InvoiceAddress { get; set; }
        public System.String InvoicePhone { get; set; }
    }
}
