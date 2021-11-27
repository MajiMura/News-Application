class ItemModel {
  late final int? id;
  late final bool? deleted;
  late final String? type;
  late final String? by;
  late final int? time;
  late final String? text;
  late final bool? dead;
  late final int? parent;
  late final List<dynamic>? kids;
  late final String? url;
  late final int? score;
  late final String? title;
  late final int? descendants;

  ItemModel(
    this.id,
    this.deleted,
    this.type,
    this.by,
    this.time,
    this.dead,
    this.parent,
    this.kids,
    this.url,
    this.score,
    this.title,
    this.descendants,
    this.text,
  );

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
  : id = parsedJson['id'],
  deleted = parsedJson['deleted'],
  type = parsedJson['type'],
  by = parsedJson['by'],
  time = parsedJson['time'],
  dead = parsedJson['dead'],
  parent = parsedJson['parent'],
  kids = parsedJson['kids'],
  url = parsedJson['url'],
  score = parsedJson['score'],
  title = parsedJson['title'],
  descendants = parsedJson['descendants'],
  text = parsedJson['text'];

}
