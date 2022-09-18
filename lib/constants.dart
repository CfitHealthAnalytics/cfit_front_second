import 'package:flutter/material.dart';

const kBackgroundWhite = Color(0xffffffff);
const kBackgroundBlack = Color(0xff000000);

const kBackgroundColor = Color(0xff12AA9E);
const kPrimaryColor = Color(0xff12AA9E);
const kPrimaryBottom = Color(0xff0A6960);
const kTextColor = Color(0xFF1C1C1C);
const kLightTextColor = Color(0xFF363636);
const kAltTextColor = Color(0xFFBBBBBB);
const kAltDarkTextColor = Color(0xFF9D9D9D);
const kInputColor = Color(0xFFF0F0F0);
const kInputTextColor = Color(0xFF646464);
const kINputLabelColor = Color(0xFF5E5E5E);
const kFbColor = Color(0xFF1976D2);
const kGoogleColor = Color(0xFFFF3D00);
const kDefaultPadding = 28.0;

const Color white = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);

const Color primary = Color(0xFF92A3FD);
const Color secondary = Color(0xFF9DCEFF);
const Color thirdColor = Color(0xFFC58BF2);
const Color fourthColor = Color(0xFFEEA4CE);
const Color bgTextField = Color(0xFFF7F8F8);

const Color facebookColor = Color(0xFF3b5998);
const Color googleColor = Color(0xFFDB4437);

bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 600;
bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

const EXCEPTION_MAX_LIMIT =
    '''Você não pode ter mais de 2 eventos ativos simultaneamente''';

const UNEXPECTED_FAILED =
    '''Ocorreu um erro inesperado, ao tentar criar seu evento. Por favor tente novamente mais tarde. ''';
