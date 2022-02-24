class Post{
  final int id;
  final String name;
  final bool nitro;

  Post({
    required this.id,
    required this.name,
    required this.nitro,
});
  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json["id"] as int,
      name: json["name"]as String,
      nitro: json["nitro"] as bool,
    );
  }
}