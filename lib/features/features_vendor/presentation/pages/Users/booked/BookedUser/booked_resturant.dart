import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart'; // استيراد مكتبة intl

import '../../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../../data/models/user_model/booked/booked_resturant_user_model.dart'; // استيراد مكتبة Dio

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int numberOfTables = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 20, minute: 0);
  final Dio dio = Dio(); // إنشاء مثيل من Dio
  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  Future<void> _bookTable() async {
    final bookedResturantUser = BookedResturantUserModel(
      numberTableBooked: numberOfTables.toString(),
      dateBooked: selectedDate,
      startTime: _formatTimeOfDay(startTime), // تنسيق startTime
      endTime: _formatTimeOfDay(endTime), // تنسيق endTime
    );

    try {
      await userDatasource.bookedrsturant(
          bookedResturantUser, '66b8b9e5a11f374d724ae764');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Table booked successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm')
        .format(DateTime(now.year, now.month, now.day, time.hour, time.minute));
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate); // تنسيق التاريخ هنا

    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Table', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, color: Colors.purple, size: 30),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: Text(
                    'Select Booking Date',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.purple, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Selected Booking Date: $formattedDate',
                        style: TextStyle(fontSize: 18, color: Colors.purple),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Start Time:', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () => _selectTime(context, true),
                    child: Text(startTime.format(context)),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Icon(Icons.arrow_forward, color: Colors.purple, size: 24),
              SizedBox(width: 20),
              Column(
                children: [
                  Text('End Time:', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () => _selectTime(context, false),
                    child: Text(endTime.format(context)),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.purple, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Number of Tables:',
                    style: TextStyle(fontSize: 16, color: Colors.purple)),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (numberOfTables > 0) numberOfTables--;
                    });
                  },
                  icon: Icon(Icons.remove),
                  color: Colors.purple,
                ),
                SizedBox(width: 10),
                Text(
                  '$numberOfTables',
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      numberOfTables++;
                    });
                  },
                  icon: Icon(Icons.add),
                  color: Colors.purple,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _bookTable,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text('Book Table', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
