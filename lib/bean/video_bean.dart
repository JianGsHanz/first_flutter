class VideoBean {
  String reason;
  Result result;
  int errorCode;

  VideoBean({
    this.reason,
    this.result,
    this.errorCode,
  });

  factory VideoBean.fromJson(Map<String, dynamic> json) => VideoBean(
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
  String title;
  String tag;
  String act;
  String year;
  dynamic rating;
  String area;
  String dir;
  String desc;
  String cover;
  String vdoStatus;
  String playlinks;
  List<dynamic> videoRec;
  List<Act> actS;

  Result({
    this.title,
    this.tag,
    this.act,
    this.year,
    this.rating,
    this.area,
    this.dir,
    this.desc,
    this.cover,
    this.vdoStatus,
    this.playlinks,
    this.videoRec,
    this.actS,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    tag: json["tag"],
    act: json["act"],
    year: json["year"],
    rating: json["rating"],
    area: json["area"],
    dir: json["dir"],
    desc: json["desc"],
    cover: json["cover"],
    vdoStatus: json["vdo_status"],
    playlinks: json["playlinks"],
    videoRec: List<dynamic>.from(json["video_rec"].map((x) => x)),
    actS: List<Act>.from(json["act_s"].map((x) => Act.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "tag": tag,
    "act": act,
    "year": year,
    "rating": rating,
    "area": area,
    "dir": dir,
    "desc": desc,
    "cover": cover,
    "vdo_status": vdoStatus,
    "playlinks": playlinks,
    "video_rec": List<dynamic>.from(videoRec.map((x) => x)),
    "act_s": List<dynamic>.from(actS.map((x) => x.toJson())),
  };
}

class Act {
  String name;
  dynamic url;
  String image;

  Act({
    this.name,
    this.url,
    this.image,
  });

  factory Act.fromJson(Map<String, dynamic> json) => Act(
    name: json["name"],
    url: json["url"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "image": image,
  };
}