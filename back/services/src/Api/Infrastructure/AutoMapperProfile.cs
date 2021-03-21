using Api.Data;
using Api.ViewModels;
using AutoMapper;

namespace Api.Infrastructure
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
             CreateMap<RecipeEntity, RecipeViewModel>();
        }
    }
}