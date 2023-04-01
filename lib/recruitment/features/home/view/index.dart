import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:mevn_app/app/di/injection.dart';
import 'package:mevn_app/app/utils/constants/app_colors.dart';
import 'package:mevn_app/app/utils/constants/app_constants.dart';
import 'package:mevn_app/recruitment/features/home/bloc/recruitment_bloc.dart';
import 'package:mevn_app/recruitment/models/recruitment_req.dart';
import 'package:url_launcher/url_launcher.dart';

class RecruitmentFormScreen extends StatefulWidget {
  const RecruitmentFormScreen({
    Key? key,
    this.changeScreen,
  }) : super(key: key);

  final void Function(int)? changeScreen;

  @override
  State<RecruitmentFormScreen> createState() => _RecruitmentFormScreenState();
}

class _RecruitmentFormScreenState extends State<RecruitmentFormScreen>
    with TickerProviderStateMixin {
  late RecruitmentBloc? _recruitmentBloc;
  final _positionController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _aboutMeController = TextEditingController();
  late String positionIdSelected = '';
  late List<SelectedListItem>? _convertSkill;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _recruitmentBloc = RecruitmentBloc(locator.get());
    _convertSkill = [];
    getSkills();
  }

  Future<void> getSkills() async {
    final data = await _recruitmentBloc!.getSkills();
    final convertData = data!.map((item) {
      return SelectedListItem(
        name: item.name!,
        value: '${item.id}',
        isSelected: false,
      );
    }).toList();
    convertData[0].isSelected = true;
    setState(() {
      _convertSkill = convertData;
    });
  }

  String? get _errorFullname {
    final text = _fullNameController.value.text;
    if (text.length < 4) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? get _errorEmail {
    final text = _emailController.value.text;
    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      return 'Please check your email';
    }
    return null;
  }

  String? get _errorPhone {
    final text = _phoneController.value.text;
    final phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(text);
    if (!phoneValid) {
      return 'Please check your phone';
    }
    return null;
  }

  String? get _errorPosition {
    final text = _positionController.value.text;
    if (text.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  bool get _validated {
    if (_fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _positionController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final dialog = AlertDialog(
      title: const Text(
        'Successfully sent!',
        textAlign: TextAlign.left,
      ),
      titlePadding: const EdgeInsets.only(top: 14, left: 14, right: 14),
      contentPadding: const EdgeInsets.all(14),
      contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
      content: const Text(
          'Thank you for submitting your application information to MarketEnterprise Vietnam. We will contact you as soon as possible. Sincere thanks.'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.changeScreen!(0);
          },
          child: const Text('Back to News'),
        ),
      ],
    );
    final dialogFailed = AlertDialog(
      title: const Text('Information sent failed!', textAlign: TextAlign.left),
      titlePadding: const EdgeInsets.all(14),
      contentPadding: const EdgeInsets.all(14),
      contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
      content:
          const Text('Please submit your information later. Sincere thanks.'),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            widget.changeScreen!(0);
          },
          child: const Text('Back to News'),
        ),
      ],
    );
    void _submit() async {
      setState(() => _submitted = true);
      if (_validated == true &&
          _errorFullname == null &&
          _errorEmail == null &&
          _errorPhone == null &&
          _errorPosition == null) {
        final data = RecruitmentReq(
          fullName: _fullNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          skill: positionIdSelected,
          aboutMe: _aboutMeController.text,
        );
        final res = await _recruitmentBloc!.sendRecruitment(data);
        if (res == true) {
          await showDialog<void>(
            context: context,
            builder: (context) => dialog,
          );
        } else {
          await showDialog<void>(
            context: context,
            builder: (context) => dialogFailed,
          );
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      physics: const ScrollPhysics(),
      children: [
        ValueListenableBuilder<TextEditingValue>(
          builder: (context, TextEditingValue value, __) {
            return TextField(
              keyboardType: TextInputType.name,
              onChanged: (_) => setState(() {}),
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full name *',
                errorText: _submitted ? _errorFullname : null,
                border: const OutlineInputBorder(),
              ),
            );
          },
          valueListenable: _fullNameController,
        ),
        const SizedBox(
          height: 15,
        ),
        ValueListenableBuilder<TextEditingValue>(
          builder: (context, TextEditingValue value, __) {
            return TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => setState(() {}),
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email *',
                errorText: _submitted ? _errorEmail : null,
                border: const OutlineInputBorder(),
              ),
            );
          },
          valueListenable: _emailController,
        ),
        const SizedBox(
          height: 15,
        ),
        ValueListenableBuilder<TextEditingValue>(
          builder: (context, TextEditingValue value, __) {
            return TextField(
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone *',
                errorText: _submitted ? _errorPhone : null,
                border: const OutlineInputBorder(),
              ),
            );
          },
          valueListenable: _phoneController,
        ),
        const SizedBox(
          height: 15,
        ),
        AppTextField(
          textEditingController: _positionController,
          hint: 'Position',
          isSkillSelected: true,
          skills: _convertSkill,
          submitted: _submitted,
          positionIdSelected: (String value) => {
            setState(() => {positionIdSelected = value})
          },
          errorPosition: _errorPosition,
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: _aboutMeController,
          decoration: const InputDecoration(
            labelText: 'Message us',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 5,
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: 58,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  _validated ? AppColors.orangeMainColor : Colors.grey[300],
            ),
            onPressed: _validated ? _submit : null,
            child: Center(
              child: Text(
                'SEND INFORMATION',
                style: TextStyle(
                  color: _validated ? Colors.white : Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Text(
                  'MarketEnterprise Vietnam',
                  style: TextStyle(
                    color: Color.fromARGB(255, 16, 110, 219),
                  ),
                ),
                onTap: () => launchUrl(Uri.parse(AppConstants.websiteUrl)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final bool isSkillSelected;
  final bool? submitted;
  final List<SelectedListItem>? skills;
  final Function? positionIdSelected;
  final String? errorPosition;

  const AppTextField({
    required this.textEditingController,
    required this.hint,
    required this.isSkillSelected,
    this.skills,
    this.submitted,
    this.positionIdSelected,
    this.errorPosition,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Position List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.skills ?? [],
        selectedItems: (List<dynamic> selectedList) {
          for (final item in selectedList) {
            if (item is SelectedListItem) {
              widget.textEditingController.text = item.name;
              widget.positionIdSelected!(item.value);
            }
          }
        },
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          keyboardType: TextInputType.none,
          showCursor: false,
          enableInteractiveSelection: false,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            errorText: widget.submitted ?? false ? widget.errorPosition : null,
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
            ),
            labelText: 'Position *',
            border: const OutlineInputBorder(),
          ),
          onTap: widget.isSkillSelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
        ),
      ],
    );
  }
}
