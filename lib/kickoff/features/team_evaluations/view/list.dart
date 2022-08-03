// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/bloc/team_evaluations_bloc.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/bloc/team_evaluations_state.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class ListTeamEvaluationsScreen extends StatefulWidget {
  const ListTeamEvaluationsScreen({Key? key}) : super(key: key);

  @override
  State<ListTeamEvaluationsScreen> createState() => _TeamListState();
}

class _TeamListState extends State<ListTeamEvaluationsScreen> {
  late TeamEvaluationsBloc? _teamEvaluationsBloc;
  late List<String> _teamsEvaluated = [];

  @override
  void initState() {
    super.initState();
    _teamEvaluationsBloc = TeamEvaluationsBloc(
      locator.get(),
      locator.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final argus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: ContentWidget(
        title: argus['title'] as String,
        body: BlocProvider(
          create: (_) => _teamEvaluationsBloc!..getListProject(),
          child: BlocBuilder<TeamEvaluationsBloc, TeamEvaluationsState>(
            builder: (_, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (state is TeamIsCheckedState) {
                  _teamsEvaluated = state.data ?? [];
                }
                if (state is TeamDataLoadedState) {
                  final data = state.data.teams;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data?.length ?? 0,
                        itemBuilder: (_, index) => Center(
                          child: Card(
                            color:
                                _teamsEvaluated.contains(data![index].name) ==
                                        true
                                    ? Colors.orange[200]
                                    : const Color.fromARGB(255, 247, 245, 245),
                            shadowColor: Colors.grey.shade100,
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
                              enabled:
                                  !_teamsEvaluated.contains(data[index].name),
                              selectedColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(
                                  AppRoute.routeDetailTeamEvaluations,
                                  arguments: data[index],
                                )
                                    .then(
                                  (value) {
                                    if (value != null) {
                                      setState(() {
                                        _teamsEvaluated.add(value as String);
                                      });
                                    }
                                  },
                                );
                              },
                              subtitle: Column(
                                children: [
                                  Text(
                                    '${data[index].name}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      // fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if (data[index].projects!.isNotEmpty)
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                  if (data[index].projects!.isNotEmpty)
                                    Text(
                                      data[index].projects![0],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  for (var i = 0;
                                      i < data[index].members!.length;
                                      i++)
                                    Text(
                                      data[index].members![i],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  if (_teamsEvaluated
                                          .contains(data[index].name) ==
                                      true)
                                    const Icon(
                                      Icons.done,
                                      color: Color.fromARGB(146, 244, 91, 3),
                                      size: 35,
                                    )
                                  else
                                    const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is ErrorTeamEvaluationsState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(
                        fontSize: 18,
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
      ),
    );
  }
}
