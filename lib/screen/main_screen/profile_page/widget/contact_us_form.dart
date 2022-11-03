import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant.dart';
import '../../../../provider/profile_provider.dart';
class ContactUsForm extends StatefulWidget {
  const ContactUsForm({Key? key}) : super(key: key);

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String companyName;
  late String subject;
  late String question;

  @override
  Widget build(BuildContext context) {
    double formFiledPadding = 18;
    EdgeInsets innerPadding = const EdgeInsets.symmetric(horizontal: 12);
    var formInputStyle = const TextStyle(fontWeight: FontWeight.bold);

    buildFistName() {
      return TextFormField(
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.firstName} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => firstName = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.firstNameIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildLastName() {
      return TextFormField(
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.lastName} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => lastName = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.lastNameIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildEmail() {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.email} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => email = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.emailIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildPhoneNumber() {
      return TextFormField(
        keyboardType: TextInputType.number,
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.phoneNumber} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => phone = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.phoneIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildCompanyName() {
      return TextFormField(
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.yourCompanyName} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => companyName = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.companyIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildSubject() {
      return TextFormField(
        style: formInputStyle,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.subject} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => subject = value),
        validator: (value) {
          if (value!.isEmpty) {
            return AppLocalizations.of(context)!.subjectIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildYourQuestion() {
      return TextFormField(
        style: formInputStyle,
        maxLines: 5,
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.yourQuestion} *",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: (value) => setState(() => question = value),
        validator: (value) {
          if (value!.isEmpty) {
          return  AppLocalizations.of(context)!.questionIsRequired;
          } else {
            return null;
          }
        },
      );
    }

    buildSubmitButton() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Theme.of(context).primaryColor),
        onPressed: () async {
          bool isValid = formKey.currentState!.validate();
          setState(() {
            isLoading = true;
          });
          if (isValid) {
            var provider = Provider.of<ProfileProvider>(context, listen: false);
            provider.onContactFormSubmit(
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                subject: subject,
                question: question,
                company: companyName,
                context: context);
          }
          setState(() {
            isLoading = false;
          });
        },
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
          AppLocalizations.of(context)!.submit,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    letterSpacing: 1.5,
                    color: Colors.white),
              ),
      );
    }

    return Column(
      children: [
        Container(
          decoration: Constant().boxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(left: formFiledPadding),
                child: Text(
                  AppLocalizations.of(context)!.contactUs,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: innerPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          buildFistName(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildLastName(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildEmail(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildPhoneNumber(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildCompanyName(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildSubject(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                          buildYourQuestion(),
                          SizedBox(
                            height: formFiledPadding,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        buildSubmitButton(),
        SizedBox(
          height: 28,
        ),
      ],
    );
  }
}
