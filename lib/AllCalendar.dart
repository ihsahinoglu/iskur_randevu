import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'main.dart';

// ignore: must_be_immutable
class AllCalendar extends StatefulWidget {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];
  AllCalendar(this.appointments,this.resources);

  @override
  _AllCalendarState createState() => _AllCalendarState();
}

class _AllCalendarState extends State<AllCalendar> {

  DataSource _getCalendarDataSource() {
    return DataSource(widget.appointments, widget.resources);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (contex) => EntrancePage()));
            },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("İŞKUR RANDEVU SİSTEMİ"),
              Text("Hoşgeldiniz"),
            ],
          ),
        ),
        body: SfCalendar(
          view: CalendarView.timelineWorkWeek,
          allowedViews: <CalendarView>[
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth
          ],
          appointmentTimeTextFormat: 'HH:mm',
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode:
              MonthAppointmentDisplayMode.appointment),
          dataSource:  _getCalendarDataSource(),
          todayHighlightColor: Colors.red,
          timeSlotViewSettings: TimeSlotViewSettings(startHour: 9,endHour: 17,nonWorkingDays: <int>[ DateTime.saturday,DateTime.sunday],
              dateFormat: 'd', dayFormat: 'EEE',timeFormat: 'HH:mm',timeInterval: Duration(minutes: 60)),



          ),

    );
  }
}


class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}


