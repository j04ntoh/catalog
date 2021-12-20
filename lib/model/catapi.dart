class CatAPI {
  final List<dynamic> breeds;
  final String id;
  final String url;
  final int width;
  final int height;

  CatAPI({
    required this.breeds,
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory CatAPI.fromJson(List<dynamic> json) {
    Map<String, dynamic> newJson = json.first;
    return CatAPI(
      breeds: newJson["breeds"],
      id: newJson['id'],
      url: newJson['url'],
      width: newJson['width'],
      height: newJson['height'],
    );
  }
}