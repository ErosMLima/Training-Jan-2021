﻿using System;
using System.Collections.Generic;

#nullable disable

namespace Assignment.Models
{
    public partial class VPatientsWithStaff
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ContactNumber { get; set; }
        public int DepartmentId { get; set; }
        public string Description { get; set; }
        public int StaffId { get; set; }
    }
}
