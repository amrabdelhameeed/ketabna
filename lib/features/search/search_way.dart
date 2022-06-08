import 'package:flutter/material.dart';
import 'package:ketabna/core/widgets/default_form_button.dart';

import '../../core/constants/strings.dart';

class SearchWay extends StatelessWidget {
  const SearchWay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultFormButton(text: 'Search by Book Name' , onPressed: (){
            Navigator.pushNamed(context, searchScreen,
                arguments: 'name');
          },),
          SizedBox(height: 40,),
          DefaultFormButton(text: 'Search by Author Name' , onPressed: (){
            Navigator.pushNamed(context, searchScreen,
                arguments: 'authorName');
          },),
        ],
      ),
    );
  }
}
