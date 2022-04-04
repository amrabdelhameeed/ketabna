import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget
{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var value = false ;
  var formKey = GlobalKey<FormState>();
  bool isPasswordShow = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
         leading:IconButton(
           splashColor: Colors.grey,
           onPressed: (){},
           icon: const Icon(
             Icons.arrow_back_ios_sharp ,
             color: Color(0xfff5b53f),
           ),
         ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Email must not be empty';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.black54,fontSize: 18.0,),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(color: Color(0xfff5b53f),width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value)
                    {
                      if(value!.isEmpty)
                        {
                          return 'Password must not be empty';
                        }
                      return null ;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPasswordShow,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon:isPasswordShow ? Icon(Icons.visibility_off): Icon(Icons.visibility),
                        onPressed: ()
                        {
                          setState(() {
                            isPasswordShow = !isPasswordShow ;
                          });
                        },
                      ) ,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black54,fontSize: 18.0,),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(color: Color(0xfff5b53f),width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                      Checkbox(
                        activeColor: Color(0xfff5b53f),
                        value: value,
                        onChanged: (value) => setState(()
                        {
                          this.value = value!;
                        })),
                      const Text(
                        'Stay Logged In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),
                      ),
                      const SizedBox(
                        width: 140,
                      ),
                    ]
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          print('good');
                        }
                      },
                      color:Colors.amberAccent[100],
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xfff5b53f),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children:[
                       Text(
                        'Forgot Your Password ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                  ),
                       TextButton(
                         style:TextButton.styleFrom(
                           primary: Color(0xfff5b53f),
                         ), onPressed: () {  },
                         child: Text('Register'),
                         ),
                     ],
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
