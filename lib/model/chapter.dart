class Chapter {
  final String id;
  final List<String> pages;
  final num score;
  final num percentage;

  Chapter({
    required this.id,
    required this.pages,
    required this.score,
    required this.percentage,
  });

  static Chapter fromJSON(Map<String, dynamic> map) => Chapter(
        id: map['id'],
        pages: List.castFrom(map['pages']),
        score: map['score'],
        percentage: map['percentage'],
      );
}
