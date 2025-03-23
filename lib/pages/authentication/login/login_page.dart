import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workshop_flutter_firebases/pages/authentication/register/register_page.dart';
import 'package:workshop_flutter_firebases/pages/list_todo_page.dart';
import 'package:workshop_flutter_firebases/services/authentication_services.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';
import 'package:workshop_flutter_firebases/widgets/shared_buttton.dart';
import 'package:workshop_flutter_firebases/widgets/shared_loading.dart';
import 'package:workshop_flutter_firebases/widgets/shared_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthenticationServices();
  final _sharedFunc = SharedFunctions();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  // fungsi untuk loginya
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _authService
          .signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      )
          .then(
        (value) {
          if (value is String) {
            _showSnackbar(value);
          } else {
            _navigateToListPage();
          }
        },
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    _sharedFunc.showSnackBar(context, message: message);
  }

  void _navigateToListPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ListTodoPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.quaternary,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 120,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sign In to Your Account',
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black_olive,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: AppColors.black_olive,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Enter your email and password to login',
                                style: GoogleFonts.montserrat(
                                    color: AppColors.black_olive,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              SharedTextFormField(
                                  title: 'Email',
                                  Controller: _emailController,
                                  labelText: 'Input email',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                    return null;
                                  }),
                              SharedTextFormField(
                                title: 'Password',
                                Controller: _passwordController,
                                obsecureText: _isObscure,
                                labelText: 'Input Password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password cannot be empty';
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              SharedButtton(
                                onPressed: _login,
                                title: _isLoading
                                    ? SharedLoading()
                                    : Text('Login',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black_olive,
                                        )),
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dont have an account?',
                                    style: GoogleFonts.montserrat(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
