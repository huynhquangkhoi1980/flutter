// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/route/app_route.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/bloc/member_evaluations_bloc.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/bloc/member_evaluations_state.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class ListMemberEvaluationsScreen extends StatefulWidget {
  const ListMemberEvaluationsScreen({Key? key}) : super(key: key);

  @override
  State<ListMemberEvaluationsScreen> createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMemberEvaluationsScreen> {
  late MemberEvaluationsBloc? _memberEvaluationsBloc;
  late List<String> _membersEvaluated = [];

  @override
  void initState() {
    super.initState();
    _memberEvaluationsBloc =
        MemberEvaluationsBloc(locator.get(), locator.get());
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
          create: (_) => _memberEvaluationsBloc!..getMembers(),
          child: BlocBuilder<MemberEvaluationsBloc, MemberEvaluationsState>(
            builder: (_, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (state is MemberIsCheckedState) {
                  _membersEvaluated = state.data ?? [];
                }
                if (state is MembersLoadedState) {
                  final data = state.data.members;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder: (_, context) => const Divider(
                              color: Colors.black87,
                              height: 10,
                              indent: 20,
                              endIndent: 20,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data?.length ?? 0,
                            itemBuilder: (_, index) => Column(
                              children: [
                                ListTile(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  selected: _membersEvaluated
                                      .contains(data![index].email),
                                  selectedTileColor: Colors.orange[200],
                                  enabled: !_membersEvaluated
                                      .contains(data[index].email),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  trailing: showChecked(
                                    data[index].email as String,
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        'assets${data[index].thumbnail}',
                                      ),
                                    ),
                                  ),
                                  title: Text('${data[index].name}'),
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(
                                      AppRoute.routeDetailMemberEvaluations,
                                      arguments: data[index],
                                    )
                                        .then(
                                      (value) {
                                        if (value != null) {
                                          setState(() {
                                            _membersEvaluated
                                                .add(value as String);
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ErrorMemberEvaluationsState) {
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

  Widget showChecked(String email) {
    if (_membersEvaluated.contains(email)) {
      return const Padding(
        padding: EdgeInsets.only(right: 30),
        child: Icon(
          Icons.done,
          color: Color.fromARGB(146, 244, 91, 3),
          size: 35,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
