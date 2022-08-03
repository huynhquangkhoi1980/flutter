import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/bloc/member_evaluations_bloc.dart';
import 'package:mevn_app/kickoff/features/member_evaluations/bloc/member_evaluations_state.dart';
import 'package:mevn_app/kickoff/models/member.dart';
import 'package:mevn_app/kickoff/models/member_evaluation_req.dart';
import 'package:mevn_app/kickoff/widget/content_widget.dart';

class DetailMemberEvaluationsScreen extends StatefulWidget {
  const DetailMemberEvaluationsScreen({Key? key}) : super(key: key);
  @override
  State<DetailMemberEvaluationsScreen> createState() => _DetailMemberState();
}

class _DetailMemberState extends State<DetailMemberEvaluationsScreen> {
  final List<bool> _question = [false, false, false, false, false];
  final List<String> _feedback = ['1', '2'];
  late dynamic defaultChecked = false;
  final MemberEvaluationReq _data = MemberEvaluationReq();
  late MemberEvaluationsBloc? _memberEvaluationsBloc;

  @override
  void initState() {
    super.initState();
    _memberEvaluationsBloc = MemberEvaluationsBloc(
      locator.get(),
      locator.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final member = ModalRoute.of(context)!.settings.arguments as Member;
    return ContentWidget(
      title: '${member.name}',
      body: BlocProvider(
        create: (_) => _memberEvaluationsBloc!..getEvaluation(),
        child: BlocBuilder<MemberEvaluationsBloc, MemberEvaluationsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state is MemberEvaluationState) {
                final data = state.data.evaluations;
                final dataFeeback = state.data.feedbacks;
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${data![index].question}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dataFeeback?.length ?? 0,
                          itemBuilder: (_, index) => Column(
                            children: [
                              Text('${dataFeeback![index].question}'),
                              TextFormField(
                                onChanged: (String? value) {
                                  setState(() {
                                    _feedback[index] = value!;
                                  });
                                },
                                maxLength: 100,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _data.evaluations = _question;
                                _data.feedbacks = _feedback;
                                _data.email = member.email;
                              });
                              _memberEvaluationsBloc!.sendEvaluation(_data);
                            },
                            child: const Text(
                              'Send',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
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
              } else if (state is SendEvaluationState) {
                Navigator.pop(context, state.data.email);
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
