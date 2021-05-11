using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Comm.MemoryCacheComm
{
    public class MemoryCacheHelper
    {
        private static IMemoryCache _memoryCache;
        /// <summary>
        /// 构造函数注入
        /// </summary>
        static MemoryCacheHelper()
        {
            _memoryCache ??=new MemoryCache(new MemoryCacheOptions());
        }

        /// <summary>
        /// 设置缓存的值
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <param name="overTime"></param>
        public static void SetMemory(string key, object value, TimeSpan overTime)
        {
            _memoryCache.Set(key,value,overTime);
        }

        /// <summary>
        /// 获取缓存的值
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public static object GetMemory(string key)
        {
            return _memoryCache.Get(key);
        }
    }
}
