// ignore_for_file: unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/strings/constans.dart';
import '../../../../injection_container.dart';
import '../../../../injection_container.dart' as di;
import '../../../auth/data/data_sources/remote/shopper_api_service.dart';
import '../../../auth/data/model/createchargewallet_model.dart';
import '../../../auth/presentation/bloc/shopper/bloc/shopper_bloc.dart';
import '../../data/data_source/User_Shopper_datasource/shopper_datasource.dart';
import '../../data/data_source/posts_data_source/posts_datasource.dart';
import '../../data/models/posts_models/post_model/getall_post_model.dart';
import '../../data/models/user_model/wallat/createchargewallet_model.dart';
import 'posts/getallpost/postcard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ReportGetAllPostsModle? ReportGetAllPosts;
  num walletBalance = 0;
  @override
  void initState() {
    super.initState();
    _getWalletBalance();
    _getmypost(); // Fetch wallet balance when the screen is loaded
  }

  Future<void> _getWalletBalance() async {
    try {
      final response = await sl<ShopperApiService>().GetWallet();
      setState(() {
        walletBalance = response.money?.toDouble() ?? 0.0;
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_ID_Wallet, response.data!);
      });
    } catch (e) {
      // _showErrorDialog('Failed to get wallet balance. Please try again.');
    }
  }

  Future<void> _getmypost() async {
    try {
      final response = await sl<ShopperApiService>().getMyposts_datasource();
      setState(() {
        ReportGetAllPosts = response;
      });
    } catch (e) {}
  }

  void _showRechargeDialog() {
    TextEditingController amountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Recharge Wallet'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Enter amount to recharge'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Enter password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _confirmRecharge(
                    amountController.text, passwordController.text);
              },
              child: const Text('Recharge Wallet'),
            ),
          ],
        );
      },
    );
  }

  void _confirmRecharge(String amount, String password) {
    if (password.isEmpty || amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password or amount should not be empty')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Recharge'),
          content: Text(
              'Are you sure you want to recharge the wallet with \$${amount}?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await sl<ShopperApiService>().chargeWallet(
                    chargewallet: CreatechargewalletModel(
                      password: password,
                      rechargeMoney: amount,
                      walteId: di.sl
                          .get<SharedPreferences>()
                          .getString(CACHED_ID_Wallet),
                    ),
                  );
                  await _getWalletBalance(); // Refresh the balance after recharging
                } catch (e) {
                  _showErrorDialog(
                      'Failed to recharge wallet. Please try again.');
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ShopperBloc>()..add(GetProShopperEvent()),
      child: BlocConsumer<ShopperBloc, GetShopperState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadedProGetShopperState) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 88, 24, 109),
                      ),
                      child: Text(
                        'photoUrl',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favorites'),
                      onTap: () {
                        // Add favorites functionality here
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.wallet),
                      title: const Text('Charge Wallet'),
                      onTap: () {
                        _showRechargeDialog(); // Show the recharge dialog when tapped
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign Out'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(
                                        state.getProShopperModel.reportCount,
                                        "posts"),
                                    buildStatColumn(
                                        state.getProShopperModel.avager_star,
                                        "Like"),
                                    GestureDetector(
                                      onTap: () {
                                        _showRechargeDialog(); // Show the recharge dialog when tapped
                                      },
                                      child: Container(
                                        width: 130,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          // color: Color.fromARGB(255, 254, 252, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              Icons.wallet,
                                              size: 40,
                                              color: Color.fromARGB(
                                                  255, 88, 24, 109),
                                            ),
                                            // const SizedBox(height: 5),
                                            Text(
                                              '\$$walletBalance',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 129, 125, 125),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FollowButton(
                                      text: 'Update profile',
                                      backgroundColor: const Color.fromARGB(
                                          255, 85, 52, 103),
                                      textColor: Colors.white,
                                      borderColor: Colors.grey,
                                      function: () {
                                        // Add update profile functionality here
                                      },
                                    ),
                                    FollowButton(
                                      text: 'Charge Wallet',
                                      backgroundColor: const Color.fromARGB(
                                          255, 85, 52, 103),
                                      textColor: Colors.white,
                                      borderColor: Colors.grey,
                                      function: () {
                                        _showRechargeDialog(); // Show the recharge dialog when tapped
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 60,
                                )
                                // Align(
                                //   alignment: Alignment.topLeft,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: GestureDetector(
                                //       onTap: () {
                                //         _showRechargeDialog(); // Show the recharge dialog when tapped
                                //       },
                                //       child: Container(
                                //         width: 130,
                                //         padding: const EdgeInsets.all(8.0),
                                //         decoration: BoxDecoration(
                                //           color: const Color.fromARGB(255, 85, 52, 103),
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         child: Column(
                                //           children: [
                                //             const Icon(
                                //               Icons.wallet,
                                //               size: 40,
                                //               color: Colors.grey,
                                //             ),
                                //             const SizedBox(height: 5),
                                //             Text(
                                //               '\$$walletBalance',
                                //               style: const TextStyle(
                                //                 color:
                                //                     Color.fromARGB(255, 252, 251, 251),
                                //                 fontWeight: FontWeight.bold,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, bottom: 10),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                    'photoUrl',
                                  ),
                                  radius: 40,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 4, bottom: 7),
                                child: Text(
                                  'username',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Padding(
                                padding: EdgeInsets.only(left: 4, bottom: 40),
                                child: Text(
                                  'bio',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 88, 24, 109),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  width: 70,
                                  height: 40,
                                  child: const Text(
                                    'Go To Details',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 246, 246, 247),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  ReportGetAllPosts == null
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ReportGetAllPosts!.dataPost.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            final post = ReportGetAllPosts!.dataPost[index];
                            final imageUrl = post.images.first.url;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailsScreen(
                                      post: post,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                child: Image.network(
                                  'http://localhost:3000/${imageUrl!.split('/').last}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(state.toString()),
            );
          }
        },
      ),
    );
  }

  Column buildStatColumn(num num1, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num1.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 88, 24, 109),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 123, 122, 122),
            ),
          ),
        ),
      ],
    );
  }
}

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const FollowButton({
    Key? key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2.8,
        height: 40,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//

class PostDetailsScreen extends StatefulWidget {
  final DataGetAllPostModel post; // تغيير النوع إلى كائن البوست

  const PostDetailsScreen({super.key, required this.post});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: PostCard(
        post: widget.post, // عرض البوست المحدد فقط
        isVendor: false,
      ),
    );
  }
}
// class PostDetailsScreen extends StatefulWidget {
//   final List<DataGetAllPostModel> posts; // قائمة البوستات
//   final int initialIndex; // الفهرس المبدئي

