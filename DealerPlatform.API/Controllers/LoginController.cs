using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DealerPlatform.Service.Customer;
using DealerPlatform.Service.Customer.Dto;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DealerPlatform.API.Controllers
{
    //[Route("api/[controller]")]
    //[ApiController]
    public class LoginController : BaseController
    {
        private readonly ICustomer _customer;
        public LoginController(ICustomer customer)
        {
            _customer = customer;
        }

        [HttpGet]
        public IActionResult CheckLoginAPi(UserCheckInput checkInput)
        {
            if (string.IsNullOrWhiteSpace(checkInput.CustomerName) || string.IsNullOrWhiteSpace(checkInput.Pwd))
            {
                return NoContent();//错误码204
            }

            return BadRequest();//400
        }

        [HttpPost]
        public string CheckLogin(UserCheckInput checkInput)
        {
            if (string.IsNullOrWhiteSpace(checkInput.CustomerName) || string.IsNullOrWhiteSpace(checkInput.Pwd))
            {
                this.HttpContext.Response.StatusCode = 204;
                return null; ;//错误码204
            }
            var customerPwd = _customer.CheckLogin(checkInput);
            if (customerPwd != null)
            {
                //return GetToken(customerPwd.CustomerNo);
                return customerPwd.CustomerNo;
            }
            else
            {
                this.HttpContext.Response.StatusCode = 204;
                return null;
            }
        }
    }
}
