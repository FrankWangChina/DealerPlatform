using System;
using System.Collections.Generic;
using System.Text;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Product.Dto
{
    public class ProductDto
    {
        public System.String SysNo { get; set; }
        public System.String ProductNo { get; set; }
        public System.String ProductName { get; set; }
        public System.String TypeNo { get; set; }
        public System.String TypeName { get; set; }
        public System.String ProductPP { get; set; }
        public System.String ProductXH { get; set; }
        public System.String ProductCZ { get; set; }
        public System.String ProductHB { get; set; }
        public System.String ProductHD { get; set; }
        public System.String ProductGY { get; set; }
        public System.String ProductHS { get; set; }
        public System.String ProductMC { get; set; }
        public System.String ProductDJ { get; set; }
        public System.String ProductCD { get; set; }
        public System.String ProductGG { get; set; }
        public System.String ProductYS { get; set; }
        public System.String UnitNo { get; set; }
        public System.String UnitName { get; set; }
        public System.String ProductNote { get; set; }
        public System.String ProductBZGG { get; set; }
        public System.String BelongTypeNo { get; set; }
        public System.String BelongTypeName { get; set; }
        public ProductSales productSale { get; set; }
        public ProductPhotos productPhoto { get; set; }
    }
}
