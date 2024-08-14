// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../../data/data_source/posts_data_source/posts_datasource.dart';

import '../../../../data/models/posts_models/post_model/getall_post_model.dart';
import 'postcard.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostdatasourceImpl postDatasource;
  ReportGetAllPostsModle? posts;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    postDatasource = PostdatasourceImpl(dio: Dio());
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final fetchedPosts = await postDatasource.getallposts_datasource();
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching posts: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : posts != null && posts!.dataPost.isNotEmpty
                  ? ListView.builder(
                      itemCount: posts!.dataPost.length,
                      itemBuilder: (context, index) {
                        return PostCard(
                          post: posts!.dataPost[index],
                          isVendor: false,
                        );
                      },
                    )
                  : const Center(child: Text('No posts found')),
    );
  }
}
