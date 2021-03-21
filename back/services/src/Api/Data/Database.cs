using System;
using System.Collections.Generic;
using Api.Types;

namespace Api.Data
{
    public static class Database
    {
        private const string ImagesUrl = "https://gohack.2ssupport.ru/media/recipes/";
        private const int ScrambledEggsId = 1;
        private const int CaesarId = 2;
        private const int UzbekPilafId = 3;
        private static readonly Random Random = new Random();

        static Database()
        {
            Recipes = new List<RecipeEntity>();

            for (var i = 0; i < 10; i++)
            {
                Recipes.Add(GetScrambledEggs(i));
                Recipes.Add(GetCaesar(i));
                Recipes.Add(GetUzbekPilaf(i));
            }
        }

        public static IList<RecipeEntity> Recipes { get; }

        private static int CreateNewId(int oldId, int index)
        {
            return int.Parse(oldId.ToString() + index);
        }

        private static RecipeEntity GetScrambledEggs(int index)
        {
            var scrambledEggsUrl = ImagesUrl + ScrambledEggsId;
            return new RecipeEntity
            {
                Id = CreateNewId(ScrambledEggsId, index),
                Popularity = Random.NextDouble(),
                Name = $"Scrambled eggs {index}",
                ShortDescription = "Captured protein and gentle liquid yolk - an ideal fried eggs",
                PreviewImageUrl = scrambledEggsUrl + "/scrambled_eggs.png",
                Description =
                    "Captured protein and a gentle liquid yolk - this is what an ideal fried egg should look like. " +
                    "This dish is easier to make in a non-stick pan. Then the eggs will definitely not stick to the bottom.",
                ImageUrl = ImagesUrl + ScrambledEggsId + "/scrambled_eggs.png",
                Duration = TimeSpan.FromMinutes(10),
                ServingsCount = 1,
                RecipeGroupTypes = new[] {RecipeGroupType.Breakfast},
                SkillTypes = new []{SkillType.Easy},
                Ingredients = new[] {"1-2 tbsp of vegetable oil/a slice of butter", "2-3 eggs", "salt to taste"},
                Tablewares = new[] {TablewareType.FryingPan, "1-2 tbsp of vegetable oil/a slice of butter"},
                RecipeTypes = new[]{RecipeType.Meat},
                Stages = new[]
                {
                    new RecipeStageEntity
                    {
                        Name = "Stage 1. Start",
                        StageType = StageType.Start,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Warm the skillet lightly. Pour in vegetable oil or melt butter. " +
                                       "After that, turn off the gas for 30–40 seconds or transfer the container to a cold burner - " +
                                       "thanks to this, the dishes will not overheat and the eggs will fry evenly.Although if you like " +
                                       "crispy edges, you can skip this step.Gently add the eggs.You can break them immediately above " +
                                       "the pan or into a small separate container, then pour over into the pan."
                            },
                            new ImageStagePart {Url = scrambledEggsUrl + "/stage_1.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 2. Consistency",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text =
                                    "Reduce the heat to a minimum. If you cook fried eggs over high heat, it can burn. And due to weak " +
                                    "heating, the eggs will fry slowly and evenly, while the edges will not dry out. If you, on the contrary, " +
                                    "need a crisp, make moderate or medium heat. Sometimes, if the eggs do not spread enough, part of the " +
                                    "protein around the yolk remains liquid.If you do not like this, carefully tear it with a fork, without " +
                                    "touching the yolk.This should be done when the lower part of the protein turns white."
                            },
                            new ImageStagePart {Url = scrambledEggsUrl + "/stage_2.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 3. Finishing and serving",
                        StageType = StageType.Finish,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text =
                                    "Fry scrambled eggs over low heat for 4–5 minutes. If the temperature is higher, it will take a little less " +
                                    "time. The dish will be ready when the protein turns white and sets. Do not forget that the yolk should remain liquid."
                            },
                            new ImageStagePart {Url = scrambledEggsUrl + "/stage_3.png"},
                            new TextStagePart
                                {
                                    Text = "It is better to salt the eggs at the end of cooking or after serving."
                                }
                        }
                    }
                }
            };
        }

        private static RecipeEntity GetCaesar(int index)
        {
            var caesarUrl = ImagesUrl + CaesarId;
            return new RecipeEntity
            {
                Id = CreateNewId(CaesarId, index),
                Popularity = Random.NextDouble(),
                Name = $"Caesar {index}",
                ShortDescription = "Great Caesar salad recipe",
                PreviewImageUrl = caesarUrl + "/caesar.png",
                Description =
                    "A great Caesar salad recipe gets its swagger from a great Caesar " +
                    "dressing recipe. Squeamish about raw egg yolks and anchovies? Sorry. " +
                    "Yolks are what give richness to the emulsion, while anchovies provide a " +
                    "briny blast (and that whole umami thing).",
                ImageUrl = caesarUrl + "/caesar.png",
                Duration = TimeSpan.FromMinutes(30),
                ServingsCount = 5,
                RecipeGroupTypes = new[] {RecipeGroupType.Salad, RecipeGroupType.ForBigFamily},
                SkillTypes = new[]{SkillType.Easy},
                Ingredients =
                    new[]
                    {
                        "2 small garlic cloves minced",
                        "2 tsp dijon mustard",
                        "1 tsp Worcestershire sauce",
                        "2 tsp fresh lemon juice",
                        "1 1/2 tsp red wine vinegar",
                        "1/3 cup extra virgin olive oil",
                        "1/2 tsp sea salt or to taste",
                        "1/8 tsp black pepper plus more to serve",
                        "1 large romaine lettuce",
                        "1/3 cup parmesan cheese",
                        "1/2 French Baguette",
                        "3 Tbsp extra virgin olive oil"
                    },
                Tablewares = new[] {TablewareType.Oven, "Mixing Bowl", "Knife"},
                RecipeTypes = new[] { RecipeType.Meat},
                Stages = new[]
                {
                    new RecipeStageEntity
                    {
                        Name = "Stage 1. Croutons",
                        StageType = StageType.Start,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Preheat oven to 350˚F. Cut the baguette in half " +
                                       "lengthwise through the top of the baguette then slice " +
                                       " diagonally into 1/4" +
                                       " thick pieces. Place the breads onto a baking sheet."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_1.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 2. Croutons",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "In a small bowl, combine 3 Tbsp extra virgin olive oil and " +
                                       "1 tsp of finely minced garlic. Drizzle the garlic oil over the " +
                                       "croutons and sprinkle the top with 2 Tbsp grated parmesan cheese."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_2.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 3. Croutons",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Toss until evenly coated. Spread in a single layer over the baking sheet" +
                                       " and bake at 350˚F until light golden and " +
                                       "crisp (10-12 minutes), or to desired crispness."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_3.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 4. Dressing",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text =
                                    "The caesar salad dressing comes together so fast and all you need is a bowl and whisk. " +
                                    "This Caesar dressing is light, healthy and packs so much fresh flavor without needing much salt at all.\n\n" +
                                    "Whisk together minced garlic, dijon, Worcestershire, lemon juice and red wine vinegar."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_4.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 5. Dressing",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                                {
                                    Text = "Season with 1/2 tsp salt and 1/8 tsp black pepper, or to taste."
                                },
                            new ImageStagePart {Url = caesarUrl + "/stage_5.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 6. Dressing",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Whisking while adding oil emulsifies the dressing " +
                                       "for a smooth and creamy (not oily) consistency."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_6.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 7. caesar Salad",
                        StageType = StageType.Finish,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Rinse, dry and chop or tear the romaine into bite-sized pieces. " +
                                       "Place in a large serving bowl and sprinkle generously with shredded " +
                                       "parmesan cheese and cooled croutons. Drizzle with caesar dressing and toss " +
                                       "gently until lettuce is evenly coated."
                            },
                            new ImageStagePart {Url = caesarUrl + "/stage_7.png"}
                        }
                    }
                }
            };
        }

        private static RecipeEntity GetUzbekPilaf(int index)
        {
            var uzbekUrl = ImagesUrl + UzbekPilafId;
            return new RecipeEntity
            {
                Id = CreateNewId(UzbekPilafId, index),
                Popularity = Random.NextDouble(),
                Name = $"Uzbek pilaf {index}",
                ShortDescription = "The most popular type of pilaf is Uzbek pilaf in the cauldron",
                PreviewImageUrl = uzbekUrl + "/uzbek_pilaf.png",
                Description =
                    "The most popular type of pilaf is Uzbek pilaf in the cauldron. In a pot or cast " +
                    "iron , of course, pilaf can also be prepared. But it is in the cauldron that you " +
                    "get a real Uzbek pilaf, which you will not be ashamed to treat even a connoisseur " +
                    "of Uzbek cuisine. Although there are hundreds, if not thousands of pilaf recipes, " +
                    "and each cook has his own correct way of cooking this dish and his own cooking tricks.",
                ImageUrl = uzbekUrl + "/uzbek_pilaf.png",
                Duration = TimeSpan.FromMinutes(150),
                ServingsCount = 10,
                RecipeGroupTypes = new[] {RecipeGroupType.ForBigFamily},
                SkillTypes = new[]{SkillType.Hard},
                Ingredients =
                    new[]
                    {
                        "1 kg of rice",
                        "1 kg of lamb",
                        "1 tsp Worcestershire sauce",
                        "300 ml vegetable oil",
                        "4 small onions",
                        "2 small dry hot peppers",
                        "2 heads of garlic",
                        "1 tbsp dried barberry",
                        "1 tbsp zira",
                        "1 tsp coriander seeds",
                        "1/2 French Baguette",
                        "3 Tbsp extra virgin olive oil"
                    },
                Tablewares = new[] {"Cauldron", "Plate", "Gas stove"},
                RecipeTypes = new[]{RecipeType.Meat},
                Stages = new[]
                {
                    new RecipeStageEntity
                    {
                        Name = "Stage 1. Preparation Ingredients",
                        StageType = StageType.Start,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Rice rinse in several waters. The last water " +
                                       "after washing should remain completely clear."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_1_part_1.png"},
                            new TextStagePart
                            {
                                Text = "Wash the lamb and cut into cubes. 3 onions and all carrots " +
                                       "to clear. Cut the onion into thin half rings, carrots - into " +
                                       "long bars 1 cm thick. Peel the garlic from the top husk, but do " +
                                       "not divide into cloves."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_1_part_2.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 2. Preparation Cauldron",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Heat a cauldron or thick-walled pan, add oil and calcine it " +
                                       "until a light haze appears. Add the remaining onion and fry " +
                                       "it until black. Remove the onion from the pan."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_2.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 3. Pilaf basis",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Prepare a zirvak (pilaf basis). Put the onion and stir, fry " +
                                       "it until dark golden, 7 min."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_3_part_1.png"},
                            new TextStagePart {Text = "Add meat and fry until a crust appears."},
                            new ImageStagePart {Url = uzbekUrl + "/stage_3_part_2.png"},
                            new TextStagePart
                            {
                                Text = "Put carrots, fry without stirring for 3 minutes. Then mix everything " +
                                       "and cook for 10 minutes, stirring slightly."
                            }
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 4. Seasoning",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Rub the zira and coriander with your fingers or pestle, add to " +
                                       "the zirvak along with barberry and salt."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_4.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 5. Seasoning",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Reduce heat to medium and cook until carrots are soft, " +
                                       "7-10 minutes. Pour boiling water into a cauldron with " +
                                       "a layer of 2 cm. Put hot pepper. Reduce heat and simmer " +
                                       "zirvak for 1 hour."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_5.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 6. Back to rice",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "Rinse the rice once again, drain to water. Put the rice on a " +
                                       "zirvak in an even layer, increase the heat to the maximum " +
                                       "and pour boiling water through a slotted spoon into the " +
                                       "cauldron so that it covers the rice with a layer of 3 cm."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_6.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 7. Cooking the rice",
                        StageType = StageType.Middle,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "As soon as the water is absorbed, press the heads of garlic " +
                                       "into the rice, reduce the heat to medium and cook until the " +
                                       "rice is ready."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_7_part_1.png"},
                            new TextStagePart
                            {
                                Text = "Slightly hit with a slotted spoon over the rice. If the sound " +
                                       "from the blow is deaf, make a few sticks in the rice with " +
                                       "a thin stick to the bottom."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_7_part_2.png"}
                        }
                    },
                    new RecipeStageEntity
                    {
                        Name = "Stage 8. Uzbek pilaf",
                        StageType = StageType.Finish,
                        Parts = new StagePart[]
                        {
                            new TextStagePart
                            {
                                Text = "To smooth the surface, cover the Uzbek pilaf with a plate and a " +
                                       "lid on top. Reduce heat to a minimum and leave pilaf for 30 minutes."
                            },
                            new ImageStagePart {Url = uzbekUrl + "/stage_8.png"}
                        }
                    }
                }
            };
        }
    }
}