import 'package:flutter/material.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

import '../../book_register/view/register.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import '../../../models/book.dart';
import '../items/book_item.dart';

class BookOrderListScreen extends StatefulWidget {
  const BookOrderListScreen({Key? key}) : super(key: key);

  @override
  State<BookOrderListScreen> createState() => _BookOrderListState();
}

class _BookOrderListState extends State<BookOrderListScreen> {
  dynamic dropdownValue = 'Human Skill';
  dynamic approveDropdownValue = 'Approve Not Yet';

  // final items = List<ListItem>.generate(
  //   1000,
  //   (i) => i % 6 == 0
  //       ? HeadingItem('Heading $i')
  //       : MessageItem('Sender $i', 'Message body $i'),
  // );

  double iconSize = 40;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      title: 'Book Order List',
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter book title',
                ),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: DropdownButton(
                value: dropdownValue,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'Human Skill',
                    child: Text('Human Skill'),
                  ),
                  DropdownMenuItem(
                    value: 'Organization',
                    child: Text('Organization'),
                  ),
                  DropdownMenuItem(
                    value: 'Programming',
                    child: Text('Programming'),
                  ),
                  DropdownMenuItem(
                    value: 'Comic',
                    child: Text('Comic'),
                  ),
                  DropdownMenuItem(
                    value: 'Language',
                    child: Text('Language'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: DropdownButton(
                value: approveDropdownValue,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    value: 'Approve Not Yet',
                    child: Text('Approve Not Yet'),
                  ),
                  DropdownMenuItem(
                    value: 'Approved',
                    child: Text('Approved'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    approveDropdownValue = value;
                  });
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Search'),
            ),

            const SizedBox(
              height: 50,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
                children: DUMMY_DATA.map((item) => BookItem(item.title.toString())).toList(),
              ),
            ),

            // Table(
            //   border: TableBorder.all(),
            //   columnWidths: const {
            //     0: FractionColumnWidth(0.7),
            //     1: FractionColumnWidth(.3)
            //   },
            //   children: [
            //     TableRow(children: [
            //       Column(children: const [
            //         Text('Title',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontWeight: FontWeight.bold))
            //       ]),
            //       Column(children: const [
            //         Text('Detail',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontWeight: FontWeight.bold))
            //       ]),
            //     ]),
            //     TableRow(
            //       children: [
            //         const Text(
            //           'The Lean Startup',
            //           textAlign: TextAlign.left,
            //           style: TextStyle(fontWeight: FontWeight.normal),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             setState(() {});
            //             Navigator.pushNamed(context, AppRoute.routeBookOrderRegister);
            //           },
            //           child: const Text('Show'),
            //         ),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         const Text(
            //           'Steve Job',
            //           textAlign: TextAlign.left,
            //           style: TextStyle(fontWeight: FontWeight.normal),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             setState(() {});
            //           },
            //           child: const Text('Show'),
            //         ),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         const Text(
            //           'Art',
            //           textAlign: TextAlign.left,
            //           style: TextStyle(fontWeight: FontWeight.normal),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             setState(() {});
            //           },
            //           child: const Text('Show'),
            //         ),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         const Text(
            //           'Japanese N1',
            //           textAlign: TextAlign.left,
            //           style: TextStyle(fontWeight: FontWeight.normal),
            //         ),
            //         ElevatedButton(
            //           onPressed: () {
            //             setState(() {});
            //           },
            //           child: const Text('Show'),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
          ),
        ),
      ),
    );
  }
}

List<Book> DUMMY_DATA = [
  Book(title: 'Title 1', link: 'Link 1', purpose: 'Purpose 1', kind: 'Kind 1'),
  Book(title: 'Title 2', link: 'Link 2', purpose: 'Purpose 2', kind: 'Kind 2'),
  Book(title: 'Title 3', link: 'Link 3', purpose: 'Purpose 3', kind: 'Kind 3'),
  Book(title: 'Title 4', link: 'Link 4', purpose: 'Purpose 4', kind: 'Kind 4'),
  Book(title: 'Title 5', link: 'Link 5', purpose: 'Purpose 5', kind: 'Kind 5'),
  Book(title: 'Title 6', link: 'Link 6', purpose: 'Purpose 6', kind: 'Kind 6'),
  Book(title: 'Title 7', link: 'Link 7', purpose: 'Purpose 7', kind: 'Kind 7'),


];
