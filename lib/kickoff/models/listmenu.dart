class ListMenu {
  List<String>? memberEvaluation;
  List<String>? teamEvaluation;
  List<bool>? pjSelection;
  List<bool>? pmSelection;
  List<bool>? subPjSelection;
  List<bool>? techLeadSelection;
  List<bool>? valueLeadSelection;

  ListMenu({
    this.memberEvaluation,
    this.teamEvaluation,
    this.pjSelection,
    this.pmSelection,
    this.subPjSelection,
    this.techLeadSelection,
    this.valueLeadSelection,
  });

  ListMenu.fromJson(Map<String, dynamic> json) {
    memberEvaluation = json['member-evaluation'].cast<String>() as List<String>;
    teamEvaluation = json['team-evaluation'].cast<String>() as List<String>;
    pjSelection = json['pj-selection'].cast<bool>() as List<bool>;
    pmSelection = json['pm-selection'].cast<bool>() as List<bool>;
    subPjSelection = json['sub-pj-selection'].cast<bool>() as List<bool>;
    techLeadSelection = json['tech-lead-selection'].cast<bool>() as List<bool>;
    valueLeadSelection =
        json['value-lead-selection'].cast<bool>() as List<bool>;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['member-evaluation'] = memberEvaluation;
    data['team-evaluation'] = teamEvaluation;
    data['pj-selection'] = pjSelection;
    data['pm-selection'] = pmSelection;
    data['sub-pj-selection'] = subPjSelection;
    data['tech-lead-selection'] = techLeadSelection;
    data['value-lead-selection'] = valueLeadSelection;
    return data;
  }
}
