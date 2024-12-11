import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mbap_project_app/models/recipe.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/appbar_title_widget.dart';
import 'package:mbap_project_app/widgets/bannerText.dart';

class EditRecipeScreen extends StatefulWidget {
  static String routeName = '/edit-recipe';
  

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  var form = GlobalKey<FormState>();

  String? title;
  String? description;
  String? recipe;
  File? recipePhoto;

  Future<Null> pickImage(mode){
    ImageSource chosenSource = mode == 0 ? ImageSource.camera : ImageSource.gallery;
    return ImagePicker()
    .pickImage(source: chosenSource, maxWidth: 600, maxHeight: 150, imageQuality: 50)
    .then((imageFile){
      if (imageFile != null){
        setState(() {
          recipePhoto = File(imageFile.path);
        });
      }
    });
  }

  void saveForm (id) {
  bool isValid = form.currentState!.validate();

  if(isValid){
    form.currentState!.save();
    fbService.addRecipePhoto(recipePhoto!).then((foodImagePath){
      fbService.updateRecipe(id, title!, description!, recipe!, foodImagePath!).then((value){
      FocusScope.of(context).unfocus();

      form.currentState!.reset();
      recipePhoto = null;

      //banner message feedback
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      backgroundColor: Color.fromRGBO(22, 132, 97, 0.466),
      content:BannerText(text: 'Recipe updated successfully!'), 
      actions: [
        TextButton(onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        }, 
        child: BannerText(text: 'Dismiss'))
      ]));
    }).onError((error, stackTrace){
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: BannerText(text: 'Error: '+error.toString()), 
      actions: [
        TextButton(onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        }, 
        child: BannerText(text: 'Dismiss'))
      ]));
      });
    });
  }
}
   
  @override
  Widget build(BuildContext context) {

    Recipe selectedRecipe = ModalRoute.of(context)?.settings.arguments as Recipe;
    if (title == null) title= selectedRecipe.Title; 
    if (description == null)description = selectedRecipe.Description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: AppBarTitleWidget(title: 'Share Recipe')
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 129, 128, 0.09),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: selectedRecipe.Title,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Title',
                                  style: TextStyle(
                                    color: Color.fromRGBO(82, 102, 108, 1),
                                    fontFamily: 'EBGaramond',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal
                                  ),)),
                              onSaved: (value) { title = value as String;},
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please provide title of the recipe.";
                                else
                                  return null;
                                },
                            ),
                    
                        SizedBox(height: 20,),  


                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              initialValue: description,
                              minLines: 1,
                              maxLines: null,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: Color.fromRGBO(82, 102, 108, 1),
                                    fontFamily: 'EBGaramond',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal
                                  ),)),
                              onSaved: (value) { description = value as String;},
                              validator: (value) {
                                if (value == null)
                                  return "Please provide description of the recipe.";
                                else
                                  return null;
                                },
                            ),
                        

                        SizedBox(height: 20,),

                        
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              initialValue: selectedRecipe.RecipeDetail,
                              minLines: 1,
                              maxLines: null,
                              decoration: const InputDecoration(
                                label: Text(
                                  'Recipe',
                                  style: TextStyle(
                                    color: Color.fromRGBO(82, 102, 108, 1),
                                    fontFamily: 'EBGaramond',
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal
                                  ),)),
                              onSaved: (value) { recipe = value as String;},
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Please fill in the recipe.";
                                else
                                  return null;
                                },
                            ),

                            SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container (
                                  width: 150,
                                  height: 100,
                                  decoration: const BoxDecoration(color: Colors.grey),
                                  child: recipePhoto != null ? FittedBox(fit: BoxFit.fill, child : Image.file(recipePhoto!)) : Center(),),
                                  Column(
                                    children: [
                                      TextButton.icon(onPressed: () => pickImage(0), icon: const Icon(Icons.camera_alt), label: const Text('Take Photo')),
                                      TextButton.icon(onPressed: () => pickImage(1), icon: const Icon(Icons.image), label: const Text('Add image'))
                                    ],)
                              ],
                            )
                          ],
                    ),
                  ),

                  //Done Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, 
                    children: [
                      TextButton(onPressed: (){saveForm(selectedRecipe.id);}, 
                      child: Text('Complete'))
                    ],)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}