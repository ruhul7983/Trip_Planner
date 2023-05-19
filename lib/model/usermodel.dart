class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.image,
  });
  late final String name;
  late final String email;
  late final String image;

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name']??'';
    email = json['email']??'';
    image = json['image']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}