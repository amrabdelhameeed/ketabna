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
import '../categoryscreen/category_screen.dart';
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
    Colors.white,
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
  Future<void> _refresh(BuildContext context) async {
    print('refresh');
    authCubit!
      // ..getCurrentFirestoreUser()
      ..getRecommended()
      ..getHorrorBooks()
      ..getTechnologyBooks()
      ..getFantasyBooks()
      ..getnovelBooks()
      ..getfictionBooks()
      ..getbiographyBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
        value: authCubit!,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                body: RefreshIndicator(
                  color: AppColors.secondaryColor,
                  onRefresh: () {
                    return _refresh(context);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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

                          /// Header ==> Recommended
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

                          /// Category
                          defaultHeader(
                            text: 'Genres',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CarouselSlider.builder(
                              itemCount: category.length,
                              itemBuilder: (context, index, realIndex) =>
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      // Navigator.pushNamed(context, categoryScreen);
                                      Navigator.push(context, MaterialPageRoute(builder:(context)=> CategoryScreen(categoryName: category[index].categoryName, book:cubit.horrorInterstBooks ,),));
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
                                                      blurStyle:
                                                          BlurStyle.normal,
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(0, 10))
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

                          BlocListener<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is BookAddedSuccessState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Uploaded Successfully')));
                              }
                            },
                            child: Container(),
                          )
                        ],
                      );
                    }),
                  ),
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