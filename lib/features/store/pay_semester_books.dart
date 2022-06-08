import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/features/store/pdf_api.dart';
import 'package:ketabna/features/store/pdf_viewer.dart';

import '../../app_router.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/components.dart';
final String myId = FirebaseAuth.instance.currentUser!.uid;


enum SingingCharacter { Fawry, Cridet }

class PayBookPrice extends StatefulWidget {
  const PayBookPrice({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;

  @override
  State<PayBookPrice> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<PayBookPrice> {
  SingingCharacter? _character = SingingCharacter.Fawry;
  final _formKey = GlobalKey<FormState>();
  bool isPayingMoney = false;

  void openPdf({required BuildContext context, filePdf, bookModel}) {
    navigateTo(
      context: context,
      widget: PdfViewerPage(
        file: filePdf,
        bookModel: bookModel,
      ),
    );
  }

  payThePrice()async{
    await FirebaseFirestore.instance.collection('books').doc(widget.bookModel.bookId).update({
      'bookOwners':FieldValue.arrayUnion([
        myId,
      ]),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'ادفع يا عرصي يا سيسي',
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
                    const customTextForm(
                      keyboardType: TextInputType.text,
                      hintText: 'Name On Card',
                      errorText: 'Please enter name',
                      widthRatio: 1.1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const customTextForm(
                      keyboardType: TextInputType.number,
                      hintText: 'Card Number',
                      errorText: 'Please enter Card Number',
                      widthRatio: 1.1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        customTextForm(
                          keyboardType: TextInputType.number,
                          hintText: 'Expiry Date',
                          errorText: 'Please enter Expiry Date',
                          widthRatio: 3,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        customTextForm(
                          keyboardType: TextInputType.number,
                          hintText: 'Cvv',
                          errorText: 'Please enter cvv',
                          widthRatio: 4,
                        ),
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
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isPayingMoney = true;
                    });
                    if (_character == SingingCharacter.Fawry) {
                      payThePrice();
                      final filePdf = await PdfApi.loadNetwork(
                          Uri.parse(widget.bookModel.bookLink!));
                      openPdf(
                          context: context,
                          filePdf: filePdf,
                          bookModel: widget.bookModel);
                      setState(() {
                        isPayingMoney = false;
                      });
                    } else {
                      if (_formKey.currentState!.validate()) {
                        payThePrice();
                        final filePdf = await PdfApi.loadNetwork(
                            Uri.parse(widget.bookModel.bookLink!));
                        openPdf(
                            context: context,
                            filePdf: filePdf,
                            bookModel: widget.bookModel);
                      }
                      authCubit!
                      // ..getCurrentFirestoreUser()
                        ..getRecommended()
                        ..getHorrorBooks()
                        ..getTechnologyBooks()
                        ..getFantasyBooks()
                        ..getnovelBooks()
                        ..getfictionBooks()
                        ..getbiographyBooks();
                      setState(() {
                        isPayingMoney = false;
                      });
                    }
                  },
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: isPayingMoney
                          ? const CircularProgressIndicator(
                              color: AppColors.mainColor,
                            )
                          : const Text(
                              'pay 5\$',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
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
  final keyboardType;

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
