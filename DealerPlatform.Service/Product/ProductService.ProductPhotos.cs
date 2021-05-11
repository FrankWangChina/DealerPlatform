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
        /// 获取所有商品的图片信息
        /// </summary>
        /// <returns></returns>
        private List<ProductPhotos> GetAllProductPhoto()
        {
            List<ProductPhotos> list = MemoryCacheHelper.GetMemory(AppConstSet.productPhotoCacheKey) as List<ProductPhotos>;
            if (list == null)
            {
                list = _productPhotoRepository.GetListAll().ToList();
                MemoryCacheHelper.SetMemory(AppConstSet.productPhotoCacheKey, list,TimeSpan.FromHours(1));
            }
            return list;
        }

        /// <summary>
        ///通过商品序号获取 对应的商品图片信息 
        /// </summary>
        /// <param name="productNos"></param>
        /// <returns></returns>
        public List<ProductPhotos> GetAllProductPhotoByProductNos(IEnumerable<string> productNos)
        {
            var productPhotos = GetAllProductPhoto();
            return productPhotos.FindAll(m => productNos.Contains(m.ProductNo));
        }
    }
}
