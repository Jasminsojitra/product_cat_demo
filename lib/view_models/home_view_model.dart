import 'package:flutter/foundation.dart';
import 'package:product_cat_demo/Models/products_respo_model.dart';
import 'package:product_cat_demo/data/respose/api_response.dart';
import 'package:product_cat_demo/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final myRepo = HomeRepository();

  //Response loading
  ApiResponse<ProductsRespoModel> listResponse = ApiResponse.loading();

//Setter method to pass a generic response
  setListResponse(ApiResponse<ProductsRespoModel> response) {
    listResponse = response;
    notifyListeners();
  }

  String selectedCat = 'all';

  seSelectedCat(category, List<Product> products) {
    selectedCat = category;
    uniqueListCat.forEach((element) => element.isSelected = false);
    uniqueListCat[uniqueListCat.indexWhere((element) => element.category == category)].isSelected = true;
    if (category == 'all') {
      catListPro = products;
    } else {
      catListPro = products.where((data) => data.category == category).toList();
    }
    isAscPro = true;
    seSelectedProOrder();
    notifyListeners();
  }

  allCategory(isSelected) {
    uniqueListCat.add(Product(
        id: 0,
        title: "all",
        description: 'description',
        price: 0,
        discountPercentage: 0,
        rating: 0,
        stock: 0,
        brand: 'brand',
        category: 'all',
        thumbnail: 'thumbnail',
        images: [],
        isSelected: isSelected));
  }

  bool isAsc = false;

  seSelectedCatOrder() {
    //uniquelist.
    uniqueListCat.removeLast();
    if (isAsc) {
      uniqueListCat.sort((a, b) => a.category.compareTo(b.category));
    } else {
      uniqueListCat.sort((a, b) => -a.category.compareTo(b.category));
    }
    if (selectedCat == 'all') {
      allCategory(true);
    } else {
      allCategory(false);
    }
    isAsc = !isAsc;
    notifyListeners();
  }

  bool isAscPro = false;
  seSelectedProOrder() {
    if (isAscPro) {
      catListPro.sort((a, b) => a.title.compareTo(b.title));
    } else {
      catListPro.sort((a, b) => -a.title.compareTo(b.title));
    }
    isAscPro = !isAscPro;
    notifyListeners();
  }

  var setUnique = Set<String>();
  List<Product> uniqueListCat = [];
  List<Product> catListPro = [];

  Future<void> fetchResourcesListApi() async {
    setListResponse(ApiResponse.loading());
    myRepo.homeScreenApi().then((value) {
      uniqueListCat = value.products.where((category) => setUnique.add(category.category)).toList();
      uniqueListCat.sort((a, b) => a.category.compareTo(b.category));
      catListPro = value.products;
      catListPro.sort((a, b) => a.title.compareTo(b.title));
      allCategory(true);
      setListResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        setListResponse(ApiResponse.error(error.toString()));
        print(error);
      }
    });
  }
}
