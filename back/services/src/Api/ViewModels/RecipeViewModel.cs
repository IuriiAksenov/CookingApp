using System;
using System.Collections.Generic;
using Api.Types;

namespace Api.ViewModels
{
    public class RecipeViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public TimeSpan Duration{ get; set; }
        public int ServingsCount{ get; set; }
        public RecipeType RecipeType { get; set; }
        public IReadOnlyCollection<string> Ingredients { get; set; }
        public IReadOnlyCollection<string> Tablewares { get; set; }
    }
}