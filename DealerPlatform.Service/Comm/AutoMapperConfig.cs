using System;
using System.Collections.Generic;
using System.Text;
using AutoMapper;
using DealerPlatform.Entity;
using DealerPlatform.Service.Customer.Dto;
using DealerPlatform.Service.Product.Dto;

namespace DealerPlatform.Service.Comm
{
    public class AutoMapperConfig:Profile
    {
        public AutoMapperConfig()
        {
            CreateMap<Customers, UserCheckInput>().ReverseMap();
            CreateMap<CustomerPwds, CustomerPwdDto>().ReverseMap();
            CreateMap<Products, ProductDto>().ReverseMap();
        }
    }
}
