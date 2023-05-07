class Recommended {
  String? name;
  String? tagLine;
  String? image;
  List<String>? images;
  String? description;
  int? price;

  Recommended(
      {this.name,
      this.tagLine,
      this.image,
      this.images,
      this.description,
      this.price});

  Recommended.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tagLine = json['tagLine'];
    image = json['image'];
    images = json['images'].cast<String>();
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['tagLine'] = tagLine;
    data['image'] = image;
    data['images'] = images;
    data['description'] = description;
    data['price'] = price;
    return data;
  }
}
