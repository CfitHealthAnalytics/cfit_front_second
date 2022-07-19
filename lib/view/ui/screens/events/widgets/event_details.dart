import 'package:cfit/data/modal/body/Event.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  Event posto;
  EventDetails({Key? key, required this.posto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Image.network(posto.foto,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24),
            child: Text(
              posto.nome,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 24),
            child: Text(
              posto.endereco,
            ),
          ),
        ],
      ),
    );
  }
}
