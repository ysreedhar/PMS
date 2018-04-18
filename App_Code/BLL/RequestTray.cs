using System;


public class RequestTray
{

    private string strReqItemCount; 
    private string strItemName;
    private string strItemDesc;
    private string strItemUOM;
    private string strReqDate;
    private string strReqQuantity;
    private string strInvAtRequestor;
    private float floQuantity;
    private string dtRequiredDate;
    private string strRequiredTime;
    private string intRequiredSeq;
    public string ReqItemCount
    {
        get
        {
            return strReqItemCount;
        }
        set
        {
            strReqItemCount = value;
        }
    }
    public string ItemName
    {
        get
        {
            return strItemName;
        }
        set
        {
            strItemName = value;
        }
    }
    public string ItemDesc
    {
        get
        {
            return strItemDesc;
        }
        set
        {
            strItemDesc = value;
        }
    }
    public string ItemUOM
    {
        get
        {
            return strItemUOM;
        }
        set
        {
            strItemUOM = value;
        }
    }
    public string ReqDate
    {
        get
        {
            return strReqDate;
        }
        set
        {
            strReqDate = value;
        }
    }
    public string ReqQuantity
    {
        get
        {
            return strReqQuantity;
        }
        set
        {
            strReqQuantity = value;
        }
    }
    public string InvAtRequestor
    {
        get
        {
            return strInvAtRequestor;
        }
        set
        {
            strInvAtRequestor = value;
        }
    }

    public float Quantity
    {
        get
        {
            return floQuantity;
        }
        set
        {
            floQuantity = value;
        }
    }
    public string RequiredDate
    {
        get
        {
            return dtRequiredDate;
        }
        set
        {
            dtRequiredDate = value;
        }
    }
    public string RequiredTime
    {
        get
        {
            return strRequiredTime;
        }
        set
        {
            strRequiredTime = value;
        }
    }
    public string RequiredSeq
    {
        get
        {
            return intRequiredSeq;
        }
        set
        {
            intRequiredSeq = value;
        }
    }

}
