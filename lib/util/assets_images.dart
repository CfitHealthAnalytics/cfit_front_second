String getImage(String type) {
  switch (type.toLowerCase()) {
    case 'caminhada':
      return 'assets/images/walking.jpeg';
    case 'corrida':
      return 'assets/images/running.jpeg';
    case 'ciclismo':
      return 'assets/images/cicle.jpeg';
    case 'funcional':
      return 'assets/images/exercise.jpeg';
    case 'musculação':
      return 'assets/images/AcademiaRecife.png';
    case 'dança':
      return 'assets/images/dance.jpeg';
    default:
      return 'assets/images/AcademiaRecife.png';
  }
}
