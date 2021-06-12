import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Image.asset(
              'assets/images/google.png',
              fit: BoxFit.contain,
            ),
          ),
          body: Column(
            children: [
              Image.asset(
                'assets/images/fondo1.jpg',
                scale: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Hello!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                'Welcome to Sales TOP a Plataform to Manager Real Estate Needs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black26),
              ),
              SizedBox(
                height: 25,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                ElevatedButton(
                    child: Text("Login", style: TextStyle(fontSize: 20)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.blue)))),
                    onPressed: () => null),
                TextButton(
                    child: Text("Sing Up", style: TextStyle(fontSize: 20)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.black)))),
                    onPressed: () => null),
              ]),
              SizedBox(
                height: 70,
              ),
              Text('Or via social media'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/facebook.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/plus.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/link.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
