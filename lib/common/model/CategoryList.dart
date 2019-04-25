
class CategoryList {

  List<Male> male;
  List<Male> female;
  List<Male> picture;
  List<Male> press;
  bool ok;

	CategoryList.fromJsonMap(Map<String, dynamic> map): 
		male = List<Male>.from(map["male"].map((it) => Male.fromJsonMap(it))),
		female = List<Male>.from(map["female"].map((it) => Male.fromJsonMap(it))),
		picture = List<Male>.from(map["picture"].map((it) => Male.fromJsonMap(it))),
		press = List<Male>.from(map["press"].map((it) => Male.fromJsonMap(it))),
		ok = map["ok"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['male'] = male != null ? 
			this.male.map((v) => v.toJson()).toList()
			: null;
		data['female'] = female != null ? 
			this.female.map((v) => v.toJson()).toList()
			: null;
		data['picture'] = picture != null ? 
			this.picture.map((v) => v.toJson()).toList()
			: null;
		data['press'] = press != null ? 
			this.press.map((v) => v.toJson()).toList()
			: null;
		data['ok'] = ok;
		return data;
	}
}

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