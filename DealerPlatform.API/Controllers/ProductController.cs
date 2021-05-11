using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DealerPlatform.Entity;
using DealerPlatform.Service.Product;
using DealerPlatform.Service.Product.Dto;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DealerPlatform.API.Controllers
{
    public class ProductController : BaseController
    {
        private readonly IProduct _productService;
            
        public ProductController(IProduct productService)
        {
            _productService = productService;
        }

        /// <summary>
        /// 根据搜索条件查找对应的产品信息
        /// </summary>
        /// <param name="bType"></param>
        /// <param name="typeName"></param>
        /// <param name="productTypes"></param>
        /// <param name="searchText"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        [HttpGet]
        public List<ProductDto> GetProductsPage(string bType, string typeName, string productTypes, string searchText, int pageIndex, int pageSize)
        {
            //var products = _productService.GetAllProducts();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            if (productTypes != null && !string.IsNullOrEmpty(productTypes))
            {
                foreach (var productType in productTypes.Split("%5E"))
                {
                    dic.Add(productType.Split('_')[0], productType.Split('_')[1]);
                }
            }
            var ppfDto = new ProductPageAndFilterDto
            {
                BType = bType,
                ProductTypes = dic,
                TypeName = typeName == "" ? null : typeName,
                SearchText = searchText,
                PageIndex = pageIndex,
                PageSize = pageSize
            };
            return _productService.GetProductsByPage(ppfDto);
        }

        [HttpGet("bType")]
        public List<string> GetTypeNames(string bType)
        {
            return _productService.GetTypeNames(bType);
        }
    }
}
