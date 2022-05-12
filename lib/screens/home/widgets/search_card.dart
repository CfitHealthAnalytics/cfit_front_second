import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cfit/screens/search/search_screen.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "",
            style: TextStyle(
                height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(),),),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/search.png',
                    width: 20,
                  ),SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pesquise novos eventos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage('assets/images/search_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Procure novos \neventos',
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "",
            style: TextStyle(
                height: 1.8, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(),),),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/search.png',
                    width: 20,
                  ),SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pesquise novos eventos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}