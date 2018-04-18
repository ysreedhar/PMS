using System;


	public class STray
	{
        private string strItemCount;
		private string strSCItemName;
        private string strSCItemDesc;
        private string strSCItemUOM;
		private string strSCQuantity;
		private string strSCItemType;
        public string SupplyItemName
		{
			get
			{
                return strSCItemName;
			}
			set
			{
                strSCItemName = value;
			}
		}
        
		public string SupplyQuantity
		{
			get
			{
                return strSCQuantity;
			}
			set
			{
                strSCQuantity = value;
			}
            
		}
        public string ItemCount
        {
            get 
            {
                return strItemCount;
            }
            set 
            {
                strItemCount = value;
            }
        }
        public string SCItemDesc
        {
            get
            {
                return strSCItemDesc;
            }
            set
            {
                strSCItemDesc = value;
            }
        }
        public string SCItemUOM
        {
            get
            {
                return strSCItemUOM;
            }
            set
            {
                strSCItemUOM = value;
            }
        }
        public string SupplyItemType
        {
            get
            {
                return strSCItemType;
            }
            set
            {
                strSCItemType = value;
            }
        }
        
	}
