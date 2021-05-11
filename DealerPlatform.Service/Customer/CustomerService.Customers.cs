using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DealerPlatform.Comm;
using DealerPlatform.Comm.MemoryCacheComm;
using DealerPlatform.Entity;

namespace DealerPlatform.Service.Customer
{
    public partial class CustomerService
    {
        /// <summary>
        /// 获取 所有的 Customer 信息
        /// </summary>
        /// <returns></returns>
        public IEnumerable<Customers> GetCustomersAll()
        {
            List<Customers> customers;
            if (MemoryCacheHelper.GetMemory(AppConstSet.customerCacheKey)==null)//检查缓存中是否存在
            {
                customers = _customerRepository.GetListAll().ToList();
                MemoryCacheHelper.SetMemory(AppConstSet.customerCacheKey,customers,TimeSpan.FromDays(1.0));
            }
            else //存在直接在缓存中取值
            {
                customers = MemoryCacheHelper.GetMemory(AppConstSet.customerCacheKey) as List<Customers>;
            }

            return customers;
        }

        /// <summary>
        /// 根据姓名查询用户信息
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public Customers GetCustomerByName(string name)
        {
            return GetCustomersAll().FirstOrDefault(x=>x.CustomerName.Equals(name));
        }

        /// <summary>
        /// 根据No查询用户信息
        /// </summary>
        /// <param name="no"></param>
        /// <returns></returns>
        public Customers GetCustomerByNo(string no)
        {
            return GetCustomersAll().FirstOrDefault(x => x.CustomerNo.Equals(no));
        }
    }
}
