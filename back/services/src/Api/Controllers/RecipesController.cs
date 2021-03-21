using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Data;
using Api.Models;
using Api.Types;
using Api.ViewModels;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [ApiController]
    [Route("recipes")]
    public class RecipesController
    {
        private readonly IMapper _mapper;

        public RecipesController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [HttpGet("popular")]
        public async Task<RecipeGroupsViewModel> GetPopularRecipesAsync()
        {
            var recipes = Database.Recipes;
            var result = GroupRecipes(recipes);
            return await Task.FromResult(result);
        }

        [HttpGet("favorite")]
        public async Task<RecipeGroupsViewModel> GetFavoriteRecipesAsync([FromQuery] int[] recipeIds)
        {
            var recipes = Database.Recipes.Where(x => recipeIds.Contains(x.Id)).ToList();
            var result = GroupRecipes(recipes);
            return await Task.FromResult(result);
        }

        [HttpGet("{id}")]
        public async Task<RecipeViewModel> GetRecipeAsync([FromRoute] int id)
        {
            var recipe = Database.Recipes.FirstOrDefault(x => x.Id == id);
            if (recipe is null)
            {
                return null;
            }

            var result = _mapper.Map<RecipeViewModel>(recipe);
            return await Task.FromResult(result);
        }

        [HttpGet("{id}/stages")]
        public async Task<IReadOnlyCollection<RecipeStageEntity>> GetRecipeStagesAsync([FromRoute] int id)
        {
            var recipe = Database.Recipes.FirstOrDefault(x => x.Id == id);
            if (recipe is null)
            {
                return null;
            }

            return await Task.FromResult(recipe.Stages);
        }

        [HttpPost("search")]
        public async Task<RecipeGroupsViewModel> SearchRecipesAsync([FromBody] Filter filter)
        {
            var recipes = Database.Recipes.AsEnumerable() ?? Array.Empty<RecipeEntity>();
            recipes = ApplyFilter(recipes, filter);

            var result = GroupRecipes(recipes.ToList());
            return await Task.FromResult(result);
        }

        [HttpPost("search/count")]
        public async Task<int> CountFilteredRecipesAsync([FromBody] Filter filter)
        {
            var recipes = Database.Recipes.AsEnumerable() ?? Array.Empty<RecipeEntity>();
            recipes = ApplyFilter(recipes, filter);

            var result = recipes.Count();
            return await Task.FromResult(result);
        }

        private static IEnumerable<RecipeEntity> ApplyFilter(IEnumerable<RecipeEntity> recipes, Filter filter)
        {
            if (filter is null)
            {
                return recipes;
            }

            if (!string.IsNullOrEmpty(filter.Query))
            {
                recipes = recipes.Where(x => x.Name.Contains(filter.Query.Trim()));
            }

            if (filter.Personas.HasValue && filter.Personas != 0)
            {
                recipes = recipes.Where(x => x.ServingsCount >= filter.Personas.Value);
            }

            if (filter.Skills.IsEnabled)
            {
                var skills = new List<SkillType>();
                if (filter.Skills.IsEasy)
                {
                    skills.Add(SkillType.Easy);
                }

                if (filter.Skills.IsMedium)
                {
                    skills.Add(SkillType.Medium);
                }

                if (filter.Skills.IsHard)
                {
                    skills.Add(SkillType.Hard);
                }

                recipes = recipes.Where(x => x.SkillTypes.Any(skillType => skills.Contains(skillType)));
            }

            if (filter.Tablewares.IsEnabled)
            {
                var tablewares = new List<string>();
                if (filter.Tablewares.HasFryingPan)
                {
                    tablewares.Add("Frying pan");
                }

                if (filter.Tablewares.HasOven)
                {
                    tablewares.Add("Oven");
                }

                if (filter.Tablewares.HasPan)
                {
                    tablewares.Add("Pan");
                }

                recipes = recipes.Where(x => x.Tablewares.Any(tableware =>
                    tablewares.Any(y => y.Equals(tableware, StringComparison.OrdinalIgnoreCase))));
            }

            if (filter.Types.IsEnabled)
            {
                var recipeTypes = new List<RecipeType>();
                if (filter.Types.IsMeat)
                {
                    recipeTypes.Add(RecipeType.Meat);
                }

                if (filter.Types.IsSweet)
                {
                    recipeTypes.Add(RecipeType.Sweet);
                }

                if (filter.Types.IsVegan)
                {
                    recipeTypes.Add(RecipeType.Vegan);
                }

                recipes = recipes.Where(x => x.RecipeTypes.Any(recipeType => recipeTypes.Contains(recipeType)));
            }

            if (filter.Times.IsEnabled)
            {
                var isAllChecked = filter.Times.Is10Min && filter.Times.IsFrom10To30Min && filter.Times.IsMoreThan30Min;
                if (!isAllChecked)
                {
                    var tenMin = TimeSpan.FromMinutes(10);
                    var thirtyMin = TimeSpan.FromMinutes(30);

                    bool Less10Min(RecipeEntity x)
                    {
                        return x.Duration <= tenMin;
                    }

                    bool From10To30Min(RecipeEntity x)
                    {
                        return x.Duration >= tenMin && x.Duration <= thirtyMin;
                    }

                    bool MoreThan30Min(RecipeEntity x)
                    {
                        return x.Duration >= thirtyMin;
                    }

                    bool MoreThan10Min(RecipeEntity x)
                    {
                        return x.Duration >= tenMin;
                    }

                    bool LessThan30Min(RecipeEntity x)
                    {
                        return x.Duration <= thirtyMin;
                    }

                    bool LessThan10MinOrMoreThan30Min(RecipeEntity x)
                    {
                        return x.Duration <= tenMin || x.Duration >= thirtyMin;
                    }


                    if (filter.Times.Is10Min && filter.Times.IsFrom10To30Min)
                    {
                        recipes = recipes.Where(LessThan30Min);
                    }
                    else if (filter.Times.Is10Min && filter.Times.IsMoreThan30Min)
                    {
                        recipes = recipes.Where(LessThan10MinOrMoreThan30Min);
                    }
                    else if (filter.Times.IsFrom10To30Min && filter.Times.IsMoreThan30Min)
                    {
                        recipes = recipes.Where(MoreThan10Min);
                    }
                    else
                    {
                        if (filter.Times.Is10Min)
                        {
                            recipes = recipes.Where(Less10Min);
                        }

                        if (filter.Times.IsFrom10To30Min)
                        {
                            recipes = recipes.Where(From10To30Min);
                        }

                        if (filter.Times.IsMoreThan30Min)
                        {
                            recipes = recipes.Where(MoreThan30Min);
                        }
                    }
                }
            }

            return recipes;
        }

        private static RecipeGroupsViewModel GroupRecipes(IList<RecipeEntity> recipes)
        {
            var breakfast = recipes.Where(x => x.RecipeGroupTypes.Contains(RecipeGroupType.Breakfast))
                .OrderBy(x => x.Popularity)
                .Take(20)
                .ToArray();
            var forBigFamily = recipes.Where(x => x.RecipeGroupTypes.Contains(RecipeGroupType.ForBigFamily))
                .OrderBy(x => x.Popularity)
                .Take(20)
                .ToArray();
            var salad = recipes.Where(x => x.RecipeGroupTypes.Contains(RecipeGroupType.Salad))
                .OrderBy(x => x.Popularity)
                .Take(20)
                .ToArray();

            var recipeGroups = new[]
            {
                new
                {
                    Recipes = breakfast,
                    RecipeGroupType = RecipeGroupType.Breakfast
                },
                new
                {
                    Recipes = forBigFamily,
                    RecipeGroupType = RecipeGroupType.ForBigFamily
                },
                new
                {
                    Recipes = salad,
                    RecipeGroupType = RecipeGroupType.Salad
                }
            };
            recipeGroups = recipeGroups
                .OrderByDescending(recipeGroup => recipeGroup.Recipes.Sum(recipe => recipe.Popularity))
                .ToArray();

            var result = new RecipeGroupsViewModel();
            var high = recipeGroups[0];
            result.HighPopular = new RecipeGroupViewModel
            {
                RecipeGroupType = high.RecipeGroupType,
                Recipes = high.Recipes.Select(x => new RecipePreviewViewModel
                    {
                        Id = x.Id,
                        Description = x.ShortDescription,
                        Duration = x.Duration,
                        ImageUrl = x.PreviewImageUrl,
                        Name = x.Name,
                        ServingsCount = x.ServingsCount
                    })
                    .ToList()
            };

            var middle = recipeGroups[1];
            result.MiddlePopular = new RecipeGroupViewModel
            {
                RecipeGroupType = middle.RecipeGroupType,
                Recipes = middle.Recipes.Select(x => new RecipePreviewViewModel
                    {
                        Id = x.Id,
                        Description = x.ShortDescription,
                        Duration = x.Duration,
                        ImageUrl = x.PreviewImageUrl,
                        Name = x.Name,
                        ServingsCount = x.ServingsCount
                    })
                    .ToList()
            };
            var low = recipeGroups[2];
            result.LowPopular = new RecipeGroupViewModel
            {
                RecipeGroupType = low.RecipeGroupType,
                Recipes = low.Recipes.Select(x => new RecipePreviewViewModel
                    {
                        Id = x.Id,
                        Description = x.ShortDescription,
                        Duration = x.Duration,
                        ImageUrl = x.PreviewImageUrl,
                        Name = x.Name,
                        ServingsCount = x.ServingsCount
                    })
                    .ToList()
            };
            result.TotalAmount = result.HighPopular.Recipes.Select(x => x.Id)
                .Union(result.MiddlePopular.Recipes.Select(x => x.Id)
                    .Union(result.LowPopular.Recipes.Select(x => x.Id)))
                .Count();
            return result;
        }
    }
}