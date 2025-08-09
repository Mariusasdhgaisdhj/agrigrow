class User {
  String? sId;
  String? name;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
        this.name,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
     if (json['__v'] is int) {
      iV = json['__v'];
    } else if (json['__v'] != null) {
      iV = int.tryParse(json['__v'].toString());
    } else {
      iV = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}