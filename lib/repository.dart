import 'package:blocproducts/model.dart';
import 'package:blocproducts/service.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<UserModel> fetchCovidList() {
    return _provider.fetchCovidList();
  }
}

class NetworkError extends Error {}
