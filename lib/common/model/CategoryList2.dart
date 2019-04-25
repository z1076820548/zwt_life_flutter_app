
class CategoryList2 {
  List<CategoryList2DataBean> male;
  List<CategoryList2DataBean> female;
  List<CategoryList2DataBean> picture;
  List<CategoryList2DataBean> press;
  bool ok;

	CategoryList2.fromJsonMap(Map<String, dynamic> map): 
		male = List<CategoryList2DataBean>.from(map["male"].map((it) => CategoryList2DataBean.fromJsonMap(it))),
		female = List<CategoryList2DataBean>.from(map["female"].map((it) => CategoryList2DataBean.fromJsonMap(it))),
		picture = List<CategoryList2DataBean>.from(map["picture"].map((it) => CategoryList2DataBean.fromJsonMap(it))),
		press = List<CategoryList2DataBean>.from(map["press"].map((it) => CategoryList2DataBean.fromJsonMap(it))),
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

class CategoryList2DataBean{

	String major;
	List<String> mins;

	CategoryList2DataBean.fromJsonMap(Map<String, dynamic> map):
				major = map["major"],
				mins = List<String>.from(map["mins"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['major'] = major;
		data['mins'] = mins;
		return data;
	}
}
