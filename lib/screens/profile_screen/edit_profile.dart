import 'dart:io';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  TextEditingController _name,_bio,_location,_dob;
  File _image;
  String dob;
  

  @override
  void initState() {
    _name = TextEditingController();
    _bio = TextEditingController();
    _location = TextEditingController();
    _dob = TextEditingController();
    super.initState();
  }

  Widget _details(String title, {TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          TextField(
            enabled: true,
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
          )
        ],
      ),
    );
  }

  void datePicker() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2020, DateTime.now().month, DateTime.now().day),
      firstDate: DateTime(1970, DateTime.now().month,DateTime.now().day),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    setState(() {
      if(picked != null) {
        dob = picked.toString();
      }
    });
  }

  void uploadProfileImage() {
    setState(() {
      // _image = file;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text('Profile Edit'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 180,
                    padding: EdgeInsets.only(bottom: 50),
                    child: Container(
                      color: Colors.red,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
            _details('Name', controller: _name),
            _details('Bio', controller: _dob),
            _details('Location', controller: _location),
            InkWell(
              onTap: datePicker,
              child: _details('Date of birth', controller: _dob),
            )
          ],
        ),
      ),
    );
  }
}
