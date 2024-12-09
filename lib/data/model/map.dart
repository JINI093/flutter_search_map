// {
//       "title": "커피해리902",
//       "link": "https://www.instagram.com/coffeeharry902",
//       "category": "음식점>카페,디저트",
//       "description": "",
//       "telephone": "",
//       "address": "인천광역시 서구 원당동 1030-8 검단퍼스트 112호",
//       "roadAddress": "인천광역시 서구 이음5로 80 검단퍼스트 112호",
//       "mapx": "1267163311",
//       "mapy": "375953218"
//     }

class Guidance {
  final String title;
  final String link;
  final String category;
  final String description;
  final String telephone;
  final String address;
  final String roadAddress;
  final String mapx;
  final String mapy;

  Guidance({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  Guidance.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          link: map['link'],
          category: map['category'],
          description: map['description'],
          telephone: map['telephone'],
          address: map['address'],
          roadAddress: map['roadAddress'],
          mapx: map['mapx'],
          mapy: map['mapy'],
        );

  // HTML 태그 제거 헬퍼 메서드
  static String _removeHtmlTags(String text) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return text.replaceAll(exp, '');
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'category': category,
      'description': description,
      'telephone': telephone,
      'address': address,
      'roadAddress': roadAddress,
      'mapx': mapx,
      'mapy': mapy,
    };
  }
}
