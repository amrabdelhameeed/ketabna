import 'package:flutter/material.dart';
import 'package:ketabna/core/widgets/components.dart';

import '../../core/utils/app_colors.dart';
import 'chose_semester.dart';

List<String> grades=[
  'الفرقة الأولي',
  'الفرقة الثانية',
  'الفرقة الثالثة',
  'الفرقة الرابعة',
];
class ChoseGrade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Chose Your Grade',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context,int index){
            late String? gradeNumber = (index+1).toString();
            return InkWell(
              onTap: (){
                navigateTo(context: context,widget: ChoseSemester(),);
              },
              child: Card(
                elevation: 3,
                shadowColor: AppColors.secondaryColor,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(gradeNumber,style: const TextStyle(color: AppColors.mainColor),),
                    backgroundColor: AppColors.secondaryColor,
                    radius: 20,
                  ),
                  title: Text(
                    grades[index],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }}