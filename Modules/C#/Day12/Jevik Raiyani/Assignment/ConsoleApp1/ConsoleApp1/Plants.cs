﻿using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp1
{
    public class Plants
    {
        public int PlantId { get; set; }
        public string PlantName { get; set; }

        public ICollection<TypeOfToy> TypeOfToys { get; set; }
    }
}
