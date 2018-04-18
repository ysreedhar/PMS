using System;


public class SupplyTray
{
    private string strSupplyItemCount;
    private string strSupItemName;
    private string strSupItemDesc;
    private string strSupItemUOM;
    private string strSupQuantity;
    private string dtSupplyDate;
    private string strPONumber;
    private string strDONumber;
    private string strPalletNumber;
    private string strBoxNumber;
    

    public string SupplyItemCount
    {
        get
        {
            return strSupplyItemCount;
        }
        set
        {
            strSupplyItemCount = value;
        }
    }
    public string SupplyItemName
    {
        get
        {
            return strSupItemName;
        }
        set
        {
            strSupItemName = value;
        }
    }
    public string SupplyItemDesc
    {
        get
        {
            return strSupItemDesc;
        }
        set
        {
            strSupItemDesc = value;
        }
    }
    public string SupplyItemUOM
    {
        get
        {
            return strSupItemUOM;
        }
        set
        {
            strSupItemUOM = value;
        }
    }
    public string SupplyQuantity
    {
        get
        {
            return strSupQuantity;
        }
        set
        {
            strSupQuantity = value;
        }
    }
    public string SupplyDate
    {
        get
        {
            return dtSupplyDate;
        }
        set
        {
            dtSupplyDate = value;
        }
    }
    public string PONumber
    {
        get
        {
            return strPONumber;
        }
        set
        {
            strPONumber = value;
        }
    }
    public string DONumber
    {
        get
        {
            return strDONumber;
        }
        set
        {
            strDONumber = value;
        }
    }
    public string PalletNumber
    {
        get
        {
            return strPalletNumber;
        }
        set
        {
            strPalletNumber = value;
        }
    }
    public string BoxNumber
    {
        get
        {
            return strBoxNumber;
        }
        set
        {
            strBoxNumber = value;
        }
    }

}
