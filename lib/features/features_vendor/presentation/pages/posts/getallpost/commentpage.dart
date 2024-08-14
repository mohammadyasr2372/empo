// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../data/models/posts_models/comment_model/addcomment_model.dart';
import '../../../../data/models/posts_models/comment_model/getcomment_model.dart';
import '../../../../data/models/user_model/comment_model/commentModel.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  late UserDatasourceImp UserDatasource;
  bool isLoading = true;
  String? errorMessage;
  CommenModel? Comment;
  CommentPostIDModel? CommentPostID;
  AddcommentModel? Addcomment;
  String? content_comment;

  @override
  void initState() {
    super.initState();
    UserDatasource = UserDatasourceImp(dio: Dio());
    Getpostcomment();
  }

  Future<void> Getpostcomment() async {
    try {
      final response = await UserDatasource.getpostcomment(widget.postId);
      setState(() {
        Comment = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error posting comment: $e';
      });
    }
  }

  Future<void> postcomment({required String content_comment}) async {
    try {
      final response =
          await UserDatasource.createcomment(content_comment, widget.postId);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error posting comment: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : ListView.builder(
                  itemCount: Comment!.data!.info.length,
                  itemBuilder: (ctx, index) {
                    return CommentCard(
                      comment: Comment!.data!.info[index],
                    );
                  },
                ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 47, 3, 81),
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    Comment!.data!.info.first.userId!.id ??
                        'https://via.placeholder.com/150'),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    style: TextStyle(color: Color.fromARGB(255, 254, 253, 253)),
                    controller: commentEditingController,
                    decoration: InputDecoration(
                      hintText:
                          'Add Comment as ${Comment!.data!.info.first.userId!.name}',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await postcomment(
                      content_comment: commentEditingController.text);
                },
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
  final InfoComment comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              comment.userId!.name ?? 'https://via.placeholder.com/150',
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
                        comment.userId!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 130, 5, 225),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        DateFormat.yMMMd().format(
                          comment.createdAt!,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      comment.contentComment!,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
