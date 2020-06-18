import 'package:flutter/material.dart';

class Bottom_Button extends StatelessWidget {
  const Bottom_Button({
    Key key,
    @required String title,
    @required Function onPressed
  }) : title = title , onPressed = onPressed , super(key: key);

  final String title ;
  final Function onPressed ;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Divider(
                thickness: 1.2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RaisedButton(
                  child: Text(this.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  onPressed: this.onPressed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
