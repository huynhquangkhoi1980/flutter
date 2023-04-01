import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mevn_app/app/utils/networks/interceptors/auth_interceptor.dart';
import 'package:mevn_app/app/utils/repositories/auth_repo.dart';
import 'package:mevn_app/app/utils/services/auth_service.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';
import 'package:mevn_app/kickoff/repositories/action_submit_repo.dart';
import 'package:mevn_app/kickoff/repositories/member_evaluation_repo.dart';
import 'package:mevn_app/kickoff/repositories/member_repo.dart';
import 'package:mevn_app/kickoff/repositories/pm_selection_repo.dart';
import 'package:mevn_app/kickoff/repositories/project_repo.dart';
import 'package:mevn_app/kickoff/repositories/sub_project_repo.dart';
import 'package:mevn_app/kickoff/repositories/team_evaluation_repo.dart';
import 'package:mevn_app/kickoff/repositories/team_repo.dart';
import 'package:mevn_app/kickoff/repositories/tech_lead_selection_repo.dart';
import 'package:mevn_app/kickoff/repositories/value_lead_selection_repo.dart';
import 'package:mevn_app/kickoff/services/kickoff_service.dart';
import 'package:mevn_app/kickoff/services/member_evaluation_service.dart';
import 'package:mevn_app/kickoff/services/member_service.dart';
import 'package:mevn_app/kickoff/services/pm_selection_service.dart';
import 'package:mevn_app/kickoff/services/project_service.dart';
import 'package:mevn_app/kickoff/services/sub_project_service.dart';
import 'package:mevn_app/kickoff/services/team_evaluation_service.dart';
import 'package:mevn_app/kickoff/services/team_service.dart';
import 'package:mevn_app/kickoff/services/tech_lead_selection_service.dart';
import 'package:mevn_app/kickoff/services/value_lead_selection_service.dart';
import 'package:mevn_app/news/repositories/repo.dart';
import 'package:mevn_app/news/services/service.dart';
import 'package:mevn_app/recruitment/repositories/recruitment_repo.dart';
import 'package:mevn_app/recruitment/services/recruitment.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/flavor/flavor.dart';
import '../utils/networks/core/dio_flutter_transformer.dart';

GetIt locator = GetIt.instance;

Future<void> initDependency() async {
  final _sharePreference = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() {
    return PrefProvider(_sharePreference);
  });

  locator.registerLazySingleton<AuthService>(() {
    return AuthService(locator.get());
  });

  locator.registerLazySingleton(
    () => AuthRepo(authService: locator.get()),
  );

  Dio _createDio(String baseUrl) {
    const _connectTimeout = 30000;
    const _receiveTimeout = 30000;
    const _sendTimeout = 30000;
    final options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      followRedirects: false,
      baseUrl: baseUrl,
    );
    final dio = Dio(options)..transformer = FlutterTransformer();
    dio.interceptors.add(
      AuthInterceptor(
        locator.get(),
      ),
    );

    // if (kDebugMode) {
    //   dio.interceptors.add(
    //     PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //     ),
    //   );
    // }
    return dio;
  }

  locator.registerLazySingleton<MemberService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return MemberService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => MemberRepo(memberService: locator.get()),
  );

  locator.registerLazySingleton<MemberEvaluationService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return MemberEvaluationService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => MemberEvaluationRepo(memberEvaluationService: locator.get()),
  );

  locator.registerLazySingleton<TeamService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return TeamService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => TeamRepo(teamService: locator.get()),
  );

  locator.registerLazySingleton<TeamEvaluationService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return TeamEvaluationService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => TeamEvaluationRepo(teamEvaluationService: locator.get()),
  );

  locator.registerLazySingleton<ValueLeadSelectionService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return ValueLeadSelectionService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => ValueLeadSelectionRepo(valueLeadSelectionService: locator.get()),
  );

  locator.registerLazySingleton<PmSelectionService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return PmSelectionService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => PmSelectionRepo(pmSelectionService: locator.get()),
  );

  locator.registerLazySingleton<TechLeadSelectionService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return TechLeadSelectionService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => TechLeadSelectionRepo(techLeadSelectionService: locator.get()),
  );

  locator.registerLazySingleton<SubProjectService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return SubProjectService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => SubProjectRepo(subProjectService: locator.get()),
  );

  locator.registerLazySingleton<ProjectService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return ProjectService(dio, locator.get());
  });

  locator.registerLazySingleton(
    () => ProjectRepo(projectService: locator.get()),
  );

  locator.registerLazySingleton<ActionSubmitService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.mainUrl!);
    return ActionSubmitService(
      dio,
      locator.get(),
      locator.get(),
      locator.get(),
    );
  });

  locator.registerLazySingleton(
    () => ActionSubmitRepo(actionSubmitService: locator.get()),
  );

  // Blog API
  locator.registerLazySingleton<NewsService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.blogUrl!);
    return NewsService(dio);
  });

  locator.registerLazySingleton(
    () => NewsRepo(newsService: locator.get()),
  );

  // API Recruitment
  locator.registerLazySingleton<RecruitmentService>(() {
    final dio = _createDio(FlavorConfig.instance!.values!.apiUrl!);
    return RecruitmentService(dio);
  });

  locator.registerLazySingleton(
    () => RecruitmentRepo(recruitmentService: locator.get()),
  );
}
