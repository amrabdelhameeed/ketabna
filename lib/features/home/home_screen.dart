// import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/category_model.dart';
// import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/home/widgets/custom_listview.dart';
import 'package:ketabna/features/on_boarding/sign_in_up_screen.dart';
import '../../core/utils/app_colors.dart';
import '../../core/widgets/default_text_form_field.dart';
// import '../chat/my_active_chats.dart';
import 'widgets/customShape.dart';
import 'widgets/customcarousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Color> colors = [
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.amber.shade500,
    Colors.red.shade900,
    Colors.brown.shade400,
    Colors.black54,
    Colors.amber,
    const Color(0xFFEF5350),
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var bookNameController = TextEditingController();
  var authorNameController = TextEditingController();
  var descriptionController = TextEditingController();
  var image;

  var category = CategoryModel.categories;

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
        value: authCubit!,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return WillPopScope(
              onWillPop: () async {
                final timegap = DateTime.now().difference(pre_backpress);

                final cantExit = timegap >= const Duration(seconds: 2);

                pre_backpress = DateTime.now();

                if (cantExit) {
                  //show snackbar
                  buildSnackBar(
                      context: context,
                      text: 'Press Back button again to Exit');

                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                key: scaffoldKey,
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     if (cubit.isBottomSheetShow) {
                //       if (formKey.currentState!.validate()) {
                //         {
                //           {
                //             // Navigator.pop(context);
                //             //  cubit.bottomSheetShowState(isShow: false , icon: Icons.add);
                //             // fabIcon = Icons.edit;
                //           }
                //         }
                //       }
                //     } else {
                //       scaffoldKey.currentState!
                //           .showBottomSheet(
                //             (context) => Container(
                //               padding: const EdgeInsetsDirectional.all(20),
                //               height: MediaQuery.of(context).size.height * 2 / 3,
                //               child: Form(
                //                 key: formKey,
                //                 child: SingleChildScrollView(
                //                   physics: const BouncingScrollPhysics(),
                //                   child: Column(
                //                     children: [
                //                       Row(
                //                         children: [
                //                           Container(
                //                             width:
                //                                 MediaQuery.of(context).size.width *
                //                                     2 /
                //                                     5,
                //                             height:
                //                                 MediaQuery.of(context).size.height *
                //                                     1 /
                //                                     4,
                //                             decoration:
                //                                 BoxDecoration(border: Border.all()),
                //                             child: Center(
                //                                 child: image != null
                //                                     ? Image.file(image!)
                //                                     : const Text(
                //                                         "No image selected")),
                //                           ),
                //                           const SizedBox(
                //                             width: 20,
                //                           ),
                //                           Column(
                //                             children: [
                //                               MaterialButton(
                //                                   color: Colors.blue,
                //                                   child: const Text("Gallery",
                //                                       style: TextStyle(
                //                                           color: Colors.white70,
                //                                           fontWeight:
                //                                               FontWeight.bold)),
                //                                   onPressed: () {
                //                                     // pickImage();
                //                                   }),
                //                               MaterialButton(
                //                                   color: Colors.blue,
                //                                   child: const Text("Camera",
                //                                       style: TextStyle(
                //                                           color: Colors.white70,
                //                                           fontWeight:
                //                                               FontWeight.bold)),
                //                                   onPressed: () {
                //                                     // pickImageC();
                //                                   }),
                //                               Container(
                //                                 width: MediaQuery.of(context)
                //                                         .size
                //                                         .width *
                //                                     1 /
                //                                     3,
                //                                 child: DropdownButton<String>(
                //                                   value: cubit.dropdownValue,
                //                                   isExpanded: true,
                //                                   icon: const Icon(
                //                                     Icons
                //                                         .arrow_drop_down_circle_outlined,
                //                                     color: Color(0xFFF5B53F),
                //                                   ),
                //                                   elevation: 16,
                //                                   style: const TextStyle(
                //                                       color: Color(0xFFF5B53F)),
                //                                   underline: Container(
                //                                     height: 2,
                //                                     color: const Color(0xFFF5B53F),
                //                                   ),
                //                                   onChanged: (String? newValue) {
                //                                     cubit.dropdownValue = newValue!;
                //                                   },
                //                                   items: <String>[
                //                                     'Biography',
                //                                     'Children',
                //                                     'Fantasy',
                //                                     'Graphic Novels',
                //                                     'History',
                //                                     'Horror',
                //                                     'Romance',
                //                                     'Science Fiction'
                //                                   ].map<DropdownMenuItem<String>>(
                //                                       (String value) {
                //                                     return DropdownMenuItem<String>(
                //                                       value: value,
                //                                       child: Text(value),
                //                                     );
                //                                   }).toList(),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ],
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       DefaultTextFormField(
                //                         hint: 'Book Name - اسم الكتاب',
                //                         controller: bookNameController,
                //                         validationText:
                //                             'Book name can\'t be empty.',
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       DefaultTextFormField(
                //                         hint: 'author Name - اسم الكاتب ',
                //                         controller: authorNameController,
                //                         validationText:
                //                             'author name can\'t be empty.',
                //                       ),
                //                       const SizedBox(
                //                         height: 10,
                //                       ),
                //                       Container(
                //                         padding:
                //                             const EdgeInsetsDirectional.all(10),
                //                         decoration: BoxDecoration(
                //                           color: Colors.grey[200],
                //                           borderRadius: const BorderRadius.all(
                //                               const Radius.circular(30)),
                //                         ),
                //                         child: TextField(
                //                           maxLines: 10,
                //                           controller: descriptionController,
                //                           decoration:
                //                               const InputDecoration.collapsed(
                //                             hintText:
                //                                 "Write your description here - اكتب وصفك هنا ",
                //                             hintStyle: TextStyle(
                //                               color: AppColors.formFontColor,
                //                             ),
                //                           ),
                //                           textAlignVertical:
                //                               TextAlignVertical.center,
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             shape: const RoundedRectangleBorder(
                //               borderRadius: BorderRadius.vertical(
                //                 top: Radius.circular(60.0),
                //               ),
                //             ),
                //             elevation: 80,
                //             backgroundColor: const Color(0xFFF5F1D7),
                //           )
                //           .closed
                //           .then((value) {
                //         cubit.bottomSheetShowState(isShow: false, icon: Icons.add);
                //       });
                //       cubit.bottomSheetShowState(isShow: true, icon: Icons.check);
                //     }
                //   },
                //   child: Icon(cubit.fabIcon),
                // ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xfff5b53f),
                          height: MediaQuery.of(context).viewPadding.top,
                        ),
                        Stack(
                            alignment: AlignmentDirectional.topStart,
                            children: [
                              ClipPath(
                                clipper: CustomShape(),
                                child: Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: const Color(0xfff5b53f),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // AppBar(
                                  //   elevation: 0.0,
                                  //   backgroundColor: Colors.transparent,
                                  //   leading: IconButton(
                                  //     onPressed: () {
                                  //       showMenu<String>(
                                  //           context: context,
                                  //           color: Colors.white,
                                  //           elevation: 5,
                                  //           shape: RoundedRectangleBorder(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(10)),
                                  //           position: const RelativeRect.fromLTRB(
                                  //               30, 40, double.infinity, 0),
                                  //           items: const [
                                  //             PopupMenuItem(
                                  //               value: 'name',
                                  //               child: Text('name'),
                                  //             ),
                                  //             PopupMenuItem(
                                  //               value: 'authorName',
                                  //               child: Text('authorName'),
                                  //             )
                                  //           ]).then((value) {
                                  //         if (value != null) {
                                  //           Navigator.pushNamed(context, searchScreen,
                                  //               arguments: value);
                                  //         }
                                  //       });
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.search,
                                  //       color: Colors.black,
                                  //       size: 35,
                                  //     ),
                                  //     splashRadius: 20,
                                  //     splashColor: Colors.transparent,
                                  //   ),
                                  //   actions: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Navigator.pushNamed(context, profileScreen,
                                  //             arguments: cubit.userModel);
                                  //       },
                                  //       hoverColor: Colors.transparent,
                                  //       borderRadius: BorderRadius.circular(200),
                                  //       focusColor: Colors.transparent,
                                  //       highlightColor: Colors.transparent,
                                  //       child: const Padding(
                                  //         padding: EdgeInsets.all(10.0),
                                  //         child: CircleAvatar(
                                  //           backgroundColor: Colors.white70,
                                  //           radius: 20,
                                  //           // backgroundImage: user.profilePic! !=""?  NetworkImage(
                                  //           //       user.profilePic!,
                                  //           // ) : const NetworkImage(
                                  //           //   'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                  //           // )
                                  //           backgroundImage: NetworkImage(
                                  //             'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     IconButton(
                                  //         onPressed: () {
                                  //           cubit.logOut().then((value) {
                                  //             navigateAndFinish(
                                  //                 context, SignInUPScreen());
                                  //           });
                                  //         },
                                  //         icon: Icon(Icons.exit_to_app))
                                  //   ],
                                  // ),
                                  defaultHeader(
                                    text: 'Recommended',
                                  ),
                                  cubit.reccomendedBooks.isNotEmpty
                                      ? CustomCarousel(
                                          listOfBookModel:
                                              cubit.reccomendedBooks,
                                        )
                                      : const Center(
                                          child: SizedBox(
                                            child: Text('No items Yet'),
                                          ),
                                        )
                                ],
                              ),
                            ]),


                        /// Category
                        defaultHeader(
                          text: 'Genres',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CarouselSlider.builder(
                            itemCount: category.length,
                            itemBuilder: (context, index, realIndex) => InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                // Navigator.pushNamed(context, categoryScreen);
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: colors[index],
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category[index].categoryName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                blurStyle: BlurStyle.normal,
                                                blurRadius: 10,
                                                offset: const Offset(0, 10))
                                          ],
                                        ),
                                        height: MediaQuery.of(context)
                                            .size
                                            .height /
                                            5,
                                        width: 100,
                                        child: Image(
                                          image: AssetImage(
                                              category[index].imagePath),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 3,
                              viewportFraction: 0.6,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                              const Duration(milliseconds: 600),
                            )),
                        const SizedBox(
                          height: 10,
                        ),

                        /// Header ==> new Releases
                        defaultHeader(
                          text: 'New Releases',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomListView(
                            listOfBook: cubit.horrorInterstBooks), //هتغير هنا
                        const SizedBox(
                          height: 10,
                        ),


                        BlocListener<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is BookAddedSuccessState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Uploaded Successfully')));
                            }
                          },
                          child: Container(),
                        )
                      ],
                    );
                  }),
                ),
              ),
            );
          },
        ));
  }
}






//  شغل عمرو

// var cubit = AuthCubit.get(context);
// // cubit.addBook(
// //     category: InterstsModel
// //         .categorys[Random().nextInt(InterstsModel.categorys.length)],
// //     nameAr: ' nameAr',
// //     nameEn: ' nameEn',
// //     authorName: ' authorName');
// cubit.addBook(
// category: InterstsModel
//     .categorys[Random().nextInt(InterstsModel.categorys.length)],
// name: "ahadith",
// authorName: "bokhari");