// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInformationModel {
  final String firstName;
  final String lastName;
  final String email;
  bool inCustomerAccount;
  UserInformationModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.inCustomerAccount = true,
  });

  UserInformationModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? inCustomerAccount,
  }) {
    return UserInformationModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      inCustomerAccount: inCustomerAccount ?? this.inCustomerAccount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'inCustomerAccount': inCustomerAccount,
    };
  }

  factory UserInformationModel.fromMap(Map<String, dynamic> map) {
    return UserInformationModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      inCustomerAccount: map['inCustomerAccount'] as bool,
    );
  }

  factory UserInformationModel.fromJson(String source) => UserInformationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInformation(firstName: $firstName, lastName: $lastName, email: $email, inCustomerAccount: $inCustomerAccount)';
  }
}