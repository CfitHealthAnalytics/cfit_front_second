import 'package:cfit/domain/models/user.dart';
import 'package:cfit/view/common/list_tile.dart';
import 'package:cfit/view/ui/screens/home/pages/profile/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({
    Key? key,
    required this.user,
    required this.qrData,
    required this.navigation,
  }) : super(key: key);
  final User user;
  final String qrData;
  final ProfileNavigation navigation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColorDark,
              radius: 95,
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/perfil.png'),
                backgroundColor: Colors.white,
                radius: 90,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16,
            ),
            child: ListTileCfit(
              title: 'Meus Dados',
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              onPressed: () => navigation.toMyDatas(user),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16,
            ),
            child: ListTileCfit(
              title: 'Avaliações',
              subtitle: 'Confira suas avaliações',
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/images/chart_icon.svg',
                ),
              ),
              onPressed: () {},
              customPadding: 8,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'QR code de identificação',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            width: 150,
            child: QrImage(
              data: qrData,
            ),
          )
        ],
      ),
    );
  }
}
