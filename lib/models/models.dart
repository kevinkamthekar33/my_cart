class AllData {
  int price;
  String description, category, thumbnail;
  List images;

  AllData(
    this.price,
    this.description,
    this.category,
    this.images,
    this.thumbnail,
  );

  factory AllData.fromMap({required Map data}) {
    return AllData(
      data['price'],
      data['description'],
      data['category'],
      data['images'],
      data['thumbnail'],
    );
  }
}
