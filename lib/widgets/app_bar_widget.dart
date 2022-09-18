import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? appBar;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? titleWidget;
  final double? leadingWidth;
  final Color? backgroundColor;
  final double? elevation;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color? backColor;

  const AppBarWidget(
      {Key? key,
      this.title,
      this.appBar,
      this.actions,
      this.leading,
      this.backColor = Colors.black,
      this.automaticallyImplyLeading = true,
      this.titleWidget,
      this.backgroundColor = Colors.transparent,
      this.elevation = 0,
      this.centerTitle = true,
      this.leadingWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme:  IconThemeData(color: backColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      leadingWidth: leadingWidth ?? AppBar().leadingWidth,
      leading: leading,
      centerTitle: centerTitle,
      title: title == null
          ? titleWidget
          : Text(
              title!,
              style: Theme.of(context).textTheme.caption,
            ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
