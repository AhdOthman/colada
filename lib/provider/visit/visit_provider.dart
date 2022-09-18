import 'dart:developer';

import 'package:coladaapp/models/pagination_model.dart';
import 'package:coladaapp/models/visits/check_out_details.dart';
import 'package:coladaapp/models/visits/create_visits_model.dart';
import 'package:coladaapp/models/visits/user_visits_model.dart';
import 'package:coladaapp/models/visits/user_visits_with_pagination.dart';
import 'package:coladaapp/services/api/offers/create_user_visits.dart';
import 'package:coladaapp/services/api/visit/check_out_details.dart';
import 'package:coladaapp/services/api/visit/create_visit_review.dart';
import 'package:coladaapp/services/api/visit/get_current_visits.dart';
import 'package:coladaapp/services/api/visit/get_user_visits.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visitProvider =
    ChangeNotifierProvider<VisitProvider>((ref) => VisitProvider());

class VisitProvider with ChangeNotifier {
  List<UserVisits>? _currentVisits;
  List<UserVisits>? get getCurrentVisits => _currentVisits;
  UserVisitsWithPagination? _userVisits = UserVisitsWithPagination();
  CheckOutDetails? _checkOutDetails;
  CheckOutDetails? get getCheckOutDetails => _checkOutDetails;

  CreateVisits? _createdVisits;
  CreateVisits? get getCreatedVisits => _createdVisits;

  UserVisits? clieckUserVisits;

  UserVisitsWithPagination? get userVisits => _userVisits;
  void setCurrentVisits(List<UserVisits>? currentVisits) {
    _currentVisits = currentVisits;
    notifyListeners();
  }

  void clearVisits() {
    if (_userVisits!.visits != null) {
      _userVisits!.visits!.clear();
    }
    notifyListeners();
  }

  void setuserVisits(List<UserVisits> userVisits) {
    if (_userVisits!.visits == null) {
      _userVisits!.visits = userVisits;
    } else {
      _userVisits!.visits!.addAll(userVisits);
    }
    notifyListeners();
  }

  void setCreatedUserVisits(CreateVisits? userVisits) {
    _createdVisits = userVisits;
    notifyListeners();
  }

  void setCheckOutDetails(CheckOutDetails? checkOutDetails) {
    _checkOutDetails = checkOutDetails;
    notifyListeners();
  }

  Future getUserVisits(
      {required String customerId, int? perPage, int? page}) async {
    List<UserVisits> userVisits = [];

    try {
      final response = await GetUserVisits(
              customerId: customerId, page: page = 1, perPage: perPage = 2)
          .fetch();

      log("response $response");
      print("userVisits $response");

      for (var visits in response['dataResponse']['currentVisits']['data']) {
        userVisits.add(UserVisits.fromJson(visits));
      }
      _userVisits!.pagination = Pagination.fromJson(
          response['dataResponse']['currentVisits']['pagination']);
      print("userVisits ${userVisits.length}");
      setuserVisits(userVisits);

      return userVisits;
    } on Failure catch (f) {
      return f;
    }
  }

  Future getCurrentVisit(String customerId) async {
    List<UserVisits>? userVisits = [];

    try {
      final response = await GetCurrentVisits(customerId: customerId).fetch();
      log("response $response");
      print("current user $response");

      for (var visits in response['dataResponse']['data']) {
        userVisits.add(UserVisits.fromJson(visits));
      }
      print("userVisits ${userVisits.length}");
      setCurrentVisits(userVisits);

      return userVisits;
    } on Failure catch (f) {
      return userVisits;
    }
  }

  Future<CreateVisits?> postCreateUserVisit(
      {required String storeId,
      required String offerId,
      required String customerId}) async {
    CreateVisits? userVisits;

    try {
      final response = await CreateUserVisits(
              customerId: customerId, offerId: offerId, storeId: storeId)
          .fetch();
      log("response $response");
      print("current user $response");

      setCreatedUserVisits(CreateVisits.fromJson(response['dataResponse']));

      //  print("userVisits ${userVisits.length}");
      setCreatedUserVisits(userVisits);

      return userVisits;
    } on Failure catch (f) {
      log("response $f");

      return userVisits;
    }
  }

  Future<CreateVisits?> postCreateVisitReview(
      {required String comment,
      required double rating,
      required String visitId}) async {
    CreateVisits? userVisits;

    try {
      print(" comment $comment");
      print(" rating $rating");
      print(" visitId $visitId");

      final response = await CreateVisitReview(
              visitId: visitId, rating: rating, comment: comment)
          .fetch();
      log("response $response");
      print("current user $response");

      return userVisits;
    } on Failure catch (f) {
      log("response $f");

      return userVisits;
    }
  }

  Future<CheckOutDetails?> postGetCheckOutDetails(
      {required String visitId}) async {
    CreateVisits? userVisits;
    CheckOutDetails? checkOutDetails;
    try {
      final response = await GetCheckOutDetails(
        visitId: visitId,
      ).fetch();
      log("response $response");
      checkOutDetails =
          CheckOutDetails.fromJson(response['dataResponse']["checkoutDetails"]);
      print("current user $response");
      setCheckOutDetails(checkOutDetails);
      return checkOutDetails;
    } on Failure catch (f) {
      log("response $f");

      return checkOutDetails;
    }
  }
}
