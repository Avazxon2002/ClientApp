import 'dart:io';

import 'package:client/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_services.dart';

class PostDetail extends StatelessWidget{
  final Post post;
  final HttpService httpService = HttpService();

  PostDetail({Key? key, required this.post,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(post.name),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.delete),
        onPressed: () async{
        httpService.deletePost(post.id);
        Navigator.of(context).pop();
      },),
      body: SingleChildScrollView(
        child:
        Padding(padding: EdgeInsets.all(12.0),
        child: Card(
          child: Column(
            children: <Widget> [

              //name
              ListTile(
                title: const Text("Name"),
                subtitle: Text(post.name),
              ),

              //id
              ListTile(
                title: const Text("ID"),
                subtitle: Text("${post.id}"),
              ),

              //nitro
              ListTile(
                title: const Text("Nitro"),
                subtitle: Text((post.nitro).toString()),

              ),
            ],
          ),
        ),),
      ),
    );
  }

}