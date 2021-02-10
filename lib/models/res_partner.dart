import 'dart:convert';
import 'dart:typed_data';

class ResPartnerList {
  List<ResPartner> contacts;

  ResPartnerList({this.contacts});

  int getLength() {
    return contacts.length;
  }

  ResPartnerList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      contacts = new List<ResPartner>();
      json['data'].forEach((contact) {
        contacts.add(new ResPartner.fromJson(contact));
      });
    }
  }
}

class ResPartner {
  // Model Information
  static String modelName = "res.partner";
  static List<String> m2oFields = ["name"];
  static List<String> fields = [
    "image_128",
    "name",
    "is_company",
    "street",
    "street2",
    "city",
    "state_id",
    "country_id",
    "zip",
    "function",
    "phone",
    "email",
    "parent_id",
    "user_id",
    "comment",
  ];

  // Model Definition
  int id;
  String imageBase64;
  String name;
  bool isCompany;
  String street;
  String street2;
  String city;
  List state;
  List country;
  String zip;
  String jobTitle;
  String phone;
  String email;
  List company;
  List contactOwner;
  String comment;

  // Constructor
  ResPartner({
    this.id,
    this.imageBase64,
    this.name,
    this.isCompany,
    this.street,
    this.street2,
    this.city,
    this.state,
    this.country,
    this.zip,
    this.jobTitle,
    this.phone,
    this.email,
    this.company,
    this.contactOwner,
    this.comment,
  });

  // Methods
  ResPartner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageBase64 = json['image_128'] == false ? "" : json['image_128'];
    name = json['name'];
    isCompany = json['is_company'];
    street = json['street'] == false ? "" : json['street'];
    street2 = json['street2'] == false ? "" : json['street2'];
    city = json['city'] == false ? "" : json['city'];
    state = json['state_id'] == false ? null : json['state_id'];
    country = json['country_id'] == false ? null : json['country_id'];
    zip = json['zip'] == false ? "" : json['zip'];
    jobTitle = json['function'] == false ? "" : json['function'];
    phone = json['phone'] == false ? "" : json['phone'];
    email = json['email'] == false ? "" : json['email'];
    company = json['parent_id'] == false ? null : json['parent_id'];
    contactOwner = json['user_id'] == false ? null : json['user_id'];
    comment = json['comment'] == false ? "" : json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['image_1920'] = this.imageBase64 != null && this.imageBase64 != ''
        ? this.imageBase64.substring(1).replaceAll("'", "")
        : null;
    data['name'] = this.name;
    data['is_company'] = this.isCompany;
    data['street'] = this.street;
    data['street2'] = this.street2;
    data['city'] = this.city;
    data['state_id'] = this.state != null ? this.state[0] : null;
    data['country_id'] = this.country != null ? this.country[0] : null;
    data['zip'] = this.zip;
    data['function'] = this.jobTitle;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['parent_id'] = this.company != null ? this.company[0] : null;
    data['user_id'] = this.contactOwner != null ? this.contactOwner[0] : null;
    data['comment'] = this.comment;

    return data;
  }

  Uint8List decodeImageBase64() {
    return base64Decode(imageBase64.substring(1).replaceAll("'", ""));
  }
}
