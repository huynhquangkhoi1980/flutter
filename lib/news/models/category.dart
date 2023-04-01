class Category {
  late int termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  int? catID;
  int? categoryCount;
  String? categoryDescription;
  String? catName;
  String? categoryNicename;
  int? categoryParent;

  Category({
    required this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
    this.catID,
    this.categoryCount,
    this.categoryDescription,
    this.catName,
    this.categoryNicename,
    this.categoryParent,
  });

  Category.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'] as int;
    name = json['name'] as String;
    slug = json['slug'] as String;
    termGroup = json['term_group'] as int;
    termTaxonomyId = json['term_taxonomy_id'] as int;
    taxonomy = json['taxonomy'] as String;
    description = json['description'] as String;
    parent = json['parent'] as int;
    count = json['count'] as int;
    filter = json['filter'] as String;
    catID = json['cat_ID'] as int;
    categoryCount = json['category_count'] as int;
    categoryDescription = json['category_description'] as String;
    catName = json['cat_name'] as String;
    categoryNicename = json['category_nicename'] as String;
    categoryParent = json['category_parent'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['cat_ID'] = catID;
    data['category_count'] = categoryCount;
    data['category_description'] = categoryDescription;
    data['cat_name'] = catName;
    data['category_nicename'] = categoryNicename;
    data['category_parent'] = categoryParent;
    return data;
  }
}
