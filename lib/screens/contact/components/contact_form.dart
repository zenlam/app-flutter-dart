import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pivotino_flutter_app/components/m2o_field_modal.dart';
import 'package:pivotino_flutter_app/models/res_country.dart';
import 'package:pivotino_flutter_app/models/res_country_state.dart';
import 'package:pivotino_flutter_app/models/res_partner.dart';
import 'package:pivotino_flutter_app/models/res_users.dart';
import 'package:pivotino_flutter_app/themes/colors.dart';

class ContactForm extends StatefulWidget {
  final bool isCompany;
  final ResPartner contact;
  final GlobalKey<FormState> formKey;

  ContactForm({
    @required this.isCompany,
    this.contact,
    this.formKey,
  });

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  bool _showMore = false;
  final TextStyle _formTextStyle = TextStyle(
    color: kFontDarkBlue,
    fontSize: 20.0,
  );
  final picker = ImagePicker();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _contactOwnerController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final bytes = await pickedFile.readAsBytes();

    setState(() {
      if (bytes != null) {
        String base64Image = base64Encode(bytes);
        widget.contact.imageBase64 = "b'" + base64Image + "'";
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _companyController.text = widget.contact.company != null
        ? widget.contact.company[1].toString()
        : "";
    _contactOwnerController.text = widget.contact.contactOwner != null
        ? widget.contact.contactOwner[1].toString()
        : "";
    _countryController.text = widget.contact.country != null
        ? widget.contact.country[1].toString()
        : "";
    _stateController.text =
        widget.contact.state != null ? widget.contact.state[1].toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: InkWell(
                  onTap: () {
                    _getImage();
                  },
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: kFontBlueGrey,
                    foregroundColor: Colors.white,
                    backgroundImage: widget.contact.imageBase64 == null ||
                            widget.contact.imageBase64 == ""
                        ? NetworkImage(
                            "https://vimcare.com/assets/empty_user-e28be29d09f6ea715f3916ebebb525103ea068eea8842da42b414206c2523d01.png")
                        : MemoryImage(
                            widget.contact.decodeImageBase64(),
                          ),
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: _buildInputDecoration(
                        label: "Name",
                      ),
                      style: _formTextStyle,
                      initialValue: widget.contact.name,
                      validator: (value) {
                        widget.contact.name = value;
                        return;
                      },
                    ),
                    buildDivider(),
                    TextFormField(
                      decoration: _buildInputDecoration(
                        label: "Mobile",
                      ),
                      style: _formTextStyle,
                      keyboardType: TextInputType.phone,
                      initialValue: widget.contact.phone,
                      validator: (value) {
                        widget.contact.phone = value;
                        return;
                      },
                    ),
                    buildDivider(),
                    TextFormField(
                      decoration: _buildInputDecoration(
                        label: "Email address",
                      ),
                      style: _formTextStyle,
                      keyboardType: TextInputType.emailAddress,
                      initialValue: widget.contact.email,
                      validator: (value) {
                        widget.contact.email = value;
                        return;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _companyController,
                      decoration: _buildInputDecoration(
                        label: "Company name",
                        isPopUp: true,
                      ),
                      style: _formTextStyle,
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return M2oFieldModal(
                              title: "Company name",
                              modelName: ResPartner.modelName,
                              modelFields: ResPartner.m2oFields,
                              domain: "[('is_company', '=', True)]",
                            );
                          },
                        ).then((company) {
                          if (company != null) {
                            _companyController.text = company[1].toString();
                            widget.contact.company = company;
                          }
                        });
                      },
                    ),
                    buildDivider(),
                    TextFormField(
                      decoration: _buildInputDecoration(
                        label: "Job title",
                      ),
                      style: _formTextStyle,
                      initialValue: widget.contact.jobTitle,
                      validator: (value) {
                        widget.contact.jobTitle = value;
                        return;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _contactOwnerController,
                      decoration: _buildInputDecoration(
                        label: "Contact owner",
                        isPopUp: true,
                      ),
                      style: _formTextStyle,
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return M2oFieldModal(
                              title: "Contact Owner",
                              modelName: ResUsers.modelName,
                              modelFields: ResUsers.fields,
                            );
                          },
                        ).then((owner) {
                          if (owner != null) {
                            _contactOwnerController.text = owner[1].toString();
                            widget.contact.contactOwner = owner;
                          }
                        });
                      },
                    ),
                    buildDivider(),
                    TextFormField(
                      decoration: _buildInputDecoration(
                        label: "Note",
                      ),
                      style: _formTextStyle,
                      initialValue: widget.contact.comment,
                      validator: (value) {
                        widget.contact.comment = value;
                        return;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              !_showMore
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showMore = true;
                          });
                        },
                        child: Text(
                          'Show all fields',
                          style: TextStyle(color: kFontBlue),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "Lead status",
                                ),
                                style: _formTextStyle,
                              ),
                              buildDivider(),
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "Group",
                                ),
                                style: _formTextStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "Address 1",
                                ),
                                style: _formTextStyle,
                                initialValue: widget.contact.street,
                                validator: (value) {
                                  widget.contact.street = value;
                                  return;
                                },
                              ),
                              buildDivider(),
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "Address 2",
                                ),
                                style: _formTextStyle,
                                initialValue: widget.contact.street2,
                                validator: (value) {
                                  widget.contact.street2 = value;
                                  return;
                                },
                              ),
                              buildDivider(),
                              TextFormField(
                                controller: _countryController,
                                decoration: _buildInputDecoration(
                                  label: "Country",
                                  isPopUp: true,
                                ),
                                style: _formTextStyle,
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (BuildContext bc) {
                                      return M2oFieldModal(
                                        title: "Country",
                                        modelName: ResCountry.modelName,
                                        modelFields: ResCountry.fields,
                                      );
                                    },
                                  ).then((country) {
                                    if (country != null) {
                                      _countryController.text =
                                          country[1].toString();
                                      widget.contact.country = country;
                                    }
                                  });
                                },
                              ),
                              buildDivider(),
                              TextFormField(
                                controller: _stateController,
                                decoration: _buildInputDecoration(
                                  label: "State",
                                  isPopUp: true,
                                ),
                                style: _formTextStyle,
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (BuildContext bc) {
                                      return M2oFieldModal(
                                        title: "State",
                                        modelName: ResCountryState.modelName,
                                        modelFields: ResCountryState.fields,
                                        domain: widget.contact.country != null
                                            ? "[('country_id', '=', ${widget.contact.country[0]})]"
                                            : "",
                                      );
                                    },
                                  ).then((state) {
                                    if (state != null) {
                                      _stateController.text =
                                          state[1].toString();
                                      widget.contact.state = state;
                                    }
                                  });
                                },
                              ),
                              buildDivider(),
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "City",
                                ),
                                style: _formTextStyle,
                                initialValue: widget.contact.city,
                                validator: (value) {
                                  widget.contact.city = value;
                                  return;
                                },
                              ),
                              buildDivider(),
                              TextFormField(
                                decoration: _buildInputDecoration(
                                  label: "Postcode",
                                ),
                                style: _formTextStyle,
                                keyboardType: TextInputType.number,
                                initialValue: widget.contact.zip,
                                validator: (value) {
                                  widget.contact.zip = value;
                                  return;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _showMore = false;
                              });
                            },
                            child: Text(
                              'Show less fields',
                              style: TextStyle(color: kFontBlue),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    @required String label,
    bool isPopUp = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 20.0,
        color: kFontBlueGrey,
      ),
      border: InputBorder.none,
      suffixIcon: isPopUp
          ? Icon(
              Icons.chevron_right,
              color: kFontBlueGrey,
              size: 28.0,
            )
          : null,
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 1.0,
      color: kFontGrey,
    );
  }
}
