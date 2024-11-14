import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/style/dialog_utils.dart';

import '../../firebase/firebase_auth_codes.dart';
import '../../style/reusable_components/custom_button.dart';
import '../../style/reusable_components/custom_text_field.dart';
import '../../style/validation.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/background 1.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Create Account'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(height * 0.03),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      controller: nameController,
                      keyword: TextInputType.name,
                      validator: (value) {
                        return Validation.fullNameValidator(
                          value,
                          'should enter your name',
                        );
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                      label: 'Email Address',
                      keyword: TextInputType.emailAddress,
                      controller: emailController,
                      validator: Validation.emailValidator,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                      label: 'Password',
                      keyword: TextInputType.visiblePassword,
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'should enter your password';
                        }
                        if (value.length < 8) {
                          return "Password shouldn't be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CustomTextField(
                      label: 'Password Confirmation',
                      keyword: TextInputType.visiblePassword,
                      controller: passwordConfirmController,
                      isPassword: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'mismatch with password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    CustomButton(
                      onPress: () {
                        createAccount();
                      },
                      title: 'Create Account',
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

  createAccount() async {
    if (formKey.currentState!.validate()) {}
    try {
      DialogUtils.showLoading(context);
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseAuthCodes.weakPass) {
        print('The password provided is too weak.');
      } else if (e.code == FirebaseAuthCodes.emailAlreadyInUse) {
        print('The account already exists for that email.');
      }
    } catch (error) {}
  }
}
