using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AutoDialOut.App_Classes
{
    public class DropCall
    {
        public string CallerName { get; set; }
        public string CallerMobile { get; set; }
        public string CallerEmail { get; set; }
        public string LostPageName { get; set; }
        public string FlightDetails { get; set; }
        public int PaxCount { get; set; }
        public string PaxNames { get; set; }
        public string Priority { get; set; }
    }
}