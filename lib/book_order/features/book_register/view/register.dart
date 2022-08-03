import 'package:flutter/material.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/book_order/features/book_register/bloc/book_register_bloc.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class BookOrderRegisterScreen extends StatefulWidget {
  const BookOrderRegisterScreen({Key? key}) : super(key: key);

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
    return ContentWidget(
      title: 'Book Order Register',
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
              child: DropdownButton(
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
            ),
            ElevatedButton(
              onPressed: () {
                var book = Book(
                    title: titleController.text,
                    link: linkController.text,
                    purpose: purposeController.text,
                    kind: kindSelected as String);
                _bookRegisterBloc.sendRegisterBook(book);
              },
              child: const Text('Register'),
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
