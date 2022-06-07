import 'package:flutter/material.dart';
import 'package:ketabna/core/models/book_model.dart';
import '../../core/constants/strings.dart';
import '../../core/models/book_model.dart';
import '../../core/utils/size_config.dart';





class CategoryScreen extends StatelessWidget {
  CategoryScreen({ Key? key, required this.categoryName,required this.book}) : super(key: key);
  final String? categoryName;
  List<BookModel> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,
        elevation: 0.0,
        backgroundColor:  Colors.transparent,
        iconTheme: const IconThemeData(
          color: Color(0xfff5b53f),
          size: 25,
        ),
        title:  Text (
          categoryName!,
          textAlign:TextAlign.center ,
          style: const TextStyle(
            fontSize: 25,
            color: Color(0xfff5b53f),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          children:
            book.map((item)=>
              InkWell(
                onTap: () {
                Navigator.pushNamed(context, bookScreen, arguments: item);},
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: item.picture != ""
                              ? DecorationImage(
                            image: NetworkImage(
                              item.picture!,
                            ),
                            fit: BoxFit.fill,
                          )
                              : const DecorationImage(
                            image: AssetImage(
                              'assets/image/Books.png',
                            ),
                          ),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(width: 1)),
                      height: 122,
                      width: 120,

                    ),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize as double),
                      child: Text(

                        '${item.name}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),

                    Text(
                      '${item.authorName}',
                      style: TextStyle( color: Colors.grey[500],fontSize: 11, fontWeight: FontWeight.w300),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ).toList()
        ),
      ),
    );
  }
}
