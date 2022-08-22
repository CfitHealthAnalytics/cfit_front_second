import 'package:cfit/domain/models/user.dart';
import 'package:cfit/util/extentions.dart';
import 'package:cfit/view/common/button.dart';
import 'package:cfit/view/common/list_tile.dart';
import 'package:cfit/view/common/padding.dart';
import 'package:cfit/view/ui/screens/my_datas/my_datas_controller.dart';
import 'package:flutter/material.dart';

class MyDatasScreen extends StatelessWidget {
  const MyDatasScreen({
    Key? key,
    required this.controller,
    required this.user,
  }) : super(key: key);

  final MyDatasController controller;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: 16,
              ),
            ),
          ),
          onPressed: controller.onBack,
        ),
        title: const Text(
          'Informações da Conta',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTileCfit(
              title: 'Nome',
              subtitle: user.name,
              onPressed: () {},
              customPadding: 8.0,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ).withPaddingSymmetric(horizontal: 16.0, vertical: 16.0),
            ListTileCfit(
              title: 'Data de Nascimento',
              subtitle: user.dateBirth,
              onPressed: () {},
              customPadding: 8.0,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ).withPaddingSymmetric(horizontal: 16.0, vertical: 16.0),
            ListTileCfit(
              title: 'Gênero',
              subtitle:
                  user.gender.toStringRepresentation().upperOnlyFirstLetter(),
              onPressed: () {},
              customPadding: 8.0,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ).withPaddingSymmetric(horizontal: 16.0, vertical: 16.0),
            ListTileCfit(
              title: 'Email',
              subtitle: user.email,
              onPressed: () {},
              customPadding: 8.0,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ).withPaddingSymmetric(horizontal: 16.0, vertical: 16.0),
            ListTileCfit(
              title: 'Senha',
              onPressed: () {},
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ).withPaddingSymmetric(horizontal: 16.0, vertical: 16.0),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 45,
          ),
          child: ButtonAction(
            text: 'Sair',
            type: ButtonActionType.primary,
            onPressed: controller.logout,
            customBackgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
