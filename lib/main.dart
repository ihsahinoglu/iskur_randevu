import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iskur_randevu/ToMyCalendar.dart';
import 'package:iskur_randevu/ToAllCalendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'DatabaseAccess.dart';

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
      title: 'İşkur Randevu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EntrancePage(),
    );
  }
}

class EntrancePage extends StatefulWidget {

  EntrancePage({
    Key key,
  }) : super(key: key);
  static List<CalendarResource> resources = <CalendarResource>[];
  @override
  _EntrancePageState createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {

  @override
  Widget build(BuildContext context) {
    var ekranBoyutu = MediaQuery.of(context);
    final yukseklik = ekranBoyutu.size.height;
    final genislik = ekranBoyutu.size.width;
    return Scaffold(
        appBar: AppBar(
            title: Align(
               alignment: Alignment.center,
              child: Text("İŞKUR RANDEVU SİSTEMİ"),
            )),
        body: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                   onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ToAllCalendar(EntrancePage.resources)));
                },
                    child: Padding(
                    padding:  EdgeInsets.only(top: yukseklik*0.05,left: genislik*0.15, right: genislik*0.15),
                    child: Container(
                    height: yukseklik*0.05,
                       decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tüm Randevular"),
                        ],
                      ),
                      alignment: Alignment.center),
                ),
              ),
                   Padding(
                    padding: EdgeInsets.only(left:10.0, right: 10.0),
                    child: FutureBuilder <List<CalendarResource>> (
                      future: getName(),
                      builder: (context, AsyncSnapshot<List<CalendarResource>> snapshot) {
                        if (snapshot.hasData) {
                         return  Padding(
                           padding: EdgeInsets.all(yukseklik*0.07),
                           child: GridView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.25 / 1,
                                        crossAxisSpacing: 40,
                                        mainAxisSpacing: 40),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ToMyCalendar(
                                                  snapshot
                                                      .data[index].displayName)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.blue[index*100+100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child:
                                          Text(snapshot.data[index].displayName),
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  );
                                }),
                         );
                        }
                        else {
                         return Center(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                ),
                             ],
                           ),
                         );
                      }
                      }
                      )
              )
            ]),
          ),
        ));
  }

  Future <List<CalendarResource>>  getName() async {
    DatabaseAccess databaseAccess = DatabaseAccess();
    return EntrancePage.resources = await databaseAccess.getPersons();
  }
}
