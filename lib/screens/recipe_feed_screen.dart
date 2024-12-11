import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/models/recipe.dart';
import 'package:mbap_project_app/screens/add_recipe_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/recipefeed/recipe_container.dart';
import 'package:mbap_project_app/widgets/appbar_title_widget.dart';

class RecipeFeedScreen extends StatefulWidget{
  static String routeName = '/recipe-book';

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  @override
  Widget build(BuildContext context){
    final FirebaseService fbService = GetIt.instance<FirebaseService>();
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: AppBarTitleWidget(title: 'Recipe Book',),
        actions: [
          IconButton(onPressed: (){Navigator.of(context).pushNamed(AddRecipeScreen.routeName);}, icon: Icon(Icons.add_circle_outline)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search))],
      ),

      body: StreamBuilder<List<Recipe>>(
        stream: fbService.getRecipes(),
          builder: (context, snapshot) {
            print('${snapshot.connectionState}');
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }

            if(!snapshot.hasData || snapshot.data!.isEmpty){
              print('No data available.');
              return Column(
                children:[
                  Center(child: Text('No Recipes available!'))
                ],
              );
            } 
            List<Recipe> recipes = snapshot.data!;
          return ListView.builder( //creating listview to make a scrollable page 
            itemCount: recipes.length,
            itemBuilder: (ctx, i){
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecipeContainer(recipe: recipes[i]), //using RecipeContainer Widget to display all the recipes in the list
                );
            },
          );
        }
      )
      
    );
  }
}
