import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import '../utilities/constant.dart';

class ApiAuthentication {
  final User firebaseUser = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser.uid;

  // function to check if user is present in the database
  Future<bool> userIsPresent() async {
    try {
      final String getUrl = baseUrl + "user-present-or-not/" + uid;
      Response getResponse = await get(Uri.parse (getUrl));

      if (getResponse.statusCode == 404) {
        return false;
      } else if (getResponse.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {

      throw Exception();
    }
  }

  // function to create user in the database
  Future createUser() async {
    try {
      final String postUrl = baseUrl + "user/";


      // posting user's data
      Response postResponse = await post(
        Uri.parse(postUrl),
        body: jsonEncode(<String, String>{
          'google_id': uid,
          'name': firebaseUser.displayName,
          'email': firebaseUser.email
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (postResponse.statusCode == 201) {

      } else if (postResponse.statusCode == 400) {

      }

    } catch (e) {

      throw Exception();
    }
  }
}
