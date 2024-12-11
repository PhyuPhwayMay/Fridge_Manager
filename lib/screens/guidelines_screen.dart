
import 'package:flutter/material.dart';

import 'package:mbap_project_app/models/guide.dart';
import 'package:mbap_project_app/widgets/guidelines/guide_container.dart';

class GuidelinesScreen extends StatelessWidget{
  static String routeName = '/guidelines';

  //list of guides to load from
  List<Guide> guides = [
    Guide(question: 'What can we do to reduce food waste?'),
    Guide(question: 'Why do we need to reduce food waste?'),
    Guide(question: 'How can the food waste be upcycled?'),
    Guide(question: 'What alternatives can be used for packaging food?'),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView( //customizing the scroll view
        slivers: [

          //sliverappbar
          SliverAppBar.medium(
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.background,
              ),
              title: Text('Guide Book on Food Waste Management',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(88, 102, 108, 1)
              )),
              titlePadding: EdgeInsets.only(left: 35, right: 35),
              collapseMode: CollapseMode.pin,
              ),
          ),

          //sliver list view to view the content
          SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext ctx , i ) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: GuideContainer(guide: guides[i]), //creating guide tabs regarding to the guide list present
                  );
                },
                childCount: guides.length),
              
            ),
        ],
      )
    );
  }
}