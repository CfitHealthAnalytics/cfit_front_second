import 'package:cfit/view/base/animation/fadeanimation.dart';
import 'package:flutter/material.dart';
import 'package:cfit/models/job.dart';
import 'package:cfit/view/ui/screens/home/widgets/job_item.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);
  final jobList = Job.generateJobs();

  double TimeAnimacao = 1.3;

  SetTime() {
    TimeAnimacao = TimeAnimacao + 0.3;
    return TimeAnimacao;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => FadeAnimation(
                delay: SetTime(),
                child: JobItem(
                  job: jobList[index],
                  showTime: true,
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(
                height: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
