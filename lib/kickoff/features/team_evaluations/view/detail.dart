import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/bloc/team_evaluations_bloc.dart';
import 'package:mevn_app/kickoff/features/team_evaluations/bloc/team_evaluations_state.dart';
import 'package:mevn_app/kickoff/models/team.dart';
import 'package:mevn_app/kickoff/models/team_evaluation_req.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class DetailTeamEvaluationsScreen extends StatefulWidget {
  const DetailTeamEvaluationsScreen({Key? key}) : super(key: key);
  @override
  State<DetailTeamEvaluationsScreen> createState() => _KickioffState();
}

class _KickioffState extends State<DetailTeamEvaluationsScreen> {
  final List<bool> _question = [false, false, false, false, false];
  final TeamEvaluationReq _data = TeamEvaluationReq();
  late TeamEvaluationsBloc? _teamEvaluationsBloc;

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
    // ignore: cast_nullable_to_non_nullable
    final team = ModalRoute.of(context)!.settings.arguments as Team;
    return ContentWidget(
      title: '${team.name}',
      body: BlocProvider(
        create: (_) => _teamEvaluationsBloc!..getEvaluation(),
        child: BlocBuilder<TeamEvaluationsBloc, TeamEvaluationsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is EvaluationLoadedState) {
                final data = state.data.evaluations;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data?.length ?? 0,
                          itemBuilder: (_, index) => Column(
                            children: [
                              Text(
                                '${data![index].question}',
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: RadioListTile<bool>(
                                      title: const Text('Yes'),
                                      value: true,
                                      groupValue: _question[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _question[index] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    child: RadioListTile<bool>(
                                      title: const Text('No'),
                                      value: false,
                                      groupValue: _question[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _question[index] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _data.evaluations = _question;
                              _data.name = team.name;
                            });
                            _teamEvaluationsBloc!.sendEvaluation(_data);
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is SendEvaluationState) {
                Navigator.pop(context, state.data.name);
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
}
