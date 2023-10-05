import 'package:flutter/material.dart';
import 'package:product_cat_demo/view_models/home_view_model.dart';

class ListCategory extends StatelessWidget {
  HomeViewViewModel value;
  ListCategory({required this.value,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: value.uniqueListCat.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(value.listResponse.data!.products);
              value.seSelectedCat(
                  value.uniqueListCat[index].category, value.listResponse.data!.products);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
              decoration: BoxDecoration(
                  color: (value.uniqueListCat[index].isSelected ?? false)
                      ? Colors.blue
                      : Colors.transparent,
                  border: Border.all(
                    color: (value.uniqueListCat[index].isSelected ?? false)
                        ? Colors.blue
                        : Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                value.uniqueListCat[index].category,
                style: TextStyle(
                  color: (value.uniqueListCat[index].isSelected ?? false)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        });
  }
}
