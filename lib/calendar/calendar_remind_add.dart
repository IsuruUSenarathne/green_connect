// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:green_connect/app_color.dart';
import 'package:green_connect/components/app_bar_with_back.dart';
import 'package:intl/intl.dart';
import '../components/app_text_form_field.dart';

class CalendarRemindAdd extends StatefulWidget {
  const CalendarRemindAdd({super.key});

  @override
  State<CalendarRemindAdd> createState() => _CalendarRemindAddState();
}

class _CalendarRemindAddState extends State<CalendarRemindAdd> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title_controller = TextEditingController();
  TextEditingController note_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  TextEditingController time_controller = TextEditingController();
  TextEditingController remind_controller = TextEditingController();

  void _date_picker() {
    DateTime selected_date = DateTime.now();
    String formattedDate = '';
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        selected_date = value!;
        formattedDate = DateFormat('yyyy/MM/dd').format(selected_date);
        date_controller.text = formattedDate;
      });
    });
  }

  void _time_picker() {
    TimeOfDay selectedTime = TimeOfDay.now();
    showTimePicker(
      initialEntryMode: TimePickerEntryMode.inputOnly,
      context: context,
      initialTime: selectedTime,
    ).then((value) {
      setState(() {
        selectedTime = value!;
        time_controller.text = selectedTime.format(context).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBack(
        title: "Add Remind",
        notifications: 4,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: appPagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Text(_selected_date.toString()),
                  const SizedBox(height: 20),
                  AppTextformfield(
                    field_controller: title_controller,
                    errormsg: 'Please enter title',
                    labelText: 'Title',
                    hintText: 'Add a reminder',
                    //isValidate: false,
                  ),
                  AppTextformfield(
                    field_controller: note_controller,
                    errormsg: 'Please enter note',
                    labelText: 'Note',
                    hintText: 'Add a note',
                    isValidate: false,
                  ),
                  AppTextformfield(
                    field_controller: date_controller,
                    errormsg: 'Please enter date',
                    labelText: 'Date',
                    hintText: 'Pick date',
                    suffix: const Icon(Icons.calendar_month),
                    readOnly: true,
                    onTap: _date_picker,
                    //isValidate: false,
                  ),
                  AppTextformfield(
                    field_controller: time_controller,
                    errormsg: 'Please enter time',
                    labelText: 'Time',
                    hintText: 'Pick Time',
                    suffix: const Icon(Icons.watch),
                    readOnly: true,
                    onTap: _time_picker,
                    //isValidate: false,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Remind",
                        style: TextStyle(
                          fontSize: 15,
                          color: appBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 3),
                      DropdownButtonFormField(
                        items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          labelText: 'Remind',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            title_controller.text = '';
                            note_controller.text = '';
                            date_controller.text = '';
                            time_controller.text = '';
                            remind_controller.text = '';
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: appBlack),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: const Text(
                            "Add Task",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
