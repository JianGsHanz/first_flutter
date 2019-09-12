class Top {
  String reason;
  Result result;
  int errorCode;

  Top({
    this.reason,
    this.result,
    this.errorCode,
  });

  factory Top.fromJson(Map<String, dynamic> json) => Top(
    reason: json["reason"],
    result: Result.fromJson(json["result"]),
    errorCode: json["error_code"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "result": result.toJson(),
    "error_code": errorCode,
  };
}

class Result {
  String stat;
  List<Datum> data;

  Result({
    this.stat,
    this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    stat: json["stat"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stat": stat,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String uniquekey;
  String title;
  String date;
  Category category;
  String authorName;
  String url;
  String thumbnailPicS;
  String thumbnailPicS02;
  String thumbnailPicS03;

  Datum({
    this.uniquekey,
    this.title,
    this.date,
    this.category,
    this.authorName,
    this.url,
    this.thumbnailPicS,
    this.thumbnailPicS02,
    this.thumbnailPicS03,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    uniquekey: json["uniquekey"],
    title: json["title"],
    date: json["date"],
    category: categoryValues.map[json["category"]],
    authorName: json["author_name"],
    url: json["url"],
    thumbnailPicS: json["thumbnail_pic_s"],
    thumbnailPicS02: json["thumbnail_pic_s02"] == null ? null : json["thumbnail_pic_s02"],
    thumbnailPicS03: json["thumbnail_pic_s03"] == null ? null : json["thumbnail_pic_s03"],
  );

  Map<String, dynamic> toJson() => {
    "uniquekey": uniquekey,
    "title": title,
    "date": date,
    "category": categoryValues.reverse[category],
    "author_name": authorName,
    "url": url,
    "thumbnail_pic_s": thumbnailPicS,
    "thumbnail_pic_s02": thumbnailPicS02 == null ? null : thumbnailPicS02,
    "thumbnail_pic_s03": thumbnailPicS03 == null ? null : thumbnailPicS03,
  };
}

enum Category { EMPTY }

final categoryValues = EnumValues({
  "头条": Category.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
