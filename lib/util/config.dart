class Environments {
  static const String production = 'prod';
  static const String homolog = 'homolog';
  static const String develop = 'dev';
  static const String local = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.production;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.local,
      'url': 'https://cfit-api.herokuapp.com/',
    },
    {
      'env': Environments.develop,
      'url': 'https://cfit-api.herokuapp.com/',
    },
    {
      'env': Environments.homolog,
      'url': 'https://cfit-api.herokuapp.com/',
    },
    {
      'env': Environments.production,
      'url': 'https://cfit-api.herokuapp.com/',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}
