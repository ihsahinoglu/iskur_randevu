import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iskur_randevu/AddAppointment.dart';
import 'package:iskur_randevu/ToMyCalendar.dart';
import 'package:iskur_randevu/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//ignore: must_be_immutable
class MyCalendar extends StatefulWidget {
  String displayName;
  List<Appointment> appointments = <Appointment>[];

  MyCalendar(this.displayName, this.appointments);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime selectedDate = DateTime.now();
  DateTime date;
  List<dynamic> appointment;
  CalendarElement element;
  Appointment _selectedAppointment;
  DateTime _startDate;
  DateTime _endDate;
  // ignore: unused_field
  TimeOfDay _startTime;
  // ignore: unused_field
  TimeOfDay _endTime;
  // ignore: unused_field
  String _subject = '';
  _AppointmentDataSource _getCalendarDataSource() {
    return _AppointmentDataSource(widget.appointments);
  }

  Future goBack() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (contex) => EntrancePage()));
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
            Text("Hoşgeldin ${widget.displayName}"),
          ],
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
          return goBack();
        },
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: yukseklik * 0.01,
            ),
            Container(height: yukseklik * 0.85, child: getCalendar()),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddAppointment(widget.displayName)));
        },
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Yeni Randevu", style: TextStyle(fontSize: 16)),
        ),
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

    //_selectedAppointment = null;
    // _subject = '';
    if (calendarTapDetails.appointments != null &&
        calendarTapDetails.appointments.length == 1) {
      final Appointment appointmentDetails = calendarTapDetails.appointments[0];
      _startDate = appointmentDetails.startTime;
      _endDate = appointmentDetails.endTime;
      _subject = appointmentDetails.subject;
      _selectedAppointment = appointmentDetails;
    } //else {
    //final DateTime date = calendarTapDetails.date;
    //_startDate = date;
    // _endDate = date.add(const Duration(hours: 1));
    // }
    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    if (_selectedAppointment != null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(_selectedAppointment.subject),
                content: Text(
                    "${DateFormat.Hm().format(_selectedAppointment.startTime)}-${DateFormat.Hm().format(_selectedAppointment.endTime)}"),
                actions: [
                  TextButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddAppointment.edit(
                                        widget.displayName,
                                        _selectedAppointment.subject,
                                        _selectedAppointment.startTime,
                                        _selectedAppointment.endTime,
                                        _selectedAppointment.notes)));
                      },
                      child: Text("Düzenle")),
                  TextButton(
                      onPressed: () async {
                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        CollectionReference collectionReference =
                            firestore.collection('randevular');
                        await collectionReference
                            .doc(_selectedAppointment.notes)
                            .delete();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (contex) =>
                                    ToMyCalendar(widget.displayName)));
                      },
                      child: Text("Sil")),
                ],
              ));
    }
  }

  Widget getCalendar() {
    return SfCalendar(
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
          nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
          dateFormat: 'd',
          dayFormat: 'EEE',
          timeFormat: 'HH:mm'),
      dataSource: _getCalendarDataSource(),
      firstDayOfWeek: 1,
      appointmentTimeTextFormat: 'HH:mm',
      monthViewSettings: MonthViewSettings(showAgenda: true, dayFormat: 'EEE'),
      onTap: onCalendarTapped,
      scheduleViewSettings: ScheduleViewSettings(appointmentItemHeight: 70),
      todayHighlightColor: Colors.red,
      showNavigationArrow: true,
    );
  }

showAppointmentList() {
  return ListView.builder(
     // physics: NeverScrollableScrollPhysics(),
     // scrollDirection: Axis.vertical,
     // shrinkWrap: true,
     // primary: false,
      itemCount: widget.appointments.length,
      itemBuilder: (context, index) {
        Appointment appointment = widget.appointments[index];
        return Card(
            child: ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text(appointment.subject),
              subtitle: Text("${appointment.startTime}-${appointment.endTime}"),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit),
          ),
        ));
      });
}
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
