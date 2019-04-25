import 'package:zwt_life_flutter_app/common/model/Male.dart';

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
