using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Text;
using System.Xml.Serialization;
using PMSApp.Web;
namespace PMSApp.BusinessLogicLayer
{
    /// <summary>
    /// Summary description for SiteSetup
    /// </summary>
    public class SiteSettings
    {
        private const string XmlConfigFile = "~/App_Data/site-config.xml";
        private bool _SiteIsOnline;
        private bool _ImplementsTUAIP;
        private string _CompanyName;
        private string _DateFormat;
        private string _ApplicationName;
        private string _siteEmail;
        private string _InvControlWarehouse;
        private string _InvControlLocation;
        private string _PurchasingWarehouse;
        private string _PurchasingLocation;
        public bool SiteIsOnline
        {
            get
            {
                return _SiteIsOnline;
            }
            set
            {
                lock (this)
                {
                    _SiteIsOnline = value;
                }
            }

        }
        public bool ImplementsTUAIP
        {
            get
            {
                return _ImplementsTUAIP;
            }
            set
            {
                lock (this)
                {
                    _ImplementsTUAIP = value;
                }
            }
        }
       
        [System.ComponentModel.TypeConverter(typeof(System.ComponentModel.EnumConverter))]

        public string CompanyName
        {
            get
            {
                return _CompanyName;
            }
            set
            {
                lock (this)
                {
                    _CompanyName = value;
                }
            }
        }

        public string DateFormat
        {
            get
            {
                return _DateFormat;
            }
            set
            {
                lock (this)
                {
                    _DateFormat = value;
                }
            }
        }
        public string ApplicationName
        {
            get
            {
                return _ApplicationName;
            }
            set
            {
                lock (this)
                {
                    _ApplicationName = value;
                }
            }
        }

        public string SiteEmailAddress
        {
            get
            {
                return _siteEmail;
            }
            set
            {
                lock (this)
                {
                    _siteEmail = value;
                }
            }
        }

        public string SiteEmailFromField
        {
            get
            {
                return String.Format("{0} <{1}>", _CompanyName, _siteEmail);
            }
        }

        public string InvControlWarehouse
        {
            get
            {
                return _InvControlWarehouse;
            }
            set
            {
                lock (this)
                {
                    _InvControlWarehouse = value;
                }
            }
        }
 

        public string InvControlLocation
        {
            get
            {
                return _InvControlLocation;
            }
            set
            {
                lock (this)
                {
                    _InvControlLocation = value;
                }
            }
        }

        public string PurchasingWarehouse
        {
            get
            {
                return _PurchasingWarehouse;
            }
            set
            {
                lock (this)
                {
                    _PurchasingWarehouse = value;
                }
            }
        }


        public string PurchasingLocation
        {
            get
            {
                return _PurchasingLocation;
            }
            set
            {
                lock (this)
                {
                    _PurchasingLocation = value;
                }
            }
        }
 
        public static SiteSettings LoadFromConfiguration()
        {
            SiteSettings s = LoadFromXml();

            if (s == null)
            {
                s = new SiteSettings();
                s.SiteIsOnline = false;
                s.ImplementsTUAIP = true;
                s.CompanyName = "PMS-II Application";
                s.DateFormat = "{0:dd/MM/yyyy}";
                s.DateFormat = "PMS - II Intranet Application";
                s.SiteEmailAddress = "administrator@sg.panasonic.com";
                s.InvControlWarehouse = "1";
                s.InvControlLocation = "43541";
                s.PurchasingWarehouse = "1";
                s.PurchasingLocation = "43541";
                SaveToXml(s);
            }
            return s;
        }

        public static SiteSettings GetSharedSettings()
        {
            return PMSHttpApplication.PMSApplicationSettings;
        }

