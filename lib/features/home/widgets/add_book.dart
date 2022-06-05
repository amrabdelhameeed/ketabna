import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';

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
  var dropdownValue = 'biography';

  List<String> items = [
    'biography',
    'children',
    'fantasy',
    'graphicNovels',
    'history',
    'horror',
    'romance',
    'scienceFiction'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: authCubit!,
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsetsDirectional.all(20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 2 / 5,
                          height: MediaQuery.of(context).size.height * 1 / 4,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(25)),
                          child: cubit.bookImage != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                    cubit.bookImage!,
                                  ))),
                                )
                              : Center(child: const Text("No image selected")),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            MaterialButton(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 6,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      20,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5B53F),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(
                                    child: Text(
                                      "Gallery",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  cubit.pickBookImage(false);
                                  // pickImage();
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 2 / 6,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      20,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5B53F),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  cubit.pickBookImage(true);
                                  // pickImage();
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 1 / 3,
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: Color(0xFFF5B53F),
                                ),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Color(0xFFF5B53F)),
                                underline: Container(
                                  height: 2,
                                  color: const Color(0xFFF5B53F),
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
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextFormField(
                      hint: 'Book Name - اسم الكتاب',
                      controller: bookNameController,
                      validationText: 'Book name can\'t be empty.',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextFormField(
                      hint: 'author Name - اسم الكاتب ',
                      controller: authorNameController,
                      validationText: 'author name can\'t be empty.',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(30)),
                      ),
                      child: TextField(
                        maxLines: 10,
                        controller: descriptionController,
                        decoration: const InputDecoration.collapsed(
                          hintText:
                              "Write your description here - اكتب وصفك هنا ",
                          hintStyle: TextStyle(
                            color: AppColors.formFontColor,
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        hoverElevation: 0,
                        hoverColor: Colors.white,
                        splashColor: Colors.transparent,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 2 / 4,
                          height: MediaQuery.of(context).size.height * 1 / 20,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF5B53F),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              "Add Book",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // pickImage();
                          cubit.addBook(
                              category: dropdownValue,
                              name: bookNameController.text,
                              authorName: authorNameController.text);
                        }),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is BookAddedSuccessState) {
                          cubit.changeIndex(0);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added successfully')));
                        }
                      },
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
/*
BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: MediaQuery.of(context).size.height * 1 / 4,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: cubit.bookImage != null
                                ? Image.file(
                                    cubit.bookImage!,
                                    fit: BoxFit.cover,
                                  )
                                : const Text("No image selected")),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          MaterialButton(
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 6,
                                height:
                                    MediaQuery.of(context).size.height * 1 / 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF5B53F),
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                cubit.pickBookImage(false);
                                // pickImage();
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 6,
                                height:
                                    MediaQuery.of(context).size.height * 1 / 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF5B53F),
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                  child: Text(
                                    "Camera",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                cubit.pickBookImage(true);
                                // pickImage();
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 1 / 3,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Color(0xFFF5B53F),
                              ),
                              elevation: 16,
                              style: const TextStyle(color: Color(0xFFF5B53F)),
                              underline: Container(
                                height: 2,
                                color: const Color(0xFFF5B53F),
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
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTextFormField(
                    hint: 'Book Name - اسم الكتاب',
                    controller: bookNameController,
                    validationText: 'Book name can\'t be empty.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                    hint: 'author Name - اسم الكاتب ',
                    controller: authorNameController,
                    validationText: 'author name can\'t be empty.',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(30)),
                    ),
                    child: TextField(
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: const InputDecoration.collapsed(
                        hintText:
                            "Write your description here - اكتب وصفك هنا ",
                        hintStyle: TextStyle(
                          color: AppColors.formFontColor,
                        ),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      hoverElevation: 0,
                      hoverColor: Colors.white,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2 / 4,
                        height: MediaQuery.of(context).size.height * 1 / 20,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5B53F),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Center(
                          child: Text(
                            "Add Book",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () {
                        // pickImage();
                        cubit.addBook(
                            category: dropdownValue,
                            name: bookNameController.text,
                            authorName: authorNameController.text);
                      }),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is BookAddedSuccessState) {}
                    },
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
 */