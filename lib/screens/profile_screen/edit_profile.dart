import 'dart:io';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _name, _bio, _location, _dob;
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

  Widget _details(String title,
      {TextEditingController controller, maxLines, hints}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontFamily: 'HelveticaNeue', fontSize: 16),
          ),
          TextField(
            enabled: true,
            controller: controller,
            maxLines: maxLines,
            autofillHints: hints,
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
      firstDate: DateTime(1970, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    setState(() {
      if (picked != null) {
        dob = picked.toString();
      }
    });
  }

  void uploadProfileImage() {
    setState(() {
      // _image = file;
    });
  }

  Widget _profileImage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 40,
        //backgroundImage:FileImage(_image),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black38,
          ),
          child: Center(
            child: IconButton(
              color: Colors.black,
              onPressed: () {},
              icon: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'HelveticaNeuelt'),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {},
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'HelveticaNeuelt'),
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
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: _profileImage(),
                  ),
                ],
              ),
            ),
            _details('Name', controller: _name),
            _details('Bio', controller: _dob, maxLines: 4),
            _details('Location', controller: _location),
            _details('Website', controller: _dob),
            InkWell(
              onTap: datePicker,
              child: _details('Date of birth',
                  controller: _dob, hints: 'Add your date of birth'),
            )
          ],
        ),
      ),
    );
  }
}
