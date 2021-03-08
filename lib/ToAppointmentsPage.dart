import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'AppointmentsPage.dart';
import 'DatabaseAccess.dart';

class ToAppointmentsPage extends StatefulWidget {
  String displayName;
  ToAppointmentsPage(this.displayName);

  @override
  _ToAppointmentsPageState createState() => _ToAppointmentsPageState();
}

class _ToAppointmentsPageState extends State<ToAppointmentsPage> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {
    List<Appointment> appointments = <Appointment>[];
    DatabaseAccess sorgu = DatabaseAccess();
    appointments = await sorgu.getData(widget.displayName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => AppointmentsPage(widget.displayName,appointments)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
