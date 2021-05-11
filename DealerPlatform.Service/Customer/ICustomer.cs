using System;
using System.Collections.Generic;
using System.Text;
using DealerPlatform.Entity;
using DealerPlatform.Service.Customer.Dto;

namespace DealerPlatform.Service.Customer
{
    public interface ICustomer
    {
        IEnumerable<Customers> GetCustomersAll();
        Customers GetCustomerByName(string name);
        Customers GetCustomerByNo(string no);
        IEnumerable<CustomerInvoices> GetCusInvoiceByAcc(string acc);
        UserLoginResult CheckLoginApi(UserCheckInput checkInput);
        CustomerPwdDto CheckLogin(UserCheckInput checkInput);
    }
}
