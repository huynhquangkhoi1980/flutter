import 'package:flutter/material.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/book_order/features/book_register/bloc/book_register_bloc.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class BookOrderRegisterScreen extends StatefulWidget {
  final dynamic arguments;
  const BookOrderRegisterScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<BookOrderRegisterScreen> createState() => _BookOrderRegisterState();
}

class _BookOrderRegisterState extends State<BookOrderRegisterScreen> {
  dynamic kindSelected = 'human-skill';

  final titleController = TextEditingController();
  final linkController = TextEditingController();
  final purposeController = TextEditingController();

  late BookRegisterBloc _bookRegisterBloc;

  @override
  void initState() {
    super.initState();
    _bookRegisterBloc = BookRegisterBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    // Book book = widget.arguments as Book;

    return ContentWidget(
      // title: book.title!,
      title: "Register Book",
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.orange[400],
                controller: linkController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter reference link',
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.orange[400],
                controller: purposeController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter request purpose',
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      'Enter category:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  DropdownButton(
                    value: kindSelected,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        value: 'human-skill',
                        child: Text('Human Skill'),
                      ),
                      DropdownMenuItem(
                        value: 'organization',
                        child: Text('Organization'),
                      ),
                      DropdownMenuItem(
                        value: 'programming',
                        child: Text('Programming'),
                      ),
                      DropdownMenuItem(
                        value: 'comic',
                        child: Text('Comic'),
                      ),
                      DropdownMenuItem(
                        value: 'language',
                        child: Text('Language'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other'),
                      ),
                    ],
                    onChanged: (dynamic value) {
                      setState(() {
                        kindSelected = value as String;
                      });
                    },
                  ),
                ],
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
                _bookRegisterBloc.sendRegisterBook(book);
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
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
