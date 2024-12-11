import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mbap_project_app/models/category.dart';
import 'package:mbap_project_app/models/item.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/appbar_title_widget.dart';
import 'package:mbap_project_app/widgets/bannerText.dart';
import 'package:mbap_project_app/widgets/auth/category_radio_widget.dart';

class EditItemScreen extends StatefulWidget {
  static String routeName = '/edit-item';
  

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  var form = GlobalKey<FormState>();

  String? _selectedCategory;
  String? description;
  int? reminder;
  DateTime? bestBefore;

  void datePicker(BuildContext context){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2101),
    ).then((value) {
      if (value == null) return;

      setState(() {
        bestBefore = value;
      });
    });
  }

  void saveForm (id) {
  bool isValid = form.currentState!.validate();

  if(isValid){
    form.currentState!.save();
    debugPrint(_selectedCategory);
    debugPrint(description);
    print(reminder);

    fbService.updateItem(id, _selectedCategory!, description!, bestBefore!, reminder!).then((value){
      if (!mounted) return;
      FocusScope.of(context).unfocus();

      form.currentState!.reset();
      bestBefore = null;

      //banner message feedback
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        backgroundColor: Color.fromRGBO(22, 132, 97, 0.466),
        content:BannerText(text: 'Item updated successfully!'), 
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, 
          child: BannerText(text: 'Dismiss'))
        ]));
      }).onError((error, stackTrace){
        if (!mounted) return;
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(content: BannerText(text: 'Error: '+error.toString()), 
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }, 
          child: BannerText(text: 'Dismiss'))
        ]));
      });
  }
  
}

  List<Category> categories = [
    Category(category: 'Meat'),
    Category(category: 'Cooked'),
    Category(category: 'Fruits'),
    Category(category: 'Canned'),
    Category(category: 'Drinks'),
    Category(category: 'Vegetables'),
    Category(category: 'Frozen'),
    Category(category: 'Ingredients'),
  ];
  
  
  @override
  Widget build(BuildContext context) {

    Item selectedItem = ModalRoute.of(context)?.settings.arguments as Item;
    if (bestBefore == null) bestBefore= DateTime.parse(selectedItem.bestBeforeDate); 
    if (_selectedCategory == null) _selectedCategory = selectedItem.category;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: AppBarTitleWidget(title: 'Edit Item')
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Select Category
                  Text("Select Category",
                  style: TextStyle(
                            color: Color.fromRGBO(82, 102, 108, 1),
                            fontFamily: 'EBGaramond',
                            fontSize: 22,
                            fontWeight: FontWeight.normal
                  )
                  ),

                  SizedBox(height: 20,),
                  //Radio Buttons
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 129, 128, 0.09),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: CategoryRadioButtonWidget(
                      categories: categories, 
                      selectedCategory: _selectedCategory,
                      onChanged: (value){
                        setState((){
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 20,),

                  //Description
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 129, 128, 0.09),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: selectedItem.description,
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
                        if (value == null || value.isEmpty)
                          return "Please provide description of the item.";
                        else
                          return null;
                        },
                    ),
                  ),

                  SizedBox(height: 20,),

                  //Best Before Date
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 129, 128, 0.09),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Best Before: ',
                        style: TextStyle(
                            color: Color.fromRGBO(82, 102, 108, 1),
                            fontFamily: 'EBGaramond',
                            fontSize: 18,
                            fontWeight: FontWeight.normal
                          ),),
                        Row(
                          children: [
                            Text(bestBefore == null ? 'No Expiry Date Chosen': "Picked date: " + DateFormat('dd/MM/yyyy').format(bestBefore!)),
                             IconButton(onPressed: (){datePicker(context);}, icon: Icon(Icons.calendar_month))
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  //Reminder
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(92, 129, 128, 0.09),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: DropdownButtonFormField(
                      value: selectedItem.reminder,
                      decoration: const InputDecoration(
                        label: Text('Reminder',
                        style: TextStyle(
                            color: Color.fromRGBO(82, 102, 108, 1),
                            fontFamily: 'EBGaramond',
                            fontSize: 18,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ), 
                      items: const [
                        DropdownMenuItem(
                          value: 1, 
                          child: Text('A day before',
                          style: TextStyle(
                            color: Color.fromRGBO(82, 102, 108, 1),
                            fontFamily: 'EBGaramond',
                            fontSize: 15,
                            fontWeight: FontWeight.normal
                          ),
                          )
                        ),
                        DropdownMenuItem(
                          value: 3, 
                          child: Text('3 days before',
                          style: TextStyle(
                            color: Color.fromRGBO(82, 102, 108, 1),
                            fontFamily: 'EBGaramond',
                            fontSize: 15,
                            fontWeight: FontWeight.normal
                          ),
                          )
                        )
                      ], 
                      onChanged: (value){ reminder = value; },
                      onSaved: (value) {reminder = value; },
                      validator: (value) {
                        if (value == null)
                          return "Please provide the day you want to recieve notification before expiry date.";
                        else
                          return null;
                        },
                    ),
                  ),

                  //Done Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, 
                    children: [
                      TextButton(onPressed: (){saveForm(selectedItem.id);}, 
                      child: Text('Done'))
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