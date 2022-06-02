import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widgets/custom_general_button.dart';
import '../../core/widgets/custom_text_form_field.dart';

enum SingingCharacter { Fawry, Cridet }

class PaySemesterBooks extends StatefulWidget {
  const PaySemesterBooks({Key? key}) : super(key: key);

  @override
  State<PaySemesterBooks> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<PaySemesterBooks> {
  SingingCharacter? _character = SingingCharacter.Fawry;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'ادفع يا عرص',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppColors.secondaryColor,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              RadioListTile<SingingCharacter>(
                activeColor: AppColors.secondaryColor,
                title: const Text('By Fawry'),
                value: SingingCharacter.Fawry,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                activeColor: AppColors.secondaryColor,
                title: const Text('By Credit Card'),
                value: SingingCharacter.Cridet,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customTextForm(keyboardType: TextInputType.text,hintText: 'Name On Card',errorText: 'Please enter name',widthRatio: 1.1,),
                    const SizedBox(
                      height: 20,
                    ),
                    const customTextForm(keyboardType: TextInputType.number,hintText: 'Card Number',errorText: 'Please enter Card Number',widthRatio: 1.1,),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        customTextForm(keyboardType: TextInputType.number,hintText: 'Expiry Date',errorText: 'Please enter Expiry Date',widthRatio: 3,),
                        SizedBox(
                          width: 10,
                        ),
                        customTextForm(keyboardType: TextInputType.number,hintText: 'Cvv',errorText: 'Please enter cvv',widthRatio: 4,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomGeneralButton(
                  color: AppColors.secondaryColor,
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      print('zobry');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class customTextForm extends StatelessWidget {
  final String hintText;
  final String errorText;
  final double widthRatio;
  final  keyboardType;
  const customTextForm({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.widthRatio,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;
        },
        cursorColor: AppColors.secondaryColor,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.formFontColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
              ),
            ),
            hintText: hintText),
      ),
      width: MediaQuery.of(context).size.width / widthRatio,
    );
  }
}
