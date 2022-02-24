import 'dart:io';
import 'package:client/data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:client/data_services.dart';
import 'package:client/post_detail..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();

  HttpService postService = HttpService();

  _showFromDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[

          FlatButton(
              onPressed: () {
                Navigator.pop(context); print('Canceled');
                },
              child: const Text('Cancel'), textColor: Colors.grey,
          ),

          FlatButton(onPressed: () async {
            Map<String, dynamic> data = {

              "name" : (Post post) => ListTile(title: Text(post.name),),
              "description" : (Post post) => ListTile(title: Text(post.id.toString()),)
            };
            //make request
            String res = await postService.createPost(data);
            //wait for response
            //show toast
            res == "Success"?
            Fluttertoast.showToast(msg: "Post created successfully"):
            Fluttertoast.showToast(msg: "Error post created");
            Navigator.of(context).pop();
            //
          },
            child: const Text('Save'), textColor: Colors.blue,
          ),

        ],

        // EditText
        title: const Text('Categories From'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Write a category name',
                  labelText: 'Category'
                ),
              ),

              TextField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
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
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),
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
          } else{
            return const Center(
              child: Text('Error networking'),
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