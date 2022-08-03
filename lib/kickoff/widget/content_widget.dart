import 'package:flutter/material.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';

class ContentWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContentWidget({
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Center(child: Text(title)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Kickoff menu',
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 150,
                    color: const Color.fromARGB(255, 247, 245, 245),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              title: const Text(
                                'Kickoff',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  AppRoute.routeKickoff,
                                  (route) => false,
                                );
                              },
                              trailing: const Icon(Icons.reviews),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: body,
    );
  }
}
