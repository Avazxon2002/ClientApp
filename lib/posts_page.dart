import 'dart:io';

import 'package:client/data_model.dart';
import 'package:client/data_services.dart';
import 'package:client/post_detail..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  _showFromDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[

          FlatButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'), textColor: Colors.blue,
          ),

          FlatButton(onPressed: (){},
            child: const Text('Save'), textColor: Colors.blue,
          ),

        ],

        // EditText
        title: const Text('Categories From'),
        content: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Write a category name',
                  labelText: 'Category'
                ),
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Write a description',
                  labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),

      //float actionbar
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed: (){
        _showFromDialog(context);
      },
      ),



      // DON'T TOUCH
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