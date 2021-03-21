using System;
using System.Collections.Generic;
using Api.Types;

namespace Api.ViewModels
{
    public class RecipeGroupsViewModel
    {
        public RecipeGroupViewModel HighPopular { get; set; } = new RecipeGroupViewModel();
        public RecipeGroupViewModel MiddlePopular { get; set; } = new RecipeGroupViewModel();
        public RecipeGroupViewModel LowPopular { get; set; } = new RecipeGroupViewModel();
        public int TotalAmount{ get; set; }
    }

    public class RecipeGroupViewModel
    {
        public RecipeGroupType RecipeGroupType { get; set; }
        public IReadOnlyCollection<RecipePreviewViewModel> Recipes { get; set; } = Array.Empty<RecipePreviewViewModel>();
    }
}