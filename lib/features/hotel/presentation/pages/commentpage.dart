// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  List<Map<String, String>> comments = [];

  void postComment(String uid, String name, String profilePic) {
    if (commentEditingController.text.isNotEmpty) {
      setState(() {
        comments.add({
          'uid': uid,
          'name': name,
          'profilePic': profilePic,
          'comment': commentEditingController.text,
        });
        commentEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = {
      'uid': 'user123',
      'username': 'TestUser',
      'photoUrl': 'https://via.placeholder.com/150',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (ctx, index) {
          return CommentCard(
            snap: comments[index],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 47, 3, 81),
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user['photoUrl']!),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 254, 253, 253)),
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Add Comment as ${user['username']}',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => postComment(
                  user['uid']!,
                  user['username']!,
                  user['photoUrl']!,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Color.fromARGB(255, 254, 254, 254),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Map<String, String> snap; // تعديل نوع البيانات إلى Map<String, String>
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              snap['profilePic']!,
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        snap['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 130, 5, 225),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Text(
                      //   DateFormat.yMMMd().format(
                      //     DateTime.now(),
                      //   ),
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      snap['comment']!,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Icon(
          //     Icons.favorite,
          //     size: 16,
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // تأكد من إضافة هذا الاستيراد

// class CommentCard extends StatelessWidget {
//   final Map<String, String> snap; // تعديل نوع البيانات إلى Map<String, String>
//   const CommentCard({Key? key, required this.snap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(
//               snap['profilePic']!,
//             ),
//             radius: 18,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: snap['name'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black, // لون النص باللون الأسود
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' ${snap['comment']}', // تغيير المفتاح إلى 'comment'
//                           style: const TextStyle(
//                             color: Colors.black, // لون النص باللون الأسود
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       DateFormat.yMMMd().format(
//                         DateTime.now(), // استخدام التاريخ الحالي كمثال
//                       ),
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.black, // لون النص باللون الأسود
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             child: const Icon(
//               Icons.favorite,
//               size: 16,
//               color: Colors.black, // لون الأيقونة باللون الأسود
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CommentsScreen extends StatefulWidget {
//   final postId;
//   const CommentsScreen({Key? key, required this.postId}) : super(key: key);

//   @override
//   _CommentsScreenState createState() => _CommentsScreenState();
// }

// class _CommentsScreenState extends State<CommentsScreen> {
//   final TextEditingController commentEditingController =
//       TextEditingController();

//   void postComment(String username, String profilePic) {
//     setState(() {
//       // Add a comment to a local list
//       comments.add({
//         'name': username,
//         'profilePic': profilePic,
//         'comment': commentEditingController.text,
//         'datePublished': DateTime.now().toString(),
//       });
//       commentEditingController.text = "";
//     });
//   }

//   final List<Map<String, String>> comments = [];

//   @override
//   Widget build(BuildContext context) {
//     final user = {
//       'username': 'Test User',
//       'photoUrl': 'https://via.placeholder.com/150',
//     };

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           'Comments',
//         ),
//         centerTitle: false,
//       ),
//       body: ListView.builder(
//         itemCount: comments.length,
//         itemBuilder: (ctx, index) => CommentCard(
//           snap: comments[index],
//         ),
//       ),
//       // text input
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: kToolbarHeight,
//           margin:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           padding: const EdgeInsets.only(left: 16, right: 8),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(user['photoUrl']!),
//                 radius: 18,
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 8),
//                   child: TextField(
//                     style: TextStyle(color: Colors.black), // تغيير لون النص إلى الأسود
//                     controller: commentEditingController,
//                     decoration: InputDecoration(
//                       hintText: 'Add Comment as ${user['username']}',
//                       hintStyle: TextStyle(color: Colors.grey), // لون النص التلميحي
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () => postComment(
//                   user['username']!,
//                   user['photoUrl']!,
//                 ),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                   child: const Text(
//                     'Post',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
