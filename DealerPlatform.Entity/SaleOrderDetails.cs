using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class SaleOrderDetails
    {
        public System.Int32? Id { get; set; }
        public System.String SaleOrderGuid { get; set; }
        public System.String SaleOrderNo { get; set; }
        public System.String ProductNo { get; set; }
        public System.String ProductName { get; set; }
        public System.String ProductPhotoUrl { get; set; }
        public System.String CustomerNo { get; set; }
        public System.DateTime? InputDate { get; set; }
        public System.Int32? OrderNum { get; set; }
        public System.Double? BasePrice { get; set; }
        public System.Double? DiffPrice { get; set; }
        public System.Double? SalePrice { get; set; }
    }
}
