using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class Stocks
    {
        public System.Int32? Id { get; set; }
        public System.String StockNo { get; set; }
        public System.String StockName { get; set; }
        public System.String StockLinkman { get; set; }
        public System.String StockTel { get; set; }
        public System.String StockPhone { get; set; }
    }
}
