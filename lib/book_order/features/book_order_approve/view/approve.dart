import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mevn_app/app/di/injection.dart';
// import 'package:mevn_app/book_order/features/book_register/bloc/book_register_bloc.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

import '../../../../app/utils/route/app_route.dart';
import '../bloc/book_approve_bloc.dart';

class BookOrderApproveScreen extends StatefulWidget {
  final dynamic arguments;
  const BookOrderApproveScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<BookOrderApproveScreen> createState() => _BookOrderApproveState();
}

class _BookOrderApproveState extends State<BookOrderApproveScreen> {
  dynamic kindSelected = 'human-skill';

  final titleController = TextEditingController();
  final linkController = TextEditingController();
  final purposeController = TextEditingController();
  final commentController = TextEditingController();
  final commentCorporateController = TextEditingController();

  late BookApproveBloc _bookApproveBloc;
  // String day = DateFormat('EEEE').format(DateTime.now());
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _bookApproveBloc = BookApproveBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    Book book = widget.arguments as Book;

    return ContentWidget(
      title: 'Book Order Detail',
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'Title:',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      book.title!,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[400]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'Link:',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      book.link!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'Purpose:',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      book.purpose!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'Kind:',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      book.kind!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (book.comment!.isEmpty)
              Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      cursorColor: Colors.orange[400],
                      controller: commentController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter approve comment',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.orange[400])),
                            onPressed: () {
                              var book = Book(
                                  title: titleController.text,
                                  link: linkController.text,
                                  purpose: purposeController.text,
                                  kind: kindSelected as String,
                                  approved: 'Approve Not Yet',
                                  comment: '',
                                  commentCorporate: '');
                              _bookApproveBloc.sendApproveBook(book);
                            },
                            child: const Text(
                              'Approve',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          width: 160,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 2, color: Colors.orange[400]!),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.routeBookOrderList,
                                arguments: book,
                              );
                            },
                            child: Text(
                              'Deny',
                              style: TextStyle(color: Colors.orange[400]),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            else
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              'Status:',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              book.approved!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              'Comment:',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              book.comment!,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              InkWell(
                                child: const Icon(Icons.calendar_month),
                                onTap: () async {
                                  final newDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );

                                  // If 'Cancel' => null
                                  if (newDate == null) return;

                                  // If 'OK' => DateTime
                                  setState(() => date = newDate);
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${date.year}/${date.month}/${date.day}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      cursorColor: Colors.orange[400],
                      controller: commentCorporateController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter Corporate comment',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange[400])),
                    onPressed: () {
                      var book = Book(
                          title: titleController.text,
                          link: linkController.text,
                          purpose: purposeController.text,
                          kind: kindSelected as String,
                          approved: 'Approve Not Yet',
                          comment: '',
                          commentCorporate: '');
                      _bookApproveBloc.sendApproveBook(book);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 50,
            )
          ]),
        ),
      ),
    );
  }
}
