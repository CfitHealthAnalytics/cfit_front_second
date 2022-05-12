import 'package:cfit/util/images.dart';

class Job {
  final String company;
  final String logoUrl;
  bool isMark;
  final String title;
  final String location;
  final String time;
  final List<String> req;
  Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);
  static List<Job> generateJobs() {
    return [
      Job(
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

      Job(
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