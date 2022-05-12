import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cfit/util/images.dart';

class HomeAPpBar extends StatelessWidget {
  const HomeAPpBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    return
      Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 2),
        padding: EdgeInsets.only(top: 32, bottom: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark
              ]),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 4,
                color: Colors.black)
          ],
        ),
        child: Image.asset(Images.logo_name, width: 100,
          fit: BoxFit.contain,),
      );

     */

    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 25, left: 25),

      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark
            ]),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              spreadRadius: 0,
              blurRadius: 4,
              color: Colors.black)
        ],
      ),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /*
          Container(
            height: 80,
            margin: EdgeInsets.only(bottom: 2),
            padding: EdgeInsets.only(top: 32, bottom: 10),
            child: Image.asset(Images.logo_name, width: 100,
              fit: BoxFit.contain,),
          ),
          */

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-vindo',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 255, 255, 1)),
              ),
              Text(
                'Max Alex',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,right: 10),
                transform: Matrix4.rotationZ(100),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              ClipOval(
                child:
                  Image.asset(Images.avatar, width: 40)
              ),
            ],
          ),
        ],
      ),
    );
  }
}