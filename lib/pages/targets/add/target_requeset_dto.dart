class TargetRequestDto {
  String? name;
  String? comment;
  double? sum;
  String? startDate;
  String? endDate;

  TargetRequestDto(
      {this.comment, this.name, this.endDate, this.startDate, this.sum});

  Map<String, dynamic> toJson() => {
        "name": name,
        "comment": comment,
        "sum": sum,
        "start_date": startDate,
        "end_date": endDate
      };
}
