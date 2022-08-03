// ignore_for_file: cast_nullable_to_non_nullable, avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/kickoff/features/pm_selection/bloc/pm_selection_bloc.dart';
import 'package:mevn_app/kickoff/features/pm_selection/bloc/pm_selection_state.dart';
import 'package:mevn_app/kickoff/models/pm_selection.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';
import 'package:mevn_app/kickoff/widget/snack_bar.dart';

class PmLeadSelectionScreen extends StatefulWidget {
  const PmLeadSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PmLeadSelectionScreen> createState() => _ListPmState();
}

class _ListPmState extends State<PmLeadSelectionScreen> {
  late PmSelectionBloc? _pmSelectionBloc;
  late List<String> pms = [];
  late bool isShow = true;
  final PmSelection _pmSelection = PmSelection();
  int maxSelected = 1;
  @override
  void initState() {
    super.initState();
    _pmSelectionBloc = PmSelectionBloc(
      locator.get(),
      locator.get(),
      locator.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final argus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ContentWidget(
      title: argus['title'] as String,
      body: BlocProvider(
        create: (_) => _pmSelectionBloc!..getListMember(),
        child: BlocBuilder<PmSelectionBloc, PmSelectionState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is CountProductLoadedState) {
                maxSelected = state.count;
              }
              if (state is PMIsCheckedState) {
                pms = state.data ?? [];
                isShow = state.data == null ? true : false;
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
                                selected:
                                    isSelected(data![index].email as String),
                                selectedColor: Colors.white,
                                selectedTileColor: Colors.orange[200],
                                trailing: showPosition(
                                  data[index].email as String,
                                ),
                                onTap: () {
                                  selectedValueLead(
                                    data[index].email as String,
                                  );
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
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
                                title: Text(
                                  '${data[index].name}',
                                  style: TextStyle(
                                    fontWeight: isSelected(
                                              data[index].email as String,
                                            ) ==
                                            true
                                        ? FontWeight.w800
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ignore: prefer_if_elements_to_conditional_expressions
                        isShow
                            ? ElevatedButton(
                                onPressed: () => submitData(context),
                                child: Text(
                                  pms.length < maxSelected
                                      ? 'Please select ${maxSelected - pms.length} more Pm'
                                      : 'Send',
                                ),
                              )
                            : const Text(
                                'Selected',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is ErrorPmSelectionState) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              } else if (state is SendSelectionState) {
                Navigator.pop(context, true);
                return Container();
              } else {
                return Container();
              }
            }
          },
        ),
      ),
    );
  }

  Widget showPosition(String email) {
    final index = pms.indexWhere((value) => value == email);
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: SizedBox(
        width: 100,
        child: OutlinedButton(
          onPressed: () {
            selectedValueLead(email);
          },
          // ignore: sort_child_properties_last
          child: Text(
            '${index == -1 ? 'CHOOSE' : index + 1}',
            style: TextStyle(
              color: index == -1 ? Colors.orange.shade200 : Colors.white,
              fontSize: index == -1 ? 14 : 20,
              fontWeight: index == -1 ? FontWeight.normal : FontWeight.w800,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor:
                index == -1 ? Colors.white : Colors.orange.shade400,
            side: BorderSide(
              color: index == -1 ? Colors.orange.shade200 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void selectedValueLead(String email) {
    setState(() {
      if (pms.length < maxSelected && !pms.contains(email)) {
        pms.add(email);
      } else if (pms.contains(email)) {
        pms.remove(email);
      }
    });
  }

  bool isSelected(String email) {
    var selected = false;
    if (pms.contains(email)) {
      selected = true;
    }
    return selected;
  }

  void submitData(BuildContext context) {
    if (pms.length == maxSelected) {
      setState(() {
        _pmSelection.pms = pms;
      });
      _pmSelectionBloc!.sendSelection(_pmSelection);
    } else {
      GlobalSnackBar.show(context, 'Please select Pm!', 'danger');
    }
  }
}
