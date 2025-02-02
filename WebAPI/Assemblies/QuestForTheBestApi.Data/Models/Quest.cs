using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuestForTheBestApi.Data.Models
{
    public class Quest
    {
        public short QuestId { get; set; }
        public short CocktailId { get; set; }

        public string CocktailName { get; set; }

        public string CocktailDescription { get; set; }

        public DateTime DateOfQuest { get; set; }
    }
}
