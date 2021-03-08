import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iskur_randevu/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Sorgu {

    Future <List<Appointment>> bilgileriGetir(String displayName) async {
      List<Appointment> appointments = <Appointment>[];

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('randevular');
      QuerySnapshot querySnapshot = await collectionReference.get();

      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {
        if (queryDocumentSnapshot.data()["displayName"] == displayName ) {
          String appointmentId= queryDocumentSnapshot.id;
          DateTime startTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["startTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
          DateTime endTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["endTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
          String subject = queryDocumentSnapshot.data()["subject"];
          var i=GirisSayfasi.resources.indexWhere((element) => element.displayName==displayName);
          var id=GirisSayfasi.resources[i].id;
          Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject, color: randomColor(),
            resourceIds: ["$id"],notes: appointmentId);
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
        var i=GirisSayfasi.resources.indexWhere((element) => element.displayName==displayName);
        var id=GirisSayfasi.resources[i].id;
        DateTime startTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["startTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        DateTime endTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["endTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        String subject = queryDocumentSnapshot.data()["subject"];
        Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject,
            color:randomColor() , resourceIds: ["$id"]);
        appointments.add(appointment);
           //resources[int.parse(id)].color
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

    Future <List<CalendarResource>> kisleriGetir() async{
      List<CalendarResource> resources = <CalendarResource>[];

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('kisiler').orderBy("id",descending: false).get();

      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {

        String displayName=queryDocumentSnapshot.data()["displayName"];
        String id=queryDocumentSnapshot.data()["id"];
        int color= int.parse(queryDocumentSnapshot.data()["color"]);
        CalendarResource resource = CalendarResource(displayName: displayName, id:id, color:Color(color));
        resources.add(resource);
      }
      );
      return resources;
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