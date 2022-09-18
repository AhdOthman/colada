import 'dart:math';

import 'package:coladaapp/models/pagination_model.dart';
import 'package:coladaapp/models/stores/filtter_data.dart';
import 'package:coladaapp/models/stores/store_model.dart';
import 'package:coladaapp/models/stores/store_model_with_pagination.dart';
import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/services/api/favorite/add_favorite_stores_api.dart';
import 'package:coladaapp/services/api/favorite/get_favorite_stores_api.dart';
import 'package:coladaapp/services/api/favorite/remove_favorite_store_api.dart';
import 'package:coladaapp/services/api/stores/filter_store.dart';
import 'package:coladaapp/services/api/stores/get_stores_api.dart';
import 'package:coladaapp/services/api/stores/search_stores_api.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final storeProvider =
    ChangeNotifierProvider<StoresProvider>((ref) => StoresProvider());

class StoresProvider with ChangeNotifier {
  StoreModelWithPagination _favoriteStores = StoreModelWithPagination();
  StoreModelWithPagination _restaurants = StoreModelWithPagination();
  StoreModelWithPagination _featuredStores = StoreModelWithPagination();
  StoreModelWithPagination _featuredStoresWithPagination =
      StoreModelWithPagination();

  StoreModelWithPagination? get featuredStores => _featuredStores;
  List<StoreModel>? _searchedStores;
  List<StoreModel>? get searchedStores => _searchedStores;
  StoreModelWithPagination get favoriteStores => _favoriteStores;
  StoreModelWithPagination get restaurants => _restaurants;
  StoreModel storeModel = StoreModel();
  String? _location;

  void changeCategoriesData(int index, {bool clear = false}) {
    if (clear == false) {
      if (index == 0) {
        if (categoriesData[index].isSelected == false) {
          for (var element in categoriesData) {
            element.isSelected = false;
          }
          categoriesData[index].isSelected = true;
        } else {
          categoriesData[index].isSelected = false;
        }
      } else {
        categoriesData[0].isSelected = false;

        categoriesData[index].isSelected = !categoriesData[index].isSelected;
      }
    } else {
      for (var element in categoriesData) {
        element.isSelected = false;
      }
    }
    notifyListeners();
  }

  void changeTimingData(int index, {bool clear = false}) {
    if (clear == false) {
      timingData[index].isSelected = !timingData[index].isSelected;
    } else {
      for (var element in timingData) {
        element.isSelected = false;
      }
    }
    notifyListeners();
  }

  void changeCuisinesData(int index, {bool clear = false}) {
    if (clear == false) {
      if (index == 0) {
        if (cuisinesData[index].isSelected == false) {
          for (var element in cuisinesData) {
            element.isSelected = false;
          }
          cuisinesData[index].isSelected = true;
        } else {
          cuisinesData[index].isSelected = false;
        }
      } else {
        cuisinesData[0].isSelected = false;

        cuisinesData[index].isSelected = !cuisinesData[index].isSelected;
      }
    } else {
      for (var element in cuisinesData) {
        element.isSelected = false;
      }
    }
    //cuisinesData[index].isSelected = !cuisinesData[index].isSelected;
    notifyListeners();
  }

  setNewLocation(String location) {
    _location = location;
    notifyListeners();
  }

  String? get getLocation => _location;
  void setRestaurants(List<StoreModel> restaurants) {
    if (_restaurants.stores == null) {
      _restaurants.stores = restaurants;
    } else {
      _restaurants.stores!.addAll(restaurants);
    }
    print("_restaurants.stores!.length ${_restaurants.stores!.length}");
    notifyListeners();
  }

  void clearFavoriteStores() {
    favoriteStores.stores!.clear();
    notifyListeners();
  }

  void clearFeatured() {
    _featuredStores.stores!.clear();
    notifyListeners();
  }

  void clearRestaurants() {
    restaurants.stores!.clear();
    print("restaurants.length ${_featuredStores.stores!.length}");

    notifyListeners();
  }

  void setFavoriteStores(List<StoreModel> favoriteStores) {
    if (_favoriteStores.stores == null) {
      _favoriteStores.stores = favoriteStores;
    } else {
      _favoriteStores.stores!.addAll(favoriteStores);
    }
    notifyListeners();
  }

  void setSearchedStores(List<StoreModel> searchedStores) {
    _searchedStores = searchedStores;
    notifyListeners();
  }

  void cleanSearchedStores() {
    _searchedStores = null;
    notifyListeners();
  }

