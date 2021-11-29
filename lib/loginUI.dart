import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background1.jpg"),
                fit: BoxFit.cover
            ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 70.0,
                        color: Colors.white,
                        fontFamily: 'Lobster',
                        letterSpacing: 5.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: TextField(
                          controller: _name,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Enter User Name',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: 'User_name'
                          ),
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Email ID',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: 'abc@gmail.com'
                          ),
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: TextField(
                          controller: _pass,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: 'password'
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 140,
                            child: ElevatedButton(
                              onPressed: (){
                                // TODO: insert code for login screen
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                DisplayPage(name: _name.text, email: _email.text)
                                ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                shadowColor: MaterialStateProperty.all(Colors.black),
                              ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                  ),
                                ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 50,
                            width: 140,
                            child: ElevatedButton(
                              onPressed: (){
                                //insert code
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                shadowColor: MaterialStateProperty.all(Colors.black),
                              ),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                    ElevatedButton(
                      onPressed: (){
                        // FORGOT PASSWORD SCREEN GOES HERE
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                        shadowColor: MaterialStateProperty.all(Colors.blueGrey),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



