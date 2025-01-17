﻿using System;
using System.Collections.Generic;

#nullable disable

namespace BookMyShowAPI.Models
{
    public partial class Event
    {
        public Event()
        {
            EventLanguages = new HashSet<EventLanguage>();
        }

        public int EventId { get; set; }
        public string Name { get; set; }
        public decimal TicketPrice { get; set; }
        public string Image { get; set; }
        public string Time { get; set; }
        public DateTime DateOfEvent { get; set; }
        public int EventVenueShowTimingId { get; set; }
        public int EventTypeId { get; set; }

        public virtual EventType EventType { get; set; }
        public virtual EventVenueShowTiming EventVenueShowTiming { get; set; }
        public virtual ICollection<EventLanguage> EventLanguages { get; set; }
    }
}
