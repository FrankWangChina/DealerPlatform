using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Core.Data
{
    public class SqlHelperOptions
    {
        public string ConStr { get; set; }
        public bool IsConfiged => !string.IsNullOrEmpty(ConStr);
    }
}
