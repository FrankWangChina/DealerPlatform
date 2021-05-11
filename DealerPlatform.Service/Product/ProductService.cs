using System;
using System.Collections.Generic;
using System.Text;
using AutoMapper;
using DealerPlatform.Core.Repository;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Product
{
    public partial class ProductService:IProduct
    {
        private readonly IRepository<Products> _productRepository;
        private readonly IRepository<ProductPhotos> _productPhotoRepository;
        private readonly IRepository<ProductSales> _productSalesRepository;
        private readonly IMapper _mapper;

        public ProductService(IRepository<Products> productRepository, IRepository<ProductPhotos> productPhotoRepository, IRepository<ProductSales> productSalesRepository, IMapper mapper)
        {
            _productRepository = productRepository;
            _productPhotoRepository = productPhotoRepository;
            _productSalesRepository = productSalesRepository;
            _mapper = mapper;
        }
    }
}
