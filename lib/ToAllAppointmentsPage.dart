import 'package:flutter/material.dart';
import 'package:iskur_randevu/AllAppointmentsPage.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'DatabaseAccess.dart';


class ToAllAppointmentsPage extends StatefulWidget {
  List<CalendarResource> resources = <CalendarResource>[];

  ToAllAppointmentsPage(this.resources);

  @override
  _ToAllAppointmentsPageState createState() => _ToAllAppointmentsPageState();
}

class _ToAllAppointmentsPageState extends State<ToAllAppointmentsPage> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {
    List<Appointment> appointments = <Appointment>[];
    DatabaseAccess databaseAccess = DatabaseAccess();
    appointments = await databaseAccess.getAllData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => AllAppointmentsPage(appointments,widget.resources)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
