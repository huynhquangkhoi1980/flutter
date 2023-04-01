import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/constants/app_assets.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';
import 'package:mevn_app/app/utils/constants/app_constants.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.showAppbar,
    Key? key,
  }) : super(key: key);

  final bool showAppbar;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      height: widget.showAppbar ? 56 : 0,
      duration: const Duration(milliseconds: 500),
      child: AppBar(
        backgroundColor: AppColors.orangeMainColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(AppAssets.meLogoAppbar),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  AppConstants.appBarTitleUp,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppConstants.appBarTitleDown,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () => {Scaffold.of(context).openDrawer()},
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
