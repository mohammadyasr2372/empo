import 'package:flutter/material.dart';

import '../../../../../data/models/posts_models/post_model/getall_post_model.dart';

class PostDetails extends StatelessWidget {
  final DataGetAllPostModel dataPost;
  final int likeCount;

  const PostDetails({required this.dataPost, required this.likeCount});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  '$likeCount likes',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
          DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w200),
              child: Text(
                dataPost.title ?? '',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
          DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w800),
              child: Text(
                dataPost.content ?? '',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: '',
                    style: TextStyle(
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
              child: const Text(
                'View all comments',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {},
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              dataPost.createdAt.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
