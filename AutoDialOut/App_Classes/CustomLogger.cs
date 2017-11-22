using AutoDialOut.Repository;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace AutoDialOut.App_Classes
{
    public static class CustomLogger
    {
        public static void LogException(Exception ex)
        {
            //LogRepository repo = new LogRepository();
            //repo.AddException(ex);
            //EventLog.WriteEntry("AutoDialOut", ex.Message, EventLogEntryType.Error);
        }

        public static void LogWarning(Exception ex)
        {
            EventLog.WriteEntry("AutoDialOut", ex.Message, EventLogEntryType.Warning);
        }

        public static void LogInfo(Exception ex)
        {
            EventLog.WriteEntry("AutoDialOut", ex.Message, EventLogEntryType.Information);
        }
    }
}