// ignore_for_file: unnecessary_null_comparison, unused_local_variable, unnecessary_import, use_super_parameters, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_declarations, avoid_print, prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../../core/strings/constans.dart';
import '../../../../data/data_source/User_Shopper_datasource/user_datasource.dart';
import '../../../../data/models/posts_models/like_model/addlike_model.dart';
import '../../../../data/models/posts_models/post_model/getall_post_model.dart';
import '../../../widgets/like_animation.dart';
import 'commentpage.dart';

class PostCard extends StatefulWidget {
  final DataGetAllPostModel post;
  final bool isVendor;

  const PostCard({
    Key? key,
    required this.post,
    required this.isVendor,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int? likeCount;
  bool isLike = false;
  bool isLikeAnimating = false;
  bool isLoading = true;
  String? errorMessage;
  UserDatasourceImp postDatasource = UserDatasourceImp(dio: Dio());
  int _currentImageIndex = 0;
  var addrepor;
  ReportAddLikeMo? ReportAddLike;
  @override
  void initState() {
    super.initState();
    fetchLikeCount();
  }

  Future<void> fetchLikeCount() async {
    try {
      final getlike = await postDatasource.getlike_d(widget.post.id!);
      setState(() {
        if (getlike.counterLikes != null) {
          likeCount = getlike.counterLikes!;
          isLike = false;
        } else {
          errorMessage = 'Invalid like data received';
        }
        isLoading = false;
      });
    } catch (e) {
      // setState(() {
      //   errorMessage = 'Error fetching likes: $e';
      //   isLoading = false;
      // });
    }
  }

  // Future<void> fetchLike() async {
  //   try {
  //     final addResponse = await postDatasource.addlike_d(widget.post.id!);
  //     if (addResponse.success!) {
  //       setState(() {
  //         isLike = addResponse.boolLike!;
  //       });
  //     } else {
  //       errorMessage = 'Failed to add like: ${addResponse.message}';
  //       errorMessage = 'Failed to add like: ${addResponse.boolLike!}';
  //     }
  //   } catch (e) {
  //     setState(() {
  //       errorMessage = 'Error fetching likes: $e';
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> toggleLike() async {
    try {
      if (isLike) {
        final deleteResponse =
            await postDatasource.deletelike_d(widget.post.id!);
        if (deleteResponse.success!) {
          setState(() {
            isLike = false;

            likeCount = (likeCount ?? 0) - 1;
          });
        } else {
          errorMessage = 'Failed to delete like: ${deleteResponse.message}';
        }
      } else {
        final addResponse = await postDatasource.addlike_d(widget.post.id!);
        if (addResponse.success!) {
          setState(() {
            isLike = true;
            ReportAddLike = addResponse;
            likeCount = (likeCount ?? 0) + 1;
          });
        } else {
          errorMessage = 'Failed to add like: ${addResponse.message}';
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error toggling like: $e';
      });
    }
  }

  Future<void> reportshopper() async {
    try {
      final report = await postDatasource.addreport_d(
          reason: 'it does things outside the rules of the application',
          shopperId: widget.post.shopperId.first.id!,
          postId: widget.post.id!);
      setState(() {
        addrepor = report;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching likes: $e';
        isLoading = false;
      });
    }
  }

  bool isBookmarked = false;

  Future<void> addFavorite(String id) async {
    try {
      setState(() {
        isLoading = true;
      });
      final report = await postDatasource.AddFavorite(id);
      setState(() {
        isBookmarked = true; // تغيير حالة الأيقونة عند الإضافة للمفضلة
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error adding to favorites: $e';
        isLoading = false;
      });
    }
  }

  Future<void> sharePostDetails() async {
    try {
      const String shopName = "اسم المحل";
      const String postDetails = "هذه هي تفاصيل المنتج المتوفرة في المحل.";
      const String appUrl = "https://example.com/download-app";

      // نص المشاركة
      final String shareText = """
      اسم المحل: $shopName
      تفاصيل: $postDetails
      رابط التطبيق: $appUrl
    """;

      // مشاركة النص فقط
      await Share.share(shareText);
    } catch (e) {
      print('Error sharing post: $e');
    }
  }

  Future<void> sharePostDetailsD(String postId) async {
    try {
      // رابط ديناميكي مخصص يتضمن postId
      final String dynamicLink =
          "https://exampleapp.page.link/?link=https://example.com/post?postId=$postId&apn=com.example.app&ibi=com.example.ios";

      // نص المشاركة
      final String shareText = "تحقق من هذا البوست في تطبيقنا: $dynamicLink";

      // مشاركة الرابط
      await Share.share(shareText);
    } catch (e) {
      print('Error sharing post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 229, 229, 245)),
        color: Color.fromARGB(255, 70, 101, 143),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: (widget.post.shopperId.isNotEmpty &&
                          widget.post.shopperId.first.image != null)
                      ? NetworkImage(
                          '$BASE_URL/${widget.post.shopperId.first.image!.split('/').last}')
                      : AssetImage('assets/image/photo.jpg') as ImageProvider,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.post.shopperId.isNotEmpty &&
                                  widget.post.shopperId.first.eventName != null
                              ? widget.post.shopperId.first.eventName!
                              : 'No event name',
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
                                      onTap: () async {
                                        await reportshopper();
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
            onDoubleTap: () async {
              await toggleLike();
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: PageView.builder(
                    itemCount: widget.post.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      print(
                          '$BASE_URL/${widget.post.images[index].url!.split('/').last}');
                      return Container(
                        width: double.infinity,
                        child: Image.network(
                          '$BASE_URL/${widget.post.images[index].url!.split('/').last}',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.post.images.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
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
                isAnimating: isLike,
                smallLike: true,
                child: IconButton(
                  icon: isLike
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () async {
                    await toggleLike();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.post.id!,
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
                onPressed: () {
                  sharePostDetailsD(widget.post.id!);
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      isBookmarked
                          ? Icons
                              .bookmark // تغيير الأيقونة إذا كانت مضافة للمفضلة
                          : Icons.bookmark_border,
                      color: isBookmarked ? Colors.white : Colors.white,
                    ),
                    onPressed: () async {
                      await addFavorite(widget.post.id!);
                    },
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
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      'Counter like ${likeCount ?? '0'}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w200),
                  child: Text(
                    widget.post.title ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    widget.post.content ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        TextSpan(
                          text: '',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all ${widget.post.commentCount} comments',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  onTap: () {},
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    widget.post.createdAt.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
