import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iskur_randevu/GecisSayfasi.dart';
import 'package:iskur_randevu/GecisSayfasiTumKisiler.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate

      ],
      supportedLocales: [
        const Locale('tr'),
      ],
      locale: const Locale('tr'),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GirisSayfasi(),
    );
  }
}

class GirisSayfasi extends StatefulWidget {

  GirisSayfasi({ Key key,}) : super(key: key);

  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {

  @override
  Widget build(BuildContext context) {
    var ekranBoyutu = MediaQuery.of(context);
    final yukseklik = ekranBoyutu.size.height;
    final genislik = ekranBoyutu.size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("İŞKUR RANDEVU SİSTEMİ",)
        ),
        body: Padding(
          padding: EdgeInsets.only(left: genislik*0.2, right: genislik*0.2, top:yukseklik*0.05, bottom: yukseklik*0.05 ),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: genislik*0.1,
            mainAxisSpacing: yukseklik*0.08,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasiTumKisiler()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tüm"),
                      Text("Randevular"),
                    ],
                  ),
                  alignment: Alignment.center

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("İbrahim")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("İbrahim"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Raşit")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Raşit"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Pakize")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Pakize"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Seray")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Seray"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Özlem")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Özlem"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Raziye")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Raziye"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> GecisSayfasi("Fatma")));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:Text("Fatma"),
                  alignment: Alignment.bottomCenter,

                ),
              ),
            ],
          ),
        ));
  }

}
