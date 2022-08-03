// ignore_for_file: cast_nullable_to_non_nullable, avoid_bool_literals_in_conditional_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/kickoff/features/project_selection/bloc/project_selection_bloc.dart';
import 'package:mevn_app/kickoff/features/project_selection/bloc/project_selection_state.dart';
import 'package:mevn_app/kickoff/models/project_req.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';
import 'package:mevn_app/kickoff/widget/snack_bar.dart';

class ListProjectScreen extends StatefulWidget {
  const ListProjectScreen({Key? key}) : super(key: key);

  @override
  State<ListProjectScreen> createState() => _ProjectListState();
}

class _ProjectListState extends State<ListProjectScreen> {
  late ProjectBloc? _projectBloc;
  final ProjectReq _projectReq = ProjectReq();
  late List<String> pjs = [];
  late bool isShow = true;
  int maxSelected = 1;
  @override
  void initState() {
    super.initState();
    _projectBloc = ProjectBloc(locator.get());
  }

  @override
  Widget build(BuildContext context) {
    final argus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ContentWidget(
      title: argus['title'] as String,
      body: BlocProvider(
        create: (_) => _projectBloc!..getList(),
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is PjIsCheckedState) {
                pjs = state.data ?? [];
                isShow = state.data == null ? true : false;
              }
              if (state is ProjectsLoadedState) {
                final data = state.data.projects;
                maxSelected = data!.length;
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
                          itemCount: data.length,
                          itemBuilder: (_, index) => Center(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: isSelected(data[index].name as String)
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
                                      selectedProject(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Owner: ',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: showOwner(
                                                  data[index].owner
                                                      as List<String>,
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
                                                'Website: ',
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
                                                '${data[index].website}',
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
                                        showPosition(data[index].name!),
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
                                onPressed: submitData,
                                child: Text(
                                  pjs.length < maxSelected
                                      ? 'Please select ${maxSelected - pjs.length} more Project'
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
              } else if (state is ErrorProjectState) {
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

  Widget showPosition(String name) {
    final index = pjs.indexWhere((value) => value == name);
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: SizedBox(
        width: 100,
        child: OutlinedButton(
          onPressed: () {
            selectedProject(name);
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
                index == -1 ? Colors.transparent : Colors.orange.shade400,
            side: BorderSide(
              color: index == -1 ? Colors.orange.shade200 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget showOwner(List<String> owner) {
    var text = '';
    for (var i = 0; i < owner.length; i++) {
      // ignore: use_string_buffers
      text += owner[i] + (i == owner.length - 1 ? '' : ', ');
    }
    return Expanded(
      flex: 6,
      child: Align(
        heightFactor: 1.3,
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void selectedProject(String name) {
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

  void submitData() {
    if (pjs.length == maxSelected) {
      setState(() {
        _projectReq.pjs = pjs;
      });
      _projectBloc!.sendSelection(_projectReq);
    } else {
      GlobalSnackBar.show(context, 'Please select Project!', 'danger');
    }
  }
}
