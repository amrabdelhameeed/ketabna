
// Write by BALY
import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/app_colors.dart';

import '../core/widgets/default_form_button.dart';
import '../core/widgets/default_text_form_field.dart';


class ForgetScreen extends StatelessWidget {
   ForgetScreen({Key? key}) : super(key: key);
var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color:AppColors.secondaryColor  ,
          size: 32,
        ),

      ),

      body: Padding(

        padding: const EdgeInsets.all(24.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
                "Forget Password !",
            style: Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height: 10,),
            Text(
              'We will send you message via your email ',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),

            SizedBox(height: 20,),

            DefaultTextFormField(
             hint: 'Enter email address',
             controller: emailController,
             inputType: TextInputType.emailAddress,
             validationText: 'please enter valid email',
              radius: 15,


            ),
            SizedBox(height: 20,),

            Center(
              child: DefaultFormButton(
                text: 'Send',
                width: 120,
                height: 40,
                textColor: Colors.grey[700],
                fontSize: 20,
                onPressed: (){

                },
                fillColor: AppColors.secondaryColor,
                radius: 10,


              ),
            ),



          ],
        ),
      ),
    );
  }
}
