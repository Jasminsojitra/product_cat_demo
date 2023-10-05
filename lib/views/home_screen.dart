import 'package:flutter/material.dart';
import 'package:product_cat_demo/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import '../data/respose/status.dart';
import '../models/products_respo_model.dart';
import 'widgets/list_cat.dart';
import 'widgets/list_products.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchResourcesListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(
            builder: (context, value, _) {
              switch (value.listResponse.status) {
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
                case Status.error:
                  return Center(child: Text(value.listResponse.message.toString()));
                case Status.completed:
                  return Column(
                    children: [
                      Container(
                        height: 54,
                        child: ListCategory(value:value),
                      ),
                      ListProducts(
                        value: value,
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      value.seSelectedCatOrder();
                                    },
                                    child: const Text('Sort Category'))),
                            const SizedBox(
                              width: 1,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      value.seSelectedProOrder();
                                    },
                                    child: const Text('Sort Products'))),
                          ],
                        ),
                      )
                    ],
                  );
              }
              return Container();
            },
          ),
        ));
  }
}
