import 'package:flutter/material.dart';
import 'package:zink/services/display/Homepage.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/auth.dart';
import 'package:zink/shared-widgets/loadingWidget.dart';


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
      dynamic result =
      await _authService.loginwithEmailandpass(_email, _password);
      if (result == null) {
        print("Not logged in");
        setState(() {
          loading = false;
          errors = "Failed to log in with those credentials";
        });
      } else {
        print("Login successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
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
      if (result == null) {
        print("There is an error");
        setState(() {
          loading = false;
          errors = "User registration failed";
        });
      } else {
        print("Registration successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    } else {
      print("form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
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


