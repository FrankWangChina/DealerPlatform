using DealerPlatform.Core.Repository;
using System;
using System.Collections.Generic;
using System.Text;
using AutoMapper;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Customer
{
    public partial class CustomerService: ICustomer
    {
        private IRepository<Customers> _customerRepository;
        private IRepository<CustomerPwds> _customerPwdsRepository;
        private IRepository<CustomerInvoices> _customerInvoiceRepository;
        private IMapper _mapper;

        public CustomerService(IRepository<Customers> customerRepository, IRepository<CustomerPwds> customerPwdsRepository, IRepository<CustomerInvoices> customerInvoiceRepository, IMapper mapper)
        {
            _customerRepository = customerRepository;
            _customerPwdsRepository = customerPwdsRepository;
            _customerInvoiceRepository = customerInvoiceRepository;
            _mapper = mapper;
        }
    }
}
