using System;
using System.Collections.Generic;
using System.Text;
using DealerPlatform.Service.Comm;

namespace DealerPlatform.Service.Customer.Dto
{
    public class CustomerPwdDto:EntityDto
    {
        public string CustomerNo { get; set; }
        public string CustomerPwd { get; set; }
    }
}
