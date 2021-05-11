using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Service.Product.Dto
{
    public class ProductTypeDto
    {
        public string TypeName { get; set; }
        public string TypeNameCn { get; set; }
        public List<string> TypeItems { get; set; } = new List<string>();
    }
}
