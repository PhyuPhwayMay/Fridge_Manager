import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/models/item.dart';
import 'package:mbap_project_app/screens/edit_item_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/home_screen/item_listtile_widget.dart';

class CategoryTabWidget extends StatefulWidget{

  final String category;

  CategoryTabWidget({required this.category});

  @override
  State<CategoryTabWidget> createState() => _CategoryTabWidgetState();
}

class _CategoryTabWidgetState extends State<CategoryTabWidget> {
  
    final FirebaseService fbService = GetIt.instance<FirebaseService>();

      void deleteItem (String id){
    showDialog<Null>(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(onPressed: (){
              fbService.deleteItem(id).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Deleted Successfully!'),));
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
  Widget build (BuildContext context){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        //creating item list tile according to the items present
        child: StreamBuilder<List<Item>>(
          stream: fbService.getItemsByCategory(widget.category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }

            if(!snapshot.hasData || snapshot.data!.isEmpty){
              return Column(
                children:[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromRGBO(92, 129, 128, 0.09)
                      ),
                      child: Center(
                        child: Text('No Items available!', 
                        style: TextStyle(
                        fontFamily: 'EBGaramond',
                        fontSize: 20,
                        fontStyle:FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(90, 104, 110, 1)
                        ),),
                      )
                    ),
                  )
                ],
              );
            }

            List<Item> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i){
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EditItemScreen.routeName,
                    arguments: snapshot.data![i]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemListTileWidget(
                      items: items[i],
                      onPressedDelete: (){ deleteItem(snapshot.data![i].id);},),
                  ),
                );
              }
            );
          }
        ),
      )
    );
  }
}