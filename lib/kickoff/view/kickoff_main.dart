import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/kickoff/features/kickoff_main/bloc/kickoff_main_bloc.dart';
import 'package:mevn_app/kickoff/features/kickoff_main/bloc/kickoff_main_state.dart';

class KickoffScreen extends StatefulWidget {
  const KickoffScreen({Key? key}) : super(key: key);

  @override
  State<KickoffScreen> createState() => _KickioffState();
}

class _KickioffState extends State<KickoffScreen> {
  late KickoffMainBloc? _kickoffMainBloc;

  @override
  void initState() {
    super.initState();
    _kickoffMainBloc = KickoffMainBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: const Text('KICKOff'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'App home',
            onPressed: () {
              Navigator.of(context).popAndPushNamed(
                AppRoute.routeKickoff,
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => _kickoffMainBloc!..getMenu(),
        child: BlocBuilder<KickoffMainBloc, KickoffMainState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is KickoffMainsLoadedState) {
                final data = state.data.menuKickoff;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data?.length ?? 0,
                          itemBuilder: (_, index) => Column(
                            children: [
                              Card(
                                shadowColor: Colors.grey.shade100,
                                color: data![index].isChecked == true
                                    ? Colors.orange[200]
                                    : const Color.fromARGB(255, 247, 245, 245),
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                margin: const EdgeInsets.only(bottom: 14),
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                  title: Text(
                                    '${data[index].name}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      '${data[index].route}',
                                      arguments: {
                                        'title': '${data[index].name}'
                                      },
                                    ).then(
                                      (value) {
                                        if (value == true) {
                                          final dataSubmit = _kickoffMainBloc!
                                              .getMenuIsSubmit();
                                          setState(() {
                                            dataSubmit.then(
                                              (value) {
                                                if (value![index] == 'true') {
                                                  data[index].isChecked = true;
                                                } else {
                                                  data[index].isChecked = false;
                                                }
                                              },
                                            );
                                          });
                                        }
                                      },
                                    );
                                  },
                                  enabled: !data[index].isChecked!,
                                  trailing: data[index].isChecked == true
                                      ? const Icon(
                                          Icons.done,
                                          color:
                                              Color.fromARGB(146, 244, 91, 3),
                                          size: 35,
                                        )
                                      : const SizedBox.shrink(),
                                  selectedColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
          },
        ),
      ),
    );
  }
}
