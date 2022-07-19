class SignUpBody {
  String nome;
  String email;
  String data_nascimento;
  String password;
  String genero;

  SignUpBody({
    String this.nome = '',
    String this.email = '',
    String this.password = '',
    String this.data_nascimento = '',
    String this.genero = '',
  });

  void fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    nome = json['nome'];
    data_nascimento = json['data_nascimento'];
    genero = json['genero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['password'] = this.password;
    data['data_nascimento'] = this.data_nascimento;
    data['genero'] = this.genero;
    return data;
  }
}
