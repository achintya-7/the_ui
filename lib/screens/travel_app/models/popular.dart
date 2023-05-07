class PopularModel {
  String image;
  int color;

  PopularModel(this.image, this.color);
}

List<PopularModel> populars = popularsData
    .map(
      (item) => PopularModel(
        item['image'].toString(),
        int.parse(item['color'].toString()),
      ),
    )
    .toList();

var popularsData = [
  {"image": "assets/travel/images/img_beach.png", "color": 0xFFFEF1ED},
  {"image": "assets/travel/images/img_mountain.png", "color": 0xFFEDF6FE},
  {"image": "assets/travel/images/img_lake.png", "color": 0xFFFEF6E8},
  {"image": "assets/travel/images/img_river.png", "color": 0xFFEAF8E8},
];
