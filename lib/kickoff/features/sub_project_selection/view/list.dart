// ignore_for_file: cast_nullable_to_non_nullable, avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/kickoff/features/sub_project_selection/bloc/sub_project_selection_bloc.dart';
import 'package:mevn_app/kickoff/features/sub_project_selection/bloc/sub_project_selection_state.dart';
import 'package:mevn_app/kickoff/models/sub_project_req.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';
import 'package:mevn_app/kickoff/widget/snack_bar.dart';

class ListSubProjectScreen extends StatefulWidget {
  const ListSubProjectScreen({Key? key}) : super(key: key);

  @override
  State<ListSubProjectScreen> createState() => _SubProjectListState();
}

class _SubProjectListState extends State<ListSubProjectScreen> {
  late SubProjectBloc? _subProjectBloc;
  final SubProjectReq _subProjectReq = SubProjectReq();
  late List<String> pjs = [];
  late bool isShow = true;
  int maxSelected = 1;
  @override
  void initState() {
    super.initState();
    _subProjectBloc = SubProjectBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    final argus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ContentWidget(
      title: argus['title'] as String,
      body: BlocProvider(
        create: (context) => _subProjectBloc!..getList(),
        child: BlocBuilder<SubProjectBloc, SubProjectState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is SubPjIsCheckedState) {
                pjs = state.data ?? [];
                isShow = state.data == null ? true : false;
              }
              if (state is ProjectsLoadedState) {
                final data = state.data.projects;
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
                          itemBuilder: (_, index) => Center(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: isSelected(data![index].name as String)
                                      ? Colors.orange
                                      : Colors.orange.shade200,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              shadowColor: Colors.blueGrey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    onTap: () {
                                      selectedSubProject(
                                        data[index].name as String,
                                      );
                                    },
                                    selected:
                                        isSelected(data[index].name as String),
                                    selectedColor: Colors.black,
                                    selectedTileColor: Colors.orange.shade100,
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 6,
                                      ),
                                      child: Text(
                                        '${data[index].name}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Align(
                                              heightFactor: 1.3,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Pm: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              heightFactor: 1.3,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '${data[index].pm}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Align(
                                              heightFactor: 1.2,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Hours in week: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              heightFactor: 1.2,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '${data[index].hoursInWeek}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Align(
                                              heightFactor: 1.3,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Number of engineers: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              heightFactor: 1.3,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '${data[index].numberOfEngineers}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Goal: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                heightFactor: 1.2,
                                                child: Text(
                                                  '${data[index].goal}',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Description: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                '${data[index].description}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 30),
                                          child: SizedBox(
                                            width: 100,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                selectedSubProject(
                                                  data[index].name as String,
                                                );
                                              },
                                              // ignore: sort_child_properties_last
                                              child: isSelected(
                                                data[index].name as String,
                                              )
                                                  ? const Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                      size: 35,
                                                    )
                                                  : Text(
                                                      'CHOOSE',
                                                      style: TextStyle(
                                                        color: isSelected(
                                                          data[index].name
                                                              as String,
                                                        )
                                                            ? Colors.white
                                                            : Colors.orange
                                                                .shade200,
                                                        fontSize: 14,
                                                        fontWeight: isSelected(
                                                          data[index].name
                                                              as String,
                                                        )
                                                            ? FontWeight.normal
                                                            : FontWeight.w800,
                                                      ),
                                                    ),

                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: isSelected(
                                                  data[index].name as String,
                                                )
                                                    ? Colors.orange.shade400
                                                    : Colors.transparent,
                                                side: BorderSide(
                                                  color: isSelected(
                                                    data[index].name as String,
                                                  )
                                                      ? Colors.white
                                                      : Colors.orange.shade200,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // ignore: prefer_if_elements_to_conditional_expressions
                        isShow
                            ? ElevatedButton(
                                onPressed: () => submitData(context),
                                child: Text(
                                  pjs.length < maxSelected
                                      ? 'Please select ${maxSelected - pjs.length} more Sub Project'
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
              } else if (state is ErrorSubProjectState) {
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

  void selectedSubProject(String name) {
    setState(() {
      if (pjs.length < maxSelected && !pjs.contains(name)) {
        pjs.add(name);
      } else if (pjs.contains(name)) {
        pjs.remove(name);
      }
    });
  }

  bool isSelected(String email) {
    var selected = false;
    if (pjs.contains(email)) {
      selected = true;
    }
    return selected;
  }

  void submitData(BuildContext context) {
    if (pjs.length == maxSelected) {
      setState(() {
        _subProjectReq.pjs = pjs;
      });
      _subProjectBloc!.sendSelection(_subProjectReq);
    } else {
      GlobalSnackBar.show(context, 'Please select Sub Project!', 'danger');
    }
  }
}
