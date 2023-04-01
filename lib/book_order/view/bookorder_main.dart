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
  final List<dynamic> data = [
    {
      'title': 'Book Register',
      'route': AppRoute.routeBookOrderRegister,
      'image':
          'https://img.lovepik.com/photo/20211122/medium/lovepik-national-library-picture_500661719.jpg'
    },
    {
      'title': 'Book Order Detail',
      'route': AppRoute.routeBookOrderList,
      'image':
          'https://img.dantocmiennui.vn/t620/uploaded/ngotzz/2020_06_10/uah_1_1.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      title: 'BookOrder',
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) => ScreenItem(
              title: data[index]['title'] as String,
              route: data[index]['route'] as String,
              image: data[index]['image'] as String,
            ),
          )),
    );
  }
}
