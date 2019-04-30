
class SearchHistory {

  List<String> history;

	SearchHistory(this.history);

	 SearchHistory.fromJsonMap(Map<String, dynamic> map){
	 history = List<String>.from(map["history"]);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['history'] = history;
		return data;
	}
}
