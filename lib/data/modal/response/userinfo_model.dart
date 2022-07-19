class UserInfoModel {
  String email = '';
  String data_nascimento = '';
  String genero = '';
  String name = '';
  String sobrenome = '';
  String password = '';
  String image = '';

  UserInfoModel({
    this.email = '',
    this.data_nascimento = '',
    this.genero = '',
    this.name = '',
    this.sobrenome = '',
    this.password = '',
    this.image = '',
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    data_nascimento = json['data_nascimento'];
    genero = json['genero'];
    name = json['name'];
    sobrenome = json['sobrenome'] ?? '';
    password = json['password'] ?? '';
    image = json['image'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['data_nascimento'] = data_nascimento;
    data['genero'] = genero;
    data['name'] = name;
    data['sobrenome'] = sobrenome;
    data['password'] = password;
    data['image'] = image;
    return data;
  }
}
