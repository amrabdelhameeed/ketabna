import 'package:flutter/material.dart';
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
  var loginColor = Color(0xffefe9c2);
  double shadow = 0;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/image/on_boarding1.png',
        title: 'over 20+ book from all genders',
        body: 'We\'ve successfully Connecting Readers across Egypt'),
    BoardingModel(
        image: 'assets/image/on_boarding2.png',
        title: 'Sell or trade Your Old Books With Other Readers',
        body:
            'If you\'re looking to downsize, sell or recycle old books, Borrowed Books can help.'),
    BoardingModel(
        image: 'assets/image/G.png',
        title: 'Sell or trade Your Old Books With Other Readers',
        body:
            'If you\'re looking to downsize, sell or recycle old books, Borrowed Books can help.'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefe9c2),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (loginColor == Color(0xfff5b53f)) {
                  setState(() {
                    navigateAndFinish(context, SignInUPScreen());
                  });
                }
              },
              child: Text(
                'Lets start',
                style: TextStyle(
                  color: loginColor,
                ),
              ))
        ],
        elevation: 0,
        backgroundColor: Color(0xffefe9c2),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  if (index == boarding.length - 1) {
                    loginColor = Color(0xfff5b53f);
                  } else {
                    loginColor = Color(0xffefe9c2);
                  }
                });
              },
              controller: boardController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SmoothPageIndicator(
            effect: ColorTransitionEffect(
              dotColor: Color(0xffe2d6af),
              activeDotColor: Color(0xfff5b53f),
              spacing: 20,
            ),
            controller: boardController,
            count: boarding.length,
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Center(
        child: Column(
          children: [
            // PageView.builder(itemBuilder: (context , index) => )
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${model.title}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xfff5b53f)),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${model.body}',
                style: TextStyle(fontSize: 15, color: Color(0xfff5b53f)),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: Image(image: AssetImage('${model.image}'))),
          ],
        ),
      );
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => true);

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