        public static bool UpdateSettings(SiteSettings newSettings)
        {
            // write settings to code or db

            // update Application-wide settings, only over-writing settings that users should edit
            lock (PMSHttpApplication.PMSApplicationSettings)
            {
                // Application is Online
                PMSHttpApplication.PMSApplicationSettings.SiteIsOnline = newSettings.SiteIsOnline;

                // Implement Transfer Using Alternate Item Policy
                PMSHttpApplication.PMSApplicationSettings.ImplementsTUAIP = newSettings.ImplementsTUAIP;

                // Company Name
                PMSHttpApplication.PMSApplicationSettings.CompanyName = newSettings.CompanyName;

                // Date Format
                PMSHttpApplication.PMSApplicationSettings.DateFormat = newSettings.DateFormat;
 
                // Application Name
                PMSHttpApplication.PMSApplicationSettings.ApplicationName = newSettings.ApplicationName;

                // Contact Email Address for Application
                PMSHttpApplication.PMSApplicationSettings.SiteEmailAddress = newSettings.SiteEmailAddress;


                // Inventory Control Warehouse for the Application
                PMSHttpApplication.PMSApplicationSettings.InvControlWarehouse = newSettings.InvControlWarehouse;

                // Inventory Control Location for the Application
                PMSHttpApplication.PMSApplicationSettings.InvControlLocation = newSettings.InvControlLocation;

                //Purchasing Warehouse for the Application
                PMSHttpApplication.PMSApplicationSettings.PurchasingWarehouse = newSettings.PurchasingWarehouse;

                // Purchasing Location for the Application
                PMSHttpApplication.PMSApplicationSettings.PurchasingLocation = newSettings.PurchasingLocation;
                

                // Serialize to Xml Config File
                return SaveToXml(PMSHttpApplication.PMSApplicationSettings);
            }
        }

        private static SiteSettings LoadFromXml()
        {
            SiteSettings settings = null;

            HttpContext context = HttpContext.Current;
            if (context != null)
            {
                string configPath = context.Server.MapPath(XmlConfigFile);

                XmlSerializer xml = null;
                FileStream fs = null;

                bool success = false;
                int numAttempts = 0;

                while (!success && numAttempts < 2)
                {
                    try
                    {
                        numAttempts++;
                        xml = new XmlSerializer(typeof(SiteSettings));
                        fs = new FileStream(configPath, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                        settings = xml.Deserialize(fs) as SiteSettings;
                        success = true;
                    }
                    catch (Exception x)
                    {
                        // if an exception is thrown, there might have been a sharing violation;
                        // we wait and try again (max: two attempts)
                        success = false;
                        System.Threading.Thread.Sleep(1000);
                        if (numAttempts == 2)
                            throw new Exception("The Site Configuration could not be loaded.", x);
                    }
                }

                if (fs != null)
                    fs.Close();
            }

            return settings;

        }

        public string GetXml()
        {
            StringBuilder result = new StringBuilder();
            StringWriter s = new StringWriter(result);
            try
            {
                XmlSerializer xml = new XmlSerializer(typeof(SiteSettings));
                xml.Serialize(s, this);
            }
            finally
            {
                s.Close();
            }

            return result.ToString();

        }

        private static bool SaveToXml(SiteSettings settings)
        {
            if (settings == null)
                return false;

            HttpContext context = HttpContext.Current;
            if (context == null)
                return false;

            string configPath = context.Server.MapPath(XmlConfigFile);

            XmlSerializer xml = null;
            System.IO.FileStream fs = null;

            bool success = false;
            int numAttempts = 0;

            while (!success && numAttempts < 2)
            {
                try
                {
                    numAttempts++;
                    xml = new XmlSerializer(typeof(SiteSettings));
                    fs = new FileStream(configPath, FileMode.Create, FileAccess.ReadWrite, FileShare.None);
                    xml.Serialize(fs, settings);
                    success = true;
                }
                catch
                {
                    // if an exception is thrown, there might have been a sharing violation;
                    // we wait and try again (max: two attempts)
                    success = false;
                    System.Threading.Thread.Sleep(1000);
                }
            }

            if (fs != null)
                fs.Close();

            return success;

        }
    }

}