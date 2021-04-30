﻿using System;
using System.Collections.Generic;

#nullable disable

namespace BookMyShowAPI.Models
{
    public partial class EventType
    {
        public EventType()
        {
            Events = new HashSet<Event>();
        }

        public int EventTypeId { get; set; }
        public string EventType1 { get; set; }

        public virtual ICollection<Event> Events { get; set; }
    }
}
