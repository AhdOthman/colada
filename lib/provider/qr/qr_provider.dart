import 'dart:developer';

import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/services/api/qr/chekin_qr.dart';
import 'package:coladaapp/services/api/qr/generate_visit_qr.dart';
import 'package:coladaapp/services/api/qr/validater_qr.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrProvider = ChangeNotifierProvider<QRProvider>((ref) => QRProvider());

class QRProvider with ChangeNotifier {
  String? _qrStoreId;
  List<OffersModel>? _chrckInQR;
  List<OffersModel>? get getChrckInQRList => _chrckInQR;

  void setchrckInQROffers(List<OffersModel> offers) {
    _chrckInQR = offers;
    notifyListeners();
  }

  String? generatedQR;
  String? get getGeneratedQR => generatedQR;
  void generateVisitQR(String? data) {
    generatedQR = data;
    notifyListeners();
  }

  Future getValidateQR(String qrData) async {
    try {
      final response = await ValidateQR(qrData: qrData).fetch();
      log("response $response");
      print("getValidateQR $response");

      if (response['message'] == "OK") {
        _qrStoreId = response['dataResponse']["validQR"]["storeId"];

        return _qrStoreId;
      }

      return null;
    } on Failure catch (f) {
      UIHelper.showNotification("wrong QR");
      return null;
    }
  }

  Future getCheckInQR(String storeId) async {
    List<OffersModel>? storeOffers = [];

    try {
      final response = await CheckinQR(storeId: storeId).fetch();
      log("response $response");
      for (var store in response['dataResponse']['checkIn']['data']) {
        storeOffers.add(OffersModel.fromJson(store));
      }
      print("getCheckInQR ${storeOffers.length}");
      setchrckInQROffers(storeOffers);

      return storeOffers;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return storeOffers;
    }
  }

  Future getGenerateVisitQR(String visitId) async {
    try {
      final response = await GenerateVisitQR(visitId: visitId).fetch();
      log("response $response");
      String? generatedQR;
      if (response['message'] == "CREATED") {
        print(response['dataResponse']['visitQR']);
        generatedQR = response['dataResponse']['visitQR'];
        print(generatedQR);

        return response['dataResponse']['visitQR'];
      }
      generateVisitQR(generatedQR);

      return generatedQR;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }
}
