import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubit/auth_cubit.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/default_text_form_field.dart';

class AddBook extends StatefulWidget {
   AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  var bookNameController = TextEditingController();

  var authorNameController = TextEditingController();

  var descriptionController = TextEditingController();

  var image;
  var dropdownValue='Biography';

   var items = ['Biography', 'Children', 'Fantasy', 'Graphic Novels','History','Horror','Romance','Science Fiction'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
    child: Container(
      padding: EdgeInsetsDirectional.all(20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*2/5,
                  height: MediaQuery.of(context).size.height*1/4,
                  decoration: BoxDecoration(border: Border.all()),
                  child:Center(child: image != null ? Image.file(image!): Text("No image selected")) ,
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    MaterialButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width*2/6,
                          height: MediaQuery.of(context).size.height*1/20,
                          decoration: BoxDecoration(
                              color: Color(0xFFF5B53F), borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: const Text(
                                "Gallery",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // pickImage();
                        }
                    ),
                    SizedBox(height: 10,),
                    MaterialButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width*2/6,
                          height: MediaQuery.of(context).size.height*1/20,
                          decoration: BoxDecoration(
                              color: Color(0xFFF5B53F), borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: const Text(
                                "Camera",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // pickImage();
                        }
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*1/3,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_outlined,color: Color(0xFFF5B53F) ,),
                        elevation: 16,
                        style: const TextStyle(color: Color(0xFFF5B53F)),
                        underline: Container(
                          height: 2,
                          color: Color(0xFFF5B53F),
                        ),

                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });

                      },
                      ),




                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            DefaultTextFormField(
              hint: 'Book Name - اسم الكتاب',
              controller: bookNameController,
              validationText: 'Book name can\'t be empty.',
            ),
            SizedBox(height: 10,),
            DefaultTextFormField(
              hint: 'author Name - اسم الكاتب ',
              controller: authorNameController,
              validationText: 'author name can\'t be empty.',
            ),
            SizedBox(height: 10,),
            Container(
              padding:  EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: TextField(
                maxLines: 10,
                controller: descriptionController,
                decoration: InputDecoration.collapsed(hintText: "Write your description here - اكتب وصفك هنا ",
                  hintStyle: const TextStyle(
                    color: AppColors.formFontColor,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            SizedBox(height: 10,),
            MaterialButton(
              hoverElevation: 0,
              hoverColor: Colors.white,
              splashColor: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width*2/4,
                  height: MediaQuery.of(context).size.height*1/20,
                  decoration: BoxDecoration(
                      color: Color(0xFFF5B53F), borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: const Text(
                      "Add Book",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  // pickImage();
                }
            ),
          ],
        ),
      ),
    ),
      ),
    );



  }
}
