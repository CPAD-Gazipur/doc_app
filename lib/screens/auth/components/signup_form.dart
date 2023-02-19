import 'dart:convert';

import 'package:doc_app/components/components.dart';
import 'package:doc_app/main.dart';
import 'package:doc_app/models/models.dart';
import 'package:doc_app/providers/dio_provider.dart';
import 'package:doc_app/services/services.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
            controller: _nameController,
            keyboardType: TextInputType.name,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Md. Al-Amin',
              labelText: 'Name',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.account_circle_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
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
                title: 'Sign Up',
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    final register = await DioProvider().registerUser(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    if (register) {
                      final result = await DioProvider().getToken(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (result) {
                        final tokenTemp =
                            await SharedPreferencesService.getToken() ?? '';

                        if (tokenTemp != '') {
                          final response = await DioProvider().getUser(
                            token: tokenTemp.toString(),
                          );

                          if (response != '') {
                            setState(() {
                              Map<String, dynamic> appointment = {};
                              final user = json.decode(response);

                              for (var doctorData in user['doctors']) {
                                if (doctorData['appointments'] != null) {
                                  appointment = doctorData;
                                }
                              }
                              auth.loginSuccess(
                                userData: user,
                                appointmentInfo: appointment,
                              );

                              MyApp.navigatorKey.currentState!
                                  .pushNamedAndRemoveUntil(
                                '/main',
                                (Route<dynamic> route) => false,
                              );
                            });
                          }
                        }
                      }
                    } else {
                      debugPrint('Registration is not successfully');
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
