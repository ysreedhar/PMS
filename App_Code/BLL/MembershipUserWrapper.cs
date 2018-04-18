

using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using System.ComponentModel;


    /// <summary>
    /// Summary description for MembershipUserWrapper
    /// This class is inherited from MembershipUser 
    /// Using the sytax public class ClassName (..) : base(initializers...) allows for calling the
    /// contstructor of the base class.  In this case MembershipUser.
    /// </summary>
    /// 
    public class MembershipUserWrapper : MembershipUser
    {

        /// <summary>
        /// This constructor is used to create a MembershipUserWrapper from a MembershipUser object.  MembershipUser is a default type used
        /// in the Membership API provided with ASP.NET 2.0
        /// </summary>
        /// <param name="mu">MembershipUser object</param>
        public MembershipUserWrapper(MembershipUser mu)
            : base(mu.ProviderName, mu.UserName, mu.ProviderUserKey, mu.Email, mu.PasswordQuestion,
            mu.Comment, mu.IsApproved, mu.IsLockedOut, mu.CreationDate, mu.LastLoginDate, mu.LastActivityDate, 
            mu.LastPasswordChangedDate, mu.LastLockoutDate)
        {
        }


        /// <summary>
        /// This calls the base class UserName property.  It is here so we can tag
        /// this property as the primary key so that datakeynames attribute gets set in the data control.
        /// </summary>
        /// 
        [DataObjectField(true)]
        public override string UserName
        {
            get { return base.UserName; }
        }


        
        /// <summary>
        /// This constructor is used to create a MembershipUserWrapper from individual parameters values.  
        /// For details of what each parameter means, see the Microsoft Membership class.
        /// </summary>
        /// <param name="comment">Passes to MembershipUser.comment</param>
        /// <param name="creationDate">Passes to MembershipUser.creationDate</param>
        /// <param name="email">Passes to MembershipUser.email</param>
        /// <param name="isApproved">Passes to MembershipUser.isApproved</param>
        /// <param name="lastActivityDate">Passes to MembershipUser.lastActivityDate</param>
        /// <param name="lastLoginDate">Passes to MembershipUser.lastLoginDate</param>
        /// <param name="passwordQuestion">Passes to MembershipUser.passwordQuestion</param>
        /// <param name="providerUserKey">Passes to MembershipUser.providerUserKey</param>
        /// <param name="userName">Passes to MembershipUser.userName</param>
        /// <param name="lastLockoutDate">Passes to MembershipUser.lastLockoutDate</param>
        /// <param name="providerName">Passes to MembershipUser.providerName</param>
        /// 
        public MembershipUserWrapper(string comment, DateTime creationDate, string email,
                    bool isApproved, DateTime lastActivityDate, DateTime lastLoginDate,
                    string passwordQuestion, object providerUserKey, string userName,
                    DateTime lastLockoutDate, string providerName)
            : base(providerName, userName, providerUserKey, email, passwordQuestion, comment,
            isApproved, false, creationDate, lastLoginDate, lastActivityDate, DateTime.Now, lastLockoutDate)
        {
            // This calls a constructor of MembershipUser automatically because of the base reference above
        }

    }
