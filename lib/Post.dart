class Post {
  final String user_name;
  final String service_id;
  final String user_login_key;
  final String user_pwd;

  Post({ this.user_name,  this.service_id,  this.user_login_key,  this.user_pwd});

  factory Post.fromJson(Map json) {
    return Post(
      user_name: json['user_name'],
      service_id: json['service_id'],
      user_login_key: json['user_login_key'],
      user_pwd: json['user_pwd'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["user_name"] = user_name;
    map["service_id"] = service_id;
    map["user_login_key"] = user_login_key;
    map["user_pwd"] = user_pwd;

    return map;
  }
}