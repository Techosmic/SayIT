using System;
using System.Collections.Generic;

namespace SayIT_API.Model
{
    public class Level
    {
        public int LevelNumber { get; set; }
        public List<string> Words { get; set; }
        public bool Unlocked { get; set; }
    }
}
