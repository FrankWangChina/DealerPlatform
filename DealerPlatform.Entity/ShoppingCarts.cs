using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class ShoppingCarts
    {
        public System.Int32? Id { get; set; }
        public System.String CartGuid { get; set; }
        public System.String CustomerNo { get; set; }
        public System.String ProductNo { get; set; }
        public System.Int32? ProductNum { get; set; }
        public System.Boolean? CartSelected { get; set; }
    }
}
