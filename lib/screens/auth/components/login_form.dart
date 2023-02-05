import 'package:doc_app/components/custom_button.dart';
import 'package:doc_app/main.dart';
import 'package:doc_app/models/auth_model.dart';
import 'package:doc_app/providers/providers.dart';
import 'package:doc_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'example@gmail.com',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscurePassword,
            cursorColor: Config.primaryColor,
            decoration: InputDecoration(
              hintText: '********',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
                icon: obscurePassword
                    ? const Icon(
                        Icons.visibility_off_outlined,
                        color: Colors.black38,
                      )
                    : const Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              ),
            ),
          ),
          Config.spaceMedium,
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return CustomButton(
                width: double.infinity,
                title: 'Sign In',
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    final token = await DioProvider().getToken(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (token) {
                      auth.loginSuccess();
                      MyApp.navigatorKey.currentState!.pushNamed('/main');
                    }
                  }
                  // Navigator.of(context).pushNamed('/main');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
