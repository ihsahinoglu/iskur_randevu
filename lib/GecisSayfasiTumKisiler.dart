import 'package:flutter/material.dart';
import 'package:iskur_randevu/TumRandevular.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Sorgu.dart';

class GecisSayfasiTumKisiler extends StatefulWidget {

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
    List<CalendarResource> resources = <CalendarResource>[];
    Sorgu sorgu = Sorgu();
    resources.add(CalendarResource(displayName: 'İbrahim', id: '0001', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Raşit', id: '0002', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Pakize', id: '0003', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Özlem', id: '0004', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Fatma', id: '0005', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Raziye', id: '0006', color: sorgu.randomColor()));
    resources.add(CalendarResource(displayName: 'Seray', id: '0007', color: sorgu.randomColor()));

    appointments = await sorgu.tumBilgileriGetir();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => TumRandevular(appointments,resources)));
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