//   PostDetailsScreen(
//       {super.key, required this.posts, required this.initialIndex});

//   @override
//   _PostDetailsScreenState createState() => _PostDetailsScreenState();
// }

// class _PostDetailsScreenState extends State<PostDetailsScreen> {
//   late PostdatasourceImpl postDatasource;
//   ReportGetAllPostsModle? posts;
//   bool isLoading = true;
//   String? errorMessage;
//   ShopperId? Shopper;
//   @override
//   void initState() {
//     super.initState();
//     postDatasource = PostdatasourceImpl(dio: Dio());
//     fetchPosts();
//     super.initState();
//     // إنشاء ScrollController
//     _scrollController = ScrollController();
//     // الانتقال إلى البوست المحدد بعد أن يتم بناء الـ ListView
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.jumpTo(
//         _scrollController.position.maxScrollExtent *
//             (widget.initialIndex / widget.posts.length),
//       );
//     });
//   }

//   late ScrollController _scrollController;

//   final ShopperDatasourceImp shopperDatasource =
//       ShopperDatasourceImp(dio: Dio());
//   Future<void> fetchPosts() async {
//     try {
//       final fetchedPosts = await shopperDatasource.getMyposts_datasource();
//       setState(() {
//         posts = fetchedPosts;
//         // widget.DataGetAllPost = posts!.dataPost.first.id!;

//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error fetching posts: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : posts != null && posts!.dataPost.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: posts!.dataPost.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             // عند الضغط على المنشور، انتقل إلى صفحة PostCard
//                           },
//                           child: PostCard(
//                             post: posts!.dataPost[index],
//                             isVendor: false,
//                           ),
//                         );
//                       },
//                     )
//                   : Center(child: Text('No posts found')),
//     );
//   }
// }
