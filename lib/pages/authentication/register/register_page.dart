// import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:workshop_flutter_firebases/pages/authentication/login/login_page.dart';
import 'package:workshop_flutter_firebases/pages/list_todo_page.dart';
import 'package:workshop_flutter_firebases/services/authentication_services.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';
import 'package:workshop_flutter_firebases/widgets/shared_buttton.dart';
import 'package:workshop_flutter_firebases/widgets/shared_loading.dart';
import 'package:workshop_flutter_firebases/widgets/shared_text_form_field.dart';

// part 'widgets/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// untuk
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _roleController = TextEditingController();
  bool _isLoading = false; // untuk mengecek apakah sedang loading atau tidak
  bool _isObscure =
      true; // untuk mengecek apakah password tersembunyi atau tidak

  final _authService = AuthenticationServices();
  final _sharedFunc = SharedFunctions();
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final result = await _authService.registerWithEmailAndPassword(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          role: _roleController.text,
          phoneNumber: _phoneNumberController.text,
        );
        if (result is String) {
          _showSnackbar(result);
        } else {
          _navigateToListPage();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          _showSnackbar("Email is already registered.");
        } else {
          _showSnackbar("Error: ${e.message}");
        }
      } catch (e) {
        _showSnackbar("An error occurred. Please try again later.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    // Menambahkan SingleChildScrollView
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/logo.png',
                          ),
                        ),
                        // Stack(
                        //   children: [
                        //     if (_image == null)
                        //       CircleAvatar(
                        //         radius: 50,
                        //         child: Padding(
                        //           padding: EdgeInsets.all(15),
                        //           child: Icon(
                        //             Icons.person,
                        //             size: 50,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       )
                        //     else
                        //       CircleAvatar(
                        //         radius: 50,
                        //         backgroundImage: FileImage(_image!),
                        //       ),
                        //   ],
                        // ),
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
                                  'Register ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SharedTextFormField(
                                  title: 'Name',
                                  Controller: _nameController,
                                  labelText: 'Input your name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SharedTextFormField(
                                  title: 'Email',
                                  Controller: _emailController,
                                  labelText: 'Input your email',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SharedTextFormField(
                                  title: 'Role',
                                  Controller: _roleController,
                                  labelText: 'Input your role',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Role cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SharedTextFormField(
                                  title: 'Phone Number',
                                  Controller: _phoneNumberController,
                                  labelText: 'Input your phone number',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Phone number cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SharedTextFormField(
                                  title: 'Password',
                                  Controller: _passwordController,
                                  labelText: 'Input your password',
                                  obsecureText: _isObscure,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                SharedButtton(
                                  title: _isLoading
                                      ? SharedLoading()
                                      : Text(
                                          'Register',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black_olive,
                                          ),
                                        ),
                                  onPressed: _register,
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      },
                                      child: Text('Login',
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    )
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
      ),
    );
  }
}
