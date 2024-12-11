import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/models/item.dart';
import 'package:mbap_project_app/screens/home_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/appbar_title_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget{
  static String routeName = '/calendar';
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState(){
    super.initState();

    _selectedDay = _focusedDay;
    
  }

  _onDaySelected(selectedDay, focusedDay){
    if (!isSameDay(_selectedDay, selectedDay)){
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: AppBarTitleWidget(title: 'Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000,1,1),
            lastDay: DateTime.utc(2100,12,31),
            focusedDay: _focusedDay,
            headerVisible: true,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.red)
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.blue),
              selectedDecoration: BoxDecoration(color: Color.fromARGB(255, 144, 202, 249))
            ),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day), //assigning day
            onDaySelected: _onDaySelected, //callback when a day is selected
          ),
          Expanded(
            child: _selectedDay==null ? Center(child: Text("Selecte a day to see expiring items"),) :StreamBuilder(
              stream: fbService.getItemsByExpiry(_selectedDay!),  //get items by expiry date
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty){
                  return Center(child: Text("No items are expiring on the selected date."));
                }
                List<Item> items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (ctx, i){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromRGBO(90, 104, 110, 1),),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListTile(
                        title : Text(items[i].description),
                        subtitle: Text('Expires on: ${items[i].bestBeforeDate}', style: TextStyle(color: Colors.red),),
                      ),
                    );
                  });
              }))
          )
        ],
      ),
    );
    
  }
}
