import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> choices = ['About', 'Proxy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 38),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.blue[300]),
                ),
                textColor: Colors.blue,
              ),
            ),
            PopupMenuButton(
              child: IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.blue,
                onPressed: () {},
              ),
              color: Colors.blue,
              initialValue: choices[0],
              onCanceled: () {
                print('You Have not selected anything');
              },
              tooltip: 'This is tool tip',
              itemBuilder: (BuildContext context) {
                return choices.map((choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice[1]),
                  );
                }).toList();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
          elevation: 0.0,
          centerTitle: true,
          title: Container(
              child: IconButton(
            icon: new Image.asset(
              'assets/logo/icon-480.png',
              alignment: Alignment.center,
            ),
            onPressed: () {},
          ))),
      body: Container(
        padding: EdgeInsets.only(left: 10),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 125, right: 5)),
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 180, bottom: 20),
              child: Text(
                'Log in to Twitter.',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 220),
                child: Text('Phone,email or username',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey))),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              alignment: Alignment.centerLeft,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black, fontSize: 25),
                autofocus: true,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 20, right: 315, top: 10),
                child: Text('Password',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey))),
            Container(
              padding: EdgeInsets.only(left: 20, right: 25),
              alignment: Alignment.centerLeft,
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 25),
                keyboardType: TextInputType.visiblePassword,
                autofocus: true,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Forget Password?',
                style: TextStyle(color: Colors.grey),
              ),
              textColor: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20 ,top: 250),
              child: Divider(
                height: 20,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 250, top: 20),
              child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(0, 172, 237, 10)),
                  child: RaisedButton(
                    child: Text('Log in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
