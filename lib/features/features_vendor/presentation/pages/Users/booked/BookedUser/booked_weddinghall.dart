import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../../data/models/user_model/booked/booked_wedding_user_model.dart'; // استيراد مكتبة intl



class MyAppp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Booking App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: TableBookingScreen(),
    );
  }
}

class TableBookingScreen extends StatefulWidget {
  @override
  _TableBookingScreenState createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  DateTime selectedDate = DateTime.now();
  int numberOfTables = 1;
  final Dio dio = Dio();
  final UserDatasourceImp userDatasource = UserDatasourceImp(dio: Dio());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _bookTable() async {
    final bookedWeddingUser = BookedWeddingUserModel(
      dateBooked: selectedDate,
      numberChairBooked: numberOfTables.toString(),
    );

    try {
      await userDatasource.bookedweddinghall(bookedWeddingUser, '66bad2dbd2444c96d5e328ff');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Table booked successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

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
                Text('Number of Chair:',
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
