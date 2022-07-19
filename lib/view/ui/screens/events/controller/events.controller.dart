import 'package:cfit/controller/auth_controller.dart';
import 'package:cfit/domain/core/exceptions/user_not_found.exception.dart';
import 'package:cfit/domain/core/utils/snackbar.util.dart';
import 'package:cfit/infrastructure/navigation/routes.dart';
import 'package:cfit/presentation/shared/loading/loading.controller.dart';
import 'package:cfit/view/ui/screens/events/models/Events.models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventsController extends GetxController implements GetxService {
  final AuthController _authController;
  final _loadingController = Get.find<LoadingController>();

  EventsController({required AuthController authRepository})
      : _authController = authRepository;

  final _storage = Get.find<GetStorage>();

  List<EventsModel>? _eventos;
  List<EventsModel>? _eventosFavorite;
  List<EventModalidade>? _modalidades;
  List<String>? _listModalidades;

  List<EventsModel>? _my_city_events;
  bool? _my_city_events_loading;
  bool? _my_public_events_loading;
  List<EventsModel>? _my_public_events;

  List<EventsModel>? _eventosCity;

  List<String> get listModalidades => _listModalidades ?? [];

  List<EventsModel> get my_city_events => _my_city_events ?? [];
  bool get my_city_events_loading => _my_city_events_loading ?? true;
  bool get my_public_events_loading => _my_public_events_loading ?? true;
  List<EventsModel> get my_public_events => _my_public_events ?? [];

  double _longitude = 0.0;
  double _latitude = 0.0;

  double get longitude => _longitude;

  double get latitude => _latitude;

  List<EventModalidade> get modalidades => _modalidades ?? [];

  List<EventsModel> get eventos => _eventos ?? [];

  List<EventsModel> get eventosCity => _eventosCity ?? [];

  List<EventsModel> get eventosfavorite => _eventosFavorite ?? [];

  final AdvancedCalendarController _calendarControllerToday =
      AdvancedCalendarController.today();

  AdvancedCalendarController get calendarControllerToday =>
      _calendarControllerToday;

  String _selectModalidadeAdd = 'Tipo do evento';
  String get selectModalidadeAdd => _selectModalidadeAdd;

  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  TimeOfDay get getTime => _time;

  final TextEditingController _controllerhora = TextEditingController();
  TextEditingController get controllerhora => _controllerhora;

  final _dateController = TextEditingController();
  TextEditingController get dateController => _dateController;

  String _dataP = '';
  String get dataP => _dataP;

  String _horaP = '';
  String get horaP => _horaP;

  Future<void> setLocation(double slongitude, double slatitude) async {
    _longitude = slongitude;
    _latitude = slatitude;
  }

  setData(DateTime stime) {
    _dataP = DateFormat('yyyy-MM-dd').format(stime);
    _dateController.text = DateFormat('dd/MM/yyyy').format(stime);
  }

  setTime(TimeOfDay stime) {
    _time = stime;

    String hora =
        (stime.hour <= 9) ? '0' + stime.hour.toString() : stime.hour.toString();

    String minuto = (stime.minute <= 9)
        ? '0' + stime.minute.toString()
        : stime.minute.toString();

    _horaP = hora + ':' + minuto;

    _controllerhora.text = _horaP;
    nhora.value = stime.hour.toString();
  }

  Future<void> setSelectModalidadeAdd(String modalidadeSelecionada) async {
    _selectModalidadeAdd = modalidadeSelecionada;
    update();
  }

  Future<dynamic> getCurrentLocation(bool fromAddress,
      {GoogleMapController? mapController, bool notify = true}) async {}

  Future<void> getEventsList({
    bool reload = false,
    String type = '',
    bool notify = false,
    bool loading = true,
  }) async {
    if (reload) {
      _eventos = null;
    }

    if (loading == true) {
      update();
    }
    if (notify) {
      //update();
    }

    if (_eventos == null || reload) {
      Response response = await _authController.getPublicEvents();

      EventsModels returnEventos = EventsModels([]);

      if (response.statusCode == 200) {
        response.body.forEach((v) {
          EventsModel evento = EventsModel.fromJson(v);
          returnEventos.eventos.add(evento);
          //categoryIds.add(new CategoryIds.fromJson(v));
        });
        //print(returnEventos.eventos.length);
      } else {}

      _eventos = returnEventos.eventos;
    }
    //setStatus();
    update();
  }

  Future<void> getCityEventsList(bool reload, String type, bool notify) async {
    if (reload) {
      _eventosCity = null;
      update();
    }
    if (notify) {
      //update();
    }
    if (_eventosCity == null || reload) {
      Response response = await _authController.getCityEvents();

      EventsModels returnEventos = EventsModels([]);

      if (response.statusCode == 200) {
        response.body.forEach((v) {
          EventsModel evento = EventsModel.fromJson(v);
          returnEventos.eventos.add(evento);
        });
      } else {}
      _eventosCity = returnEventos.eventos;
    }
    //setStatus();
    update();
  }

  Future<void> getModalidades(bool reload, String type, bool notify) async {
    if (reload) {
      print('Recarrega Modalidade');
      _modalidades = null;
    }
    if (notify) {
      //update();
    }
    if (_modalidades == null || reload) {
      ListModalidades _modalidadesF = ListModalidades([]);
      Response response = await _authController.getModalidades();

      if (response.statusCode == 200) {
        response.body.forEach((v) async {
          EventModalidade evento = EventModalidade(nome: v);
          EventsModels eventos = await getEventsModalidade(v, true, '', false);
          evento.eventos = eventos.eventos;
          if (evento.eventos!.isNotEmpty) {
            evento.statusLoading = true;
          }
          _modalidadesF.modalidades.add(evento);

          print('Eventos => ' + v);
          update();
        });
        //print(returnEventos.eventos.length);
      } else {}
      _modalidades = _modalidadesF.modalidades;
    }
    if (reload) {
      //update();
    }
  }

  Future<EventsModels> getEventsModalidade(
      String modalidade, bool reload, String type, bool notify) async {
    EventsModels returnEventos = EventsModels([]);

    Response response =
        await _authController.getEventsModalidade('modalidade=' + modalidade);
    if (response.statusCode == 200) {
      try {
        response.body.forEach((v) {
          EventsModel evento = EventsModel.fromJson(v);
          returnEventos.eventos.add(evento);
        });
      } catch (erro) {}

      /*
      response.body.forEach((v) {
        EventsModel evento = EventsModel.fromJson(v);
        returnEventos.eventos.add(evento);
      });*/
    } else {}
    _eventosCity = returnEventos.eventos;

    return returnEventos;
  }

  Future<void> getEventsFavoriteList(
      bool reload, String type, bool notify) async {
    if (reload) {
      _eventos = null;
    }
    if (notify) {
      //update();
    }
    if (_eventos == null || reload) {
      Response response = await _authController.getFavoriteEvents();

      EventsModels returnEventos = EventsModels([]);

      if (response.statusCode == 200) {
        response.body.forEach((v) {
          EventsModel evento = EventsModel.fromJson(v);
          returnEventos.eventos.add(evento);
          //categoryIds.add(new CategoryIds.fromJson(v));
        });
        //print(returnEventos.eventos.length);
      } else {
        //print(response.body);
      }

      _eventosFavorite = returnEventos.eventos;
    }
    update();
  }

  Future<void> checkinCityEvent(String id) async {
    Response response = await _authController.checkinCityEvent(id);
    if (response.statusCode == 200) {
      SnackbarUtil.showSuccess(
          message: 'Inscrição do evento realizado com sucesso.');
      getCityEventsList(true, '', false);
      //Get.back();
      //} else if (response.statusCode == 500) {
    } else {
      if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
        Get.toNamed(Routes.login);
        SnackbarUtil.showError(
          message: 'Sua sessõa expirou.',
        );
      } else {
        SnackbarUtil.showError(
          message: 'Tivemos um problema ao realizar a sua inscrição no Evento.',
        );
      }
    }
    update();
  }

  Future<void> checkoutCityEvent(String id) async {
    Response response = await _authController.checkoutCityEvent(id);

    if (response.statusCode == 200) {
      SnackbarUtil.showSuccess(
          message: 'Inscrição do evento realizado com sucesso.');

      getCityEventsList(true, '', false);
      //Get.back();
      //} else if (response.statusCode == 500) {
    } else {
      if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
        Get.toNamed(Routes.login);
        SnackbarUtil.showError(
          message: 'Sua sessõa expirou.',
        );
      } else {
        SnackbarUtil.showError(
          message: 'Tivemos um problema ao realizar a sua inscrição no Evento.',
        );
      }
    }
    update();
  }

  Future<void> checkinPublicCityEvent(String id) async {
    Response response = await _authController.checkinPublicCityEvent(id);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 500) {
      SnackbarUtil.showError(
          message:
              'Tivemos um problema ao realizar a sua inscrição na competição.');
      getEventsList(reload: true);
    } else {
      if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
        Get.toNamed(Routes.login);
        SnackbarUtil.showError(
          message: 'Sua sessõa expirou.',
        );
      } else {
        SnackbarUtil.showError(
          message: 'Tivemos um problema ao realizar a sua inscrição no Evento.',
        );
      }
    }
    update();
  }

  Future<void> getMyCityEvents(bool reload, String type, bool notify) async {
    if (reload) {
      _my_city_events = [];
      _my_city_events_loading = true;
      update();
    }
    if (notify) {
      //update();
    }

    if (_my_city_events == [] || reload) {
      Response response = await _authController.getMyCityEvents();
      EventsModels returnEventos = EventsModels([]);
      if (response.statusCode == 200) {
        //} else if (response.statusCode == 500) {
        try {
          response.body.forEach((v) {
            if (v != null) {
              EventsModel evento = EventsModel.fromJson(v);
              returnEventos.eventos.add(evento);
              update();
            }
          });
        } catch (erro) {}
      } else {
        if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
          Get.toNamed(Routes.login);
          SnackbarUtil.showError(
            message: 'Sua sessõa expirou.',
          );
        } else {}
      }
      _my_city_events = returnEventos.eventos;
      _my_city_events_loading = false;
      update();
    }
  }

  Future<void> getMyPublicEvents(bool reload, String type, bool notify) async {
    if (reload) {
      _my_public_events = null;
      _my_public_events_loading = true;
      update();
    }
    if (notify) {
      //update();
    }

    if (_my_public_events == null || reload) {
      Response response = await _authController.getMyPublicEvents();
      EventsModels returnEventos = EventsModels([]);
      if (response.statusCode == 200) {
        //} else if (response.statusCode == 500) {
        try {
          response.body.forEach((v) {
            if (v != null) {
              try {
                EventsModel evento = EventsModel.fromJson(v);
                returnEventos.eventos.add(evento);
                update();
              } catch (erro) {}
            }
          });
        } catch (erro) {}
      } else {
        if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
          Get.toNamed(Routes.login);
          SnackbarUtil.showError(
            message: 'Sua sessõa expirou.',
          );
        } else {}
      }
      _my_public_events = returnEventos.eventos;

      _my_public_events_loading = false;
      update();
    }
  }

  Future<void> checkoutPublicCityEvent(String id) async {
    Response response = await _authController.checkoutPublicCityEvent(id);
    if (response.statusCode == 200) {
      SnackbarUtil.showSuccess(message: 'Cancelamento Realizado com sucesso.');
    } else {
      if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
        Get.toNamed(Routes.login);
        SnackbarUtil.showError(
          message: 'Sua sessõa expirou.',
        );
      } else {
        SnackbarUtil.showError(
          message: 'Tivemos um problema ao realizar a sua inscrição no Evento.',
        );
      }
    }
    update();
  }

  Future<void> comfirmationInEvents(String id) async {
    Response response = await _authController.comfirmationInEvents(id);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 500) {
      SnackbarUtil.showError(
          message:
              'Tivemos um problema ao realizar a sua inscrição na competição.');
    } else {
      if (response.body!['detail'] == 'INVALID_ID_TOKEN') {
        Get.toNamed(Routes.login);
        SnackbarUtil.showError(
          message: 'Sua sessõa expirou.',
        );
      } else {
        SnackbarUtil.showError(
          message: 'Tivemos um problema ao realizar a sua inscrição no Evento.',
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever<String>(nnome, validateNome);
    ever<String>(ncidade, validateCidade);
    ever<String>(nbairro, validateBairro);
    ever<String>(nrua, validateRua);
    ever<String>(nnumero, validateNumero);
    ever<String>(ntipoevento, validateTipoEvento);
    ever<String>(nqtdPessoas, validateQtdPessoas);
    ever<String>(ndescricao, validateDescricao);
    //ever<String>(password, validatePassword);
  }

  Future<void> doCadatro() async {
    try {
      _loadingController.isLoading = true;

      //print(_dataP + 'T' + _horaP + ':00.369Z');

      if (_selectModalidadeAdd == 'Tipo do evento') {
        SnackbarUtil.showWarning(
            message: 'Par continuar Selecione o tipo do evento');
      } else if (validateFields()) {
        //Get.focusScope?.unfocus();

        EventsModel evento = EventsModel(
          qtd_user: nqtdPessoas.value,
          qtd_max_user: nqtdPessoas.value,
          id: null,
          status: true,
          bairro: nbairro.value,
          numero: nnumero.value,
          cidade: ncidade.value,
          descricao: ndescricao.value,
          //users_confirmation: [],
          horario_de_inicio: _dataP + 'T' + _horaP + ':00.369Z',
          rua: nrua.value,
          //users_checkin: [],
          nome: nnome.value,
          tipo: _selectModalidadeAdd,
          created_at: '',
          coordenadas:
              EventsCoordenadas(latitude: latitude, longitude: longitude),
        );

        Response response = await _authController.registerEvents(evento);

        print(response.body);

        if (response.body['detail']! == 'create event sucess') {
          SnackbarUtil.showSuccess(message: 'Evento Criado com sucesso.');
          //Get.find<EventsController>().getEventsList(reload: true);
          //Get.toNamed(Routes.eventos);
          getModalidades(true, '', false);
        } else {
          SnackbarUtil.showError(
              message:
                  'Tivemos um problema ao realizar o cadastro do seu evento, Tente novamente.');
        }

        _loadingController.isLoading = false;
      } else {
        SnackbarUtil.showWarning(
            message: 'Par continuar adicione os campos obrigátorios.');
      }
    } on UserNotFoundException catch (err) {
      SnackbarUtil.showWarning(message: err.toString());
    } catch (err) {
      SnackbarUtil.showError(message: err.toString());
    } finally {
      _loadingController.isLoading = false;
    }
  }

  bool validateFields() {
    validateNome(nnome.value);
    validateCidade(ncidade.value);
    validateBairro(nbairro.value);
    validateDescricao(ndescricao.value);
    validateTipoEvento(ntipoevento.value);
    validateQtdPessoas(nqtdPessoas.value);
    validateRua(nrua.value);

    //validateLogin(login.value);
    //validatePassword(password.value);

    return nnome.isNotEmpty &&
        nnomeError.value == null &&
        ncidade.isNotEmpty &&
        ncidadeError.value == null &&
        nbairro.isNotEmpty &&
        nbairroError.value == null &&
        nrua.isNotEmpty &&
        nruaError.value == null &&
        ndescricao.isNotEmpty &&
        ndescricaoError.value == null &&
        nqtdPessoas.isNotEmpty &&
        nqtdPessoasError.value == null;
  }

  final nhora = ''.obs;
  final nhoraError = RxnString();
  final nhoraFocus = FocusNode();

  final nnome = ''.obs;
  final nnomeError = RxnString();
  final nnomeFocus = FocusNode();

  void validateNome(String val) {
    if (val.isEmpty) {
      nnomeError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      nnomeError.value =
          'Nome da Cidade precisa de pelo menos 3 caracteristicas.';
    } else {
      nnomeError.value = null;
    }
  }

  final ncidade = ''.obs;
  final ncidadeError = RxnString();
  final ncidadeFocus = FocusNode();

  void validateCidade(String val) {
    if (val.isEmpty) {
      ncidadeError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      ncidadeError.value =
          'Nome da Cidade precisa de pelo menos 3 caracteristicas.';
    } else {
      ncidadeError.value = null;
    }
  }

  final nbairro = ''.obs;
  final nbairroError = RxnString();
  final nbairroFocus = FocusNode();

  void validateBairro(String val) {
    if (val.isEmpty) {
      ncidadeError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      ncidadeError.value =
          'Nome do bairro precisa de pelo menos 3 caracteristicas.';
    } else {
      ncidadeError.value = null;
    }
  }

  final nrua = ''.obs;
  final nruaError = RxnString();
  final nruaFocus = FocusNode();

  void validateRua(String val) {
    if (val.isEmpty) {
      nruaError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      nruaError.value = 'Nome do Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      nruaError.value = null;
    }
  }

  final nnumero = ''.obs;
  final nnumeroError = RxnString();
  final nnumeroFocus = FocusNode();

  void validateNumero(String val) {
    if (val.isEmpty) {
      nnumeroError.value = 'Campo Obrigatório';
    } else {
      nnumeroError.value = null;
    }
  }

  final ntipoevento = ''.obs;
  final ntipoeventoError = RxnString();
  final ntipoeventoFocus = FocusNode();

  void validateTipoEvento(String val) {
    if (val.isEmpty) {
      ntipoeventoError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      ntipoeventoError.value =
          'Digite o numero da Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      ntipoeventoError.value = null;
    }
  }

  final nqtdPessoas = ''.obs;
  final nqtdPessoasError = RxnString();
  final nqtdPessoasFocus = FocusNode();

  void validateQtdPessoas(String val) {
    if (val.isEmpty) {
      nnumeroError.value = 'Campo Obrigatório';
    } else {
      nnumeroError.value = null;
    }
  }

  final ndescricao = ''.obs;
  final ndescricaoError = RxnString();
  final ndescricaoFocus = FocusNode();

  void validateDescricao(String val) {
    if (val.isEmpty) {
      ndescricaoError.value = 'Campo Obrigatório';
    } else if (val.length < 3) {
      ndescricaoError.value =
          'Digite o numero da Rua precisa de pelo menos 3 caracteristicas.';
    } else {
      ndescricaoError.value = null;
    }
  }

  final npassword = ''.obs;
  final npasswordError = RxnString();
  final npasswordFocus = FocusNode();

  void validatePassword(String val) {
    if (val.isEmpty) {
      npasswordError.value = 'Digite sua senha';
    } else if (val.length < 3) {
      npasswordError.value = 'Senha inválida, no mínimo 3 caracters.';
    } else {
      npasswordError.value = null;
    }
  }

  bool get enableButton => ncidade.isNotEmpty && ncidadeError.value != null;
}
