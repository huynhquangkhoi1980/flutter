import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  const DrawerMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        backgroundColor: const Color.fromRGBO(239, 130, 0, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.only(top: 72, bottom: 40),
                child: Image.asset(
                  'assets/images/logos/me_logo.png',
                  height: 64,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
              child: TextFormField(
                enableInteractiveSelection: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search',
                  filled: true,
                  labelStyle: const TextStyle(
                    fontSize: 0,
                    color: Colors.redAccent,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            ListTile(
              textColor: const Color(0xFFFFFFFF),
              iconColor: const Color(0xFFFFFFFF),
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Technology'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: const Color(0xFFFFFFFF),
              iconColor: const Color(0xFFFFFFFF),
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Development Process'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: const Color(0xFFFFFFFF),
              iconColor: const Color(0xFFFFFFFF),
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Teamwork'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              textColor: const Color(0xFFFFFFFF),
              iconColor: const Color(0xFFFFFFFF),
              leading: const Icon(
                Icons.train,
              ),
              title: const Text('Human Skill'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const AboutListTile(
              icon: Icon(
                Icons.info,
                color: Color(0xFFFFFFFF),
              ),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'MevnApp',
              applicationVersion: '1.0',
              applicationLegalese: '© 2022 Company',
              aboutBoxChildren: [
                ///Content goes here...
              ],
              child: Text(
                'About app',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
