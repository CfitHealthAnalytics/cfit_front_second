import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cfit/models/job.dart';
import 'job_details.dart';
import 'job_item.dart';
import 'package:http/http.dart' as http;

import 'package:cfit/view/base/animation/fadeanimation.dart';

class JobList extends StatelessWidget {
  JobList({Key? key}) : super(key: key);

  final jobList = Job.generateJobs();

  double animation = 2.4;

//print(await http.read(Uri.parse('https://example.com/foobar.txt')));

  Animation() {
    animation = animation + 0.4;
    return animation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 190,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: JobDetail(
                            jobList[index],
                          ),
                        ),
                      );
                    },
                    child: JobItem(
                      job: jobList[index],
                    ),
                  ),
                ],
              ),
          separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
          itemCount: jobList.length),
    );
  }
}
