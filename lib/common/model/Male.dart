
class Male {

  String name;
  int bookCount;
  int monthlyCount;
  String icon;
  List<String> bookCover;

	Male.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		bookCount = map["bookCount"],
		monthlyCount = map["monthlyCount"],
		icon = map["icon"],
		bookCover = List<String>.from(map["bookCover"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['bookCount'] = bookCount;
		data['monthlyCount'] = monthlyCount;
		data['icon'] = icon;
		data['bookCover'] = bookCover;
		return data;
	}
}
