class ResCountryList {
  List<ResCountry> countries;

  ResCountryList({this.countries});

  int getLength() {
    return countries.length;
  }

  ResCountryList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      countries = new List<ResCountry>();
      json['data'].forEach((country) {
        countries.add(new ResCountry.fromJson(country));
      });
    }
  }
}

class ResCountry {
  // Model Information
  static String modelName = "res.country";
  static List<String> fields = ["name", "code"];

  // Model Definition
  int id;
  String name;
  String code;

  // Constructor
  ResCountry({this.id, this.name, this.code});

  // Methods
  ResCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }
}
