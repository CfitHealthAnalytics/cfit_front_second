import 'package:flutter/material.dart';

class GenericErrorScreen extends StatelessWidget {
  const GenericErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  '''O seu token do conecta está expirado. Volte para o conecta e faça login novamente''',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
