using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using PMSApp.BusinessLogicLayer;

/// <summary>
/// Summary description for ValidationFunctions
/// This Class is used for validation functions across the entire application.
/// </summary>
public class ValidationFunctions
{     
    public static bool IsValidDateRange(string FromDate, string ToDate)
    {
        bool IsValidRange = false ;
        try
        {

            TimeSpan startSpan = CommonFunctions.ConvertToUniversalDate(ToDate) - CommonFunctions.ConvertToUniversalDate(FromDate);
            if (startSpan.Days >= 0)
            {
                IsValidRange = true;
            }
        }
        catch
        { 

        }
        return IsValidRange;
    }

    public ValidationFunctions()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}
