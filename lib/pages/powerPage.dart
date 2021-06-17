import 'package:flutter/material.dart';

class Power extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Pgina Power'),
      ),
      body: new Column(
        children: <Widget>[
          Text("Estamos Financiando"),
          RaisedButton(
            child: Text("Salir"),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
          ),
        ],
      ),
    );
  }
}
