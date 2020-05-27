import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zink/services/mainScreens//Homepage.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/auth.dart';
import 'package:zink/shared-widgets/loadingWidget.dart';
import 'package:asset_toast/asset_toast.dart';

class loginandsignup extends StatefulWidget {
  @override
  _loginandsignupState createState() => _loginandsignupState();
}

class _loginandsignupState extends State<loginandsignup> {
  final formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isVisible = true;
  bool loading = false;
  String _email, _password, _password1, _finalpass;
  String errors = "";
  String passerrors = '';
  String UserID;




  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        AssetToast.show(content, context,
            asset: 'assets/images/insta_logo.png',
            duration: AssetToast.lengthShort,
            prefixBadge: Colors.deepPurple,
            gravity: AssetToast.bottom,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            msgColor: Colors.white);
      },
    );
  }

  passvalidation() {
    final form = formKey.currentState;
    form.save();
    if (_password == _password1) {
      _finalpass = _password;
    } else {
      setState(() => passerrors = "Passwords do not match");
    }
  }

  void valiadationandlogin() async {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      print("From is valid, Email : $_email , password : $_password");
      setState(() => loading = true);
      dynamic userid =
          await _authService.loginwithEmailandpass(_email, _password);
      if (userid == null) {
        print("Not logged in");
        setState(() {
          loading = false;
          errors = "Failed to log in with those credentials";
        });
      } else {

        print("Login successful");
        print("UserId after log in $userid");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepages()));
      }
    }
  }

  void registerandsave() async {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      print("Form is valid Email: $_email , password : $_password");
      setState(() => loading = true);
      print(loading);
      dynamic result =
          await _authService.registerwithEmailandpass(_email, _password);
      if (result != null) {
        print("Registration successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepages()));
      } else {
        setState(() => loading = false);
        print("::::::::::::::::: $loading");

          print("There is an error");
          print("Error in sign up: e");
          setState(() {
            loading = false;
            //TODO show relevant error
            errors = "AuthService.getExceptionText(e\f-\-fffffffffffffff\-)";
          });

      }
    } else {
      print("form is not valid");
    }
  }
//  void registerandsave() async {
//    try {
//      final form = formKey.currentState;
//      form.save();
//      if (form.validate()) {
//        print("Form is valid Email: $_email , password : $_password");
//        setState(() => loading = true);
//        print(loading);
//        await _authService
//            .registerwithEmailandpass(_email, _password)
//            .then((uid) {
//          AuthService.addUser(uid);
//        });
//
//        print("Registration successful");
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => Homepage()));
//      } else {
//        print("form is not valid");
//      }
//    } catch (e) {
//        print("Error in sign up: $e");
//      String exception = AuthService.getExceptionText(e);
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content:
//            Text("Error creating account.Check your internet and try again"),
//      ));
//      _showErrorAlert(
//          title: "Signup Failed", content: exception, onPressed: () => null);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    print(loading);
    return loading
        ? loadingwidget()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.teal[200],
            appBar: AppBar(
              title: Text("Login and signup"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/emirates.png'),
                    Container(
                        child:
                            (_isVisible) ? _getLoginfrom() : _getSignupForm()),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _getLoginfrom() {
    return Form(
      key: formKey,
      child: Container(
        width: 450,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (value) =>
                  value.isEmpty ? "Email field can't be empty " : null,
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              obscureText: true,
              validator: (value) =>
                  value.isEmpty ? "Password field can not be empty" : null,
              onSaved: (value) => _password = value,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: valiadationandlogin,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                // Todo
                //                add on pressed
                padding: EdgeInsets.all(12),
                color: Colors.lightBlueAccent,
                child: Text('Log In', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Text(errors, style: TextStyle(color: Colors.red, fontSize: 14.0)),
            new FlatButton(
              //          onPressed: setter(1),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Text('Not a member? Sign up now',
                  style: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSignupForm() {
    return Form(
      key: formKey,
      child: Container(
        width: 450,
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Email',
                icon: Icon(Icons.alternate_email),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (value) =>
                  value.isEmpty ? "This filed is required" : null,
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 25),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.lock),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (value) =>
                  value.isEmpty ? "This filed is required" : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(height: 5),
            Text(
              passerrors,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            SizedBox(height: 25),
            TextFormField(
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Confirm password',
                icon: Icon(Icons.lock),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              validator: (value) =>
                  value.isEmpty ? "This filed is required" : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(height: 5),
            Text(
              passerrors,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                // Todo
                //                add on pressed
                onPressed: registerandsave,
                padding: EdgeInsets.all(12),
                color: Colors.lightBlueAccent,
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              errors,
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
            FlatButton(
              //         onPressed: load login page ,
              //          onPressed: setter(0),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Text('Already a member? Login',
                  style: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }
}

// This class deals with firebase authentifications login and registration
