// Write by BALY

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/app_router.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/models/user_model.dart';
import 'package:ketabna/core/widgets/default_form_button.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/components.dart';
import '../features/on_boarding/sign_in_up_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitch1 = false;
  bool isSwitch2 = false;

  List<Map<String, Object>> itemBook = [
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description': 'My Book',
      'isCheckedSwitch': false
    },
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description': 'My Book',
      'isCheckedSwitch': false
    },
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description': 'My Book',
      'isCheckedSwitch': false
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>.value(
      value: authCubit!
        ..getCurrentFirestoreUser()
        ..getUserBooks(),
      child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        var cubit = AuthCubit.get(context);
        print(cubit.userModel!.name);
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.logOut().then((value) {
                      navigateAndFinish(context, SignInUPScreen());
                    });
                  },
                  child: Text('log out')),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: AppColors.secondaryColor,
              size: 32,
            ),
          ),
          body: Container(
            padding: const EdgeInsetsDirectional.all(10),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // profile image
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      // image
                      cubit.userModel!.picture == '' ||
                              cubit.userModel!.picture == null
                          ? const CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('assets/image/b.png'))
                          : CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  NetworkImage(cubit.userModel!.picture!)),
                      // camera icon
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.shade600,
                        child: IconButton(
                          tooltip: 'Upload Image',
                          splashRadius: 30,
                          onPressed: () {
                            //upload picture
                            cubit.editProfilePicture().then((value) {
                              AuthCubit.get(context).getCurrentFirestoreUser();
                            });
                          },
                          icon: const Icon(
                            Icons.linked_camera,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // Name
                  Text(
                    cubit.userModel!.name!,
                    maxLines: 1,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  DefaultFormButton(
                    text: 'Edit Profile',
                    width: 120,
                    height: 35,
                    radius: 10,
                    padding: 10,
                    textColor: Colors.white,
                    fillColor: AppColors.secondaryColor,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // text My books
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'My books',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // item book
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    if (cubit.userBooks.isEmpty) {
                      return const Center(
                        child: Text('there is no books added'),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildItemBook(
                            image: cubit.userBooks[index].picture ?? '',
                            context: context,
                            title: cubit.userBooks[index].name ?? '',
                            description:
                                cubit.userBooks[index].describtion ?? '',
                            isCheckedSwitch:
                                cubit.userBooks[index].isValid ?? false,
                            switchChange: (value) {
                              cubit.userBooks[index].isValid = value;
                              cubit.toggleSwitchOfBooks(
                                  val: value, book: cubit.userBooks[index]);
                              setState(() {});
                            }),
                        itemCount: cubit.userBooks.length,
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildItemBook({
    required BuildContext context,
    required String title,
    required String description,
    required String image,
    required Function switchChange,
    bool isCheckedSwitch = false,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: 20, start: 20, end: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Positioned(
              child: Text(
                title,
                maxLines: 1,
                softWrap: true,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              left: 30,
              top: 20,
            ),
            Positioned(
              child: Text(
                description,
                maxLines: 2,
                softWrap: true,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              left: 30,
              top: 40,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  end: 20, top: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                  width: 70,
                  height: 110,
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 0,
              child: Switch(
                  value: isCheckedSwitch,
                  activeColor: AppColors.secondaryColor,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    switchChange(value);
                  }),
            ),
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurStyle: BlurStyle.solid,
              offset: Offset.fromDirection(1),
              blurRadius: 2,
              spreadRadius: 2,
            )
          ],
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
