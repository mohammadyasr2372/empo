// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../data/models/posts_models/post_model/getall_post_model.dart';
import '../../../../widgets/like_animation.dart';
import '../commentpage.dart';

class PostActions extends StatelessWidget {
  final bool isLiked;
  final Function toggleLike;

  PostActions({
    super.key,
    required this.isLiked,
    required this.toggleLike,
  });
  DataGetAllPostModel? dataPost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        LikeAnimation(
          isAnimating: isLiked,
          smallLike: true,
          child: IconButton(
            icon: isLiked
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () => toggleLike(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.comment_outlined, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommentsScreen(
                postId: dataPost!.id!,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
