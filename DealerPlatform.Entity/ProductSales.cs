using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class ProductSales:BaseEntity
    {
        //public System.Int32? Id { get; set; }
        public System.String SysNo { get; set; }
        public System.String ProductNo { get; set; }
        public System.String StockNo { get; set; }
        public System.Double? SalePrice { get; set; }
    }

}
