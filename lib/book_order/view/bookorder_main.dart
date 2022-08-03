import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';
import 'package:mevn_app/kickoff/widget/screen_item.dart';

class BookOrderScreen extends StatefulWidget {
  const BookOrderScreen({Key? key}) : super(key: key);

  @override
  State<BookOrderScreen> createState() => _BookOrderState();

  
}

class _BookOrderState extends State<BookOrderScreen> {
  // final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      title: 'BookOrder',
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            SizedBox(
              height: 20,
            ),
            ScreenItem(
              title: 'Book Register',
              route: AppRoute.routeBookOrderRegister,
            ),
            ScreenItem(
              title: 'Book Order Detail',
              route: AppRoute.routeBookOrderList,
            )
          ],
        ),
      ),
    );
  }
}
