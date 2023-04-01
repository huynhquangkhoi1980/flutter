import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/book_order/models/book.dart';

class BookItem extends StatelessWidget {
  final Book book;

  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(border: Border.all()),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('${book.title}'),
              )),
          VerticalDivider(
            width: 2,
            color: Colors.black,
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: TextButton(
                  child: Text(
                    'Show',
                    style: TextStyle(
                        color: Colors.orange[400], fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.routeBookOrderApprove,
                        arguments: book);
                  },
                ),
              ))
        ],
      ),
    );
  }
}
