import 'package:shared_preferences/shared_preferences.dart';

class PrefNames {
  static const String idToken = 'idToken';
  static const String userEmail = 'userEmail';
  static const String memberEvaluations = 'member-evaluation';
  static const String teamEvaluations = 'team-evaluation';
  static const String pMSelection = 'pm-selection';
  static const String techSelection = 'tech-lead-selection';
  static const String valueSelection = 'value-lead-selection';
  static const String projectSelection = 'pj-selection';
  static const String subProjectSelection = 'sub-pj-selection';
  static const String countMember = 'countMember';
  static const String countTeam = 'countTeam';
  static const String menuIsSubmit = 'menuIsSubmit';
}

class PrefProvider {
  PrefProvider(this._prefs);

  final SharedPreferences _prefs;

  bool get isAuthenticated => idToken != null;

  String? get idToken => _prefs.getString(PrefNames.idToken);

  String? get userEmail => _prefs.getString(PrefNames.userEmail);
  int? get countMember => _prefs.getInt(PrefNames.countMember);
  int? get countTeam => _prefs.getInt(PrefNames.countTeam);

  Future<bool> setCountData(String action, int? data) async {
    await _prefs.setInt(action, data!);
    return true;
  }

  List<String>? get memberEvaluations =>
      _prefs.getStringList(PrefNames.memberEvaluations);

  List<String>? get teamEvaluations =>
      _prefs.getStringList(PrefNames.teamEvaluations);

  List<String>? get pMSelection => _prefs.getStringList(PrefNames.pMSelection);

  List<String>? get techSelection =>
      _prefs.getStringList(PrefNames.techSelection);

  List<String>? get valueSelection =>
      _prefs.getStringList(PrefNames.valueSelection);

  List<String>? get projectSelection =>
      _prefs.getStringList(PrefNames.projectSelection);

  List<String>? get subProjectSelection =>
      _prefs.getStringList(PrefNames.subProjectSelection);

  List<String>? get menuIsSubmit =>
      _prefs.getStringList(PrefNames.menuIsSubmit);

  Future<List<String>?> getDataIsChecked(String action) async {
    return _prefs.getStringList(action);
  }

  Future<bool> setMenuIsSubmit(List<String> data) async {
    await _prefs.setStringList(PrefNames.menuIsSubmit, data);
    return true;
  }

  Future<bool> setDataIsChecked(String action, List<String>? data) async {
    await _prefs.setStringList(action, data!);
    return true;
  }

  Future<bool> setTokenForApi(String idToken) async {
    await _prefs.setString(PrefNames.idToken, idToken);
    return true;
  }

  Future<bool> setUserEmailForApi(String email) async {
    await _prefs.setString(PrefNames.userEmail, email);
    return true;
  }

  Future<bool> removeAll() async {
    // await _prefs.remove(PrefNames.teamEvaluations);
    // await _prefs.remove(PrefNames.countTeam);
    // await _prefs.remove(PrefNames.memberEvaluations);
    // await _prefs.remove(PrefNames.countMember);
    // await _prefs.remove(PrefNames.menuIsSubmit);
    await _prefs.clear();
    return true;
  }
}
