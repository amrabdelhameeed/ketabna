import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/home/widgets/custom_listview.dart';
import 'widgets/customShape.dart';
import 'widgets/get_books.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: () {},
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
                        ],
                      ),
                    ),
                    defaultHeader(
                      text: 'Recommended',
                    ),
                    CustomCarousel(
                      listOfBookModel: cubit.reccomendedBooks,
                    ),
                  ],
                ),
              ]),

              /// Header ==> Recommended
              defaultHeader(
                text: 'technology',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListView(listOfBook: cubit.technologyInterstBooks),
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
                                '${name_genres[index]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 10,
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height / 5,
                                width: 100,
                                child: Image(
                                  image: AssetImage('${image_genres[index]}'),
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
                    autoPlayAnimationDuration: Duration(milliseconds: 600),
                  )), //Genres
              const SizedBox(
                height: 10,
              ),

              /// Recently Viewed
              defaultHeader(
                text: 'horror',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListView(listOfBook: cubit.horrorInterstBooks),
            ],
          );
        }),
      ),
    );
  }
}
