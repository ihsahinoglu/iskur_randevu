import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iskur_randevu/Ekle.dart';
import 'package:iskur_randevu/GecisSayfasi.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AnaSayfa extends StatefulWidget {
  String displayName;
  List<Appointment> appointments = <Appointment>[];

  AnaSayfa(this.displayName, this.appointments);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  DateTime selectedDate = DateTime.now();
  bool listele = true;
  DateTime date;
  List<dynamic> appointment;
  CalendarElement element;
  Appointment _selectedAppointment;
  DateTime _startDate;
  DateTime _endDate;
  TimeOfDay  _startTime;
  TimeOfDay  _endTime;
  String _subject = '';
  _AppointmentDataSource _getCalendarDataSource() {
    return _AppointmentDataSource(widget.appointments);
  }
  @override
  Widget build(BuildContext context) {
    var ekranBoyutu = MediaQuery.of(context);
    final yukseklik = ekranBoyutu.size.height;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox( height: yukseklik*0.01,),
            Container(
                    height: yukseklik*0.85,
                    child: SfCalendar(
                      view: CalendarView.workWeek,
                      allowedViews: <CalendarView>[
                        CalendarView.day,
                        CalendarView.week,
                        CalendarView.workWeek,
                        CalendarView.month,
                        CalendarView.schedule
                      ],
                      timeSlotViewSettings: TimeSlotViewSettings(
                          startHour: 9,
                          endHour: 17,
                          nonWorkingDays: <int>[
                            DateTime.saturday,
                            DateTime.sunday
                          ],
                          dateFormat: 'd',
                          dayFormat: 'EEE',
                          timeFormat: 'HH:mm'),
                      dataSource: _getCalendarDataSource(),
                      firstDayOfWeek: 1,
                      appointmentTimeTextFormat: 'HH:mm',
                      monthViewSettings: MonthViewSettings(
                          showAgenda: true, dayFormat: 'EEE'),
                      onTap: onCalendarTapped,
                      scheduleViewSettings:
                          ScheduleViewSettings(appointmentItemHeight: 70),
                      todayHighlightColor: Colors.red,
                      showNavigationArrow: true,
                    )
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Ekle(widget.displayName)));
        },
        label: Text("Yeni Randevu"),
        tooltip: 'Kaydet',
        icon: Icon(Icons.save),
      ),
    );
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {

    // if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
    //     calendarTapDetails.targetElement != CalendarElement.appointment) {
    //   return;
    // }

    _selectedAppointment = null;
    _subject = '';
    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.appointments.length == 1) {
      final Appointment appointmentDetails = calendarTapDetails.appointments[0];
      _startDate = appointmentDetails.startTime;
      _endDate = appointmentDetails.endTime;
      _subject = appointmentDetails.subject;
      _selectedAppointment = appointmentDetails;
    } else {
      final DateTime date = calendarTapDetails.date;
      _startDate = date;
      _endDate = date.add(const Duration(hours: 1));
    }
    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    if(_selectedAppointment!=null) {
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: Text(_selectedAppointment.subject),
            content: Text("${DateFormat.Hm().format(_selectedAppointment.startTime)}-${DateFormat.Hm().format(_selectedAppointment.endTime)}"),
            actions: [
              TextButton(onPressed: () async {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) =>
                    Ekle.edit(widget.displayName,
                        _selectedAppointment.subject,
                        _selectedAppointment.startTime,
                        _selectedAppointment.endTime)));
              },
                  child: Text("Düzenle")),
              TextButton(onPressed: () async {
                FirebaseFirestore firestore = FirebaseFirestore.instance;
                CollectionReference collectionReference = firestore.collection(
                    'randevular');
                await collectionReference.doc(_selectedAppointment.notes)
                    .delete();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => GecisSayfasi(widget.displayName)));
              }, child: Text("Sil")),
            ],
          ));
    }
  }

  // showAppointmentList() {
  //   return ListView.builder(
  //      // physics: NeverScrollableScrollPhysics(),
  //      // scrollDirection: Axis.vertical,
  //      // shrinkWrap: true,
  //      // primary: false,
  //       itemCount: widget.appointments.length,
  //       itemBuilder: (context, index) {
  //         Appointment appointment = widget.appointments[index];
  //         return Card(
  //             child: ListTile(
  //               leading: Icon(Icons.account_circle_outlined),
  //               title: Text(appointment.subject),
  //               subtitle: Text("${appointment.startTime}-${appointment.endTime}"),
  //               trailing: IconButton(
  //                 icon: Icon(Icons.edit),
  //           ),
  //         ));
  //       });
  // }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
