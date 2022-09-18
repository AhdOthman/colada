import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/notification/notification_model.dart';
import 'package:coladaapp/provider/notifications/notification_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/notifications_item_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  late Future _fetchUserNotificationFuture;

  @override
  void initState() {
    _fetchUserNotificationFuture = _fetchUserNotification();

    // _getUserVisitsFuture = _fetchGetFeaturedUserVisit();
    super.initState();
  }

  Future _fetchUserNotification() async {
    final userProv = ref.read(userProvider);
    final notificationProv = ref.read(notificationProvider);
    return await notificationProv.getUserNotification(userProv.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.notification_option.tr(),
      ),
      body: FutureBuilder(
        future: Future.wait([_fetchUserNotificationFuture]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError);
            return const Center(
                child: TextWidget(
                    'unfortunately, There is no data available yet'));
          } else if (snapshot.hasData) {
            if (snapshot.data is Failure) {
              return Center(child: TextWidget(snapshot.data.toString()));
            }
            return SizedBox(
              width: size.width,
              //   height: 300,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  NotificationModel? getNotificationList =
                      (ref.watch(notificationProvider).getNotification ?? [])
                          as NotificationModel?;
                  return ListView.builder(
                    itemCount: getNotificationList!.offer!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {},
                          child: NotificationsItemWidget(
                            notification: getNotificationList.offer![index],
                            notificationDate: getNotificationList.data!
                                .firstWhere((element) =>
                                    element.id ==
                                    getNotificationList.offer![index].id),
                          ));
                    },
                    //    scrollDirection: Axis.horizontal,
                  );
                },
              ),
            );
          }
          return const LoaderWidget();
        },
      ),
    );
  }
}
