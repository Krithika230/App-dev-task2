
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());
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

  String password = '' , email='', message='',message1='';
  bool emailValidate = false, passwordValidate= false;
  bool eValidate (String email) {
    if(email.endsWith('.com') && email.contains('@')) {
      return true;
    } else{
      return false;
    }
  }

  bool pValidate (String password) {
    bool hasUppercase=false, hasLowerCase=false, isDigit=false;
    int stringLength=0;
    stringLength = password.length;
    hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    isDigit = password.contains(new RegExp(r'[0-9]'));
    hasLowerCase = password.contains(new RegExp(r'[a-z]'));
    if(hasLowerCase && hasUppercase && isDigit && stringLength>=8)
    {return true;}
    else{return false;}
  }
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Email ID',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: 'abc@gmail.com'
                        ),
                        onChanged: (text1) {
                          setState(() {
                            email = text1;
                            emailValidate=eValidate(email);
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: 'password'
                        ),
                        onChanged: (text2) {
                          setState(() {
                            password = text2;
                            passwordValidate=pValidate(password);
                          });
                        },
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
                                if(emailValidate==false && passwordValidate==false)
                                  {
                                    message='InValid Email and Password';
                                  }
                                else{
                                  message='Valid Email or Password';
                                }
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
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(message),
                    ),
                    ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>API()));
                      },

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                        shadowColor: MaterialStateProperty.all(Colors.blueGrey),
                      ),
                      child: Text(
                        'Go to API',
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

class API extends StatefulWidget {
  // This widget is the root of your application.
  APIState createState() => APIState();
}


class APIState extends State<API> {
  late Future<List<User>> listUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var getUsersData = json.decode(response.body) as List;
      var listUsers = getUsersData.map((i) => User.fromJSON(i)).toList();
      return listUsers;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<List<User>>(
          future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List<User>)[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.name,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: 'Wonderland',
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.email,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.address.street +
                              " " +
                              user.address.suite +
                              " " +
                              user.address.city +
                              " " +
                              user.address.zipcode,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.phone,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.website,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.company.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(user.company.catchPhrase,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Scriptin',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: (snapshot.data as List<User>).length);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
              ),
            );
          },
        ),
    );
  }
}




