﻿using System;
using System.Collections.Generic;

#nullable disable

namespace Assignment.Models
{
    public partial class Customer
    {
        public Customer()
        {
            CustomerAddresses = new HashSet<CustomerAddress>();
            Orders = new HashSet<Order>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string ContactNumber { get; set; }
        public string Password { get; set; }

        [System.Text.Json.Serialization.JsonIgnore]
        public virtual ICollection<CustomerAddress> CustomerAddresses { get; set; }

        [System.Text.Json.Serialization.JsonIgnore]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
