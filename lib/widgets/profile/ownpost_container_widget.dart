import 'package:flutter/material.dart';
import 'package:mbap_project_app/models/recipe.dart';
import 'package:mbap_project_app/models/user.dart';
import 'package:mbap_project_app/screens/edit_recipe_screen.dart';

//Creating the container for the profile screen
class OwnPostContainerWidget extends StatelessWidget{

  final Recipe recipe; //importing user model
  final Function deleteRecipe;

  const OwnPostContainerWidget({required this.recipe, required this.deleteRecipe});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: 
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const  Color.fromRGBO(92, 129, 128, 0.09),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      //Title 
                      Text(
                        recipe.Title, 
                        style: TextStyle(
                          fontFamily: 'EBGaramond',
                          fontSize: 25,
                          fontStyle:FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(88, 102, 108, 1)
                        ), 
                      ),
                      Spacer(),

                      //Edit Button
                      IconButton(onPressed: (){Navigator.of(context).pushNamed(EditRecipeScreen.routeName, arguments: recipe);}, icon: Icon(Icons.edit)),
                      
                      //Delete Button
                      IconButton( icon: Icon(Icons.delete, color: Color.fromRGBO(187, 66, 83, 1),), onPressed: (){deleteRecipe();},)
                    ]
                  ),
                  
                  
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      //Content 
                      Expanded(
                        child: Text(
                          recipe.Description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'EBGaramond',
                              fontSize: 19,
                              fontStyle:FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(88, 102, 108, 1)
                              )
                        ),
                    )
                    ],
                  ),
                  
                  //Button to view full recipe
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text('Click to see full recipe'),
                        onPressed: (){
                          debugPrint('Full recipe');
                        },
                      )
                    ],
                  )
                ],
              )
            ),
    );
  }
}