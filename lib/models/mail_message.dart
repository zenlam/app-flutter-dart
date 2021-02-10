import 'package:html/parser.dart';

class MailMessageList {
  List<MailMessage> notes;

  MailMessageList({this.notes});

  int getLength() {
    return notes.length;
  }

  MailMessageList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notes = new List<MailMessage>();
      json['data'].forEach((note) {
        notes.add(new MailMessage.fromJson(note));
      });
    }
  }
}

class MailMessage {
  // Model Information
  static String modelName = "mail.message";
  static List<String> fields = [
    "date",
    "body",
    "attachment_ids",
    "model",
    "res_id",
    "message_type",
    "author_id",
  ];

  // Model Definition
  int id;
  DateTime date;
  String bodyMessage;
  List attachments;
  String model;
  int resId;
  String messageType;
  List author;

  // Constructor
  MailMessage({
    this.id,
    this.date,
    this.bodyMessage,
    this.attachments,
    this.model,
    this.resId,
    this.messageType,
    this.author,
  });

  // Methods
  MailMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.parse(json['date']);
    bodyMessage = _parseHtmlString(json['body']);
    attachments = json['attachment_ids'];
    model = json['model'];
    resId = json['res_id'];
    messageType = json['message_type'];
    author = json['author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['body'] = this.bodyMessage.replaceAll("\n", "<br>");
    data['model'] = this.model;
    data['res_id'] = this.resId;
    data['message_type'] = this.messageType;

    return data;
  }

  String _parseHtmlString(String htmlString) {
    // replace <br> tag with "\n" to show the String in multiline
    var newHtmlString = htmlString.replaceAll("<br>", "\n");

    // parse the htmlString to readable String
    final document = parse(newHtmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
}
