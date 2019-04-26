
class HotWordBean {

  List<String> hotWords;
  List<NewHotWords> newHotWords;
  bool ok;

	HotWordBean.fromJsonMap(Map<String, dynamic> map): 
		hotWords = List<String>.from(map["hotWords"]),
		newHotWords = List<NewHotWords>.from(map["newHotWords"].map((it) => NewHotWords.fromJsonMap(it))),
		ok = map["ok"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['hotWords'] = hotWords;
		data['newHotWords'] = newHotWords != null ? 
			this.newHotWords.map((v) => v.toJson()).toList()
			: null;
		data['ok'] = ok;
		return data;
	}
}

class NewHotWords {

	String word;
	String book;

	NewHotWords.fromJsonMap(Map<String, dynamic> map):
				word = map["word"],
				book = map["book"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['word'] = word;
		data['book'] = book;
		return data;
	}
}
