import 'package:flutter/cupertino.dart';

class User {
  String userName;
  String firstName;
  String lastName;
  String address;
  AssetImage profilePic;

  User(this.userName, this.firstName, this.lastName, this.address,
      this.profilePic);
}
