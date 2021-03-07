import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'AnaSayfa.dart';
import 'Sorgu.dart';

class GecisSayfasi extends StatefulWidget {
  String displayName;
  GecisSayfasi(this.displayName);

  @override
  _GecisSayfasiState createState() => _GecisSayfasiState();
}

class _GecisSayfasiState extends State<GecisSayfasi> {

  void initState() {
    super.initState();
    asyncMethod();
  }

  Future asyncMethod() async {
    List<Appointment> appointments = <Appointment>[];
    Sorgu sorgu = Sorgu();
    appointments = await sorgu.bilgileriGetir(widget.displayName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => AnaSayfa(widget.displayName,appointments)));
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
