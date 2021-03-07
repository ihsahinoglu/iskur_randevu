import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Sorgu {
  static Map<String,String> staff = {"İbrahim":"0001","Raşit":"0002","Pakize":"0003","Özlem":"0004","Fatma":"0005","Raziye":"0006","Seray":"0007"};

    Future <List<Appointment>> bilgileriGetir(String displayName) async {
      List<Appointment> appointments = <Appointment>[];

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('randevular');
      QuerySnapshot querySnapshot = await collectionReference.get();
      var id=staff[displayName];
      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        if (queryDocumentSnapshot.data()["displayName"] == displayName ) {
          String appointmentId= queryDocumentSnapshot.id;
          print(appointmentId);
          DateTime startTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["startTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
          DateTime endTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["endTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
          String subject = queryDocumentSnapshot.data()["subject"];
          Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject, color: randomColor(),
            resourceIds: ['$id'],notes: appointmentId);
          appointments.add(appointment);
        }
      }
      );
      return appointments;
    }

    Future <List<Appointment>> tumBilgileriGetir() async {
      List<Appointment> appointments = <Appointment>[];
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('randevular');
      QuerySnapshot querySnapshot = await collectionReference.get();

      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {

        String displayName=queryDocumentSnapshot.data()["displayName"];
        var id=staff[displayName];
        DateTime startTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["startTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        DateTime endTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["endTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        String subject = queryDocumentSnapshot.data()["subject"];
        Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject,
            color:randomColor(),resourceIds: ["$id"]);
        appointments.add(appointment);

      }

      );
      return appointments;
    }

    Color randomColor() {
      var random = Random();
      List<Color> _colorCollection = <Color>[];
      _colorCollection.add(const Color(0xFF0F8644));
      _colorCollection.add(const Color(0xFF8B1FA9));
      _colorCollection.add(const Color(0xFFEC2B2A));
      _colorCollection.add(const Color(0xFFE5987F));
      _colorCollection.add(const Color(0xFFC96628));
      _colorCollection.add(const Color(0xFFC73DC7));
      _colorCollection.add(const Color(0xFF3D4FB5));
      _colorCollection.add(const Color(0xFFEC1B09));
      _colorCollection.add(const Color(0xFF636363));
      _colorCollection.add(const Color(0xFFFFC107));
      _colorCollection.add(const Color(0xFF58B6B6));
      _colorCollection.add(const Color(0xFF3F51B5));

      return _colorCollection[random.nextInt(11)];
    }

}


class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }


}
DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];


  return DataSource(appointments, resources);
}