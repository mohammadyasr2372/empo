// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names

import 'dart:convert';

class ImageNet {
  final String url;
  final String id;
  ImageNet({
    required this.url,
    required this.id,
  });

  ImageNet copyWith({
    String? url,
    String? id,
  }) {
    return ImageNet(
      url: url ?? this.url,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'id': id,
    };
  }

  factory ImageNet.fromMap(Map<String, dynamic> map) {
    return ImageNet(
      url: map['url'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageNet.fromJson(String source) =>
      ImageNet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageNet(url: $url, id: $id)';

  @override
  bool operator ==(covariant ImageNet other) {
    if (identical(this, other)) return true;

    return other.url == url && other.id == id;
  }

  @override
  int get hashCode => url.hashCode ^ id.hashCode;
}
