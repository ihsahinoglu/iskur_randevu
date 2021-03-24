import 'package:flutter/material.dart';
import 'package:iskur_randevu/AllCalendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'DatabaseAccess.dart';


// ignore: must_be_immutable
class ToAllCalendar extends StatefulWidget {
  List<CalendarResource> resources = <CalendarResource>[];

  ToAllCalendar(this.resources);

  @override
  _ToAllCalendarState createState() => _ToAllCalendarState();
}

class _ToAllCalendarState extends State<ToAllCalendar> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {
    List<Appointment> appointments = <Appointment>[];
    DatabaseAccess databaseAccess = DatabaseAccess();
    appointments = await databaseAccess.getAllData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => AllCalendar(appointments,widget.resources)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {

          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("İŞKUR RANDEVU SİSTEMİ"),
            Text("Hoşgeldiniz")
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),

    );
  }
}
