using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Net.Configuration;
using System.Web.Configuration;
using System.Text;
using System.Globalization;
using PMSApp.Web;
using PMSApp.BusinessLogicLayer;

/// <summary>
/// Summary description for CommonFunctions
/// </summary>
public class CommonFunctions
{
    public static string LocationsEmailAddress(string Warehouse, string Location)
    {
        string strEmailofLocation = DataFunctions.FunGetLocationEmail(Warehouse,Location);
        return strEmailofLocation;
    }
    public static bool SendNewRequisitionEmail(int RequisitionId, string senderWarehouse, string senderLocation, string recieverWarehouse, string recieverLocation, string subject, string message)
    {
        bool sent = false;
        string from = String.Format("{0} <{1}>", senderWarehouse + " : " + senderLocation , LocationsEmailAddress(senderWarehouse,senderLocation));
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat("You have a new Requisition!");
        sb.AppendLine();
        sb.AppendLine();
        sb.AppendLine("The Requisition is: " + message);
        sb.AppendLine();
        sb.AppendLine();
        sb.AppendLine("The user information is below:");
        sb.AppendLine();
        //sb.AppendLine("Requestor: ");
        sb.AppendLine("Warehouse: " + senderWarehouse + " Location: " + senderLocation);
        sb.AppendLine();
        sb.AppendLine(ReturnSiteVariables.ReturnAppCompanyName());
        sb.AppendLine(PMSHttpApplication.SiteUrl);
        try
        {
            MailMessage m = new MailMessage(from, LocationsEmailAddress(recieverWarehouse, recieverLocation));
            SmtpSection smtpSec = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
            m.Subject = ReturnSiteVariables.ReturnAppApplicationName() + " - " + subject;
            m.Body = sb.ToString();
            SmtpClient client = new SmtpClient();
            client.Host = smtpSec.Network.Host;
            client.Send(m);
            sent = true;
        }
        catch
        {
            // Not Sent.
            sent = false;
        }
        return sent;
    }
    // Static Method to Display Weekday for any given date
    public static string DisplayWeekDay(DateTime dt)
    {
        string str = dt.DayOfWeek.ToString();
        return str;
    }
    public static DateTime ConvertToUniversalDate(string dt)
    {
        DateTime returndt;
        returndt = DateTime.ParseExact(dt, GetAppDateString(), new System.Globalization.CultureInfo("en-US", true));
        return returndt;
    }

    public static string GetAppDateString()
    {
        string dtstr = GetAppDateFormat();
        int startIndex = dtstr.IndexOf("{") + 3;
        int readLength =   (((dtstr.Length) -1) - startIndex);     //dtstr.IndexOf("}");
        string strresult = dtstr.Substring(startIndex, readLength);
        return strresult;
    }
    public static string GetAppDateFormat()
    {
        SiteSettings settings = SiteSettings.GetSharedSettings();
        string strAppDateFormat = settings.DateFormat;
        return strAppDateFormat;
    }
    public static string ConvertToAppDateFormat(DateTime varDate)
    {
        string strConvAppDateFormat;
        try
        {
            strConvAppDateFormat = String.Format(GetAppDateFormat(), varDate);
        }
        catch
        {
            strConvAppDateFormat = "";
        }
        return strConvAppDateFormat;
    }

    public static string ConvertStrToAppDateFormat(string varDate)
    {
        string strConvAppDateFormat;
        try
        {
            strConvAppDateFormat = String.Format(GetAppDateFormat(), varDate);
        }
        catch
        {
            strConvAppDateFormat = "";
        }
        if (strConvAppDateFormat != "")
        {
            strConvAppDateFormat = ConvertToAppDateFormat(Convert.ToDateTime(strConvAppDateFormat));
        }
        return strConvAppDateFormat;
    }
    public static string ConvertMapicsStrToAppDateFormat(string varDate)
    {
        string strConvAppDateFormat;
        //Convert YYYYMMDD -> dd/MM/YYYY
        string strDt = varDate.Substring(6,2)+ "/" + varDate.Substring(4,2) + "/"+ varDate.Substring(0,4);
        try
        {
            DateTime dtParseDate = DateTime.Parse(strDt);
            strConvAppDateFormat = ConvertToAppDateFormat(dtParseDate);
        }
        catch
        {
            strConvAppDateFormat = "";
        }
        return strConvAppDateFormat;
    }
    public static decimal ConvertAppDateToCMapicsFormat(DateTime varDate)
    {
        decimal ConvertCYYMMDD;
        ConvertCYYMMDD = Convert.ToDecimal(varDate.ToString("yyyyMMdd")) - 19000000;
        return ConvertCYYMMDD;
        
    }
    public CommonFunctions()
    {
        //
        // TODO: Add constructor logic here
        //

    }
}
