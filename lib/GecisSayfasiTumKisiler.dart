import 'package:flutter/material.dart';
import 'package:iskur_randevu/TumRandevular.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Sorgu.dart';

class GecisSayfasiTumKisiler extends StatefulWidget {
  List<CalendarResource> resources = <CalendarResource>[];

  GecisSayfasiTumKisiler(this.resources);

  @override
  _GecisSayfasiTumKisilerState createState() => _GecisSayfasiTumKisilerState();
}

class _GecisSayfasiTumKisilerState extends State<GecisSayfasiTumKisiler> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {

    List<Appointment> appointments = <Appointment>[];

    Sorgu sorgu = Sorgu();
    appointments = await sorgu.tumBilgileriGetir();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => TumRandevular(appointments,widget.resources)));
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
