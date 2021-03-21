using System;
using System.Collections.Generic;
using Api.Types;

namespace Api.Data
{
    public class RecipeEntity
    {
        public int Id { get; set; }
        public string Name { get; set; }

        public double Popularity { get; set; }

        public string ShortDescription { get; set; }
        public string PreviewImageUrl { get; set; }

        public string Description { get; set; }
        public string ImageUrl { get; set; }

        public TimeSpan Duration{ get; set; }
        public int ServingsCount{ get; set; }
        public IReadOnlyCollection<RecipeGroupType> RecipeGroupTypes { get; set; }
        public IReadOnlyCollection<RecipeType> RecipeTypes { get; set; }
        public IReadOnlyCollection<SkillType> SkillTypes { get; set; }
        public IReadOnlyCollection<string> Ingredients { get; set; }
        public IReadOnlyCollection<string> Tablewares { get; set; }
        public IReadOnlyCollection<RecipeStageEntity> Stages{ get; set; }
    }

    public class RecipeStageEntity
    {
        public string Name{ get; set; }
        public IReadOnlyCollection<StagePart> Parts{ get; set; }
        public StageType StageType{ get; set; }
    }

    public abstract class StagePart
    {
      public abstract StagePartType StagePartType { get;  }
    }

    public class ImageStagePart : StagePart
    {
        public override StagePartType StagePartType => StagePartType.Image;
        public string Url { get; set; }
    }

    public class TextStagePart : StagePart
    {
        public override StagePartType StagePartType => StagePartType.Text;
        public string Text { get; set; }
    }
}