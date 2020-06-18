import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/utils/bottom_button.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset('assets/logo/icon-48.png'),
        ),
        elevation: 0,
        leading: null,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Text(
                'Create your account',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w800, color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal : 20.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 50,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Name',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Phone number or email',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Bottom_Button(title: 'Next', onPressed: () {})
        ],
      ),
    );
  }
}
