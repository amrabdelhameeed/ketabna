import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../core/widgets/components.dart';

class MediaForChat extends StatefulWidget {
  const MediaForChat({required this.imagesUrl});

  final List<String> imagesUrl;

  @override
  _MediaForChatState createState() => _MediaForChatState();
}

saveImageToGallery(path, context) async {
  buildSnackBar(context, 'Downloading....');
  await GallerySaver.saveImage(path).then((value) => {
        //show snackbar
        buildSnackBar(context, 'Saved to gallery'),
        Navigator.pop(context),
      });
}

class _MediaForChatState extends State<MediaForChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Media'),
        centerTitle: true,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2.8,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: widget.imagesUrl.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Download?'),
                    content: const Text('Do you want to download image?'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          saveImageToGallery(widget.imagesUrl[index], context);
                        },
                        child: const Text('Yes'),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                  barrierDismissible: false,
                );
              },
              child: FullScreenWidget(
                child: Center(
                  child: Hero(
                    tag: index,
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.imagesUrl[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
