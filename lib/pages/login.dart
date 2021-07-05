import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad_demo/style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          const SizedBox(
            height: 80.0,
          ),
          Column(
            children: [
              FlutterLogo(
                size: 100.0,
                // textColor: Colors.pink,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Flutter Shopping',
                style: Theme.of(context).textTheme.headline,
              )
            ],
          ),
          const SizedBox(
            height: 120.0,
          ),
          PrimaryColorOverride(
            color: ShoppingColors.brown900,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: '输入用户名'),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          PrimaryColorOverride(
            color: ShoppingColors.brown900,
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  prefixStyle: TextStyle(color: Colors.green),
                  prefixIcon: Icon(Icons.lock),
                  labelText: '请输入密码'),
            ),
          ),
          ButtonBar(
            children: [
              FlatButton(
                onPressed: () {
                  print('dd');
                  SystemNavigator.pop();
                },
                child: Text('取消'),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('登录'),
                elevation: 8.0,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
              )
            ],
          )
        ],
      )),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(primaryColor: color), child: child);
  }
}
