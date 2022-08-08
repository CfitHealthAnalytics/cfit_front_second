class Routes {
  static const splash = '/';
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const login = '/login';
  static const forgot = '/forgot';
  static const usuarios = '/usuarios';
  static const register = '/cadastro';
  static const eventos = '/eventos';
  static const eventos_favorite = '/eventos/favoritos';
  static const eventos_editar = '/evento/editar';
  static const eventos_detalhe = '/evento/detalhe';
  static const cadastro_eventos = '/eventos/cadastro';
  static const eventos_search = '/eventos/pesquisa';
  static const perfil = '/perfil';
  static const mymeasures = '/mymeasures';
  static const qrcode = '/qrcode';

  static const mapa = '/mapa';

  static String getEventEditRoute(String itemID) =>
      '$eventos_editar?id=$itemID';

  static String getEventDetailRoute(String itemID) =>
      '$eventos_detalhe?id=$itemID';
}