import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/category_model.dart';
import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/home/widgets/custom_listview.dart';
import 'widgets/customShape.dart';
import 'widgets/customcarousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<String> image_genres = [
    'assets/images/Biography.jpg',
    'assets/images/Cookery.jpg',
    'assets/images/Children.jpg',
    'assets/images/Business.jpg',
    'assets/images/Graphic Novels.jpg',
  ];
  List<Color> colors = [
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.red,
    Colors.amber,
    Colors.blueAccent,
  ];

  List<String> name_genres = [
    'technology',
    'horror',
    'fantasy',
    'novel',
    'studying'
  ];

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress);

        final cantExit = timegap >= Duration(seconds: 2);

        pre_backpress = DateTime.now();

        if(cantExit){
          //show snackbar
          buildSnackBar(context,'Press Back button again to Exit');

          return false;
        }else{
          return true;
        }
      },
      child:  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var cubit = AuthCubit.get(context);
            // cubit.addBook(
            //     category: InterstsModel
            //         .categorys[Random().nextInt(InterstsModel.categorys.length)],
            //     nameAr: ' nameAr',
            //     nameEn: ' nameEn',
            //     authorName: ' authorName');
            cubit.addBook(
                category: InterstsModel
                    .categorys[Random().nextInt(InterstsModel.categorys.length)],
                name: "ahadith",
                authorName: "bokhari");
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(alignment: AlignmentDirectional.topStart, children: [
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
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showMenu<String>(
                                    context: context,
                                    position:
                                    const RelativeRect.fromLTRB(0, 0, 0, 0),
                                    items: const [
                                      PopupMenuItem(
                                        child: Text('name'),
                                        value: 'name',
                                      ),
                                      PopupMenuItem(
                                        child: Text('authorName'),
                                        value: 'authorName',
                                      )
                                    ]).then((value) {
                                  if (value != null) {
                                    Navigator.pushNamed(context, searchScreen,
                                        arguments: value);
                                  }
                                });
                              },
                              icon: const Icon(Icons.search, size: 30),
                            ),
                            const SizedBox(
                              width: 220,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications,
                                  size: 30,
                                )),
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                'https://th.bing.com/th/id/R.94add630f7d00e412d90070db8587021?rik=Mv4xaEwvaqalTg&pid=ImgRaw&r=0',
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  AuthCubit.get(context).logOut().then((value) {
                                    Navigator.pushReplacementNamed(
                                        context, signInUpScreen);
                                  });
                                },
                                icon: const Icon(Icons.exit_to_app))
                          ],
                        ),
                      ),
                      defaultHeader(
                        text: 'Recommended',
                      ),
                      cubit.reccomendedBooks.isNotEmpty
                          ? CustomCarousel(
                        listOfBookModel: cubit.reccomendedBooks,
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
                  text: 'horror',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomListView(listOfBook: cubit.horrorInterstBooks),
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
                    itemCount: name_genres.length,
                    itemBuilder: (context, index, realIndex) => Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          width: 180,
                          decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${CategoryModel.categories[index].categoryName}',
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
                                      color: Colors.black.withOpacity(0.5),
                                      blurStyle: BlurStyle.normal,
                                      blurRadius: 10,
                                      offset: const Offset(0, 10))
                                ],
                              ),
                              height: MediaQuery.of(context).size.height / 5,
                              width: 100,
                              child: Image(
                                image: AssetImage(
                                    '${CategoryModel.categories[index].imagePath}'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 3,
                      viewportFraction: 0.6,
                      autoPlay: true,
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 600),
                    )), //Genres
                const SizedBox(
                  height: 10,
                ),

                /// Recently Viewed
                defaultHeader(
                  text: 'children',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomListView(listOfBook: cubit.studingInterstBooks),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is BookAddedSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Uploaded Successfully')));
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
  }
}
