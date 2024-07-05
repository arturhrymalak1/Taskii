import 'package:flutter/material.dart';

class Newtask extends StatelessWidget {
  const Newtask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('New Task'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "  Insert your message",),
                scrollPadding: EdgeInsets.all(19.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,)
            ],
          ),
        ),
      ),
        resizeToAvoidBottomInset: true,
    );
  }
}


