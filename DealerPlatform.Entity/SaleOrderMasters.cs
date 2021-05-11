using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class SaleOrderMasters
    {
        public System.Int32? Id { get; set; }
        public System.String SaleOrderNo { get; set; }
        public System.String CustomerNo { get; set; }
        public System.String InvoiceNo { get; set; }
        public System.DateTime? InputDate { get; set; }
        public System.String StockNo { get; set; }
        public System.String EditUserNo { get; set; }
        public System.DateTime? DeliveryDate { get; set; }
        public System.String Remark { get; set; }
    }
}
