// import 'package:flutter/material.dart';

// import 'like_animation.dart';

// class PostCard extends StatefulWidget {
//   final snap;
//   const PostCard({
//     Key? key,
//     required this.snap,
//   }) : super(key: key);

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   int commentLen = 0;
//   bool isLikeAnimating = false;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   fetchCommentLen();
//   // }

//   // fetchCommentLen() async {
//   //   try {
//   //     QuerySnapshot snap = await FirebaseFirestore.instance
//   //         .collection('posts')
//   //         .doc(widget.snap['postId'])
//   //         .collection('comments')
//   //         .get();
//   //     commentLen = snap.docs.length;
//   //   } catch (err) {
//   //     showSnackBar(
//   //       context,
//   //       err.toString(),
//   //     );
//   //   }
//   //   setState(() {});
//   // }

//   // deletePost(String postId) async {
//   //   try {
//   //     await BlocProvider.of<PostBloc>(context).deletePost.delete(postId);
//   //   } catch (err) {
//   //     showSnackBar(
//   //       context,
//   //       err.toString(),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // Users user = BlocProvider.of<AuthBloc>(context).getUserdetailss.getuser() as Users;

//     //final Users user = Provider.of<UserProvider>(context).getUser;
//     final width = MediaQuery.of(context).size.width;

//     return Container(
//       // boundary needed for web
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black
//         ),
//         color:Colors.black ,
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       child: Column(
//         children: [
//           // HEADER SECTION OF THE POST
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 4,
//               horizontal: 16,
//             ).copyWith(right: 0),
//             child: Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundImage: NetworkImage(
//                     widget.snap['profImage'].toString(),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                          'das',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // widget.snap['uid'].toString() == user.uid
//                      IconButton(
//                         onPressed: () {
//                           showDialog(
//                             useRootNavigator: false,
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 child: ListView(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 16),
//                                   shrinkWrap: true,
//                                   children: [
//                                     'Delete',
//                                   ]
//                                       .map(
//                                         (e) => InkWell(
//                                             child: Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 12,
//                                                       horizontal: 16),
//                                               child: Text(e),
//                                             ),
//                                             onTap: () {
//                                               // deletePost(
//                                               //   widget.snap['postId']
//                                               //       .toString(),
//                                               // );
//                                               // remove the dialog box
//                                               Navigator.of(context).pop();
//                                             }),
//                                       )
//                                       .toList(),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         icon: const Icon(Icons.more_vert),
//                       ),
//                      Container(),
//               ],
//             ),
//           ),
//           // IMAGE SECTION OF THE POST
//           GestureDetector(
//             onDoubleTap: () {
//               // BlocProvider.of<PostBloc>(context).likePost.likeposts(
//               //       widget.snap['postId'].toString(),
//               //       user.uid,
//               //       widget.snap['likes'],
//               //     );
//               // setState(() {
//               //   isLikeAnimating = true;
//               // });
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   width: double.infinity,
//                   child: Image.network(
//                     widget.snap['postUrl'].toString(),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 AnimatedOpacity(
//                   duration: const Duration(milliseconds: 200),
//                   opacity: isLikeAnimating ? 1 : 0,
//                   child: LikeAnimation(
//                     isAnimating: isLikeAnimating,
//                     duration: const Duration(
//                       milliseconds: 400,
//                     ),
//                     onEnd: () {
//                       setState(() {
//                         isLikeAnimating = false;
//                       });
//                     },
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // LIKE, COMMENT SECTION OF THE POST
//           Row(
//             children: <Widget>[

// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_super_parameters

//               LikeAnimation(
//                 isAnimating: true,
//                 smallLike: true,
//                 child: IconButton(
//                     icon: isLikeAnimating==true
//                         ? const Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           )
//                         : const Icon(
//                             Icons.favorite_border,
//                           ),
//                     onPressed: () {}
//                         // BlocProvider.of<PostBloc>(context).add(LikePostEvent(
//                         //   likes: widget.snap['likes'],
//                         //   postId: user.uid,
//                         //   uid: widget.snap['postId'].toString(),
//                         // ))
//                     //  BlocProvider.of<PostBloc>(context).likePost.likeposts(
//                     // widget.snap['postId'].toString(),
//                     // user.uid,
//                     // widget.snap['likes'],
//                     // ),
//                     ),
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.comment_outlined,
//                 ),
//                 onPressed: () {}
//                 // Navigator.of(context).push(
//                 //   MaterialPageRoute(
//                 //     builder: (context) => CommentsScreen(
//                 //       postId: widget.snap['postId'].toString(),
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//               IconButton(
//                   icon: const Icon(
//                     Icons.send,
//                   ),
//                   onPressed: () {}),
//               Expanded(
//                   child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: IconButton(
//                     icon: const Icon(Icons.bookmark_border), onPressed: () {}),
//               ))
//             ],
//           ),
//           //DESCRIPTION AND NUMBER OF COMMENTS
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 DefaultTextStyle(
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall!
//                         .copyWith(fontWeight: FontWeight.w800),
//                     child: Text(
//                       '${widget.snap['likes'].length} likes',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     )),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(
//                     top: 8,
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(color: Colors.black),
//                       children: [
//                         TextSpan(
//                           text: widget.snap['username'].toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' ${widget.snap['description']}',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     child: Text(
//                       'View all $commentLen comments',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () {}
//                   // Navigator.of(context).push(
//                   //   MaterialPageRoute(
//                   //     builder: (context) => CommentsScreen(
//                   //       postId: widget.snap['postId'].toString(),
//                   //     ),
//                   //   ),
//                   // ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Text('dars',
//                     // DateFormat.yMMMd()
//                     //     .format(widget.snap['datePublished'].toDate()),
//                     style: const TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'commentpage.dart';
import 'hotel/get_hotel/hotel_page.dart';
import '../widgets/like_animation.dart';
import 'profilescreen.dart';

class PostCard extends StatefulWidget {
  final snap;
  final bool isVendor;

  const PostCard({
    Key? key,
    required this.snap,
    required this.isVendor,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/photo1.jpg'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!widget.isVendor)
                  IconButton(
                    onPressed: () {
                      showDialog(
                        useRootNavigator: false,
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: ['Report']
                                  .map(
                                    (e) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.asset(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: true,
                smallLike: true,
                child: IconButton(
                  icon: isLikeAnimating
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CommentsScreen(
                      postId: '',
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon:
                        const Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all $commentLen comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Text(
                    'dars',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PostListScreen(isVendor: false);
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Search Screen', style: TextStyle(color: Colors.white)));
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Favorites Screen', style: TextStyle(color: Colors.white)));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('Account Screen', style: TextStyle(color: Colors.white)));
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    // Searchpage(),
    HotelPage(),
    AccountScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_outlined,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          backgroundColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}

class PostListScreen extends StatelessWidget {
  final bool isVendor;
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'user1',
      'postUrl': 'assets/images/photo1.jpg',
      'likes': [],
      'description': 'Description for image 1'
    },
    {
      'username': 'user2',
      'postUrl': 'assets/images/photo2.jpg',
      'likes': [],
      'description': 'Description for image 2'
    },
  ];

  PostListScreen({super.key, required this.isVendor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(snap: posts[index], isVendor: isVendor);
      },
    );
  }
}
