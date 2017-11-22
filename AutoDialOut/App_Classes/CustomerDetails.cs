using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AutoDialOut.App_Classes
{
    public class CallerBookingInfo
    {
        public string   PaxName { get; set; }
        public string FlightDate { get; set; }
        public string   Market { get; set; }
        public string   DepartureTime { get; set; }
        public string   FlightNumber { get; set; }
        public string RecordLocator { get; set; }
        public string PnrStatus { get; set; }
    }
}