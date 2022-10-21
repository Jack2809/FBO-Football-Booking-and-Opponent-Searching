import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_booking_fbo_mobile/providers/google_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _primaryColor = Color.fromRGBO(25, 165, 74, 1);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: size.height * 0.2,
                  width:  size.width * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/app_icon.png'),
                      fit: BoxFit.fill
                    ),
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor
                  ),
                ),
                SizedBox(height: size.height * 0.20,),
                //User name textfield
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: "UserName",
                  ),
                ),
                SizedBox(height: size.height * 0.05,),
                //password textfield
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                  obscureText: true,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(child: Text('Register'),onPressed: (){},),
                      SizedBox(width: size.width * 0.1,),
                      TextButton(child: Text('Forget password?'),onPressed: (){},),
                    ],
                  ),
                ),

                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if(states.contains(MaterialState.pressed)){
                          return Colors.blue;
                        }
                        return Colors.green;
                      }
                      ),
                    ),
                    child: Text('Login'),
                    onPressed: (){}),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: Divider(thickness: 1,color:Colors.black,height:100)),
                      Text('OR'),
                      Expanded(child: Divider(thickness: 1,color:Colors.black,height:100)),
                    ],
                  ),
                ),

                Text('Login with',style: TextStyle(color: _primaryColor)),

                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return Colors.blue;
                      }
                      return Colors.green;
                    }
                    ),
                  ),
                  onPressed: () async {
                    final provider = Provider.of<GoogleLoginProvider>(context,listen: false);
                    provider.loginWithGoogle();
                  },
                  icon: Image.asset('assets/google.png',width: 30,height: 30 ),
                  label: Text('Đăng nhập'), // <-- Text
                ),



              ],
            ),
          ),
        ),
      ),

    );
  }
}