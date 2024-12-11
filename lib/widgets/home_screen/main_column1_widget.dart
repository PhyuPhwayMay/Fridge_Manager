import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/screens/add_item_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/logo_widget.dart';
import 'package:mbap_project_app/widgets/home_screen/my_tab.dart';
import 'package:mbap_project_app/widgets/home_screen/tabs/alltab_widget.dart';
import 'package:mbap_project_app/widgets/home_screen/tabs/categorytab_widget.dart';
import 'package:mbap_project_app/widgets/home_screen/text1_widget.dart';


class MainColumnWidget extends StatelessWidget{
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  
  logOut(context){
    return fbService.logOut().then((value){
      FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out Successfully")));
    }).catchError((error){
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))
        );
      });
  }

  @override
  Widget build(BuildContext context){

    //List of tabs
    List<Widget> tabs = [
      MyTab(tabname: 'All'),
      MyTab(tabname: 'Meat'),
      MyTab(tabname: 'Cooked'),
      MyTab(tabname: 'Fruits'),
      MyTab(tabname: 'Canned'),
      MyTab(tabname: 'Drinks'),
      MyTab(tabname: 'Vegetables'),
      MyTab(tabname: 'Frozen'),
      MyTab(tabname: 'Ingredients'),];


    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: LogoWidget(),
          ),
          actions: [
            IconButton(
              onPressed: () => logOut(context) , icon: Icon(Icons.logout)
            ),
           
          ],
        ),

        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Text1Widget(),
                ), 
                Spacer(),
                IconButton(onPressed: (){Navigator.of(context).pushNamed(AddItemScreen.routeName);}, icon: Icon(Icons.add))
              ],
            ),

            const SizedBox(height: 24),

            //creating tabbar
            TabBar(
              isScrollable:true, //making it scrollable
              tabs: tabs),
            Expanded(
              child: TabBarView(
              children: [
                AllTabWidget(),
                CategoryTabWidget(category: 'Meat'),
                CategoryTabWidget(category: 'Cooked'),
                CategoryTabWidget(category: 'Fruits'),
                CategoryTabWidget(category: 'Canned'),
                CategoryTabWidget(category: 'Drinks'),
                CategoryTabWidget(category: 'Vegetables'),
                CategoryTabWidget(category: 'Frozen'),
                CategoryTabWidget(category: 'Ingredients'),],
              )
            )
          ],
        ),
      ),
    );
  }
}
