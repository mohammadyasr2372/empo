import 'package:flutter/material.dart';

// ر// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp2());
// }
//
// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Booking Resturant'),
//         ),
//         body: Container(margin: EdgeInsets.all(10),decoration:BoxDecoration(boxShadow:[BoxShadow(color: Colors.grey.shade500,offset:Offset(4.0,4.0),blurRadius:1.0  )] ,borderRadius:BorderRadius.circular(15),) ,padding: EdgeInsets.all(10),width: 600,height: 150,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // صورة البروفايل واسم المستخدم
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: AssetImage('assets/profile_image.png'), // مسار صورة البروفايل
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'User name',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               // عمودين للمعلومات الأخرى
//
//                   Container(margin:EdgeInsets.only(right: 10) ,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Number of chair : 4',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Price of booking : 100',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Booking of day: 12 أغسطس 2024',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Clock of starting: 7:00 م',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Clock of end : 9:00 م',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp2());
// }

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BookingListScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// نموذج بيانات الحجز
class Booking {
  final String userName;
  final String profileImage;
  final int numberOfChairs;
  final double bookingPrice;
  final DateTime bookingDate;
  final String startTime;
  final String endTime;

  Booking({
    required this.userName,
    required this.profileImage,
    required this.numberOfChairs,
    required this.bookingPrice,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
  });
}

// واجهة عرض قائمة الحجز
class BookingListScreen extends StatelessWidget {
  final List<Booking> bookings = [
    Booking(
      userName: 'User 1',
      profileImage: 'assets/profile_image.png',
      numberOfChairs: 4,
      bookingPrice: 100.0,
      bookingDate: DateTime(2024, 8, 12),
      startTime: '7:00 م',
      endTime: '9:00 م',
    ),
    Booking(
      userName: 'User 2',
      profileImage: 'assets/profile_image.png',
      numberOfChairs: 3,
      bookingPrice: 75.0,
      bookingDate: DateTime(2024, 8, 13),
      startTime: '8:00 م',
      endTime: '10:00 م',
    ),
    // أضف المزيد من الحجوزات هنا
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Restaurant'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return BookingItem(booking: booking);
        },
      ),
    );
  }
}

// واجهة عنصر الحجز
class BookingItem extends StatelessWidget {
  final Booking booking;

  BookingItem({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(4.0, 4.0),
            blurRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // صورة البروفايل واسم المستخدم
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(booking.profileImage),
              ),
              SizedBox(height: 8),
              Text(
                booking.userName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // عمودين للمعلومات الأخرى
          Container(
            padding: EdgeInsets.only(left: 320),
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Number of chairs: ${booking.numberOfChairs}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Price of booking: \$${booking.bookingPrice}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking day: ${booking.bookingDate.day}-${booking.bookingDate.month}-${booking.bookingDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Start time: ${booking.startTime}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'End time: ${booking.endTime}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
