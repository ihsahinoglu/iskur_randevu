import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Sorgu.dart';

class TumRandevular extends StatefulWidget {
  List<Appointment> appointments = <Appointment>[];
  List<CalendarResource> resources = <CalendarResource>[];
  TumRandevular(this.appointments,this.resources);

  @override
  _TumRandevularState createState() => _TumRandevularState();
}

class _TumRandevularState extends State<TumRandevular> {

  DataSource _getCalendarDataSource() {
    return DataSource(widget.appointments, widget.resources);
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("İŞKUR RANDEVU SİSTEMİ"),
              Text("Hoşgeldiniz"),
            ],
          ),
        ),
        body: SfCalendar(
          view: CalendarView.timelineDay,
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

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(
      List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
  @override
  List<Object> getResourceIds(int index) {
    return appointments[index].ids;
  }
}

