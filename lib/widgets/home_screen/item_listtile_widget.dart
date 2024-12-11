import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mbap_project_app/models/item.dart';

//Creating a reusable item listtile widget
class ItemListTileWidget extends StatelessWidget{

  //importing the model Item as items
  final Item items;
  final Function onPressedDelete;

  const ItemListTileWidget({required this.items, required this.onPressedDelete});
  
  String formatDate(String date){
    DateTime datetime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(datetime);
  }
  @override
  Widget build (BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),

        //decoration of the tile
        decoration: BoxDecoration(
          color: const Color.fromRGBO(92, 129, 128, 0.09),
          borderRadius: BorderRadius.circular(15)
        ),
        
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //Created date
                Icon(Icons.arrow_right),
                Text(
                  formatDate(items.createdDate), //text will be accessed from the list
                  style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontSize: 20,
                    fontStyle:FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(90, 104, 110, 1)
                  )
                ),
                Spacer(),

                //Delete button
                IconButton(
                  icon: Icon(Icons.delete), 
                  color: Color.fromRGBO(187, 66, 83, 1), 
                  onPressed: (){onPressedDelete();})
              ],
            ),

            SizedBox(height: 3),

            //Property of the item (Name, Category)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  items.imagePath, height: 40, width: 60),
                SizedBox(width: 3),
                Expanded(
                  child: Text(
                    items.description,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 20,
                      fontStyle:FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(90, 104, 110, 1)
                    )
                  ),
                ),
              ],
            ),

            SizedBox(height: 3),

            //Best before date of the item
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Best Before: ' + formatDate(items.bestBeforeDate),
                  style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontSize: 15,
                    fontStyle:FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(187, 66, 83, 1)
                  )
                )
              ],
            )
          ],
        )
      ),
    );
  }
}