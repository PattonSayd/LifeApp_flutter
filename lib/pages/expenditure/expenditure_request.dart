class ExpenditureRequest {
  String? name;
  double? limit;
  String? type;
  String? startDate;
  String? endDate;
  int? tagId;
  int? categoryId;
  String? periodType;

  ExpenditureRequest({
    this.name,
    this.limit,
    this.type,
    this.startDate,
    this.endDate,
    this.tagId,
    this.categoryId,
    this.periodType,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "limit": limit,
        "type": type,
        "start_date": startDate,
        "end_date": endDate,
        "tag_id": tagId,
        "category_id": categoryId,
        "period_type": periodType
      };
}
