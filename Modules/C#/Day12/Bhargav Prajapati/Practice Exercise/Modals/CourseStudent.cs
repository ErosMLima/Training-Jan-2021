﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Practice_Exercise.Modals
{
    class CourseStudent
    {
        public int StudentId { get; set; }
        public Student Student { get; set; }

        public int CourseId { get; set; }
        public course Course{ get; set; }
    }
}
