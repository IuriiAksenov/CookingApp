import 'package:app/models/recipe_stage.dart';
import 'package:app/providers/current_provider.dart';
import 'package:app/widgets/current_recipe/recipe_finish_stage.dart';
import 'package:app/widgets/current_recipe/recipe_middle_stage.dart';
import 'package:app/widgets/current_recipe/recipe_start_stage.dart';
import 'package:app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentStagePage extends StatefulWidget {
  CurrentStagePage({Key key}) : super(key: key);

  @override
  _CurrentStagePageState createState() => _CurrentStagePageState();
}

class _CurrentStagePageState extends State<CurrentStagePage> {
  Widget _switchStage(BuildContext context, RecipeStage stage) {
    switch (stage.stageType) {
      case 1:
        return RecipeStartStageWidget(
          recipeStage: stage,
          // isVoiceable: context.select<CurrentRecipeProvider, bool>(
          //     (provider) => provider.isStageVoiceable),
        );
      case 2:
        return RecipeMiddleStageWidget(
          recipeStage: stage,
          // isVoiceable: context.select<CurrentRecipeProvider, bool>(
          //     (provider) => provider.isStageVoiceable),
        );
      case 3:
        return RecipeFinishStageWidget(
          recipeStage: stage,
          // isVoiceable: context.select<CurrentRecipeProvider, bool>(
          //     (provider) => provider.isStageVoiceable),
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return !context.select<CurrentRecipeProvider, bool>(
            (provider) => provider.hasRecipeInProgress)
        ? Scaffold(
            appBar: AppBar(
              title: Text('Stage loading'),
            ),
            body: LoadingIndicatorWidget(),
          )
        : _switchStage(
            context,
            context.select<CurrentRecipeProvider, RecipeStage>(
                (provider) => provider.stage),
          );
  }
}