  void setFeaturedStores(List<StoreModel> featuredStores) {
    if (_featuredStores.stores == null) {
      _featuredStores.stores = featuredStores;
    } else {
      _featuredStores.stores!.addAll(featuredStores);
    }
    print(_featuredStores.stores?.length);
    print(_featuredStores.pagination?.page);
    notifyListeners();
  }

  Future getStores(UserLocationModel location,
      {bool isFeatured = true, int? perPage = 3, int? page = 1}) async {
    try {
      final response = await GetStoresApi(
              location: location,
              page: page,
              perPage: perPage,
              isFeatured: isFeatured)
          .fetch();
      List<StoreModel> stores = [];
      for (var store in response['dataResponse']['stores']['data']) {
        stores.add(StoreModel.fromJson(store));
      }
      print(" isFeatured ------------------");

      print("isFeatured is $isFeatured");
      print("isFeatured is perPage $perPage");
      print("isFeatured is page $page");
      print(
          "isFeatured ${response['dataResponse']['stores']['pagination']['hasNextPage']}");

      print(" isFeatured ------------------");

      isFeatured
          ? _featuredStores.pagination = Pagination.fromJson(
              response['dataResponse']['stores']['pagination'])
          : _restaurants.pagination = Pagination.fromJson(
              response['dataResponse']['stores']['pagination']);
      isFeatured ? setFeaturedStores(stores) : setRestaurants(stores);
      return stores;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getFavoriteStores(
      {required String customerId, int? perPage = 3, int? page = 1}) async {
    try {
      final response = await GetFavoriteStores(
              customerId: customerId, page: page, perPage: perPage)
          .fetch();
      List<StoreModel> stores = [];
      for (var store in response['dataResponse']['stores']['data']) {
        stores.add(StoreModel.fromJson(store));
      }
      setFavoriteStores(stores);
      _favoriteStores.pagination =
          Pagination.fromJson(response['dataResponse']['stores']['pagination']);
      return _favoriteStores;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  List<String> getSelectedCategories() {
    List<String> categories = [];

    for (var element in categoriesData) {
      if (element.value == 'All' && element.isSelected) {
        for (var element in categoriesData) {
          categories.add((element.value));
        }
      } else if (element.isSelected) {
        categories.add(element.value);
      }
    }

    return categories;
  }

  Map<String, dynamic> getSelectedTiming() {
    Map<String, dynamic> timing = {};
    List<int> time = [];
    for (var element in timingData) {
      if (element.isSelected) {
        time.add(int.parse(element.startTime!));
        time.add(int.parse(element.endTime!));
      }
    }
    if (time.isNotEmpty) {
      DateTime now = DateTime.now();
      timing['weekday'] = DateFormat('EEEE').format(now);
      timing['openingTime'] = time.reduce(min);
      timing['closingTime'] = time.reduce(max);
    }

    return timing;
  }

  List<String> getSelectedCuisines() {
    List<String> cuisines = [];
    for (var element in cuisinesData) {
      if (element.value == 'All' && element.isSelected) {
        for (var element in cuisinesData) {
          cuisines.add((element.value));
        }
      } else if (element.isSelected) {
        cuisines.add(element.value);
      }
    }
    return cuisines;
  }

  Future getSearchedStores(String searchTerm) async {
    try {
      final response = await GetSearchStoresApi(searchTerm: searchTerm).fetch();
      print("getSearchedStores $response");

      List<StoreModel> stores = [];
      for (var store in response['dataResponse']['stores']) {
        stores.add(StoreModel.fromJson(store));
      }
      setSearchedStores(stores);
      print("getSearchedStores ${stores.length}");

      return stores;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getFiltterStores(
      {required List<String> categories,
      required List<String> cuisines,
      required Map<String, dynamic> workingHours}) async {
    try {
      final response = await GetFiltterStores(
              categories: categories,
              cuisines: cuisines,
              workingHours: workingHours)
          .fetch();

      List<StoreModel> stores = [];
      for (var store in response['dataResponse']['stores']['data']) {
        stores.add(StoreModel.fromJson(store));
      }
      setSearchedStores(stores);

      return stores;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future addFavoriteStores({required String customerId, storeId}) async {
    try {
      final response =
          await AddFavoriteStores(customerId: customerId, storeId: storeId)
              .fetch();

      notifyListeners();

      return response['dataResponse']['user'];
    } on Failure catch (f) {
      print("fav response $f");

      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future removeFavoriteStores({required String customerId, storeId}) async {
    try {
      final response =
          await RemoveFavoriteStores(customerId: customerId, storeId: storeId)
              .fetch();

      notifyListeners();

      return response['dataResponse']['user'];
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }
}
