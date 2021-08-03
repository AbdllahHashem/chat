import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
late final void Function(String email,String password,String username,bool isLogin,BuildContext ctx) submitFn;

final bool isLoading;
AuthForm(this.submitFn,this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formkey=GlobalKey<FormState>();
  bool _isLogin=true;
  String _email="";
  String _password="";
  String _userName="";

  void _submit()
  {
    final isValid=_formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(isValid)
      {
        _formkey.currentState!.save();
        widget.submitFn(_email.trim(),_password.trim(),_userName.trim(),_isLogin,context);
      }

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
           child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val){
                    if(val!.isEmpty||!val.contains('@'))
                      {
                        return 'Please enter a valid email address';
                      }
                    return null;
                  },
                  onSaved: (val)=>_email=val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address'
                  ),
                ),
                if(!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  validator: (val){
                    if(val!.isEmpty||val.length<4)
                      {
                        return 'Please enter at least 4 characters';
                      }
                    return null;
                  },
                  onSaved: (val)=>_userName=val!,
                  decoration: InputDecoration(
                    labelText: 'UserName'
                  ),
                ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val!.isEmpty||val.length<7)
                      {
                        return 'Please enter at least 7 characters';
                      }
                    return null;
                  },
                  onSaved: (val)=>_password=val!,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 12,),
                if(widget.isLoading)
                  CircularProgressIndicator(),
                if(!widget.isLoading)
                Container(
                  decoration: BoxDecoration(
                    color:Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: MaterialButton(
                      onPressed: _submit,
                    child: Text(
                      _isLogin?'Login':'Sign Up'
                    ),


                  ),
                ),
                if(!widget.isLoading)
                TextButton(
                    onPressed: (){
                      setState(() {
                        _isLogin=!_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin? 'Create New Account' :'I already have an account'
                    ),
                ),
                


              ],
            ),
          ),
        ),
      ),
    );
  }
}
