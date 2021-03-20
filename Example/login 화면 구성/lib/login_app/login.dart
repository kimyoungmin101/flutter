import 'package:flutter/material.dart';
import 'package:signin2/my_button/my_button.dart';

class LogIn extends StatelessWidget {

  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final LogIn logIn = new LogIn();
    logIn.buildButton();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: buildButton(),
    );
  }

  Widget buildButton() {
    return Builder(
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Image(
                      image: AssetImage('images/gifimg.gif'),
                      width: 150,
                    ),
                  )),
              Form(
                child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.teal,
                            fontSize: 15.0,
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            decoration:
                            InputDecoration(labelText: 'Enter "dice"'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: controller1,
                            decoration:
                            InputDecoration(labelText: 'Enter "password"'),
                            keyboardType: TextInputType.text,
                            obscureText: true, //비밀번호 입력시 안보이게 !!
                          ),
                          SizedBox(
                            height: 20.0,
                          ),



                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MyButton(
                                  image : Image.asset('images/glogo.png'),
                                  text: Text(
                                    'Login with Google',
                                    style: TextStyle(color: Colors.black87, fontSize: 15.0),
                                  ),
                                  color : Colors.white,
                                  radius : 4.0,
                                  onPressed : (){},
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                MyButton(
                                  image : Image.asset('images/flogo.png'),
                                  text: Text(
                                    'Login with Facebook',
                                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                                  ),
                                  color : Color(0xFF334D92),
                                  radius : 4.0,
                                  onPressed : (){},
                                ),

                                SizedBox(
                                  height: 10.0,
                                ),

                                MyButton(
                                  image : Icon(Icons.email, color: Colors.indigo, size: 35,),
                                  text: Text(
                                    'Login with Email',
                                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                                  ),
                                  color : Colors.green,
                                  radius : 4.0,
                                  onPressed : (){},
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: ButtonTheme(
                                    minWidth: 100,
                                    height: 50,
                                    child: RaisedButton(
                                        color: Colors.orange,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          if (controller.text == 'dice' && controller1.text == '1234') {

                                          }
                                          else if (controller.text == 'dice' && controller1.text != '1234') {
                                            showSnackBar2(context);
                                          }
                                          else if (controller.text != 'dice' && controller1.text == '1234') {
                                            showSnackBar3(context);
                                          }
                                          else {
                                            showSnackBar(context);
                                          }
                                        }),
                                  ),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

void showSnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      '로그인 정보를 다시 확인하세요.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackBar2(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      '비밀번호가 일치하지 않습니다.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}

void showSnackBar3(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      'dice의 절차를 확인하세요.',
      textAlign: TextAlign.center,
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}
