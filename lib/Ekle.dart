import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iskur_randevu/GecisSayfasi.dart';

class Ekle extends StatefulWidget {
  String displayName;
  String subject;
  DateTime startTime;
  DateTime endTime;
  Ekle(this.displayName);
  Ekle.edit(this.displayName,this.subject,this.startTime,this.endTime);
  @override
  _EkleState createState() => _EkleState();
}

class _EkleState extends State<Ekle> {
  final formKey = GlobalKey<FormState>();
  var tfsubject = TextEditingController();
  var tfDate = TextEditingController();
  var tfStartTime = TextEditingController();
  var tfEndTime = TextEditingController();
  DateTime date;
  // DateTime startTime;
  // DateTime endTime;
  Future goBack() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (contex) => GecisSayfasi(widget.displayName)));
  }
@override
  void initState() {
    if(widget.subject!=null){tfsubject.text= widget.subject;}
    if(widget.startTime!=null){tfDate.text =new DateFormat("dd.MM.yyyy").format(widget.startTime);}
    if(widget.startTime!=null){tfStartTime.text = new DateFormat.Hm().format(widget.startTime);}
    if(widget.endTime!=null){tfEndTime.text = new DateFormat.Hm().format(widget.endTime);}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var ekranBoyutu = MediaQuery.of(context);
    final yukseklik = ekranBoyutu.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [Text("İŞKUR RANDEVU SİSTEMİ"), Text("Yeni Randevu")],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goBack();
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          goBack();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: tfsubject,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen açıklama giriniz';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.work),
                        hintText: "Firma adı giriniz",
                      ),
                    ),
                    TextFormField(
                      controller: tfDate,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen tarih giriniz';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        hintText: "Tarih giriniz",
                      ),
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          locale: const Locale("tr"),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        ).then((selectedDate) {
                          if (selectedDate != null)
                            setState(() {
                              date = selectedDate;
                              tfDate.text =
                                  new DateFormat("dd.MM.yyyy").format(selectedDate);
                            });
                        });
                      },
                    ),
                    TextFormField(
                      controller: tfStartTime,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen başlangıç saati giriniz';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.access_time_outlined),
                        hintText: "Başlangıç saati giriniz",
                      ),
                      onTap: () async {
                        await showTimePicker(
                                context: context,
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child,
                                  );
                                },
                                initialTime: TimeOfDay(hour: 12, minute: 00))
                            .then((selectedStartTime) {
                          setState(() {
                            widget.startTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                selectedStartTime.hour,
                                selectedStartTime.minute);
                            tfStartTime.text =
                                new DateFormat.Hm().format(widget.startTime);
                          });
                        });
                      },
                    ),
                    TextFormField(
                      controller: tfEndTime,
                      textAlign: TextAlign.center,
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Lütfen bitiş saati giriniz';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.access_time_outlined),
                        hintText: "Bitiş Saati giriniz",
                      ),
                      onTap: () async {
                        await showTimePicker(
                                context: context,
                                builder: (BuildContext context, Widget child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child,
                                  );
                                },
                                initialTime: widget.startTime != null
                                    ? TimeOfDay(
                                        hour: widget.startTime.hour + 1, minute: 00)
                                    : TimeOfDay(hour: 13, minute: 00))
                            .then((selectedEndTime) {
                          setState(() {
                            widget.endTime = DateTime(date.year, date.month, date.day,
                                selectedEndTime.hour, selectedEndTime.minute);
                            tfEndTime.text = DateFormat.Hm().format(widget.endTime);
                          });
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            var appointments = Map<String, dynamic>();
                            appointments["displayName"] = widget.displayName;
                            appointments["startTime"] =
                                widget.startTime.add(const Duration(hours: -3));
                            appointments["endTime"] =
                                widget.endTime.add(const Duration(hours: -3));
                            appointments["subject"] = tfsubject.text;
                            FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
                            CollectionReference collectionReference =
                                firestore.collection('randevular');
                            await collectionReference.add(appointments);
                            goBack();
                          }
                        },
                        child: Text("Yeni Randevu Oluştur"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
