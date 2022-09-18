import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FagPage extends ConsumerStatefulWidget {
  const FagPage({Key? key}) : super(key: key);

  @override
  _FagPageState createState() => _FagPageState();
}

class _FagPageState extends ConsumerState<FagPage> {
  late Future _fetchFQAFuture;

  @override
  void initState() {
    _fetchFQAFuture = _fetchFAQBack();

    // _getUserVisitsFuture = _fetchGetFeaturedUserVisit();
    super.initState();
  }

  Future _fetchFAQBack() async {
    final userProv = ref.read(userProvider);
    return await userProv.getFAQ();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget(
        title: "FAQ",
      ),
      body: FutureBuilder(
        future: Future.wait([_fetchFQAFuture]),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError);
            return const Center(child: TextWidget('Something Wrong'));
          } else if (snapshot.hasData) {
            if (snapshot.data is Failure) {
              return Center(child: TextWidget(snapshot.data.toString()));
            }
            return SizedBox(
              width: size.width,
              //   height: 300,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final getFAQ = ref.watch(userProvider).getFAQList ?? [];
                  return getFAQ.isNotEmpty
                      ? ListView.builder(
                          itemCount: getFAQ.length,
                          itemBuilder: (context, index) {
                            return FAQCard(
                              answer: getFAQ[index].answer ?? '',
                              title: getFAQ[index].question ?? '',
                            );
                          },
                        )
                      : const Center(
                          child: TextWidget(
                          "unfortunately, There is no data available yet",
                          color: AppColors.gray,
                        ));
                  ;
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

class FAQCard extends StatelessWidget {
  final String title;
  final String answer;

  const FAQCard({Key? key, required this.title, required this.answer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList(String answer) {
      return buildItem(answer);
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            //   iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: buildList(answer),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
