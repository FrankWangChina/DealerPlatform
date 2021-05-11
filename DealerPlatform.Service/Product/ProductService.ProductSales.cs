using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DealerPlatform.Comm;
using DealerPlatform.Comm.MemoryCacheComm;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Product
{
    public partial class ProductService
    {
        /// <summary>
        /// 获取所有商品的售价信息
        /// </summary>
        /// <returns></returns>
        private List<ProductSales> GetAllProductSale()
        {
            List<ProductSales> list = MemoryCacheHelper.GetMemory(AppConstSet.productSaleCacheKey) as List<ProductSales>;
            if (list == null)
            {
                list = _productSalesRepository.GetListAll().ToList();
                MemoryCacheHelper.SetMemory(AppConstSet.productPhotoCacheKey, list,TimeSpan.FromHours(1));
            }
            return list;
        }

        /// <summary>
        /// 通过商品序号 获取售价信息
        /// </summary>
        /// <param name="productNos"></param>
        /// <returns></returns>
        public List<ProductSales> GetAllProductSaleByProductNos(IEnumerable<string> productNos)
        {
            var productSales = GetAllProductSale();
            return productSales.FindAll(m => productNos.Contains(m.ProductNo));
        }
    }
}
