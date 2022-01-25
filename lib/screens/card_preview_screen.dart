import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPreviewScreen extends StatelessWidget {
  final String description;
  final String imageUrl;
  const CardPreviewScreen({Key? key,
    required this.description,
    required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black,
        title: const Text('Card Preview'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(description, style: TextStyle(fontSize: 18.h),),
          SizedBox(height: 20.h,),
          Expanded(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              minScale: 1,
              maxScale: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.fill,
                  ),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
