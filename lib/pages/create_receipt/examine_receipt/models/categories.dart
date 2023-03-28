// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(Map<String, dynamic> json) =>
    Categories.fromJson(json);

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.taskId,
    this.classificationResults,
  });

  int? taskId;
  List<ClassificationResult>? classificationResults;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        taskId: json["task_id"],
        classificationResults: List<ClassificationResult>.from(
            json["classification_result"]
                .map((x) => ClassificationResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "classification_result":
            List<dynamic>.from(classificationResults!.map((x) => x.toJson())),
      };
}

class ClassificationResult {
  ClassificationResult({
    this.productName,
    this.categoryIdx,
    this.categoryName,
    this.probability,
  });

  String? productName;
  int? categoryIdx;
  String? categoryName;
  double? probability;

  factory ClassificationResult.fromJson(Map<String, dynamic> json) =>
      ClassificationResult(
        productName: json["product_name"],
        categoryIdx: json["category_idx"],
        categoryName: json["category_name"],
        probability: json["probability"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "category_idx": categoryIdx,
        "category_name": categoryName,
        "probability": probability,
      };
}
