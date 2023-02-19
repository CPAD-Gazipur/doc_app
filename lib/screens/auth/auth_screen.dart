import 'package:doc_app/main.dart';
import 'package:doc_app/models/models.dart';
import 'package:doc_app/screens/auth/components/signup_form.dart';
import 'package:doc_app/screens/screens.dart';
import 'package:doc_app/services/services.dart';
import 'package:doc_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;

  checkAutoLogin() async {
    final token = await SharedPreferencesService.getToken() ?? '';
    if (token != '') {
      AuthModel().loginSuccess(
        userData: {},
        appointmentInfo: {},
      );
      MyApp.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        '/main',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    checkAutoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Text(
                isSignIn
                    ? AppText.enText['signIn_text']!
                    : AppText.enText['register_text']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              isSignIn ? const LoginForm() : const SignupForm(),
              Config.spaceSmall,
              isSignIn
                  ? Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppText.enText['forget_password_text']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const Spacer(),
              Center(
                child: Text(
                  AppText.enText['social_login_text']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialLoginButton(
                    title: 'google',
                    onPressed: () {},
                  ),
                  SocialLoginButton(
                    title: 'facebook',
                    onPressed: () {},
                  ),
                ],
              ),
              Config.spaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isSignIn
                        ? AppText.enText['signUp_text']!
                        : AppText.enText['registered_text']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSignIn = !isSignIn;
                      });
                    },
                    child: Text(
                      isSignIn ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
