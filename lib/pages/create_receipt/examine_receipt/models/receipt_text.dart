
import 'dart:convert';

ReceiptText receiptFromJson(Map<String, dynamic> json) => ReceiptText.fromJson(json);

String receiptToJson(ReceiptText data) => json.encode(data.toJson());

class ReceiptText {
  ReceiptText({
    this.fullText,
  });

  List<String>? fullText;

  factory ReceiptText.fromJson(Map<String, dynamic> json) => ReceiptText(
    fullText: List<String>.from(json["full_text"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "full_text": List<dynamic>.from(fullText!.map((x) => x)),
  };
}
