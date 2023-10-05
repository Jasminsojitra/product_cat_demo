import 'package:flutter/material.dart';
import 'package:product_cat_demo/view_models/home_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListProducts extends StatelessWidget {
  HomeViewViewModel value;
  ListProducts({required this.value,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 15, bottom: 10, left: 18, right: 18),
          shrinkWrap: true,
          itemCount: value.catListPro.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 170,
          ),
          itemBuilder: (context, index) {
            return Card(
                child: Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        value.catListPro[index].title.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child: CachedNetworkImage(
                      imageUrl: value.catListPro[index].images.first,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(value: downloadProgress.progress))),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${value.catListPro[index].price}',
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
