import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';


class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  late final CalendarDatePicker2Config config; 

  @override
  void initState() {
    super.initState();
    config = CalendarDatePicker2Config(
      weekdayLabelTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.25, height: 17.07 / 14),
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      firstDayOfWeek: 1,
      dayBorderRadius: BorderRadius.circular(10),
      controlsHeight: 62, // 40 + 22
      dayTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17.07 / 14),
      disabledDayTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17.07 / 14, color: Colors.red), // Color(0xFF848CA0) //! todo:change
      selectedDayTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.25, height: 17.07 / 14, color: Color(0xFF3C69D1)),
      controlsTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17.07 / 14, color: Color(0xFF848CA0)),
      selectedDayHighlightColor: Colors.white.withOpacity(0.8),
      selectedDayBoxShadows: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.05))],
      todayHighlightColor: Colors.green,
      // todayTextStyle: ,
      pastOrFutureDaysTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 17.07 / 14, color: Color(0xFF848CA0)),
      splashRadius: 0.0,
      selectableDayPredicate: (day) => day.difference(DateTime.now()).isNegative,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: <Widget>[
              _buildDefaultSingleDatePickerWithValue(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _singleDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _singleDatePickerValueWithDefaultValue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) => (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

}