// Writen by BALY
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/category_model.dart';
import 'package:ketabna/core/models/intersts_model.dart';
import 'package:ketabna/core/utils/shared_pref_helper.dart';
import 'package:ketabna/features/choosing_categories_screen/widgets/category_item.dart';
import 'package:ketabna/main.dart';

class InterestedScreen extends StatefulWidget {
  const InterestedScreen({Key? key}) : super(key: key);

  @override
  State<InterestedScreen> createState() => _InterestedScreenState();
}

class _InterestedScreenState extends State<InterestedScreen> {
  final colorButton = 0xFFF5B53F;
  List<CategoryModel> categories = [
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Biography.jpg',
        categoryName: 'Biography'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Children.jpg',
        categoryName: 'Children'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Fantasy.jpg',
        categoryName: 'Fantasy'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Graphic Novels.jpg',
        categoryName: 'Graphic Novels'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/History.jpg',
        categoryName: 'History'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Horror.jpg',
        categoryName: 'Horror'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Romance.jpg',
        categoryName: 'Romance'),
    CategoryModel(
        isSelected: false,
        imagePath: 'assets/image/Science Fiction.jpg',
        categoryName: 'Science Fiction'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'What genres are you interested in ?',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                'What genres are you interested in What genres are you interested in ?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: Colors.grey)),
            const SizedBox(
              height: 20,
            ),
            /*********Grid View ******** */
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: categories.length,
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.hardEdge,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return CategoryItem(
                  categoryModel: categories[index],
                );
              },
            ),
            BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                    onPressed: () async {
                      await cubit.updateInterstedModel(
                          interstsModel: InterstsModel(
                              biography: categories[0].isSelected,
                              children: categories[1].isSelected,
                              fantasy: categories[2].isSelected,
                              graphicNovels: categories[3].isSelected,
                              history: categories[4].isSelected,
                              horror: categories[5].isSelected,
                              romance: categories[6].isSelected,
                              scienceFiction: categories[7].isSelected));

                      listOfUsersChoosedCategories
                          .add(cubit.instance.currentUser!.uid);
                      SharedPrefHelper.putlstStr(
                              key: keylst, value: listOfUsersChoosedCategories)
                          .then((value) {
                        print('eyh eldnya fe list : $value');
                        print(listOfUsersChoosedCategories);
                      });
                      Navigator.pushReplacementNamed(context, bottomNavBar);
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      // body: ,
    );
  }
}
