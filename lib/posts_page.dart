import 'dart:io';

import 'package:client/data_model.dart';
import 'package:client/data_services.dart';
import 'package:client/post_detail..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post>? posts = snapshot.data;

            return ListView(
              children: posts
                  !.map(
                      (Post post) => ListTile(
                    title: Text(post.name),
                    subtitle: Text(post.id.toString(),),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetail(post: post,
                          ),
                          )),
                  )
              )
                  .toList(),
            );
          }

          return const Center(child:
          CircularProgressIndicator(),
          );
        },
      ),
    );
  }

}