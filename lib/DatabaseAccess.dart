import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iskur_randevu/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DatabaseAccess {

    Future <List<Appointment>> getData(String displayName) async {
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
          var i=EntrancePage.resources.indexWhere((element) => element.displayName==displayName);
          var id=EntrancePage.resources[i].id;
          Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject, color: randomColor(),
            resourceIds: ["$id"],notes: appointmentId);
          appointments.add(appointment);
        }
      }
      );
      return appointments;
    }

    Future <List<Appointment>> getAllData() async {
      List<Appointment> appointments = <Appointment>[];
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionReference = firestore.collection('randevular');
      QuerySnapshot querySnapshot = await collectionReference.get();

      querySnapshot.docs.forEach((QueryDocumentSnapshot queryDocumentSnapshot) {

        String displayName=queryDocumentSnapshot.data()["displayName"];
        var i=EntrancePage.resources.indexWhere((element) => element.displayName==displayName);
        var id=EntrancePage.resources[i].id;
        DateTime startTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["startTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        DateTime endTime = DateTime.fromMillisecondsSinceEpoch(queryDocumentSnapshot.data()["endTime"].millisecondsSinceEpoch).add(const Duration(hours: 3));
        String subject = queryDocumentSnapshot.data()["subject"];
        Appointment appointment= Appointment(startTime: startTime, endTime: endTime, isAllDay: false, subject: subject,
            color:randomColor() , resourceIds: ["$id"]);
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
      _colorCollection.add(const Color(0xFFF16107));
      _colorCollection.add(const Color(0xFFE747E7));
      _colorCollection.add(const Color(0xFF213CD4));
      _colorCollection.add(const Color(0xFFEC1B09));
      _colorCollection.add(const Color(0xFFE50D0D));
      _colorCollection.add(const Color(0xFFFFC107));
      _colorCollection.add(const Color(0xFF58B6B6));
      _colorCollection.add(const Color(0xFF3F51B5));

      return _colorCollection[random.nextInt(11)];
    }

    Future <List<CalendarResource>> getPersons() async{
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

    // Future<ImageProvider<ExactAssetImage>> getImages(String displayName) async{
    //   firebase_storage.Reference ref = await firebase_storage.FirebaseStorage.instance.ref('images/$displayName');
    //   return ExactAssetImage(ref);
    //
    // }

}


class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}
