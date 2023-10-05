import 'package:product_cat_demo/Models/products_respo_model.dart';
import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_urls.dart';

class HomeRepository{
  BaseApiServices apiServices = NetworkApiService();
  Future<ProductsRespoModel> homeScreenApi() async {
    dynamic response = await apiServices.getApiResponse(AppUrl.baseUrl);
    try {
      return response= ProductsRespoModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}