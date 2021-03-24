import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:iskur_randevu/MyCalendar.dart';
import 'DatabaseAccess.dart';

// ignore: must_be_immutable
class ToMyCalendar extends StatefulWidget {
  String displayName;
  ToMyCalendar(this.displayName);

  @override
  _ToMyCalendarState createState() => _ToMyCalendarState();
}

class _ToMyCalendarState extends State<ToMyCalendar> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {
    List<Appointment> appointments = <Appointment>[];
    DatabaseAccess databaseAccess = DatabaseAccess();
    appointments = await databaseAccess.getData(widget.displayName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => MyCalendar(widget.displayName,appointments)));
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
            Text("Hoşgeldin ${widget.displayName}")
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
