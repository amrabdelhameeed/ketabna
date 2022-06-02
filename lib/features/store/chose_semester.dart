import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/store/pay_semester_books.dart';
import 'package:ketabna/features/store/semester_books.dart';

import '../../core/utils/app_colors.dart';
final String? myId = FirebaseAuth.instance.currentUser?.uid.toString();
bool? isSemesterPaid = false;
List<String> semester=[
  'الترم الأول',
  'الترم الثاني',
];
class ChoseSemester extends StatelessWidget {

  final data = FirebaseFirestore.instance.collection('users').doc(myId).get().then((value){
    isSemesterPaid = value.data()!['isSemesterPaid'];
    print('isSemesterPaid :'+isSemesterPaid.toString());
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Chose Your Semester',
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
          itemCount: 2,
          itemBuilder: (BuildContext context,int index){
            late String? gradeNumber = (index+1).toString();
            return InkWell(
              onTap: (){
                if(isSemesterPaid!){
                  navigateTo(context: context,widget: SemesterBooks(),);
                }else{
                  navigateTo(context: context,widget: const  PaySemesterBooks(),);
                }
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
                    semester[index],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }}