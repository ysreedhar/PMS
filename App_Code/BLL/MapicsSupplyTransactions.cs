using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using MPPDATATableAdapters;

/// <summary>
/// Summary description for MapicsSupplyTransactions
/// </summary>
public class MapicsSupplyTransactions
{
    public static void UpdateRecieveSupplyFiles(decimal decSupplyQuantity, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUserName, string strWarehouse, string strItemName, string strOrderNumber, string strDONumber, string strPalletNumber)
    {
        MI5RSHDPTableAdapter SupplyHeaderAdapter = new MI5RSHDPTableAdapter();
        SupplyHeaderAdapter.UpdateMI5RSHDP(decSupplyQuantity, decCurrUpdationDt, decCurrUpdationTm, strUserName, strWarehouse, strItemName, strOrderNumber);
        MI5RSRDPTableAdapter SupplyDetailAdapter = new MI5RSRDPTableAdapter();
        SupplyDetailAdapter.UpdateMI5RSRDP(decSupplyQuantity, decSupplyQuantity, decCurrUpdationDt, decCurrUpdationTm, strUserName, strItemName, strWarehouse, strOrderNumber, strDONumber, strPalletNumber);
    }
    public static void InsertMI5RSSDP(string strItemNumber, string strWarehouse, string strTransactionCode, string strOrderNumber, string strPalletNumber, string strBoxNumber, decimal decSupplyQuantity, decimal decTransactionDate, string strLocation, string strDONumber, string strItemDesc, string strToWarehouse, string strToLocation, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUserName)
    {
        MI5RSSDPTableAdapter SupplyFileAdapter = new MI5RSSDPTableAdapter();
        SupplyFileAdapter.InsertMI5RSSDP(strItemNumber, strWarehouse, "TW", strOrderNumber, strPalletNumber + strOrderNumber, strPalletNumber, strBoxNumber, decSupplyQuantity, decTransactionDate, strLocation, 0, " ", strDONumber, strItemDesc, strToWarehouse, strToLocation, decCurrUpdationDt, decCurrUpdationTm, strUserName, " ");
    }

    public static void InsertMI5RSHDP(string strItemNumber, string strItemDesc, string strWarehouse, decimal decSupplyQuantity, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUserName)
    {
        MI5RSHDPTableAdapter SupplyFileAdapter = new MI5RSHDPTableAdapter();
        SupplyFileAdapter.InsertMI5RSHDP(strItemNumber, strItemDesc, strWarehouse, "0000001", decSupplyQuantity, decSupplyQuantity, 0, decCurrUpdationDt, decCurrUpdationTm, strUserName);
    }

    public static void InsertMI5RSRDP(string strItemNumber, string strWarehouse, string strItemUOM, string strPalletNumber, decimal decSupplyQuantity, string strLocation, string strItemDesc, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUserName)
    {
        MI5RSRDPTableAdapter SupplyFileAdapter = new MI5RSRDPTableAdapter();
        SupplyFileAdapter.InsertMI5RSRDP(strItemNumber, strWarehouse, strItemUOM, "0000001", "0000001", strPalletNumber, decSupplyQuantity, 0, decSupplyQuantity, strItemDesc, "0000001", strLocation, decCurrUpdationDt, decCurrUpdationTm, strUserName);
    }

    public static void WriteSubConSupplyTransaction(string strItemNumber, string strWarehouse, string strItemUOM, DateTime dtTransactionDt, string strIssueLocation, string strRecWH, string strRecLocation, decimal decSupplyQuantity, string strItemDesc, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUserName)
    {
        // step 1 from the Issue Warehouse to Application's Inventory Control, Insert if required
        if (1 != 1)
        {
            InsertMI5RSHDP(strItemNumber, strItemDesc, ReturnSiteVariables.ReturnAppInvControlWarehouse(), decSupplyQuantity, decCurrUpdationDt, decCurrUpdationTm, strUserName);
            InsertMI5RSRDP(strItemNumber, ReturnSiteVariables.ReturnAppInvControlWarehouse(), strItemUOM, "", decSupplyQuantity, ReturnSiteVariables.ReturnAppInvControl(), strItemDesc, decCurrUpdationDt, decCurrUpdationTm, strUserName);
        }
        // else update the already existing file with different Item Number, Quantity
        else
        {
            UpdateRecieveSupplyFiles(decSupplyQuantity, decCurrUpdationDt, decCurrUpdationTm, strUserName, ReturnSiteVariables.ReturnAppInvControlWarehouse(), strItemNumber, "00001", " ", " ");
        }
        // Insert the Supply Detail file with transaction
        InsertMI5RSSDP(strItemNumber, strWarehouse, "TW", "001", "001", "0", decSupplyQuantity,  Convert.ToDecimal(dtTransactionDt.ToString("ddMMyyyy")), strIssueLocation, " ", strItemDesc, ReturnSiteVariables.ReturnAppInvControlWarehouse(), ReturnSiteVariables.ReturnAppInvControl(), decCurrUpdationDt, decCurrUpdationTm, strUserName);
        WriteOfflineTransactions("001", strItemNumber, ReturnSiteVariables.ReturnAppInvControlWarehouse(), strWarehouse, decSupplyQuantity, strItemUOM, " ", strIssueLocation, CommonFunctions.ConvertAppDateToCMapicsFormat(dtTransactionDt), ReturnSiteVariables.ReturnAppInvControl());
        // Step 2. write Normal supply transaction to from Application Inventory to SubCon
        WriteSupplyTransactions("001", strItemNumber, strItemDesc, strRecWH, ReturnSiteVariables.ReturnAppInvControlWarehouse(), decSupplyQuantity, strItemUOM, "0", " ", "001", ReturnSiteVariables.ReturnAppInvControl(), dtTransactionDt, strRecLocation, strUserName);
    }
    public static void InsertPMSTRXOF(string strOLN020, string strOLN030, string strOLN040, string strOLN050, string strOLN060, decimal decOLN070, string strOLN080, string strOLN150, string strOLN160, decimal decOLN170,string strOLN200, string strOLN210, string strOLN220)
    {
        PMSTRXOFTableAdapter OfflineFileAdapter = new PMSTRXOFTableAdapter();
        OfflineFileAdapter.InsertPMSTRXOF(" ", strOLN020, strOLN030, strOLN040, strOLN050, strOLN060, decOLN070, strOLN080, " ", 0, " ", 0, 0, " ", strOLN150, strOLN160, decOLN170, 0, 0, strOLN200, strOLN210, strOLN220, " ", 0, 0, " ", " ", 0, 0, 0, " ", " ", " ", 0, " ", " ", " ", " ", " ", " ", " ", " ", 0, 0, 0, 0, 0);
    }
    public static void WriteTWTransaction(string strPONumber, string strItemNumber,string strRecWH,string strIssueWH,decimal decTransactionQty,string strUOM,string strBoxNumber,string strIssueLocation, decimal decTransactionDt,string strRecLocation)
    {
        InsertPMSTRXOF("RW", strPONumber, strItemNumber, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strIssueLocation, decTransactionDt, strRecLocation, " ", " ");
        InsertPMSTRXOF("IW", strPONumber, strItemNumber, strIssueWH, strRecWH, decTransactionQty, strUOM, strBoxNumber, strRecLocation, decTransactionDt, strIssueLocation, " ", " ");
    }
    public static void WriteISTransaction(string strPONumber, string strItemNumber, string strRecWH, string strIssueWH, decimal decTransactionQty, string strUOM, string strBoxNumber, string strIssueLocation, decimal decTransactionDt, string strRecLocation)
    {
        InsertPMSTRXOF("IS", strPONumber, strItemNumber, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strIssueLocation, decTransactionDt, strRecLocation, " ", " ");
    }
    public static void WriteRCTransaction(string strPONumber, string strItemNumber, string strRecWH, string strIssueWH, decimal decTransactionQty, string strUOM, string strBoxNumber, string strIssueLocation, decimal decTransactionDt, string strRecLocation)
    {
        InsertPMSTRXOF("RC", strPONumber, strItemNumber, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strIssueLocation, decTransactionDt, strRecLocation, " ", " ");
    }
    public static void WriteOfflineTransactions(string strPONumber, string strItemNumber, string strRecWH, string strIssueWH, decimal decTransactionQty, string strUOM, string strBoxNumber, string strIssueLocation, decimal decTransactionDt, string strRecLocation)
    {
        WriteTWTransaction(strPONumber, strItemNumber, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strIssueLocation, decTransactionDt, strRecLocation);
    }
    public static void WriteRecieveSupplyTransactions(string strPONumber, string strItemNumber,string strItemDesc, string strRecWH, string strIssueWH, decimal decTransactionQty, string strUOM, string strBoxNumber, string strDONumber,string strPalletNumber, string strIssueLocation, decimal decTransactionDt, string strRecLocation, decimal decCurrUpdationDt, decimal decCurrUpdationTm, string strUsrName)
    {
        UpdateRecieveSupplyFiles(decTransactionQty, decCurrUpdationDt, decCurrUpdationTm, strUsrName, strIssueWH, strItemNumber, strPONumber, strDONumber, strPalletNumber);
        InsertMI5RSSDP(strItemNumber, strIssueWH, "TW", strPONumber, strPalletNumber, strBoxNumber, decTransactionQty, decTransactionDt, strIssueLocation, strDONumber, strItemDesc, strRecWH, strRecLocation, decCurrUpdationDt, decCurrUpdationTm, strUsrName);

    }
    public static void WriteSupplyTransactions(string strPONumber, string strItemNumber, string strItemDesc, string strRecWH, string strIssueWH, decimal decTransactionQty, string strUOM, string strBoxNumber, string strDONumber, string strPalletNumber, string strIssueLocation, DateTime dtTransactionDt, string strRecLocation, string strUsrName)
    {
        WriteRecieveSupplyTransactions(strPONumber, strItemNumber, strItemDesc, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strDONumber, strPalletNumber, strIssueLocation, Convert.ToDecimal(dtTransactionDt.ToString("ddMMyyyy")), strRecLocation, Convert.ToDecimal(DateTime.Now.ToString("yyyyMMdd")), Convert.ToDecimal(DateTime.Now.ToString("hhmmss")), strUsrName);
        WriteOfflineTransactions(strPONumber, strItemNumber, strRecWH, strIssueWH, decTransactionQty, strUOM, strBoxNumber, strIssueLocation, CommonFunctions.ConvertAppDateToCMapicsFormat(dtTransactionDt), strRecLocation);
    }

}
