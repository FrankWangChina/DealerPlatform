using System;
using System.Collections.Generic;
using System.Text;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Customer
{
    public partial class CustomerService
    {
        /// <summary>
        /// 获取供应商开户行
        /// </summary>
        /// <param name="acc"></param>
        /// <returns></returns>
        public IEnumerable<CustomerInvoices> GetCusInvoiceByAcc(string acc)
        {
            var invoices = _customerInvoiceRepository.GetListByCustom("CustomerNo", acc);
            return invoices;
        }
    }
}
