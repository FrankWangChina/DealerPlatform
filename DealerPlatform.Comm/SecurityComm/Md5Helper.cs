using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace DealerPlatform.Comm.SecurityComm
{
    public static partial class Md5Helper
    {
        public static string ToMd5(this string str)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] outPut = md5.ComputeHash(Encoding.Default.GetBytes(str + "QQ@Frank"));
            var md5Str = BitConverter.ToString(outPut).Replace("-", "");
            return md5Str;
        }
    }
}
