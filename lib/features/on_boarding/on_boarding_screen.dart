import 'package:flutter/material.dart';
import 'package:ketabna/core/utils/shared_pref_helper.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/on_boarding/sign_in_up_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  var loginColor = const Color(0xffefe9c2);
  double shadow = 0;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/image/on_boarding1.png',
        title: 'Over 20+ book from all genders',
        body: 'We\'ve successfully connecting readers across egypt'),
    BoardingModel(
        image: 'assets/image/on_boarding2.png',
        title: 'Sell or trade your books with other readers',
        body:
            'If you\'re looking to downsize, sell or recycle books, Borrowed Books can help.'),
    BoardingModel(
        image: 'assets/image/G.png',
        title: 'Starting now ',
        body:
            'Let\'s Go'),
  ];

  bool isLast = false;
  double sizeIcon = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffefe9c2),
      appBar: AppBar(
        actions: [
          TextButton(

              onPressed: () {
                if (loginColor == const Color(0xfff5b53f)) {
                  setState(() {
                    submit();
                  });
                }
              },
              child: Text(
                'SKIP',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                  color:const Color(0xfff5b53f),
                  decoration: TextDecoration.underline,
                ),
              ))
        ],
        elevation: 0,
        backgroundColor: const Color(0xffefe9c2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast =true;
                        sizeIcon =32;
                        loginColor = const Color(0xfff5b53f);
                      });

                    } else {
                      setState(() {
                        isLast =false;
                        sizeIcon =24;
                        loginColor = const Color(0xffefe9c2);

                      });
                    }
                  });
                },
                controller: boardController,
                physics:const  BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    activeDotColor:  Color(0xfff5b53f),
                    spacing: 10.0,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,

                    // dotColor: Color(0xffe2d6af),


                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                const  Spacer(),
                FloatingActionButton(
                  tooltip: 'next page',
                  elevation: 0,
                  mini: isLast?false :true ,
                  backgroundColor:const Color(0xfff5b53f),
                  child:  Icon(
                    Icons.navigate_next,
                    size: sizeIcon,
                  ),
                  onPressed: (){
                    if (isLast){

                      setState(() {
                        submit();
                      });
                    }
                    else
                    {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 700,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },),

              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(

        children: [
          // PageView.builder(itemBuilder: (context , index) => )
         const  SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style:const  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xfff5b53f)),
            // textAlign: TextAlign.center,
            maxLines: 3,
          ),
         const  SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style:Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
                color: const Color(0xfff5b53f),
              fontWeight: FontWeight.w900,
            ),
            // textAlign: TextAlign.center,
          ),
          Expanded(child: Image(image: AssetImage(model.image))),
        ],
      ),
    ),
  );

  void submit(){

    SharedPrefHelper.saveData(key: 'onBoarding', value: true).then((value){
      if (value){
        navigateAndFinish(context, const SignInUpScreen());
      }
    });
  }
}



// void navigateAndFinish(
//   context,
//   widget,
// ) =>
//     Navigator.pushAndRemoveUntil(context,
//         MaterialPageRoute(builder: (context) => widget), (route) => true);



// FloatingActionButton(
// onPressed: (){
//
// },
// child: Icon(
// Icons.arrow_forward_rounded,
// ),
// backgroundColor: loginColor,
// elevation: shadow,
// ),