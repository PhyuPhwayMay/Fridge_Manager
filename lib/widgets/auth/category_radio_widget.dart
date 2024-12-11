import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mbap_project_app/models/category.dart';

class CategoryRadioButtonWidget extends StatelessWidget{

  final String? selectedCategory;
  final ValueChanged onChanged;
  final List<Category> categories;

  CategoryRadioButtonWidget({required this.categories, required this.onChanged, required this.selectedCategory});

  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4),
        itemCount: categories.length,
        itemBuilder: (ctx, i){
          return RadioListTile(
            title: Text(categories[i].category,
            style: TextStyle(
              color: Color.fromRGBO(88, 102, 108, 1),
              fontFamily: 'EBGaramond',
              fontSize: 15,
              fontWeight: FontWeight.normal
            ),),
            value: categories[i].category,
            groupValue: selectedCategory, 
            onChanged: onChanged);
        }
      ),
    );
  }
}