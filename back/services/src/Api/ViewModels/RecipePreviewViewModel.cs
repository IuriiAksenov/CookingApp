using System;

namespace Api.ViewModels
{
    public class RecipePreviewViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public TimeSpan Duration{ get; set; }
        public int ServingsCount{ get; set; }
    }
}