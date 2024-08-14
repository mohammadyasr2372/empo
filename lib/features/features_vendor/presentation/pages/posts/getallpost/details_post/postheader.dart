import 'package:flutter/material.dart';

import '../../../../../data/models/posts_models/post_model/getall_post_model.dart';

class PostHeader extends StatelessWidget {
  final DataGetAllPostModel dataPost;
  final bool isVendor;

  const PostHeader({required this.dataPost, required this.isVendor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
          .copyWith(right: 0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundImage: dataPost.images.first.url!.isNotEmpty
                ? NetworkImage('http://localhost:3000/${dataPost.images.first.url!.split('/').last}')
                : AssetImage('assets/images/photo1.jpg') as ImageProvider,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    dataPost.shopperId.first.eventName!.isNotEmpty
                        ? dataPost.shopperId.first.eventName!
                        : 'No event name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          if (!isVendor)
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
    );
  }
}
