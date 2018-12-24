class Deed {
  final String id;
  final String text;

  Deed({this.id, this.text});

  factory Deed.fromJson(Map<String, dynamic> json) => Deed(
        id: json['id'],
        text: json['text'],
      );
}
