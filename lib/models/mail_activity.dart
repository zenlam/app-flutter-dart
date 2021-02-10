class MailActivity {
  // Model Information
  static String modelName = "mail.activity";
  static List<String> fields = [];

  // Model Definition
  int id;

  // Constructor
  MailActivity({
    this.id,
  });

  // Methods
  MailActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}
