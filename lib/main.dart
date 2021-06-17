import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appfinanciera/pages/financiantePage.dart';
import 'package:flutter_appfinanciera/pages/powerPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Financiera',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/powerPage': (BuildContext context) => new Power(),
        '/financiantePage': (BuildContext context) => new Financiante(),
        '/LoginPage': (BuildContext context) => LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String mensage = '';

  Future<List> login() async {
    var api = Uri.parse('http://10.2.2.17/financiera/login.php');
    var res, drinks;

    final response = await http.post(api, body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensage = "user an pasword incorrecto";
      });
    } else {
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/PowerPage');
      } else if (datauser[0]['nivel'] == 'financiamientos') {
        Navigator.pushReplacementNamed(context, '/financiantePage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/imagenprestamo.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 77.0),
                child: new CircleAvatar(
                  backgroundColor: Color(0xF81F7F3),
                  child: new Image(
                    width: 135,
                    height: 135,
                    image:
                        new AssetImage('assets/images/fondo-de-maniobra.jpg'),
                  ),
                ),
                width: 170.0,
                height: 170.0,
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 93),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                        top: 4,
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: controllerUser,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.blue,
                            ),
                            hintText: 'User'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(
                        top: 32,
                      ),
                      padding: EdgeInsets.only(
                        top: 4,
                        left: 16,
                        right: 16,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.blue,
                            ),
                            hintText: 'Password'),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 6,
                    right: 32,
                  ),
                  child: Text(
                    'Recordar Pass',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Spacer(),
              new RaisedButton(
                child: new Text("Ingresar"),
                color: Colors.orangeAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  login();
                  Navigator.pop(context);
                },
              ),
              Text(
                mensage,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
