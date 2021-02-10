class ResCountryStateList {
  List<ResCountryState> states = [];

  ResCountryStateList({this.states});

  int getLength() {
    return states.length;
  }

  ResCountryStateList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      states = new List<ResCountryState>();
      json['data'].forEach((state) {
        states.add(new ResCountryState.fromJson(state));
      });
    }
  }
}

class ResCountryState {
  // Model Information
  static String modelName = "res.country.state";
  static List<String> fields = ["country_id", "name", "code"];

  // Model Definition
  int id;
  int countryId;
  String name;
  String code;

  // Constructor
  ResCountryState({this.id, this.countryId, this.name, this.code});

  // Methods
  ResCountryState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json["country_id"][0];
    name = json['name'];
    code = json['code'];
  }
}
