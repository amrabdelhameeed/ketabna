
import 'package:flutter/material.dart';
import 'package:ketabna/core/widgets/default_form_button.dart';


class VisitorScreen extends StatefulWidget {
  const VisitorScreen({Key? key}) : super(key: key);

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  bool isSwitch1 = false;
  bool isSwitch2 = false;

  List<Map<String,Object>> itemBook = [
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description' : 'My Book',
      'isCheckedSwitch': false
    },
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description' : 'My Book',
      'isCheckedSwitch': false
    },
    {
      'title': 'Book',
      'image': 'assets/image/ph.jpg',
      'description' : 'My Book',
      'isCheckedSwitch': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color:Color(0xFFF5B53F)  , // AppColors.secondaryColor
          size: 32,
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // profile image
            const  CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'assets/image/ph.jpg'
              ) ,
            ),

            const SizedBox(height: 15,),
            // Name
            Text(
              'Will Newman',
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold

              ),
            ),

            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    DefaultFormButton(
                      text: 'Call',
                      width: 120,
                      height: 35,
                      radius: 10,
                      padding: 10,
                      textColor: Colors.white,
                      fillColor:  Colors.grey.shade600
                    ) ,

                    const Icon(
                        Icons.add_call,
                    color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(width: 30,),
                DefaultFormButton(
                  text: 'Chat',
                  width: 120,
                  height: 35,
                  radius: 10,
                  padding: 10,
                  textColor: Colors.white,
                  fillColor: const Color(0xFFF5B53F) ,

                ),
              ],
            ),

            const SizedBox(height: 15,),
            // text My books
            Text(
              'Books',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 15,),

            // item book
            GridView.count(
              shrinkWrap: true,
              // padding: EdgeInsetsDirectional.only(start: 15 , bottom: 10, top: 10),
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 3,
              primary: false,
              crossAxisSpacing: 3,
              crossAxisCount: 3,
              children: [
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),

              ],
            ),
          ],
        ),
      ) ,
    );

  }


Widget buildItem(){
    return
    Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(

            borderRadius: BorderRadius.circular(10),
            child: const Image(

              image: AssetImage('assets/image/ph.jpg'),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'name',
          style:  TextStyle(
            fontWeight: FontWeight.bold,
          ),

          maxLines: 3,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'dis',
          style: TextStyle(
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,

        ),
      ],
    );
}
}