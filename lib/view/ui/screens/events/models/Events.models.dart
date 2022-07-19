class EventsModel {
  String? qtd_user;
  String? qtd_max_user;
  String? id;
  bool? status;
  EventsCoordenadas? coordenadas;
  String? bairro;
  String? numero;
  String? cidade;
  String? descricao;
  List? users_confirmation = [];
  String? rua;
  List? users_checkin = [];
  String? nome;
  String? tipo;
  String? created_at;
  String? user_id_create;
  String? horario_de_inicio;

  EventsModel({
    this.id,
    this.qtd_user = '0',
    this.qtd_max_user = '0',
    this.status,
    this.coordenadas,
    this.bairro,
    this.numero,
    this.cidade,
    this.descricao,
    this.users_confirmation,
    this.rua,
    this.users_checkin,
    this.nome,
    this.tipo,
    this.created_at,
    this.user_id_create,
    this.horario_de_inicio,
  });

  EventsModel.fromJson(Map<String, dynamic> json) {
    qtd_user = json['qtd_user'].toString();
    qtd_max_user = json['qtd_max_user'].toString();
    id = json['id'];
    status = json['status'];
    if (json['coordenadas'] != null) {
      coordenadas = EventsCoordenadas.fromJson(json['coordenadas']);
    } else {}
    bairro = json['bairro'];
    numero = json['numero'];
    cidade = json['cidade'];
    descricao = json['descricao'];
    users_confirmation = json['users_confirmation'];
    rua = json['rua'];
    users_checkin = json['users_checkin'] ?? [];
    nome = json['nome'];
    tipo = json['tipo'];
    created_at = json['created_at'];
    user_id_create = json['user_id_create'];
    horario_de_inicio = json['horario_de_inicio'];
  }
}

class EventsModels {
  List<EventsModel> eventos;
  EventsModels(this.eventos);
}

class ListModalidades {
  List<EventModalidade> modalidades;
  ListModalidades(this.modalidades);
}

class EventsCoordenadas {
  double? latitude;
  double? longitude;

  EventsCoordenadas({this.latitude, this.longitude});
  EventsCoordenadas.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}

class EventsUserId {
  String? id;
  EventsUserId({this.id = ''});
  EventsUserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}

class Event {
  final String company;
  final String logoUrl;
  bool isMark;
  final String title;
  final String location;
  final String time;
  final List<String> req;
  Event(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);
  static List<Event> generateJobs() {
    return [
      Event(
        'Corrida recife',
        'assets/images/google_logo.png',
        false,
        'Grupo corrida recife é uma iniciativa para correr pelas ruas de recife e marcamos.. ...',
        'Rua teste, nº 12\nBoa Viagem, Recife - PE',
        '2 horas',
        [
          'Bachelors degree in industrial design, manufacturing, engineering, or a related field.',
          'A creative eye, good imagination, and vision.',
          'A firm grasp of market trends and consumer preferences.',
          'Practical experience using computer-aided design software.',
          'Good technical and IT skills.'
        ],
      ),
      Event(
        'Corrida recife',
        'assets/images/google_logo.png',
        false,
        'Grupo corrida recife é uma iniciativa para correr pelas ruas de recife e marcamos.. ...',
        'Rua teste, nº 12\nBoa Viagem, Recife - PE',
        '2 horas',
        [
          'Bachelors degree in industrial design, manufacturing, engineering, or a related field.',
          'A creative eye, good imagination, and vision.',
          'A firm grasp of market trends and consumer preferences.',
          'Practical experience using computer-aided design software.',
          'Good technical and IT skills.'
        ],
      ),
    ];
  }
}

class EventModalidade {
  String nome = '';
  List<EventsModel>? eventos = [];
  bool statusLoading = false;
  EventModalidade({
    this.nome = '',
    this.eventos,
  });
  EventModalidade.fromJson(Map<String, dynamic> json) {
    nome = json['nome'] ?? '';
    eventos = json['eventos'] ?? [];
  }
}
