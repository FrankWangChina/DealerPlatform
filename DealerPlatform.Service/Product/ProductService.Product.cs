using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DealerPlatform.Comm;
using DealerPlatform.Comm.MemoryCacheComm;
using DealerPlatform.Entity;
using DealerPlatform.Service.Product.Dto;

namespace DealerPlatform.Service.Product
{
    public partial class ProductService
    {
        /// <summary>
        /// 获取所有商品并缓存
        /// </summary>
        /// <returns></returns>
        public List<Products> GetAllProducts()
        {
            List<Products> list = MemoryCacheHelper.GetMemory(AppConstSet.productCacheKey) as List<Products>;
            if (list == null)
            {
                list = _productRepository.GetListAll().ToList();
                MemoryCacheHelper.SetMemory(AppConstSet.productCacheKey,list,TimeSpan.FromHours(1));
            }
            return list;
        }

        /// <summary>
        /// 根据筛选条件获取产品分页
        /// </summary>
        /// <param name="ppadto"></param>
        /// <returns></returns>
        public List<ProductDto> GetProductsByPage(ProductPageAndFilterDto ppadto)
        {
            var products = GetAllProducts();
            if (ppadto.ProductTypes != null && ppadto.ProductTypes.Count > 0)
            {
                ppadto.ProductTypes.TryGetValue("ProductBZGG", out string bzgg);
                ppadto.ProductTypes.TryGetValue("ProductCD", out string cd);
                ppadto.ProductTypes.TryGetValue("ProductPP", out string pp);
                ppadto.ProductTypes.TryGetValue("ProductXH", out string xh);
                ppadto.ProductTypes.TryGetValue("ProductCZ", out string cz);
                ppadto.ProductTypes.TryGetValue("ProductHB", out string hb);
                ppadto.ProductTypes.TryGetValue("ProductHD", out string hd);
                ppadto.ProductTypes.TryGetValue("ProductGY", out string gy);
                ppadto.ProductTypes.TryGetValue("ProductHS", out string hs);
                ppadto.ProductTypes.TryGetValue("ProductMC", out string mc);
                ppadto.ProductTypes.TryGetValue("ProductDJ", out string dj);
                ppadto.ProductTypes.TryGetValue("ProductGG", out string gg);
                ppadto.ProductTypes.TryGetValue("ProductYS", out string ys);
                products = products.FindAll(m => (bzgg == null || m.ProductBZGG == bzgg)
                                                 && (cd == null || m.ProductCD == cd)
                                                 && (pp == null || m.ProductPP == pp)
                                                 && (xh == null || m.ProductXH == xh)
                                                 && (cz == null || m.ProductCZ == cz)
                                                 && (hb == null || m.ProductHB == hb)
                                                 && (hd == null || m.ProductHD == hd)
                                                 && (gy == null || m.ProductGY == gy)
                                                 && (hs == null || m.ProductHS == hs)
                                                 && (mc == null || m.ProductMC == mc)
                                                 && (dj == null || m.ProductDJ == dj)
                                                 && (gg == null || m.ProductGG == gg)
                                                 && (ys == null || m.ProductYS == ys));
            }

            return GetFullProductDto(products.FindAll(x=>x.BelongTypeNo.Equals(ppadto.BType)
                                                         &&(x.BelongTypeName.Equals(ppadto.TypeName)||string.IsNullOrEmpty(ppadto.TypeName))
                                                         &&x.ProductName.Contains(ppadto.SearchText==null?"":ppadto.SearchText)
                                                         )
                .Skip((ppadto.PageIndex-1)*ppadto.PageSize)
                .Take(ppadto.PageSize).ToList());
        }

        /// <summary>
        /// 根据产品序号获取对应价格和图片的合集
        /// </summary>
        /// <param name="products"></param>
        /// <returns></returns>
        private List<ProductDto> GetFullProductDto(List<Products> products)
        {
            //获取物品编号的集合
            var productNos = products.Select(x =>x.ProductNo).ToList();
            //获取属于这些物品的照片和价格
            var photos = GetAllProductPhotoByProductNos(productNos);
            var sales = GetAllProductSaleByProductNos(productNos);
            //AutoMapper转换
            var dtos = _mapper.Map<List<ProductDto>>(products);
            dtos.ForEach(m =>
            {
                m.productPhoto = photos.FirstOrDefault(s => s.ProductNo.Equals(m.ProductNo));
                m.productSale = sales.FirstOrDefault(s => s.ProductNo.Equals(m.ProductNo));
                m.productSale ??= new ProductSales { SalePrice = 0 };
                m.productPhoto ??= new ProductPhotos { ProductPhotoUrl = "/img/productPhotos/1.jpg" };
            });
            return dtos;
        }

        /// <summary>
        /// 获得所有类别名称
        /// </summary>
        /// <param name="bType"></param>
        /// <returns></returns>
        public List<string> GetTypeNames(string bType)
        {
            return GetAllProducts().FindAll(x => x.BelongTypeNo.Equals(bType)).Select(x => x.TypeName).Distinct()
                .Where(x => !string.IsNullOrWhiteSpace(x)).ToList();
        }
    }
}
