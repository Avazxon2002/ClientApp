import 'dart:convert';
import 'package:http/http.dart';
import 'data_model.dart';

class HttpService{
  final String baseUrl = "http://192.168.1.104:8080/cars";

  Future<void> deletePost(int id) async {
    Response res = await delete(Uri.parse("$baseUrl/$id"));

    if(res.statusCode == 200){
      print("Deleted!");
    }
  }

  Future<List<Post>> getPosts() async {
    Response res  = await get(Uri.parse(baseUrl));
      if(res.statusCode == 200){
        List<dynamic> body = jsonDecode(res.body);

        List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();   return posts;

      } else {
        throw "Can't get posts";
      //   print(body);
      //   return body.map((e) => DataModel.fromJson(e)).toList();
      // } else {
      //   return <DataModel>[];
      }
    // }catch(e){
    //   print(e);
    //   return <DataModel>[];
    // }
  }

}