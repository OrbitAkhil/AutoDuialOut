using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AutoDialOut.App_Classes
{
    public class OutgoingCall
    {
        [JsonProperty(PropertyName = "CallerId")]
        public int  CallerId { get; set; }
        [JsonProperty(PropertyName = "CallerName")]
        public string CallerName { get; set; }
        [JsonProperty(PropertyName = "CallerMobile")]
        public string CallerMobile { get; set; }
        [JsonProperty(PropertyName = "ExtensionNo")]
        public string ExtensionNo { get; set; }
        [JsonProperty(PropertyName = "AgentId")]
        public int AgentId { get; set; }
        [JsonProperty(PropertyName = "CallOutgoingDateTime")]
        public DateTime CallOutgoingDateTime { get; set; }
        [JsonProperty(PropertyName = "CallEstablishedDateTime")]
        public DateTime CallEstablishedDateTime { get; set; }
        [JsonProperty(PropertyName = "CallEndDateTime")]
        public DateTime CallEndDateTime { get; set; }
        [JsonProperty(PropertyName = "CallStatus")]
        public string CallStatus { get; set; }
        [JsonProperty(PropertyName = "DropOutCallerId")]
        public int DropOutCallerId { get; set; }
    }
}