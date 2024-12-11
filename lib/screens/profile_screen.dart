import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/models/recipe.dart';
import 'package:mbap_project_app/models/user.dart';
import 'package:mbap_project_app/screens/calendar_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/TextButtonIcon_widget.dart';
import 'package:mbap_project_app/widgets/app_drawer.dart';
import 'package:mbap_project_app/widgets/appbar_title_widget.dart';
import 'package:mbap_project_app/widgets/profile/ownpost_container_widget.dart';
import 'package:mbap_project_app/widgets/profile/profile_pic_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget{
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  void deleteRecipe (String id){
    showDialog<Null>(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(onPressed: (){
              fbService.deleteRecipe(id).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recipe Deleted Successfully!'),));
                Navigator.of(context).pop();
              }).onError((error, stackTrace) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ' + error.toString()),));
            });
            }, 
            child: const Text('Yes')),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No')),
          ],
        );
      });  
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: AppBarTitleWidget(title: "Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.settings),
          ),
          IconButton(onPressed: (){
            String message = "Hey, I'm on this amazing Fridge App! Check it out here! https://www.flutter.dev ";
            Share.share(message);
          }, icon:Icon(Icons.share))
        ],
      ),
      drawer: AppDrawer(),

      body:StreamBuilder<FirestoreUser>(
        stream: fbService.getAuthUserFromFirestore(),
        builder:(context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError || !userSnapshot.hasData){
            return Center(child: Text('Error fetching user data'),);
          }

          final user = userSnapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [

                //Profile Picture
                ProfilePicWidget(user: user),

                SizedBox(height: 10,),

                //Username
                Text(user.username),

                SizedBox(height: 10,),

                //Saved button      
                Row(
                        
                  mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtonIconWidget(
                        buttontext: 'Saved',
                        routename: '', 
                        icon: Icon(Icons.bookmark), 
                        backgroundcolor:Theme.of(context).colorScheme.background,
                        outercolor: Theme.of(context).colorScheme.background)
                    ],
                ),

                StreamBuilder<List<Recipe>>(
                  stream: fbService.getRecipes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }

                    if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return Column(
                        children:[
                          Text('No Recipes available!')
                        ],
                      );
                    } 
            
                  List<Recipe> recipes = snapshot.data!;
                    return ListView.builder( 
                      shrinkWrap: true,
                      itemCount: recipes.length,
                      itemBuilder: (ctx, i){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OwnPostContainerWidget(recipe: recipes[i], deleteRecipe: (){deleteRecipe(recipes[i].id);}), 
                        );
                      },
                    );
                  },
                ),  
              ],  
            ),
          );
        },
      ),
    );  
  }
}