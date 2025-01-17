﻿using System;
using System.Collections.Generic;

#nullable disable

namespace Assignment.Models
{
    public partial class Order
    {
        public Order()
        {
            OrderItems = new HashSet<OrderItem>();
        }

        public int Id { get; set; }
        public int CustomerId { get; set; }
        public DateTime OrderDate { get; set; }
        public int OrderAmount { get; set; }
        public int OfferAmount { get; set; }

        [System.Text.Json.Serialization.JsonIgnore]
        public virtual Customer Customer { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
