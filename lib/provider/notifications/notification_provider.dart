import 'dart:developer';

import 'package:coladaapp/models/notification/notification_data_model.dart';
import 'package:coladaapp/models/notification/notification_model.dart';
import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/services/api/notifications/get_user_notification.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = ChangeNotifierProvider<NotificationProvider>(
    (ref) => NotificationProvider());

class NotificationProvider with ChangeNotifier {
  NotificationModel? _notification;
  NotificationModel? get getNotification => _notification;

  void setNotification(NotificationModel notification) {
    _notification = notification;
    NotificationModel();
  }

  Future getUserNotification(String customerId) async {
    try {
      final response =
          await GetUserNotification(customerId: customerId).fetch();
      log("response $response");
      NotificationModel? notificationList =
          NotificationModel(data: [], offer: []);
      for (var notification in response['dataResponse']['offers']) {
        notificationList.offer!.add(OffersModel.fromJson(notification));
      }
      for (var notification in response['dataResponse']['data']) {
        notificationList.data!
            .add(NotificationDateModel.fromJson(notification));
      }

      print("notificationList ${notificationList.offer!.length}");
      print("notificationList ${notificationList.data!.length}");
      setNotification(notificationList);

      return notificationList;
    } on Failure catch (f) {
      print("notificationList $f");

      UIHelper.showNotification(f.message);
      return f;
    }
  }
}
