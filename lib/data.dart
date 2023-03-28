List<HomeScreenPrice> homeScreenPriceList = [
  HomeScreenPrice(
    title: "Yumurta",
    items: [
      Item(price: "0,17 AZN", title: "Bravo"),
      Item(price: "0,18 AZN", title: "Araz supermarket"),
      Item(price: "0,18 AZN", title: "Bazarstore"),
    ],
  ),
  HomeScreenPrice(
    title: "Final qarğıdalı yağı 500ml",
    items: [
      Item(price: "12,09 AZN", title: "Araz supermarket"),
      Item(price: "13,18 AZN", title: "Rahat market"),
      Item(price: "13,39 AZN", title: "Rahat market"),
    ],
  ),
  HomeScreenPrice(
    title: "Şəkər tozu 1kq",
    items: [
      Item(price: "1,19 AZN", title: "Oba"),
      Item(price: "1,25 AZN", title: "Bazarstore"),
      Item(price: "1,42 AZN", title: "Rahat market"),
    ],
  ),
];

List<Targets> targets = [
  Targets(price: "800 / 1000 AZN", title: "Birinci hədəfim", percent: 0.8),
  Targets(price: "243 / 458 AZN", title: "Digər hədəfim", percent: 0.64),
  Targets(price: "1075 / 2200 AZN", title: "Telefon", percent: 0.48),
];

class HomeScreenPrice {
  HomeScreenPrice({
    this.items,
    this.title,
  });

  List<Item>? items;
  String? title;

  factory HomeScreenPrice.fromJson(Map<String, dynamic> json) =>
      HomeScreenPrice(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "title": title,
      };
}

class Item {
  Item({
    this.title,
    this.price,
  });

  String? title;
  String? price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
      };
}

class Targets {
  Targets({
    this.title,
    this.price,
    this.percent,
  });

  String? title;
  String? price;
  double? percent;

  factory Targets.fromJson(Map<String, dynamic> json) => Targets(
        title: json["title"],
        price: json["price"],
        percent: json["percent"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "percent": percent,
      };
}
