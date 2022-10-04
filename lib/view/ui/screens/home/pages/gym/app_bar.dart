import 'package:cfit/view/common/input_text.dart';
import 'package:flutter/material.dart';

class AppBarGym extends StatelessWidget {
  const AppBarGym({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InputText(
        type: InputTextType.text,
        onChanged: (_) {},
        hintText: 'Perto de Boa Viagem',
      ),
      centerTitle: false,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      leadingWidth: 0,
      automaticallyImplyLeading: false,
    );
  }
}
