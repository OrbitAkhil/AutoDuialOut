using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutoDialOut.App_Classes
{
    public class ErrorHandleAttribute : HandleErrorAttribute
    {
        NLog.Logger logger = LogManager.GetLogger("databaseLogger");
        public override void OnException(ExceptionContext filterContext)
        {
            Exception ex = filterContext.Exception;
            logger.Error(ex);

            filterContext.ExceptionHandled = true;
            var model = new HandleErrorInfo(filterContext.Exception, "Controller", "Action");

            filterContext.Result = new ViewResult()
            {
                ViewName = "Login",
                ViewData = new ViewDataDictionary(model)
            };
        }
    }

}