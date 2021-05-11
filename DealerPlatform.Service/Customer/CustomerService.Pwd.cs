using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DealerPlatform.Comm.SecurityComm;
using DealerPlatform.Entity;
using DealerPlatform.Service.Customer.Dto;

namespace DealerPlatform.Service.Customer
{
    public partial class CustomerService
    {
        /// <summary>
        /// 检查供应商登录
        /// </summary>
        /// <param name="checkInput"></param>
        /// <returns></returns>
        public UserLoginResult CheckLoginApi(UserCheckInput checkInput)
        {
            var acc = checkInput.CustomerName; //用户名
            var pwd = checkInput.Pwd;

            if (checkInput.Equals(null)) return UserLoginResult.CustomerNoExist;
            //根据用户名查找到用户信息

            var dicParams = new Dictionary<string,string>();
            dicParams.Add("CustomerNo",acc);
            dicParams.Add("CustomerPwd",pwd);
            var customer = _customerPwdsRepository.GetListByCustoms(dicParams).FirstOrDefault();
            if (customer.Equals(null)) return UserLoginResult.CustomerNoExist;
            string pwdToMd5 = pwd.ToMd5();
            if (!customer.CustomerPwd.Equals(pwdToMd5))
            {
                return UserLoginResult.WrongPassword;
            }

            return UserLoginResult.Successful;
        }

        public CustomerPwdDto CheckLogin(UserCheckInput userCheckInput)
        {
            var customerName = userCheckInput.CustomerName;
            var password = userCheckInput.Pwd;
            var customer = GetCustomerByName(customerName);
            if (customer == null) return null;
            Dictionary<string, string> keyValuePairs = new Dictionary<string, string>();
            keyValuePairs.Add("CustomerNo", customer.CustomerNo);
            keyValuePairs.Add("CustomerPwd", password.ToMd5());
            var customerPwd = _customerPwdsRepository.GetListByCustoms(keyValuePairs).FirstOrDefault();
            var customerPwdDto = _mapper.Map<CustomerPwdDto>(customerPwd);
            return customerPwdDto;
        }
    }
}
