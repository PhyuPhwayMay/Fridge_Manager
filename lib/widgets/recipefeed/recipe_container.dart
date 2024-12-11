import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbap_project_app/models/recipe.dart';

//Creating recipe container for recipe screen
class RecipeContainer extends StatelessWidget{

  final Recipe recipe; //importing recipe model

  RecipeContainer({ required this.recipe});


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
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

                  //Title of the recipe
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        recipe.Title, 
                        style: TextStyle(
                          fontFamily: 'EBGaramond',
                          fontSize: 25,
                          fontStyle:FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(14, 61, 67, 1)
                        ), 
                      ),
                    ]
                  ),

                  SizedBox(height: 3),
                  
                  //Timestamp of the recipe posted
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Created At ' + recipe.Timestamp.toString(),
                        style: TextStyle(
                              fontFamily: 'EBGaramond',
                              fontSize: 13,
                              fontStyle:FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(88, 102, 108, 1)
                        )
                      ),
                    ],
                  ),

                  SizedBox(height: 8),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      //Image of the recipe
                      SizedBox(
                        height: 151,
                        width: 121,
                        child: Image.network(
                          recipe.FoodImagePath,
                          fit: BoxFit.fill,),
                      ),
                      
                      SizedBox(width: 18),

                      //content of the recipe
                      Expanded(
                        child: Text(recipe.Description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'EBGaramond',
                          fontSize: 19,
                          fontStyle:FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(14, 61, 67, 1)
                          )
                        )
                      ),
                    ]
                  ),


                  //Click to see full recipe button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Click to see full recipe',
                          style: TextStyle(
                            color:Color.fromRGBO(88, 102, 108, 1) )
                          ),
                        onPressed: (){
                          debugPrint('Full recipe');
                        },
                      )
                    ],
                  )
              ],
              )
            )
        ],
      ),
    );
  }
}