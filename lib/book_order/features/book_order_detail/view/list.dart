import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/book_order/features/book_order_detail/bloc/book_list_block.dart';
import 'package:mevn_app/book_order/features/book_order_detail/bloc/book_list_state.dart';
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
  final List<dynamic> categories = [
    {'title': 'Human Skill', 'value': 'Human Skill'},
    {'title': 'Organization', 'value': 'Organization'},
    {'title': 'Programming', 'value': 'Programming'},
    {'title': 'Comic', 'value': 'Comic'},
    {'title': 'Language', 'value': 'Language'},
    {'title': 'Other', 'value': 'Other'}
  ];
  final List<dynamic> approves = [
    {'title': 'Approve Not Yet', 'value': 'Approve Not Yet'},
    {'title': 'Approved', 'value': 'Approved'}
  ];

  final titleController = TextEditingController();

  String dropdownValue = 'Human Skill';
  String approveDropdownValue = 'Approve Not Yet';

  late BookListBloc _bookListBloc;

  double iconSize = 40;

  @override
  void initState() {
    super.initState();
    _bookListBloc = BookListBloc(locator.get());

    // dropdownValue = categories[0]['value'] as String;
    // approveDropdownValue = approves[0]['value'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookListBloc>(
      create: (context) => _bookListBloc,
      child: BlocBuilder<BookListBloc, BookListState>(
        builder: (context, state) {
          return ContentWidget(
            title: 'Book Order List',
            body: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        cursorColor: Colors.orange[400],
                        controller: titleController,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              'Enter category:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            items: categories
                                .map((e) => DropdownMenuItem<String>(
                                      value: e['value'] as String,
                                      child: Text('${e['title']}'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              'Enter status:',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          DropdownButton<String>(
                            value: approveDropdownValue,
                            items: approves
                                .map((e) => DropdownMenuItem<String>(
                                      value: e['value'] as String,
                                      child: Text('${e['title']}'),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                approveDropdownValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state is LoadingBookListState)
                      CircularProgressIndicator()
                    else
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.orange[400])),
                          onPressed: () {
                            _bookListBloc.searchBook(titleController.text,
                                dropdownValue, approveDropdownValue);
                          },
                          child: const Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    if (state is SearchBookListState)
                      Container(
                        height: 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.books.length,
                          itemBuilder: (context, index) =>
                              BookItem(state.books[index]),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
