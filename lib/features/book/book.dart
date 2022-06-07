import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketabna/bloc/cubit/auth_cubit.dart';
import 'package:ketabna/core/constants/strings.dart';
import 'package:ketabna/core/models/book_model.dart';
import 'package:ketabna/core/utils/app_colors.dart';
import 'package:ketabna/core/utils/size_config.dart';
import 'package:ketabna/core/widgets/components.dart';
import 'package:ketabna/features/store/pay_semester_books.dart';
import 'package:ketabna/features/store/pdf_api.dart';

import '../store/pdf_viewer.dart';

final String myId = FirebaseAuth.instance.currentUser!.uid;

class BookScreen extends StatefulWidget {
  const BookScreen({Key? key, required this.bookModel}) : super(key: key);
  final BookModel bookModel;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  bool isDownloadingPdf = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xfff5b53f),
              expandedHeight: 250,
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              //title: Text(bookModel.name!),
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.bookModel.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                background: Image.network(
                  widget.bookModel.picture!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.bookModel.name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'By : ${widget.bookModel.authorName}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.defaultSize,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Category : ${widget.bookModel.category}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                  height: 110,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.bookModel.describtion ?? '',
                        textAlign: TextAlign.center,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          isDownloadingPdf = true;
                        });
                        if (widget.bookModel.bookOwners!.contains(myId) == false &&widget.bookModel.isPdf!){
                          print('first if');
                          navigateTo(context: context,widget: PayBookPrice(bookModel: widget.bookModel,),);
                          setState(() {
                            isDownloadingPdf = false;
                          });
                        } else if (widget.bookModel.isPdf! &&
                            widget.bookModel.bookOwners!.contains(myId)) {
                          print('second if');
                          final filePdf = await PdfApi.loadNetwork(
                              Uri.parse(widget.bookModel.bookLink!));
                          openPdf(context: context,
                              filePdf: filePdf,
                              bookModel: widget.bookModel);
                          setState(() {
                            isDownloadingPdf = false;
                          });
                        } else if(widget.bookModel.isPdf! == false){
                          setState(() {
                            isDownloadingPdf=false;
                          });
                          //view Profile
                          cubit
                              .getUserModelByOwnerUid(
                              widget.bookModel.ownerUid!)
                              .then((value) {


                            Navigator.pushNamed(context, visitorScreen,
                                arguments: value);
                          });
                        }
                      },
                      color: const Color(0xfff5b53f),
                      child: isDownloadingPdf ? const CircularProgressIndicator(
                        color: AppColors.mainColor,) : Text(widget
                          .bookModel.isPdf! ? 'Read the book.' :
                      'View Owner Profile',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    color: Colors.black26,
                    height: 60,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void openPdf({required BuildContext context, filePdf, bookModel}) {
    navigateTo(context: context,
      widget: PdfViewerPage(file: filePdf, bookModel: bookModel,),);
  }
}
// appBar: AppBar(
//   elevation: 0.0,
//   backgroundColor: Colors.white,
//   leading:IconButton(
//     splashColor: Colors.grey,
//     onPressed: (){},
//     icon: const Icon(
//       Icons.arrow_back_ios_sharp ,
//       color: Color(0xfff5b53f),
//     ),
//   ),
// ),