using System;
using System.Collections.Generic;
using System.Text;
using DealerPlatform.Entity;
using DealerPlatform.Service.Product.Dto;

namespace DealerPlatform.Service.Product
{
    public interface IProduct
    {
        List<Products> GetAllProducts();
        List<ProductDto> GetProductsByPage(ProductPageAndFilterDto ppadto);
        List<string> GetTypeNames(string bType);
    }
}
