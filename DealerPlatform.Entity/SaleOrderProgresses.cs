using System;
using System.Collections.Generic;
using System.Text;

namespace DealerPlatform.Entity
{
    [Serializable]
    public class SaleOrderProgresses
    {
        public System.Int32? Id { get; set; }
        public System.String SaleOrderNo { get; set; }
        public System.String ProgressGuid { get; set; }
        public System.Int32? StepSn { get; set; }
        public System.String StepName { get; set; }
        public System.DateTime? StepTime { get; set; }
    }
}
