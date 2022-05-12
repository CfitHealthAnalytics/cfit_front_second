import 'package:flutter/material.dart';
import 'package:cfit/screens/home/widgets/home_app_bar.dart';
import 'package:cfit/screens/home/widgets/job_list.dart';
import 'package:cfit/screens/home/widgets/search_card.dart';
import 'package:cfit/screens/home/widgets/tag_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeAPpBar(),
                SearchCard(),
                TagsList(),
                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: JobList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}