import 'dart:developer';

import 'package:coladaapp/models/offers/offers_item.dart';
import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/services/api/offers/get_active_offers.dart';
import 'package:coladaapp/services/api/offers/get_offets_details.dart';
import 'package:coladaapp/services/api/offers/get_store_offers.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final offersProvider =
    ChangeNotifierProvider<OffersProvider>((ref) => OffersProvider());

class OffersProvider with ChangeNotifier {
  List<OffersModel>? _offers;
  List<OffersModel>? get getOffersList => _offers;
  List<OffersModel>? _activeOffers;
  List<OffersModel>? get getActiveOffersList => _activeOffers;

  List<OfferItem>? _offerItem;
  List<OfferItem>? get getOfferItemList => _offerItem;

  void setOffers(List<OffersModel> offers) {
    _offers = offers;
    notifyListeners();
  }

  void setOfferItem(List<OfferItem> offers) {
    _offerItem = offers;
    notifyListeners();
  }

  void setActiveOffers(List<OffersModel> offers) {
    _activeOffers = offers;
    notifyListeners();
  }

  Future getStoresOffers(String storeId) async {
    try {
      final response = await GetStoreOffers(storeId: storeId).fetch();
      List<OffersModel> storeOffers = [];
      for (var store in response['dataResponse']['offers']['data']) {
        storeOffers.add(OffersModel.fromJson(store));
      }

      setOffers(storeOffers);

      return storeOffers;
    } on Failure catch (f) {
      //   UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getActiveOffers() async {
    List<OffersModel> storeOffers = [];

    try {
      final response = await GetActiveOffers().fetch();
      for (var store in response['dataResponse']['offers']['data']) {
        storeOffers.add(OffersModel.fromJson(store));
      }

      setActiveOffers(storeOffers);

      return storeOffers;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return storeOffers;
    }
  }

  Future getOffersDetails(String offerId) async {
    List<OfferItem> offerItem = [];

    try {
      final response = await GetOffersDetails(offerId: offerId).fetch();
      for (var store in response['dataResponse']['offer']['items']) {
        offerItem.add(OfferItem.fromJson(store));
      }

      setOfferItem(offerItem);
      print("offerItem ${offerItem.length}");
      return offerItem;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return offerItem;
    }
  }
}
